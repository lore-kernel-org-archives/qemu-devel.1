Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE5AC04AAA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB42B2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwrAMRuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB42B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaWb-0005NT-23
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:55:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaVk-00054c-CC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaVi-0006Jz-P4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaVi-0006Hu-GD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so8488846wrp.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=phvQdGPDrTv40hatsvI2zYnn1lXqke4gviF65+Xb/ao=;
	b=vwrAMRuTBwCewcaUXSYhOcWXWOEw2RPj2knUzpvubkfTUGRduJOPelYx9fl9OCucA9
	6gP7//9N6jl8t0hwiVUl3CUtG4nfYh/vMtvz/TXxr4I9HidJRagPxVgREHfNXs8nCBSH
	EP0jwfrbTuGdKC8wZm4kojmUd4AawFi5ZxUgjTiJIUd9bH4vrvPDI7NMPBeWN1sC0EMp
	wa+BIjOExMLvum7daO6/zhGSp56ovIdFys5ubXh5Guc4/+EFTjN99Ejb4BonGTNyv+ql
	3WsdUs/VQIijDKEHLq1vjtD8Nnt4rPKh4VgazqX0vU43Y4bqJPuZG7NQCZ/JtEd5Mf5C
	HpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=phvQdGPDrTv40hatsvI2zYnn1lXqke4gviF65+Xb/ao=;
	b=a6I2ZXYRXfFEkCatG2rP6tWdzOg0fSTwHCsjH+9wjjIPixQlrhKxXh98AI+48ctOzo
	owMLFmO4E7AMdEV+mv0tS6ZtvEWbkn7h3maN9yfZicVBnYNxFgPSVTpuWo8wYEb3SNfS
	sDVcPA6k+S9FGl6c5iP2EgdqPVNHclI3d7pQQ+sq3zPlkLSETpOf1Jj2SeIX5hJdu0fn
	BctweKARIRI+xsOoQKatj6tMAaXpRLeJkIJlyI/P4q8QcrSF2IHZxufY9lAGw2p0M1xm
	NDPsMmEVB0mU7B4/BRH8exKo8dmT26Kf/QvCh8+YBAu5tko+1YxMSeDEc3urNXzPiZ9p
	jGLQ==
X-Gm-Message-State: APjAAAXxqkofbGVbIUKeZyKgNkafAuOSIjQzf/Ux1pTjhETT83Dp9beK
	HGJ+wTzLauEfxTsdmYYkErkg3Q==
X-Google-Smtp-Source: APXvYqy7kJ7zd9osUbkZoRmFm9X5s4MhVBO7djcgXKzc8n8EXInVe63mDsVOQtZSveF+eVs4spoE6w==
X-Received: by 2002:a5d:4348:: with SMTP id u8mr7921956wrr.129.1556898844892; 
	Fri, 03 May 2019 08:54:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h81sm6033602wmf.33.2019.05.03.08.54.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 08:54:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D6BDB1FF87;
	Fri,  3 May 2019 16:54:03 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-5-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-5-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:54:03 +0100
Message-ID: <87h8ab4jqc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH RFC v8 04/12] target/rx: RX disassembler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503155403.ES8YVW_J3R0jLK6E1Z0yylq9-g2og-Xt9OygLmcFJC0@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/disas/dis-asm.h |    5 +
>  target/rx/disas.c       | 1481 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1486 insertions(+)
>  create mode 100644 target/rx/disas.c
>
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 9240ec32c2..de17792e88 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -226,6 +226,10 @@ enum bfd_architecture
>  #define bfd_mach_nios2r2        2
>    bfd_arch_lm32,       /* Lattice Mico32 */
>  #define bfd_mach_lm32 1
> +  bfd_arch_rx,       /* Renesas RX */
> +#define bfd_mach_rx            0x75
> +#define bfd_mach_rx_v2         0x76
> +#define bfd_mach_rx_v3         0x77
>    bfd_arch_last
>    };
>  #define bfd_mach_s390_31 31
> @@ -433,6 +437,7 @@ int print_insn_little_nios2     (bfd_vma, disassemble=
_info*);
>  int print_insn_xtensa           (bfd_vma, disassemble_info*);
>  int print_insn_riscv32          (bfd_vma, disassemble_info*);
>  int print_insn_riscv64          (bfd_vma, disassemble_info*);
> +int print_insn_rx(bfd_vma, disassemble_info *);
>
>  #if 0
>  /* Fetch the disassembler for a given BFD, if that support is available.=
  */
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> new file mode 100644
> index 0000000000..014fadfca3
> --- /dev/null
> +++ b/target/rx/disas.c
> @@ -0,0 +1,1481 @@
> +/*
> + * Renesas RX Disassembler
> + *
> + * Copyright (c) 2019 Yoshinori Sato <ysato@users.sourceforge.jp>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "disas/dis-asm.h"
> +#include "qemu/bitops.h"
> +#include "cpu.h"
> +
> +typedef struct DisasContext {
> +    disassemble_info *dis;
> +    uint32_t addr;
> +    uint32_t pc;
> +} DisasContext;
> +
> +
> +static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
> +                           int i, int n)
> +{
> +    bfd_byte buf;
> +    while (++i <=3D n) {
> +        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
> +        insn |=3D buf << (32 - i * 8);
> +    }
> +    return insn;
> +}
> +
> +static int32_t li(DisasContext *ctx, int sz)
> +{
> +    int32_t addr;
> +    bfd_byte buf[4];
> +    addr =3D ctx->addr;
> +
> +    switch (sz) {
> +    case 1:
> +        ctx->addr +=3D 1;
> +        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> +        return buf[0];
> +    case 2:
> +        ctx->addr +=3D 2;
> +        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> +        return buf[1] << 8 | buf[0];
> +    case 3:
> +        ctx->addr +=3D 3;
> +        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
> +        return buf[2] << 16 | buf[1] << 8 | buf[0];
> +    case 0:
> +        ctx->addr +=3D 4;
> +        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
> +        return buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static int bdsp_s(DisasContext *ctx, int d)
> +{
> +    /*
> +     * 0 -> 8
> +     * 1 -> 9
> +     * 2 -> 10
> +     * 3 -> 3
> +     * :
> +     * 7 -> 7
> +     */
> +    if (d < 3) {
> +        d +=3D 8;
> +    }
> +    return d;
> +}
> +
> +/* Include the auto-generated decoder.  */
> +#include "decode.inc.c"

This introduces a dependency on a generated file so you'll need:

target/rx/disas.o: target/rx/decode.inc.c

in Makefile.objs

--
Alex Benn=C3=A9e

