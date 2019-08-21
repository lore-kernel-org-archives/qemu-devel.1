Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B627C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F31E2339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F31E2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qcl-0007IX-T9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QZS-0001vQ-Bn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QZR-00009S-8K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QZQ-00008d-VA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:22:37 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08A53C057E9A
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:22:36 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b1so1225643wru.4
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w2V8fHoT7g/hE3y1MUfQuj/SBJjLfoDC7skvCwNQJq4=;
 b=MAyWQKC2uGwDcU1CV0c9l0xzfqXtXFylpwAG3/IjgMZkANvvZBOcB2ZdFuOfF8tuI7
 0UwCNIiSmHQnE5J6N1SuMBNEfxvOoI7RFEfXNQZSTCyKn3mM5Ehe8iwV3iVnp0aq/jLa
 UHiOnFZeHYG+iXhufAI0MM2lepFUuQjZiJEmeXlY+1YHdDgNN8E3V1M/zp2VMw/VOVpf
 MEazzPvrGARJmp3dJzDjPBtP8FYa50A5aTrfxPhCgM+L5GiXQ69n7JiJAsNPB+x5QJ++
 ZoGPpvuj96wBfSpMuBAxuRY5R2/Yz7xZZkn088JWz2nJ5HQzQNzZbgnQ3a7C2T7FGO+6
 bmCg==
X-Gm-Message-State: APjAAAW2MOtE8A6Ios0Q+m+imYOR5qv04eHkEYgVgxN+ndhk5He7N4i8
 RXYNPYzSAXGwttACuqWX2DQXJMctbVWEBZQI8YYalRAhGiLIUpSlrMuXzj1kROvpQNviIJY5tl+
 plIgUgzCJSHM6RFY=
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr6077210wml.77.1566393754729; 
 Wed, 21 Aug 2019 06:22:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDDzV3ZAPsNkJzkY/1e4u3O5U+/YrcDMd3PlLJE8JvZF4/4059hwJAEw4xQ81Xl2HpGS4G8A==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr6077195wml.77.1566393754502; 
 Wed, 21 Aug 2019 06:22:34 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v124sm5301627wmf.23.2019.08.21.06.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:22:33 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-37-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f5cc0c43-d366-6e3f-c741-47d70c95c429@redhat.com>
Date: Wed, 21 Aug 2019 15:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 36/68] target/arm: Convert SETEND
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
>  target/arm/translate.c       | 22 +++++++++++++---------
>  target/arm/a32-uncond.decode |  4 ++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 928205d993..46e88d1d17 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10124,6 +10124,18 @@ static bool trans_SB(DisasContext *s, arg_SB *=
a)
>      return true;
>  }
> =20
> +static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
> +{
> +    if (!ENABLE_ARCH_6) {
> +        return false;
> +    }
> +    if (a->E !=3D (s->be_data =3D=3D MO_BE)) {

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        gen_helper_setend(cpu_env);
> +        s->base.is_jmp =3D DISAS_UPDATE;
> +    }
> +    return true;
> +}
> +
>  /*
>   * Legacy decoder.
>   */
> @@ -10209,15 +10221,7 @@ static void disas_arm_insn(DisasContext *s, un=
signed int insn)
>              return; /* v7MP: Unallocated memory hint: must NOP */
>          }
> =20
> -        if ((insn & 0x0ffffdff) =3D=3D 0x01010000) {
> -            ARCH(6);
> -            /* setend */
> -            if (((insn >> 9) & 1) !=3D !!(s->be_data =3D=3D MO_BE)) {
> -                gen_helper_setend(cpu_env);
> -                s->base.is_jmp =3D DISAS_UPDATE;
> -            }
> -            return;
> -        } else if ((insn & 0x0e000f00) =3D=3D 0x0c000100) {
> +        if ((insn & 0x0e000f00) =3D=3D 0x0c000100) {
>              if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
>                  /* iWMMXt register transfer.  */
>                  if (extract32(s->c15_cpar, 1, 1)) {
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decod=
e
> index eb1c55b330..d5ed48f0fd 100644
> --- a/target/arm/a32-uncond.decode
> +++ b/target/arm/a32-uncond.decode
> @@ -24,6 +24,7 @@
> =20
>  &empty           !extern
>  &i               !extern imm
> +&setend          E
> =20
>  # Branch with Link and Exchange
> =20
> @@ -50,3 +51,6 @@ DSB              1111 0101 0111 1111 1111 0000 0100 -=
---
>  DMB              1111 0101 0111 1111 1111 0000 0101 ----
>  ISB              1111 0101 0111 1111 1111 0000 0110 ----
>  SB               1111 0101 0111 1111 1111 0000 0111 0000
> +
> +# Set Endianness
> +SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
>=20

