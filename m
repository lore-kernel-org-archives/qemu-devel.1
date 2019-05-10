Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4750AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C71720989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKfl21Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C71720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPChB-0008MD-B6
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:04:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCgE-00084d-SC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hPCgD-0003TG-QZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:03:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hPCgD-0003SF-Iv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:03:45 -0400
Received: by mail-lj1-x244.google.com with SMTP id n4so6220635ljg.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=epZjphsjgMIkucQ47AJfCq6Rn4M2QQf7nE7JcYsrgEc=;
	b=kKfl21QxKYKV/V1c5pj0fj1BjGyB2KNIgLQebgXSjcTyI+2RvyzsQ/SbRBoFC0kfzo
	QoUgoznA/2fa3VVY07Gkose+c+49DWyOnpugrfC4fboOeGvN2aw/QFG9Stco3udTBPtY
	g2qb06hBLE0CpR29id57jNmbZpdpYHiezyaAkWfuKPazJ+UBAg50cDsf3Zzd4KX+j/ea
	iTu7pE+OnvzBUF+FgDF3TbFDuvXakX5Wn/1AZjUVaxq6xI21hlpJkSSdtcvRT9BpeoDK
	6+btgyC4frt+iFysLL3tgsPETcozr+xkqi8HG5sq0nmMYPUAiYLyp5WIu3dcD3CdDwuE
	z8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=epZjphsjgMIkucQ47AJfCq6Rn4M2QQf7nE7JcYsrgEc=;
	b=cy7KQst65HVeykQhTISVZcEJHEbqNpvlWRV1BpT9SSVDkKqGXK186DMmQStyAsj7HL
	Cm457YFpx9bgsXFPhD/kAwoJaALNZj+RZwcOLIehQNQFm4P9T6NZLFh5btyrYIFymPl8
	C1U++fGC9vHQWXPGoJPCGo0UnyAVdb4qnOsLasi0XceWxc6xkT6Cr5vojcr9eH+LzzUk
	ls5sYC/AFMOrk7a4xaAa+EcIEzK9IlWZb9GaSu9p4wK9VmhjXTzbuLyrg3xAqmY351ds
	Zh0Fy1vkPvV40FlH9ETfQBYAO2Mff8qxiq2rufcoayhH8ZzYOCNU99RPiVg20913/3Bt
	32Gw==
X-Gm-Message-State: APjAAAU+hCsK7KG2XY7M+M8XYouhZiV/Mkc92Fmhl3TDTrnfZmfx1Nyz
	9fa/6EW8YRkqDskj8Q1e3dkrahq84UArPVIT8aQ=
X-Google-Smtp-Source: APXvYqzWt7Gzxp4PcOdNvyBdWgRfC+Dif4nt8bDn0ZgXTO2soKf9T+x7DbT23oeR14uJtF6lDPEG/yYwG3g6jUDLoZw=
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr7027952lji.28.1557522224233;
	Fri, 10 May 2019 14:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-38-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-38-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 May 2019 14:01:35 -0700
Message-ID: <CAKmqyKPrrLHvjsmX5jMTv72djo3aCD1ta7Z_D5-H_uEqs65wZg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v3 37/39] tcg/aarch64: Use LDP to load tlb
 mask+table
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:29 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This changes the code generation for the tlb from e.g.
>
>         ldur     x0, [x19, #0xffffffffffffffe0]
>         ldur     x1, [x19, #0xffffffffffffffe8]
>         and      x0, x0, x20, lsr #8
>         add      x1, x1, x0
>         ldr      x0, [x1]
>         ldr      x1, [x1, #0x18]
>
> to
>
>         ldp      x0, x1, [x19, #-0x20]
>         and      x0, x0, x20, lsr #8
>         add      x1, x1, x0
>         ldr      x0, [x1]
>         ldr      x1, [x1, #0x18]
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v3: Add QEMU_BUILD_BUG_ON for mask/table ordering; comment fixes.
> ---
>  tcg/aarch64/tcg-target.inc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index afac018301..2863a371a0 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1459,6 +1459,10 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
>  QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
>
> +/* These offsets are built into the LDP below.  */
> +QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
> +QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
> +
>  /* Load and compare a TLB entry, emitting the conditional jump to the
>     slow path for the failure case, which will be patched later when finalizing
>     the slow path. Generated code returns the host addend in X1,
> @@ -1467,23 +1471,20 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
>                               tcg_insn_unit **label_ptr, int mem_index,
>                               bool is_read)
>  {
> -    int fast_ofs = TLB_MASK_TABLE_OFS(mem_index);
> -    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
> -    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
>      unsigned a_bits = get_alignment_bits(opc);
>      unsigned s_bits = opc & MO_SIZE;
>      unsigned a_mask = (1u << a_bits) - 1;
>      unsigned s_mask = (1u << s_bits) - 1;
> -    TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0, x3;
> +    TCGReg x3;
>      TCGType mask_type;
>      uint64_t compare_mask;
>
>      mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
>                   ? TCG_TYPE_I64 : TCG_TYPE_I32);
>
> -    /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
> -    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
> -    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
> +    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
> +    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
> +                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);
>
>      /* Extract the TLB index from the address into X0.  */
>      tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
> --
> 2.17.1
>
>

