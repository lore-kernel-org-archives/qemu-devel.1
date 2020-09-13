Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83CC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EF0206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEu4/+lU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EF0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUfF-0000db-Jn
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUdz-00085c-PJ; Sun, 13 Sep 2020 12:14:23 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUdy-0002Wy-4e; Sun, 13 Sep 2020 12:14:23 -0400
Received: by mail-lf1-x143.google.com with SMTP id d15so10796017lfq.11;
 Sun, 13 Sep 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=ZQu6qQJbLkFDj/GY8270WYG+Gh8hIY8Xim+Fqy/5eUA=;
 b=rEu4/+lUm8zvtLTRlul0RDoQzvvwpzxzG5CVtQeX0Zv7P0/v+oblEbDPphJJsMfh47
 MAhKFMeejhMNV7vSwc6s8LY3suviSd5Q8wifYWGs28t8oFTnlDszEwmdiz5INcUNfGcY
 C4Xd0EmAMLzK+A9hM3W+8sAm5MYiZF9u8B2cBzcwXjGcIZZcuxtjrjZDrk6TKOT1QFxv
 mBjaIpit1yJodDgl07WvRY9nzbiBAmFUcH6ANuP2QUH0sjmgMyP6Y/kBzCBbEtjBGlks
 0SfMbCVXtpZX/QMz4+PC8ybBIAABuaFZJQJJfYPMbVWxY1DstllZ36Pn6KQXxd29kNEO
 qTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=ZQu6qQJbLkFDj/GY8270WYG+Gh8hIY8Xim+Fqy/5eUA=;
 b=XXOKbgw/czvkOyQs92sYUhCvPbnViZGUBTAZhdd4Q6Rk6fUn7/BEDDSPp3ldEznlTR
 3BrzMfeAyYfK16UPvd7fUpneKoJ5GqofAMMo9rgItHY27deKxYVdK1RsjJA1bi0dCUJ1
 yxweRzWSz2kNxyIzqMQNIQJvPtxx/bFp2VwWxBKDwYg4hovti7Hpzpyj75jfDBH3MuNq
 qjv4DaKLnoYeYjaGwAEjEMPbc3SpGymXxw5Bg3ou8XpWn2LvmiVhel16oRLEuTeBS1tp
 5RaxJxcZeCV9v+XEtYyPtvGFd5J4zv4meu7k4Jw/NQwQP5kKJPg8WTCdNDxCyAfB6+Rl
 IXmQ==
X-Gm-Message-State: AOAM530PWXYi0or7xsGTL4C6cvMfvAeWBQItAI+sPGB4FwX0MhGTH/Si
 XnNWDIluxTk4gRaOXwW1KAMcqaTd2ZZgwuMZFe0=
X-Google-Smtp-Source: ABdhPJwq5Yb1vgdawsst+ruhXLXHLPkMDwVAWhrQ6kEw/J+7I/ky5oumtU0DtI10jSmF4Q5+IrcINtDtXdn4b49kUK0=
X-Received: by 2002:a19:674f:: with SMTP id e15mr3263421lfj.50.1600013659892; 
 Sun, 13 Sep 2020 09:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
In-Reply-To: <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 00:14:08 +0800
Message-ID: <CAE2XoE8Ly=bhkLPbnUm1eg91Re0rf-UkAy25f8LgPLJUaYyHNw@mail.gmail.com>
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d5702305af34354d"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d5702305af34354d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 10:08 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 13/09/20 00:44, Yonggang Luo wrote:
> > This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.
> >
> > The --ninja option doesn't need anymore because of upgrade meson to
> 0.55.2
> > At that version we can use ninjatool
>
> We might actually get rid of ninjatool before QEMU 5.2 goes out, if we
> decide to make Ninja a mandatory build dependency.  So we can hold on
> patches 26 and 27.  Thanks for testing though!
>
I am hurry to revert --ninja option because when the meson are changed, the
make -j10 can not automatically re configure, that would raise ninja can
not found error

>
> I'm also not sure about patch 16, since that's not my area, but Daniel
> and Ed both reviewed it so that's okay.
>
> Finally, instead of checking !_WIN32 it's better to check CONFIG_POSIX
> or CONFIG_WIN32.  That can be changed on commit though.
>
> Everything else seems okay.  I'll wait a couple days and queue the whole
> bunch up to patch 25.
>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d5702305af34354d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 13, 2020 at 10:08 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
13/09/20 00:44, Yonggang Luo wrote:<br>
&gt; This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.<br>
&gt; <br>
&gt; The --ninja option doesn&#39;t need anymore because of upgrade meson t=
o 0.55.2<br>
&gt; At that version we can use ninjatool<br>
<br>
We might actually get rid of ninjatool before QEMU 5.2 goes out, if we<br>
decide to make Ninja a mandatory build dependency.=C2=A0 So we can hold on<=
br>
patches 26 and 27.=C2=A0 Thanks for testing though!<br></blockquote><div>I =
am hurry to revert --ninja option because when the meson are changed, the</=
div><div>make -j10 can not automatically re configure, that would raise nin=
ja can not found error=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
I&#39;m also not sure about patch 16, since that&#39;s not my area, but Dan=
iel<br>
and Ed both reviewed it so that&#39;s okay.<br>
<br>
Finally, instead of checking !_WIN32 it&#39;s better to check CONFIG_POSIX<=
br>
or CONFIG_WIN32.=C2=A0 That can be changed on commit though.<br>
<br>
Everything else seems okay.=C2=A0 I&#39;ll wait a couple days and queue the=
 whole<br>
bunch up to patch 25.<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d5702305af34354d--

