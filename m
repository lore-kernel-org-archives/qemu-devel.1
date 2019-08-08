Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0832C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9D721880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvfew2mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D721880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvgob-0004kR-MP
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvgo7-0004EM-2o
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvgo4-0008Bv-L2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:42:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hvgo4-0008Bk-Dy; Thu, 08 Aug 2019 07:42:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id d17so117359998oth.5;
 Thu, 08 Aug 2019 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CKno2DapZpYQu3Z86w+Y/66MwzpYCKih6dsAa+KGQMM=;
 b=Nvfew2mLDamU8cFkBhiE2CiDDCVnotyr+hOUtAfW7/+xfmWZotY5HkD7FutbawFQ9l
 p7pAhxypd2PXJ+z9YPgCXnPbBEh7sDUoXhdVZCj60t9MahN5LtisHl6E9nNkobIZz+gQ
 bOuDc9Aop7eiPF9pA+Mx6sjWYGQcl0rtso+y/N4L83NUGiLtivmOsxVEIm3Wpkfo38qp
 Ly/uFN9ZQ0OeE9ksxZHyyjeV76xwUAqZOyIuYkl5m9SP4DNkvXCC/EO7IvQsKQquzUgH
 da9CJYAuYwheKzLkSOZVLiTE1s5BW5qRZrQsnz28ivc8lh3Ik5FtaJVGkk1tcrTOIMg1
 6tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CKno2DapZpYQu3Z86w+Y/66MwzpYCKih6dsAa+KGQMM=;
 b=TNim+5x1OVhedniQJEwvz8f7lvhYFcR/YGMrB9U6o4IBZW53CuGq2mvvSmTeIkiCUk
 Yv/exP6k9w0i3+U4Nwm3mFNDe5w0Jf+b5ktwRKExsXTEhhCs/O4p1UMfQgoHFM6cBUwX
 iCdl4/vtjatNeoYcjrs+GCHcn4uwnrZDQEgfw29Ev37wzY4RpfPtwjhyQdhAyYh3U6rN
 zi87/oAkFhaGiQ2v1RdtiD2IGkOnw13hD8/HJgNDKL3Wlb3hAo0/VmnxrJc3WZTi3Jgp
 LgZqozC06MFFFI7+2uhb65uaA4ZVTwc+0C3cbjDHlXdmt8tLm9BbsVjlmTaKr0KY5nfg
 apiQ==
X-Gm-Message-State: APjAAAVSQGkfNyoAXMncVLTlpMJ3gMS/aniOVBkqLqVbkyZZzdkaDK1K
 TvWvwMix3dpZqp44+I4qYkaaTQnVrtaRMOKZs2g=
X-Google-Smtp-Source: APXvYqycvW8qLjEFI1IdB++gfO6awBOibqkHotUF7WIlQxSpl0A8fDc5jIFe4oIeNwCNK3/oTRDkW6QyAfPQQwrNuLw=
X-Received: by 2002:a54:4619:: with SMTP id p25mr2464756oip.62.1565264527449; 
 Thu, 08 Aug 2019 04:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
In-Reply-To: <20190726175032.6769-12-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 8 Aug 2019 13:41:56 +0200
Message-ID: <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 8:05 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Add the infrastructure that will become the new decoder.
> No instructions adjusted so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c       | 45 +++++++++++++++++++++++++++++++++++-
>  target/arm/Makefile.objs     | 18 +++++++++++++++
>  target/arm/a32-uncond.decode | 23 ++++++++++++++++++
>  target/arm/a32.decode        | 23 ++++++++++++++++++
>  target/arm/t32.decode        | 20 ++++++++++++++++
>  5 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/a32-uncond.decode
>  create mode 100644 target/arm/a32.decode
>  create mode 100644 target/arm/t32.decode
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 36419025db..4738b91957 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7715,6 +7715,33 @@ static void arm_skip_unless(DisasContext *s,
> uint32_t cond)
>      }
>  }
>
> +/*
> + * Include the generated decoders.
> + * Note that the T32 decoder reuses some of the trans_* functions
> + * initially declared by the A32 decoder, which results in duplicate
> + * declaration warnings.  Suppress them.
> + */
> +
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Wredundant-decls"
> +# ifdef __clang__
> +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> +# endif
> +#endif
> +
>

