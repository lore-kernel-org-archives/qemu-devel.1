Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6A4C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A3B2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A3B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NcE-0007Tf-FW
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Nae-00060X-IC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Nad-0005v1-Ci
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Nad-0005uU-5s
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:03 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4425158569
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:48:02 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w11so2384851wru.17
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zuL/XyDgUlA/aOanDRF95eRwovOtyEV7KQN+/PkovAU=;
 b=I+Uxd1Mhat2iQWgj1Y81nvJEcWbwCAzS5Txm/Q2HmAt09az99MbRtbf85eKamvhVCM
 2Q5ezd42DNvFwqi9HQWdOhGFqlUSQO4AP1E63BFV8sEzpkaxd8ZylSlspouNcRyNG714
 HOiZzRHsLdHU9LX+Y5RllJJQI8CE0OWO6vw0RtV2iZUgGxOiEI9Gip+xOCDfmR4Y7Q6m
 1OgJU5fxpkf8n2B+l9Dk9WFGC9Nsy/TblUC2HZzF9iXvXi3YqQQbYmAhxaZV5taiAoEI
 4DLiySElzs32AAsaiiTS5jaRKzQJCG7xoiI0jJ92axMKBpZTj9fFbw8I3B04i7j4SmUd
 V81g==
X-Gm-Message-State: APjAAAVsgMdutCgRtxhHxuXSk6eSJWrj5igPiybMqSLPQTxrJnAindrj
 e5kuDIvsdz7aN7FbRmdocbdKs6Dqy/Lg/7xf73mLX13UOtiy8Hl1eW1EjscHb7yDU7qZKSgPiZZ
 SzaP10xnzHaMG0JE=
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr9811866wrn.198.1567097280696; 
 Thu, 29 Aug 2019 09:48:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykRGuEuLOwp0yf1q7fBYtqgIr3zFEL+4/KY/NVMDBhyvZ0781hZUAhQ0G+9CwF1+nIajZgoQ==
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr9811841wrn.198.1567097280538; 
 Thu, 29 Aug 2019 09:48:00 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o17sm3813876wrx.60.2019.08.29.09.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:48:00 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828190456.30315-1-richard.henderson@linaro.org>
 <20190828190456.30315-57-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <184f0a09-c850-91e1-3af8-904dbf44fc0c@redhat.com>
Date: Thu, 29 Aug 2019 18:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828190456.30315-57-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 56/69] target/arm: Convert T16, extract
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

On 8/28/19 9:04 PM, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c | 14 +-------------
>  target/arm/t16.decode  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b7e2c72f35..d06ec48ab9 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10743,21 +10743,9 @@ static void disas_thumb_insn(DisasContext *s, =
uint32_t insn)
>          op =3D (insn >> 8) & 0xf;
>          switch (op) {
>          case 0: /* add/sub (sp, immediate), in decodetree */
> +        case 2: /* sign/zero extend, in decodetree */
>              goto illegal_op;
> =20
> -        case 2: /* sign/zero extend.  */
> -            ARCH(6);
> -            rd =3D insn & 7;
> -            rm =3D (insn >> 3) & 7;
> -            tmp =3D load_reg(s, rm);
> -            switch ((insn >> 6) & 3) {
> -            case 0: gen_sxth(tmp); break;
> -            case 1: gen_sxtb(tmp); break;
> -            case 2: gen_uxth(tmp); break;
> -            case 3: gen_uxtb(tmp); break;
> -            }
> -            store_reg(s, rd, tmp);
> -            break;
>          case 4: case 5: case 0xc: case 0xd:
>              /*
>               * 0b1011_x10x_xxxx_xxxx
> diff --git a/target/arm/t16.decode b/target/arm/t16.decode
> index b425b86795..b5b5086e8a 100644
> --- a/target/arm/t16.decode
> +++ b/target/arm/t16.decode
> @@ -23,6 +23,7 @@
>  &s_rrr_shr       !extern s rn rd rm rs shty
>  &s_rri_rot       !extern s rn rd imm rot
>  &s_rrrr          !extern s rd rn rm ra
> +&rrr_rot         !extern rd rn rm rot
>  &ri              !extern rd imm
>  &r               !extern rm
>  &ldst_rr         !extern p w u rn rt rm shimm shtype
> @@ -173,3 +174,12 @@ BX              0100 0111 0 .... 000            @b=
ranchr
>  BLX_r           0100 0111 1 .... 000            @branchr
>  BXNS            0100 0111 0 .... 100            @branchr
>  BLXNS           0100 0111 1 .... 100            @branchr
> +
> +# Extend
> +
> +@extend         .... .... .. rm:3 rd:3          &rrr_rot rn=3D15 rot=3D=
0
> +
> +SXTAH           1011 0010 00 ... ...            @extend
> +SXTAB           1011 0010 01 ... ...            @extend
> +UXTAH           1011 0010 10 ... ...            @extend
> +UXTAB           1011 0010 11 ... ...            @extend
>=20

