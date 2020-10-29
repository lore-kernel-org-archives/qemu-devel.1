Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235EC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91DB2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIdQ15vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91DB2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8OA-0005lx-D3
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kY8N5-0004ra-2C
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:53:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:44054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kY8N2-0001Va-6f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:53:42 -0400
Received: by mail-ej1-x635.google.com with SMTP id j24so3887313ejc.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UgABUPlKaClr1Cyye3KItQ3EyvIJD1hQg+jtXooIQ+o=;
 b=GIdQ15vraDzLM/zChtEx5rp9PIzoPZAQrVFmuf6q+CcTGLvYTeKZUN68tKHsTWdg11
 TbMsnGCFVME3XygxLWwxRm8jff9xh0GxqxtT9K/fgdaELNchg6bj7tSbKReerh+ftxD2
 gMcZEhlbE8Y8/IhKU3ukMp/DNLQ4cEKgGhmpOzGqugS3eCAuCPxJM/LrHdInhnKzGy78
 TZlFlqKNh0a0N/3zMDZW3IpWh3J5vy+60/K50xo2NFA0Rq5ZQZUnM10ezbnlFguyZ9a6
 Luu4stsiJPwsMuoX+tbPrJCCH6n5i97ZaPDvoUg5Cj8Qu/dLYAbczodp2hcqtpqwEP20
 QeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UgABUPlKaClr1Cyye3KItQ3EyvIJD1hQg+jtXooIQ+o=;
 b=YSULCE8oiswI8VkPO7frcfu6ULHtkTc6Rc8fpovoURoDijnR3sWpVKXoRUTOhb96PB
 mduKHBb9rRIRMqxJxPDYMS5uFJQKyF0+6sAkd/TvB6QVnivc0Kx2hbPQS61cHFITmYok
 bSlh89NQtYOGyypZwItI9j3RWt1zrdzUncxX7z5G+DgntAiNWofYJtXb1KJvllfkm8fs
 Gl7x4s6mNGuRxZOKF1mF14hfRPr2EZSd/NdRfWURXNf0QOgdVBGpA1x80D8LFMTM1FoG
 bwChrQXjVRs62CIE3fBUaTn0gKoAWkwakrw4Bh8m0nhXnAkEwhFz0dqY6k4RizIdNqlS
 G1pA==
X-Gm-Message-State: AOAM530MHEqeyBzB3TVrzDaQAl/G4HUjYn6iK2d/XygspLqAu3T19ks+
 /uTCJ1/ghVW4DSVLvnUdnhAeOGln7SKvudJ8U/k=
X-Google-Smtp-Source: ABdhPJxHVj6mTi1AdmxEkBjPzxJfzIFjFBHCT/XgKbkDWwYxg/cvLRgnPHayAqPR4NeOo46MnvwANPOlosUxnaKyNWs=
X-Received: by 2002:a17:906:2798:: with SMTP id
 j24mr4094533ejc.109.1603979617953; 
 Thu, 29 Oct 2020 06:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201029133833.3450220-1-armbru@redhat.com>
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Oct 2020 17:53:25 +0400
Message-ID: <CAJ+F1CLW=zfWq3apgrKear2v42LYarSMQKw07BHadM-rYjcmoA@mail.gmail.com>
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005aecbd05b2cf9bc2"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 xiaoqiang zhao <zxq_yx_007@163.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005aecbd05b2cf9bc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Thu, Oct 29, 2020 at 5:43 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> In my opinion, the Linux-specific abstract UNIX domain socket feature
> introduced in 5.1 should have been rejected.  The feature is niche,
> the interface clumsy, the implementation buggy and incomplete, and the
> test coverage insufficient.  Review fail.
>

I also failed (as chardev maintainer..) to not only review but weigh in and
discuss the merits or motivations behind it.

I agree with you. Also the commit lacks motivation behind this "feature".


> Fixing the parts we can still fix now is regrettably expensive.  If I
> had the power to decide, I'd unceremoniously revert the feature,
> compatibility to 5.1 be damned.  But I don't, so here we go.
>
> I'm not sure this set of fixes is complete.  However, I already spent
> too much time on this, so out it goes.  Lightly tested.
>
> Regardless, I *will* make time for ripping the feature out if we
> decide to do that.  Quick & easy way to avoid reviewing this series
> *hint* *hint*.
>

well, fwiw, I would also take that approach too, to the risk of upsetting
the users. But maybe we can get a clear reason behind it before that
happens. (sorry, I didn't dig the ML archive is such evidence is there, it
should have been in the commit message too)


