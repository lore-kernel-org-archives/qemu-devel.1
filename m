Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A1DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444F62082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444F62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0QKk-0005bz-F3
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0QK0-00050I-UA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0QJy-0008Bo-OW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0QJy-0008BS-Gw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:06:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 476351108
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:06:37 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f9so1201421wrq.14
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hYElJxr5AFBq/nCY5K8esjGQwLIHA76r8VPjbDucolo=;
 b=sHqjJuJQo3eXBruIhOCkDkgnXwcp7aTeTkzGwzyrQOZF7TTav4SHuACT51OCVQrjV2
 /1NaR/qwzrXWiLe63/kMOjcUf+F75zG99BM+piWWc0KHoTxbFiXHko74p/QpSRgFBMYW
 g3GrvksKqJII9J+A1yFaCvbrgGoHWmG49kVBOGGLYlbRk5NwFSReh8zYSVw1abGVWwSx
 VZKzKzcDbhG8UtnypRVeRndKe3dfFI+oAKi4NpeZAVdyRhDC66nRerVIFBwXTxvEAvlx
 0Ppn0y1PDTXY6x45mtvbKwdKJQWY4UyHovXVOYQd4IACYSOjuSoGLnVi47H/zZlJgkt8
 6ccw==
X-Gm-Message-State: APjAAAWmXi1XeCDNW5lO0KMmV1stSc5VRktCblMbpmxB8yBw1v4u8wTd
 CJ2UvH1N+vN+u2A0atUvfWtA3Pe/37MT+bmCVi0nNVUHDivg4x+MUMLFlC2PrHq91pToOp3WbCg
 jxXqoBnZvQ0c/E5M=
X-Received: by 2002:a5d:4492:: with SMTP id j18mr40173607wrq.53.1566392796004; 
 Wed, 21 Aug 2019 06:06:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQaTouFSotfj+o6Y9Sz2RpvBO/+VkVQHWTfe1of+RY6++ybLrdutROU7PI1mVobf6E3WI5YA==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr40173577wrq.53.1566392795775; 
 Wed, 21 Aug 2019 06:06:35 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w13sm49817359wre.44.2019.08.21.06.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 06:06:35 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9e63bb8e-bbec-afe1-0fc4-6b7723a889ef@redhat.com>
Date: Wed, 21 Aug 2019 15:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819213755.26175-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/68] target/arm: Add stubs for aa32
 decodetree
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

On 8/19/19 11:36 PM, Richard Henderson wrote:
> Add the infrastructure that will become the new decoder.
> No instructions adjusted so far.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/arm/translate.c       | 31 ++++++++++++++++++++++++++++++-
>  target/arm/Makefile.objs     | 18 ++++++++++++++++++
>  target/arm/a32-uncond.decode | 23 +++++++++++++++++++++++
>  target/arm/a32.decode        | 23 +++++++++++++++++++++++
>  target/arm/t32.decode        | 20 ++++++++++++++++++++
>  5 files changed, 114 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/a32-uncond.decode
>  create mode 100644 target/arm/a32.decode
>  create mode 100644 target/arm/t32.decode
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index db69d998eb..c759fe0797 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7661,6 +7661,18 @@ static void arm_skip_unless(DisasContext *s, uin=
t32_t cond)
>      arm_gen_test_cc(cond ^ 1, s->condlabel);
>  }
> =20
> +/*
> + * Include the generated decoders.
> + */
> +
> +#include "decode-a32.inc.c"
> +#include "decode-a32-uncond.inc.c"
> +#include "decode-t32.inc.c"
> +
> +/*
> + * Legacy decoder.
> + */
> +
>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
>  {
>      unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
> @@ -7679,7 +7691,8 @@ static void disas_arm_insn(DisasContext *s, unsig=
ned int insn)
>          return;
>      }
>      cond =3D insn >> 28;
> -    if (cond =3D=3D 0xf){
> +
> +    if (cond =3D=3D 0xf) {
>          /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
>           * choose to UNDEF. In ARMv5 and above the space is used
>           * for miscellaneous unconditional instructions.
> @@ -7687,6 +7700,11 @@ static void disas_arm_insn(DisasContext *s, unsi=
gned int insn)
>          ARCH(5);
> =20
>          /* Unconditional instructions.  */
> +        if (disas_a32_uncond(s, insn)) {
> +            return;
> +        }
> +        /* fall back to legacy decoder */
> +
>          if (((insn >> 25) & 7) =3D=3D 1) {
>              /* NEON Data processing.  */
>              if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> @@ -7901,6 +7919,12 @@ static void disas_arm_insn(DisasContext *s, unsi=
gned int insn)
>             next instruction */
>          arm_skip_unless(s, cond);
>      }
> +
> +    if (disas_a32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      if ((insn & 0x0f900000) =3D=3D 0x03000000) {
>          if ((insn & (1 << 21)) =3D=3D 0) {
>              ARCH(6T2);
> @@ -9386,6 +9410,11 @@ static void disas_thumb2_insn(DisasContext *s, u=
int32_t insn)
>          ARCH(6T2);
>      }
> =20
> +    if (disas_t32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      rn =3D (insn >> 16) & 0xf;
>      rs =3D (insn >> 12) & 0xf;
>      rd =3D (insn >> 8) & 0xf;
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 5cafc1eb6c..7806b4dac0 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -28,9 +28,27 @@ target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/targ=
et/arm/vfp-uncond.decode $(D
>  	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
>  	  "GEN", $(TARGET_DIR)$@)
> =20
> +target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode $(DECOD=
ETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
> +	  "GEN", $(TARGET_DIR)$@)
> +
> +target/arm/decode-a32-uncond.inc.c: $(SRC_PATH)/target/arm/a32-uncond.=
decode $(DECODETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@ $<,\
> +	  "GEN", $(TARGET_DIR)$@)
> +
> +target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode $(DECOD=
ETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
> +	  "GEN", $(TARGET_DIR)$@)
> +
>  target/arm/translate-sve.o: target/arm/decode-sve.inc.c
>  target/arm/translate.o: target/arm/decode-vfp.inc.c
>  target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
> +target/arm/translate.o: target/arm/decode-a32.inc.c
> +target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
> +target/arm/translate.o: target/arm/decode-t32.inc.c
> =20
>  obj-y +=3D tlb_helper.o debug_helper.o
>  obj-y +=3D translate.o op_helper.o
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decod=
e
> new file mode 100644
> index 0000000000..8dee26d3b6
> --- /dev/null
> +++ b/target/arm/a32-uncond.decode
> @@ -0,0 +1,23 @@
> +# A32 unconditional instructions
> +#
> +#  Copyright (c) 2019 Linaro, Ltd
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> +# All insns that have 0xf in insn[31:28] are decoded here.
> +# All of those that have a COND field in insn[31:28] are in a32.decode
> +#
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> new file mode 100644
> index 0000000000..a3e6e8c1c2
> --- /dev/null
> +++ b/target/arm/a32.decode
> @@ -0,0 +1,23 @@
> +# A32 conditional instructions
> +#
> +#  Copyright (c) 2019 Linaro, Ltd
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> +# All of the insn that have a COND field in insn[31:28] are here.
> +# All insns that have 0xf in insn[31:28] are in a32-uncond.decode.
> +#
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> new file mode 100644
> index 0000000000..ac01fb6958
> --- /dev/null
> +++ b/target/arm/t32.decode
> @@ -0,0 +1,20 @@
> +# Thumb2 instructions
> +#
> +#  Copyright (c) 2019 Linaro, Ltd
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
>=20

