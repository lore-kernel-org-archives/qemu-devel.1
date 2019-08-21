Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2648C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867432339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867432339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qeo-0001GY-Me
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QbW-0005G6-MG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QbV-00016O-Di
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QbV-00015z-67
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:24:45 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65D9A46697
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:24:44 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a2so1227133wrs.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8tFGO5CHaBMuyfQl29QMXGfRoQe+7se+b32QsW/sJHA=;
 b=tCIq1EyOWd+0+CpzW56WjJdLyD33DGTbe0W4iphXdlvQbrvypetxb8+2hhhvUUqdM5
 jUbjAQBJh/PDYXbQRXew3IVzY7DB1A7gV6/PMfSLmReEb+aqI2BlpAk/36Bq0BR7tugh
 yTxy+oOG6M018o8fFnK6aFtloTuXj5xxH/N5mqgRkiIhgRtt0Kiy4A17i+rRQvV6PcX1
 bAEtS1ZiY7FydPoIDBMPYjbNUAf8QV08JpqfaLwYuozbN3r7hVePth3bRp9LUlzJ6q32
 C+l/DwL2+7zna+NyPU7nYjs8hqILWGs0fzEkbpvMP8jUMY4CBprPuWkFPt8d+CFdUy5t
 bSzQ==
X-Gm-Message-State: APjAAAV+ymoubWe9UJ1yISSy7oGny6r/3t84u6EULMZ4jv1oa/uwmrcj
 4B8XGjPZPp3wBDC8WpvvdmzGUQKa5NiY6oS5N5pkKtCNg+N6R7BH+/d7kCgaOGXlP0xhRAZChgE
 hzes8Ya7YdKnjPNI=
X-Received: by 2002:a5d:5408:: with SMTP id g8mr34206207wrv.201.1566393882835; 
 Wed, 21 Aug 2019 06:24:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzm5G+bEq+Ql7T3tx7koeBupZVdudiWR2Fy3SaphkPDky6hdi33wmvQaMlZLb30AlS6Y0pxRQ==
X-Received: by 2002:a5d:5408:: with SMTP id g8mr34206193wrv.201.1566393882681; 
 Wed, 21 Aug 2019 06:24:42 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id 20sm2465110wmk.34.2019.08.21.06.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:24:42 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-39-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <03f2a4d7-6511-916a-efaa-baa8cbf40386@redhat.com>
Date: Wed, 21 Aug 2019 15:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 38/68] target/arm: Convert Unallocated
 memory hint
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 11:37 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c       | 8 --------
>  target/arm/a32-uncond.decode | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index a30a9bb4e0..9ec6b25c03 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10216,14 +10216,6 @@ static void disas_arm_insn(DisasContext *s, un=
signed int insn)
>              }
>              return;
>          }
> -        if (((insn & 0x0f700000) =3D=3D 0x04100000) ||
> -            ((insn & 0x0f700010) =3D=3D 0x06100000)) {
> -            if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
> -                goto illegal_op;
> -            }
> -            return; /* v7MP: Unallocated memory hint: must NOP */
> -        }
> -
>          if ((insn & 0x0e000f00) =3D=3D 0x0c000100) {
>              if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
>                  /* iWMMXt register transfer.  */
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decod=
e
> index aed381cb8e..afa95bf7aa 100644
> --- a/target/arm/a32-uncond.decode
> +++ b/target/arm/a32-uncond.decode
> @@ -64,3 +64,11 @@ PLI              1111 0100 -101 ---- 1111 ---- ---- =
----    # (imm, lit) 7
>  PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (registe=
r) 5te
>  PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (registe=
r) 7mp
>  PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (registe=
r) 7
> +
> +# Unallocated memory hints
> +#
> +# Since these are v7MP nops, and PLDW is v7MP and implemented as nop,
> +# (ab)use the PLDW helper.
> +
> +PLDW             1111 0100 -001 ---- ---- ---- ---- ----
> +PLDW             1111 0110 -001 ---- ---- ---- ---0 ----
>=20

