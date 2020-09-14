Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8BF207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 06:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtVg944o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8BF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhy0-00008Q-Lu
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 02:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHhxR-00085B-Fr; Mon, 14 Sep 2020 02:27:21 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHhxP-0004dW-Gl; Mon, 14 Sep 2020 02:27:21 -0400
Received: by mail-lj1-x242.google.com with SMTP id c2so17562146ljj.12;
 Sun, 13 Sep 2020 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=M7dFwmsRh+FNZP7P1iJ6lahhJX9ebnRyFa52mZuB15A=;
 b=TtVg944oKwyjhi5iT9N/nhE605at7B8RtAC3TsFsOJR2E5ye9t2JAUqK+wJvohe+jb
 fMPiDfC7poG1udHslzWrlemg7fAkDaniXj8sLP30+jFKekNVmbs7g0jMRRX6riRVbfyc
 ahfTQ5KkUCGHNwwoIdZOnzposb045dzS3uzqx6UIF7rMrb0iZKclo8hRolcQoerIMx59
 v+jMlKqXonERzPg2z9DkQqR8gryPWXJfRJjSXDJTgSNieR0o4Qs4WXHGtBmNBImAtATq
 07qnrPm+c01+AaoCFCZK+QUV+pVK8yVSUCfsf1z/FXbd8Fx060hiD63oCzdmrLAOjQ/X
 7LrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=M7dFwmsRh+FNZP7P1iJ6lahhJX9ebnRyFa52mZuB15A=;
 b=LGmeLMmrKnNvR8bQmTym+tW6uIUFEferCXQ24f1TmBME3swIpeDlaP20ll1DYv6gtW
 V+xX3aKrmw7jHUhR94RMzkVoOfeeb0aFxOb3Aw2tLip40VIjXCrA9ToNbxgXYkwg37ZD
 xPe7LxVeix4zXMRwkRMabqat7pCSNL7SrkQBom7JOxTRQE72jXErLDbCfVKPKgzBkeeF
 N04FrboHzOHcZ76MAmau0MWSRrCxxFU4WgyYXTivO1AGOHeTnv6v0SiUIXqMmhVKTNTG
 rBKCHRxM4xz9vGDQenIlcsfOJ+ZZqnpnlPL8huDHAfIOyLLf8dSFw5sR5/Ta1b2744PX
 Qa0A==
X-Gm-Message-State: AOAM531Mh6EDH49gwTiLE1vBkEUdpL5B9bPyNrflc/l2yVKNK3iB/a26
 b62Vv7/VtrSlHrUiCcmy6cLFfGUfywdUWBJJ4lc=
X-Google-Smtp-Source: ABdhPJxmi3xDwXP6/+0Gbl35i4V4QodzOWmUwGZrgypUTmQ8b7YPRRyM2/ak/UYai1lLFFKlIBXMdcsUXRoziQ1rnfs=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr4930578ljj.447.1600064836986; 
 Sun, 13 Sep 2020 23:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <276a137d-d863-2465-1fe2-599e5772a1a8@redhat.com>
In-Reply-To: <276a137d-d863-2465-1fe2-599e5772a1a8@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 14:27:07 +0800
Message-ID: <CAE2XoE8WrE1_e1VR1VSG7vWWX9nsbp2iRwZvOur1ouGrbC+Rqw@mail.gmail.com>
Subject: Re: [PATCH v8 00/27] W32, W64 msys2/mingw patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000039ee8e05af402030"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000039ee8e05af402030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 2:10 PM Thomas Huth <thuth@redhat.com> wrote:

> On 13/09/2020 00.44, Yonggang Luo wrote:
> > It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses an=
d
> > disable partial test-char tests.
> > And then fixes all unit tests failure on msys2/mingw
> > This fixes the reviews suggested in the mailling list
> > All cirrus CI are passed
>
>  Hi,
>
> since you're very often sending new versions of your patch series, could
> you please add a history to the cover letter to say what you changed in
> each version? Otherwise, your work is very hard to follow.
> I'd also suggest to really slow down the sending a little bit. Let your
> patches mature in your tests first, then send out a new series only if
> you feel that they are really ready. Nobody has the bandwith to review a
> patch series with 27 patches each day...
>
> Thanks, I am learning how to submit patches properly, in old days,  when =
I
am using pull request on github have no such problems. easy to follow up

>  Thanks,
>   Thomas
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000039ee8e05af402030
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 14, 2020 at 2:10 PM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 13/09/202=
0 00.44, Yonggang Luo wrote:<br>
&gt; It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses a=
nd<br>
&gt; disable partial test-char tests.<br>
&gt; And then fixes all unit tests failure on msys2/mingw<br>
&gt; This fixes the reviews suggested in the mailling list<br>
&gt; All cirrus CI are passed<br>
<br>
=C2=A0Hi,<br>
<br>
since you&#39;re very often sending new versions of your patch series, coul=
d<br>
you please add a history to the cover letter to say what you changed in<br>
each version? Otherwise, your work is very hard to follow.<br>
I&#39;d also suggest to really slow down the sending a little bit. Let your=
<br>
patches mature in your tests first, then send out a new series only if<br>
you feel that they are really ready. Nobody has the bandwith to review a<br=
>
patch series with 27 patches each day...<br>
<br></blockquote><div>Thanks, I am learning how to submit patches properly,=
 in old days,=C2=A0 when I am using pull request on github have no such pro=
blems. easy to follow up=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
=C2=A0Thanks,<br>
=C2=A0 Thomas<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000039ee8e05af402030--