> For additional information, see
>
>     Subject: Our abstract UNIX domain socket support is a mess
>     Date: Wed, 28 Oct 2020 13:41:06 +0100
>     Message-ID: <87o8kmwmjh.fsf@dusky.pond.sub.org>
>
> Markus Armbruster (11):
>   test-util-sockets: Plug file descriptor leak
>   test-util-sockets: Correct to set has_abstract, has_tight
>   test-util-sockets: Clean up SocketAddress construction
>   test-util-sockets: Factor out test_socket_unix_abstract_one()
>   test-util-sockets: Synchronize properly, don't sleep(1)
>   test-util-sockets: Test the complete abstract socket matrix
>   sockets: Fix default of UnixSocketAddress member @tight
>   sockets: Fix socket_sockaddr_to_address_unix() for abstract sockets
>   char-socket: Fix qemu_chr_socket_address() for abstract sockets
>   sockets: Bypass "replace empty @path" for abstract unix sockets
>   sockets: Make abstract UnixSocketAddress depend on CONFIG_LINUX
>
>  qapi/sockets.json         |  14 ++--
>  chardev/char-socket.c     |  22 +++++-
>  chardev/char.c            |   2 +
>  tests/test-util-sockets.c | 155 ++++++++++++++++++++------------------
>  util/qemu-sockets.c       |  54 ++++++++++---
>  5 files changed, 156 insertions(+), 91 deletions(-)
>
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005aecbd05b2cf9bc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Markus,<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 29, 2020 at 5:4=
3 PM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">In my opinion, the Linux-specific abstract UNIX domain socket feature=
<br>
introduced in 5.1 should have been rejected.=C2=A0 The feature is niche,<br=
>
the interface clumsy, the implementation buggy and incomplete, and the<br>
test coverage insufficient.=C2=A0 Review fail.<br></blockquote><div><br></d=
iv><div>I also failed (as chardev maintainer..) to not only review but weig=
h in and discuss the merits or motivations behind it. <br></div><div><br></=
div><div>I agree with you. Also the commit lacks motivation behind this &qu=
ot;feature&quot;.<br></div><div><br> </div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
Fixing the parts we can still fix now is regrettably expensive.=C2=A0 If I<=
br>
had the power to decide, I&#39;d unceremoniously revert the feature,<br>
compatibility to 5.1 be damned.=C2=A0 But I don&#39;t, so here we go.<br>
<br>
I&#39;m not sure this set of fixes is complete.=C2=A0 However, I already sp=
ent<br>
too much time on this, so out it goes.=C2=A0 Lightly tested.<br>
<br>
Regardless, I *will* make time for ripping the feature out if we<br>
decide to do that.=C2=A0 Quick &amp; easy way to avoid reviewing this serie=
s<br>
*hint* *hint*.<br></blockquote><div><br></div><div>well, fwiw, I would also=
 take that approach too, to the risk of upsetting the users. But maybe we c=
an get a clear reason behind it before that happens. (sorry, I didn&#39;t d=
ig the ML archive is such evidence is there, it should have been in the com=
mit message too)<br></div><div> <br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
For additional information, see<br>
<br>
=C2=A0 =C2=A0 Subject: Our abstract UNIX domain socket support is a mess<br=
>
=C2=A0 =C2=A0 Date: Wed, 28 Oct 2020 13:41:06 +0100<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:87o8kmwmjh.fsf@dusky.pond.s=
ub.org" target=3D"_blank">87o8kmwmjh.fsf@dusky.pond.sub.org</a>&gt;<br>
<br>
Markus Armbruster (11):<br>
=C2=A0 test-util-sockets: Plug file descriptor leak<br>
=C2=A0 test-util-sockets: Correct to set has_abstract, has_tight<br>
=C2=A0 test-util-sockets: Clean up SocketAddress construction<br>
=C2=A0 test-util-sockets: Factor out test_socket_unix_abstract_one()<br>
=C2=A0 test-util-sockets: Synchronize properly, don&#39;t sleep(1)<br>
=C2=A0 test-util-sockets: Test the complete abstract socket matrix<br>
=C2=A0 sockets: Fix default of UnixSocketAddress member @tight<br>
=C2=A0 sockets: Fix socket_sockaddr_to_address_unix() for abstract sockets<=
br>
=C2=A0 char-socket: Fix qemu_chr_socket_address() for abstract sockets<br>
=C2=A0 sockets: Bypass &quot;replace empty @path&quot; for abstract unix so=
ckets<br>
=C2=A0 sockets: Make abstract UnixSocketAddress depend on CONFIG_LINUX<br>
<br>
=C2=A0qapi/sockets.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 ++--<br=
>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 22 +++++-<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
=C2=A0tests/test-util-sockets.c | 155 ++++++++++++++++++++-----------------=
-<br>
=C2=A0util/qemu-sockets.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 54 ++++++++++--=
-<br>
=C2=A05 files changed, 156 insertions(+), 91 deletions(-)<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000005aecbd05b2cf9bc2--

