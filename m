Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0307C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732D82339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732D82339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0QdM-0008Jb-Kj
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QaZ-0003lB-0v
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QaX-0000iZ-SR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QaX-0000iI-L1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:23:45 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE57181129
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:23:44 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f14so843526wmh.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vem4joSo6UR4KhAT7SKjnG8yccKTpq+jyZZ5CDqA2gs=;
 b=gmQgjrSZEOS6gE6wmTbhsEHNVqEmW+AIt6R3DUcW5ezNjDZIYR6N8PvrsNPc4CrOpR
 aBNcGCJYjDxpExeDoWrPQxKo5mY+aKuakaJkoqrOsEyObJXeaIjDf9k/RqOkfRm4Mmew
 CDznw2SqMkXLK0HhuuJKDF6xmyNzVFn5PqfSsoCDDNLEFiLs9hPmmoNDPKzJRNxhjPd4
 5WNEfDJkpEtXJbpMyrx1jKsxwyodBJEUvDSXdUSQPEB+osk3n/rH3JUo0FdNlFG5BRW1
 CNUVdwOtNkNgHaULF0OP30BDsY7mAqa6YOP2LycZrQKagVOeBWfEQepmrKfYMQsA6wTt
 Bwdg==
X-Gm-Message-State: APjAAAUg3+1xt9p34mdbxEZ6/yb+L6IjkkCDus2PPiLkodY7z2BB8nc3
 N9FH4nudSvS0Jy0uxvVa7xt8GPH3CvMDBZUHcjBYdaYTi/Hqni2J7BsL5nsfK1n1y/vpXgUlABT
 fhAw029Ic3gv3aGw=
X-Received: by 2002:a1c:a008:: with SMTP id j8mr6211143wme.57.1566393823419;
 Wed, 21 Aug 2019 06:23:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqvmin/9gIlcrAm1Nz4+00bn20cxbhYQK88Afjw5R4m4Mef8HTr8skxDq/qYaXtRT4wBOcTQ==
X-Received: by 2002:a1c:a008:: with SMTP id j8mr6211128wme.57.1566393823198;
 Wed, 21 Aug 2019 06:23:43 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e15sm14282248wrj.74.2019.08.21.06.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:23:42 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b1993f41-d193-b858-efe0-372df3b65b0d@redhat.com>
Date: Wed, 21 Aug 2019 15:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 37/68] target/arm: Convert PLI, PLD, PLDW
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
> ---
>  target/arm/translate.c       | 37 +++++++++++++++++++-----------------
>  target/arm/a32-uncond.decode | 10 ++++++++++
>  2 files changed, 30 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 46e88d1d17..a30a9bb4e0 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10136,6 +10136,26 @@ static bool trans_SETEND(DisasContext *s, arg_=
SETEND *a)
>      return true;
>  }
> =20
> +/*
> + * Preload instructions
> + * All are nops, contingent on the appropriate arch level.
> + */
> +
> +static bool trans_PLD(DisasContext *s, arg_PLD *a)
> +{
> +    return ENABLE_ARCH_5TE;

Excellent :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> +
> +static bool trans_PLDW(DisasContext *s, arg_PLD *a)
> +{
> +    return arm_dc_feature(s, ARM_FEATURE_V7MP);
> +}
> +
> +static bool trans_PLI(DisasContext *s, arg_PLD *a)
> +{
> +    return ENABLE_ARCH_7;
> +}
> +
>  /*
>   * Legacy decoder.
>   */
> @@ -10196,23 +10216,6 @@ static void disas_arm_insn(DisasContext *s, un=
signed int insn)
>              }
>              return;
>          }
> -        if (((insn & 0x0f30f000) =3D=3D 0x0510f000) ||
> -            ((insn & 0x0f30f010) =3D=3D 0x0710f000)) {
> -            if ((insn & (1 << 22)) =3D=3D 0) {
> -                /* PLDW; v7MP */
> -                if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
> -                    goto illegal_op;
> -                }
> -            }
> -            /* Otherwise PLD; v5TE+ */
> -            ARCH(5TE);
> -            return;
> -        }
> -        if (((insn & 0x0f70f000) =3D=3D 0x0450f000) ||
> -            ((insn & 0x0f70f010) =3D=3D 0x0650f000)) {
> -            ARCH(7);
> -            return; /* PLI; V7 */
> -        }
>          if (((insn & 0x0f700000) =3D=3D 0x04100000) ||
>              ((insn & 0x0f700010) =3D=3D 0x06100000)) {
>              if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decod=
e
> index d5ed48f0fd..aed381cb8e 100644
> --- a/target/arm/a32-uncond.decode
> +++ b/target/arm/a32-uncond.decode
> @@ -54,3 +54,13 @@ SB               1111 0101 0111 1111 1111 0000 0111 =
0000
> =20
>  # Set Endianness
>  SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
> +
> +# Preload instructions
> +
> +PLD              1111 0101 -101 ---- 1111 ---- ---- ----    # (imm, li=
t) 5te
> +PLDW             1111 0101 -001 ---- 1111 ---- ---- ----    # (imm, li=
t) 7mp
> +PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, li=
t) 7
> +
> +PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (registe=
r) 5te
> +PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (registe=
r) 7mp
> +PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (registe=
r) 7
>=20

