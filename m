Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B6C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF40207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSIVIUXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF40207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQVt-0003Dt-Mp
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iCQTk-0002JN-FA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iCQTj-00047I-6Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:42:20 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:46139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iCQTi-00046x-Vq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:42:19 -0400
Received: by mail-qk1-x730.google.com with SMTP id 201so15828352qkd.13
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AYtRYpu1TQtH1kP/To7Rp85ehM2tcEh75qedhwWVEpU=;
 b=DSIVIUXOKuKmsd4/2odr2efM9YngzCmxABtN5jSVs+EmK9pUvIkm81Wr5dXy2sdMxf
 V5FnOtgtjxj/+Rn3G6RlGwOA47XIiPF/2GjbOZh2t/py+qYjtGMu5W9e/jICpm9VPw9G
 GmXQB07HIoylfN3WI+sw3sTTECJgHoTQJnGu4DXJIAPOgkajTGycTmDCPJsbr9lTNXMU
 OgKYNLBsRhTnnJWL6MEuVIuC8u6lKKKkqfoxImzYPU+hACaUdnCSeP8Kh0Br99qQPA/n
 0LTTmCWndTQCadD3gPtTeevNvbhciFYlMTgJoNYfMhRdRN5bFUHMKL2+6NycULMf7By4
 Qz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AYtRYpu1TQtH1kP/To7Rp85ehM2tcEh75qedhwWVEpU=;
 b=deEedoN5vOT9l6UllCefsUmL/vRRSe8O+qSn285SiDbMOV34LULDTtUf5RalQ+oAoK
 8xpNSbyzAiXc/2ThBdTpJqUnlxPC4msyQVUpFMrUusi77O4tg5+ZI+S/kehFie2+aVtv
 aZ3rYHoHO+K7W2iPpLHU3FU06dZxF83fKKizxgJu9L9d6uvm0BMlt8RKQ9eYyFLDy2Zc
 4edP5xK2jCLJUgW3Qm9BjLanqOV3f9iHH2BMJ48w9P22Xh7rT8LTtzBiX0yyDiwgakWR
 xGfkba++JiKbbUiG2jT9NTJ9j8dxNzZQI5uoesYsC0pkRyq/wwLmTlopZ/SV8Tej2mqm
 YpwQ==
X-Gm-Message-State: APjAAAXlsN6XPF32N0yylol1JJlKQjjUg3TLz63mFmuPAOqNPBy0DSyd
 uceKK5kK6/TpQAU7voxdR3G1D7BMA3JKUw19+2Y=
X-Google-Smtp-Source: APXvYqzPE3BGcmKMOXhiVayCyATK+xtwEo6mWBUgmk+U0NkkwrJtqnvw45MLCEC0ZTo5n5DApycTpYDdKXb17ZZknEY=
X-Received: by 2002:a37:2e04:: with SMTP id u4mr381937qkh.181.1569253338277;
 Mon, 23 Sep 2019 08:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190915122015.45852-1-mrolnik@gmail.com>
 <CAK4993gKyXXzffRyBYBOHp2ffSvx=gLVuKmbpVK+VGGyahCdVg@mail.gmail.com>
 <271e5d27-4b3d-5d99-ca57-7f6afe2054f4@redhat.com>
In-Reply-To: <271e5d27-4b3d-5d99-ca57-7f6afe2054f4@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 23 Sep 2019 18:41:37 +0300
Message-ID: <CAK4993hgLOK6=YW2hF_w0_jotmjT-wETJ0O-vnvyRFs7PknP4A@mail.gmail.com>
Subject: Re: [PATCH v31 0/8] QEMU AVR 8 bit cores
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ca6b1805933a43af"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::730
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
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ca6b1805933a43af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Philippe.

On Mon, Sep 23, 2019 at 6:29 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Michael,
>
> On 9/23/19 5:21 PM, Michael Rolnik wrote:
> > Hi all,
> >
> > Is there any hope this will be pulled any time soon?
>
> I have your v28 tagged for review/test, but I need to do a big context
> switch to review it and haven't find personal time to look at it again.
>
> I don't know what happens when a contributer insists and nobody objects.
> Should you pick specific persons and personally ask them? I dunno.
> I'll ask around on IRC.
>
> > Regards,
> > Michael Rolnik
> >
> > On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik <mrolnik@gmail.com
> > <mailto:mrolnik@gmail.com>> wrote:
> >
> >     This series of patches adds 8bit AVR cores to QEMU.
> >     All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not
> >     fully tested yet.
> >     However I was able to execute simple code with functions. e.g
> >     fibonacci calculation.
> >     This series of patches include a non real, sample board.
> >     No fuses support yet. PC is set to 0 at reset.
> [...]
>


--=20
Best Regards,
Michael Rolnik

--000000000000ca6b1805933a43af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Philippe.</div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 23, 2019 at 6:29 PM Philippe M=
athieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Michael,<br>
<br>
On 9/23/19 5:21 PM, Michael Rolnik wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; Is there any hope this will be pulled any time=C2=A0soon?<br>
<br>
I have your v28 tagged for review/test, but I need to do a big context<br>
switch to review it and haven&#39;t find personal time to look at it again.=
<br>
<br>
I don&#39;t know what happens when a contributer insists and nobody objects=
.<br>
Should you pick specific persons and personally ask them? I dunno.<br>
I&#39;ll ask around on IRC.<br>
<br>
&gt; Regards,<br>
&gt; Michael Rolnik=C2=A0<br>
&gt; <br>
&gt; On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrol=
nik@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This series of patches adds 8bit AVR cores to QEMU.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0All instruction, except BREAK/DES/SPM/SPMX, are imp=
lemented. Not<br>
&gt;=C2=A0 =C2=A0 =C2=A0fully tested yet.<br>
&gt;=C2=A0 =C2=A0 =C2=A0However I was able to execute simple code with func=
tions. e.g<br>
&gt;=C2=A0 =C2=A0 =C2=A0fibonacci calculation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This series of patches include a non real, sample b=
oard.<br>
&gt;=C2=A0 =C2=A0 =C2=A0No fuses support yet. PC is set to 0 at reset.<br>
[...]<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000ca6b1805933a43af--

