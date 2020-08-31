Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5062DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFDD206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFDD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrGu-0007w1-5k
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9e-0007R5-8W
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:54 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9b-00019C-Ff
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:15:53 -0400
Received: by mail-qv1-f67.google.com with SMTP id cy2so2602317qvb.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=erzc2eLbAg40TxtscfBgpusD+tqSFp/kZZ7XBm7Fu8M=;
 b=ARDNd1/7WwUaEqZSZBTSAJEiR8QdTARq04ZUW0/iOu7G/W6cnkRPlYoCBV82LqowSv
 pxdc1yIBTARmv2sMOajXHZerqEdBO1OTW6kvD3TMoMYLCglmZDa6AGaCm35Al88CHwJB
 /AN5wqJLkp91iOfm89nQ22tCmmPWTMEZU1h6Gm0YG47Y+rHRDKJXi/SkeR8e6T9aF1Wf
 c5uFEpHpJFDsRLgeXj6FyYaYlBCMs/ZMnMZYcUUYtmEXAOu9X5oLPKuRyPtkzJCC2LPP
 QlzLniq0R1NUHsq5F8jrv6EI2MxBcLTV6siMd2bnJ5yiFCVQu/9pdIon20NvrkwNszHN
 UjcQ==
X-Gm-Message-State: AOAM531jRLj0/hT26W204D/TuEjOI45XSNKRa0pE6xsmm37nE6inSpdo
 xijK1DvbkGN0O2efnsmLhwKzJM25C1BCBQJxAZf+LT5O
X-Google-Smtp-Source: ABdhPJyt06m8ug6g+rXbVnz/B598U/G4//YeSxB4/QhhMdHBwFUIud58eSPWrzSwpzZGtREmrmmyeG4NS70Puw3D0do=
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr2944802qvo.227.1598908550544; 
 Mon, 31 Aug 2020 14:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-2-richard.henderson@linaro.org>
In-Reply-To: <20200828141929.77854-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:32:10 +0200
Message-ID: <CAAdtpL60CYWYGw4KvzsLn8o5RgYM8Qj9c8fRcJudJDVVnAA83A@mail.gmail.com>
Subject: Re: [PATCH v2 01/76] tests/tcg: Add microblaze to arches filter
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002f025505ae32e805"
Received-SPF: pass client-ip=209.85.219.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:15:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002f025505ae32e805
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 16:20, Richard Henderson <richard.henderson@linar=
o.org>
a =C3=A9crit :

> Not attempting to use a single cross-compiler for both
> big-endian and little-endian at this time.
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tests/tcg/configure.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 7d714f902a..598a50cd4f 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -94,7 +94,7 @@ for target in $target_list; do
>      xtensa|xtensaeb)
>        arches=3Dxtensa
>        ;;
> -    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
> +
> alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s=
390x|sh4|sparc64)
>        arches=3D$target
>        ;;
>      *)
> --
> 2.25.1
>
>
>

--0000000000002f025505ae32e805
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 16:20, Richard Henderson &lt;<a =
href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</=
a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Not atte=
mpting to use a single cross-compiler for both<br>
big-endian and little-endian at this time.<br>
<br>
Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@xilinx.=
com" target=3D"_blank" rel=3D"noreferrer">edgar.iglesias@xilinx.com</a>&gt;=
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org=
</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewe=
d-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.=
org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-s=
erif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:sans=
-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
---<br>
=C2=A0tests/tcg/configure.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh<br>
index 7d714f902a..598a50cd4f 100755<br>
--- a/tests/tcg/configure.sh<br>
+++ b/tests/tcg/configure.sh<br>
@@ -94,7 +94,7 @@ for target in $target_list; do<br>
=C2=A0 =C2=A0 =C2=A0xtensa|xtensaeb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0arches=3Dxtensa<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
-=C2=A0 =C2=A0 alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sp=
arc64)<br>
+=C2=A0 =C2=A0 alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openr=
isc|riscv64|s390x|sh4|sparc64)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0arches=3D$target<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0 =C2=A0*)<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000002f025505ae32e805--