This looks more like a "band aid" solution rather than the right one.

I find it surprising that in spite of ever-growing complexity and numerous
refinements of the decodetree module, it still generates code that causes
these complaints of the compiler.

Regards,
Aleksandar



> +#include "decode-a32.inc.c"
> +#include "decode-a32-uncond.inc.c"
> +#include "decode-t32.inc.c"
> +
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic pop
> +#endif
> +
> +/*
> + * Legacy decoder.
> + */
> +
>  static void disas_arm_insn(DisasContext *s, unsigned int insn)
>  {
>      unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
> @@ -7733,7 +7760,8 @@ static void disas_arm_insn(DisasContext *s, unsigned
> int insn)
>          return;
>      }
>      cond = insn >> 28;
> -    if (cond == 0xf){
> +
> +    if (cond == 0xf) {
>          /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
>           * choose to UNDEF. In ARMv5 and above the space is used
>           * for miscellaneous unconditional instructions.
> @@ -7741,6 +7769,11 @@ static void disas_arm_insn(DisasContext *s,
> unsigned int insn)
>          ARCH(5);
>
>          /* Unconditional instructions.  */
> +        if (disas_a32_uncond(s, insn)) {
> +            return;
> +        }
> +        /* fall back to legacy decoder */
> +
>          if (((insn >> 25) & 7) == 1) {
>              /* NEON Data processing.  */
>              if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> @@ -7953,6 +7986,11 @@ static void disas_arm_insn(DisasContext *s,
> unsigned int insn)
>
>      arm_skip_unless(s, cond);
>
> +    if (disas_a32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      if ((insn & 0x0f900000) == 0x03000000) {
>          if ((insn & (1 << 21)) == 0) {
>              ARCH(6T2);
> @@ -9440,6 +9478,11 @@ static void disas_thumb2_insn(DisasContext *s,
> uint32_t insn)
>          ARCH(6T2);
>      }
>
> +    if (disas_t32(s, insn)) {
> +        return;
> +    }
> +    /* fall back to legacy decoder */
> +
>      rn = (insn >> 16) & 0xf;
>      rs = (insn >> 12) & 0xf;
>      rd = (insn >> 8) & 0xf;
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 5cafc1eb6c..7806b4dac0 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -28,9 +28,27 @@ target/arm/decode-vfp-uncond.inc.c:
> $(SRC_PATH)/target/arm/vfp-uncond.decode $(D
>           $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@
> $<,\
>           "GEN", $(TARGET_DIR)$@)
>
> +target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode
> $(DECODETREE)
> +       $(call quiet-command,\
> +         $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
> +         "GEN", $(TARGET_DIR)$@)
> +
> +target/arm/decode-a32-uncond.inc.c:
> $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
> +       $(call quiet-command,\
> +         $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@
> $<,\
> +         "GEN", $(TARGET_DIR)$@)
> +
> +target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode
> $(DECODETREE)
> +       $(call quiet-command,\
> +         $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
> +         "GEN", $(TARGET_DIR)$@)
> +
>  target/arm/translate-sve.o: target/arm/decode-sve.inc.c
>  target/arm/translate.o: target/arm/decode-vfp.inc.c
>  target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
> +target/arm/translate.o: target/arm/decode-a32.inc.c
> +target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
> +target/arm/translate.o: target/arm/decode-t32.inc.c
>
>  obj-y += tlb_helper.o debug_helper.o
>  obj-y += translate.o op_helper.o
> diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
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
> +# License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> +# All insns that have 0xf in insn[31:28] are decoded here.
> +# All of those that have a COND field in insn[31:28] are in a32.decode
> +#
> diff --git a/target/arm/a32.decode b/target/arm/a32.decode
> new file mode 100644
> index 0000000000..2d84a02861
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
> +# License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> +# All of the insn that have a COND field in insn[31:28] are here.
> +# All insns that have 0xf in insn[31:28] are in a32u.decode.
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
> +# License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> +
> +#
> +# This file is processed by scripts/decodetree.py
> +#
> --
> 2.17.1
>
>
>
