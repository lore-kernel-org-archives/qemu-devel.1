Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026CC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0649E21D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzrmQRsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0649E21D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkw3-0004MV-5y
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHkv8-0003LJ-OF; Mon, 14 Sep 2020 05:37:10 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHkv7-0002uq-4x; Mon, 14 Sep 2020 05:37:10 -0400
Received: by mail-lf1-x141.google.com with SMTP id x69so12685895lff.3;
 Mon, 14 Sep 2020 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=IND7o5/NYMnf56KGOS8IpAtjkZVelZOlJ/IDjk8aMUw=;
 b=BzrmQRsENSV3reN27GFWl9lq1PHKPQN695vxS9PzrDVwo0Y1hEcznen/4yvvabpVHz
 Ncd7+oqK/T5MaG0KDIEH115/XwTuSuePmIoepKRSqk5bD1BR/Bc7NJ/r2URO8kVWD4uz
 dNu5HSS28VqoN39Z4is0qNMhmxcNdxbEj1bHoj3VNV8J8Z8ejrFbh7UhZYi4+r0cNFKk
 uD3YGmIfT/90Vc1AA5HwOWaxLPI+FT9GfAbI8mUq3l7X2FOEPrhpgmFXACYke+nxgNnq
 1YjEn9jIi3FXFoz4aspnkTdcRD3Rw35lZoYHID+el9XFCnJVg3WHmLHsl6ieQmFDYshW
 HSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=IND7o5/NYMnf56KGOS8IpAtjkZVelZOlJ/IDjk8aMUw=;
 b=FYKsLa+NxWjKIvUQNoiWe5OiW6YNVf4DMeiYw+Z0JPnpvZqQd5CCaSPc7NdvU6W8Rw
 0TCP18sQNysrCvGyCg9EQC6BLUuKTdv5ZJBETe1Ti7ZpKb5/94j1zINetcKR+gVLtsKZ
 a+ri75BqtcJnBLxUqC+iamC9UoWLqAe5J83RmU67X2dYbV2OCPgoDcaETbDFDq190k//
 FtBZDsLNjmsnYJVidclkmnYKTKNrh8GIM8YIgFpLTdkauByZwjTGfMMc/tEb1zyBiBRY
 JskKA6RL5a6GmyqsAdOmyAE7nO7uhnSkUNeuBdpu1xH8Gvfes0fZ+ZiLGIisyH4UdJX+
 jeWg==
X-Gm-Message-State: AOAM532IVFnr3mmlRQkoFYdK1pfEMkY2z2tEsRC06O1/30p2S2C3Ea85
 lMAqtO+ZjiqRWFBhVDctYi1txdwRslQ1H2zyY40=
X-Google-Smtp-Source: ABdhPJw3xGA2LEgoChuCaqTV4Q1xI21XoWb/1hC270j/oB4KqAnwqcZvlbQtnMTobXc6YhvIUSUy2AgY7zjEQcvPf4I=
X-Received: by 2002:a19:a407:: with SMTP id q7mr3742435lfc.377.1600076227018; 
 Mon, 14 Sep 2020 02:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200912121412.10999-1-thuth@redhat.com>
In-Reply-To: <20200912121412.10999-1-thuth@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 17:36:57 +0800
Message-ID: <CAE2XoE-RxwJ1ddAb_RzWHVYQFtkdy=d-1W0eFicMyJMyeP1LLA@mail.gmail.com>
Subject: Re: [PATCH] tests/check-block: Do not run the iotests with old
 versions of bash
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002005a405af42c7fe"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002005a405af42c7fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2020 at 8:16 PM Thomas Huth <thuth@redhat.com> wrote:
>
> macOS is shipped with a very old version of the bash (3.2), which
> is currently not suitable for running the iotests anymore. Add
> a check to skip the iotests in this case - if someone still wants
> to run the iotests on macOS, they can install a newer version from
> homebrew, for example.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/check-block.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index 8e29c868e5..bfe1630c1e 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -46,6 +46,11 @@ if ! command -v bash >/dev/null 2>&1 ; then
>      exit 0
>  fi
>
> +if bash --version | grep 'GNU bash, version [123]' > /dev/null 2>&1 ;
then
> +    echo "bash version too old =3D=3D> Not running the qemu-iotests."
> +    exit 0
> +fi
> +
>  if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
>      if ! command -v gsed >/dev/null 2>&1; then
>          echo "GNU sed not available =3D=3D> Not running the qemu-iotests=
."
> --
> 2.18.2
>
>
Is that worth to convert the check-block.sh script to python script? so it
can even running under msys2/mingw=EF=BC=9F

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002005a405af42c7fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Sep 12, 2020 at 8:16 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; macOS is shipped with a very old version of the bash (3.2), which<br=
>&gt; is currently not suitable for running the iotests anymore. Add<br>&gt=
; a check to skip the iotests in this case - if someone still wants<br>&gt;=
 to run the iotests on macOS, they can install a newer version from<br>&gt;=
 homebrew, for example.<br>&gt;<br>&gt; Signed-off-by: Thomas Huth &lt;<a h=
ref=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt;<br>&gt; ---<br>&gt=
; =C2=A0tests/check-block.sh | 5 +++++<br>&gt; =C2=A01 file changed, 5 inse=
rtions(+)<br>&gt;<br>&gt; diff --git a/tests/check-block.sh b/tests/check-b=
lock.sh<br>&gt; index 8e29c868e5..bfe1630c1e 100755<br>&gt; --- a/tests/che=
ck-block.sh<br>&gt; +++ b/tests/check-block.sh<br>&gt; @@ -46,6 +46,11 @@ i=
f ! command -v bash &gt;/dev/null 2&gt;&amp;1 ; then<br>&gt; =C2=A0 =C2=A0 =
=C2=A0exit 0<br>&gt; =C2=A0fi<br>&gt;<br>&gt; +if bash --version | grep &#3=
9;GNU bash, version [123]&#39; &gt; /dev/null 2&gt;&amp;1 ; then<br>&gt; + =
=C2=A0 =C2=A0echo &quot;bash version too old =3D=3D&gt; Not running the qem=
u-iotests.&quot;<br>&gt; + =C2=A0 =C2=A0exit 0<br>&gt; +fi<br>&gt; +<br>&gt=
; =C2=A0if ! (sed --version | grep &#39;GNU sed&#39;) &gt; /dev/null 2&gt;&=
amp;1 ; then<br>&gt; =C2=A0 =C2=A0 =C2=A0if ! command -v gsed &gt;/dev/null=
 2&gt;&amp;1; then<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;GNU=
 sed not available =3D=3D&gt; Not running the qemu-iotests.&quot;<br>&gt; -=
-<br>&gt; 2.18.2<br>&gt;<br>&gt;<br>Is that worth to convert the check-bloc=
k.sh script to python script? so it can even running under msys2/mingw=EF=
=BC=9F<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br=
>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincere=
ly,<br>Yonggang Luo</div>

--0000000000002005a405af42c7fe--

