Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E93C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6DC205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnHWIJ/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7iO-0006v9-JI
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:57:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7h7-00068c-ME
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7h2-0007IU-1O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7gy-0007EO-CG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:55:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id 77so2699560otu.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ZbTgAbM3/4VCJYChvyXRRrwSToAKKNFGEcrRHjAZUeI=;
	b=HnHWIJ/p95o1Hbp2zdoZb1sOjh36PLUkA++ijr+3WdJciZkGinYMLo3W/+FevyxVBK
	KwxVJBJc5rrXn3ioKVuNUo/EBTHD0ZNHCy6KoPN462tnb3xck5kcg9vWR4O4aDu5VFkM
	ORLJ+n52vg34jF0T6DpK+A3V59iNIeugYbpmhuxc+a4rjBDGTlIr6Qa/8DIn6UxBnLQb
	qpRaWua74uhgySpXEdJ7QYsa31OPvOnl0n1DfI6pWpSGPH56wtCeLKKF5heENb1Miu05
	zpXz5hBMIX6b0I526fxeEdClzKLvbDIGZGt1bKIuCA0TvQOgCaEItSNo9YyNpCSSHaWA
	/Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ZbTgAbM3/4VCJYChvyXRRrwSToAKKNFGEcrRHjAZUeI=;
	b=LOTGVJC4VqkDV72hAO2qc5EVVMfv4apOorHL9sx2Lh+TBynI0e3/bZn38snlUFLAn0
	Cqufd6ZwWUsy/dqNdijdMpwGEOn1f9zsNd7ITFXuaJON/XFIniyz3tAQ4qo51F05Ka0i
	RHLR4Sfhn45yS3zFhjCm+sGh2blpVPYD3kTyVEIJfrDxnhl5CgJUN/bp3KTpndqIRfnk
	X9ahsCOe43wWjeja/0kbMG2B2CR5J2AY+BCTSk0vIL0mo/Ffub1sOKS4RHOY5qg5LpQo
	rNokQnrbC38aBnyAcjeng71i+f3WeN28P0HZeTzHzjrDmAGozhBrfLRyFRdYlxVPoMil
	rmTQ==
X-Gm-Message-State: APjAAAUJtBJ0JbttzzrpS1GZscikzT/UP3ZkAKJwiUvXL5cCWY36dsXZ
	zGWFmk69Grpd4x5ZEXapk1d7m8lrROiVSQhzO3zB0A==
X-Google-Smtp-Source: APXvYqwLFZjYyA0+41oDSd3muWPMrxq+I4BMzrccuACCrLpoDuRdy9WdNFJFpS05jPhmywZGJbyyxYn1/c/I9kvpIwA=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr4275389oti.151.1556549731993; 
	Mon, 29 Apr 2019 07:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-36-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:55:21 +0100
Message-ID:
 <CAFEAcA8u8GgWK=YQ40-OD_eA2JarA7JrOAPsxfrqkbzyT1aoGg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 35/36] tcg/aarch64: Use LDP to
 load tlb mask+table
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429145521.UlG272OdB9yd1A4MLeJ0D_ziNzUhqXf-b32xSlTVlCQ@z>

On Thu, 28 Mar 2019 at 23:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index ac765137ae..979efbcfe4 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1463,14 +1463,11 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
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
> @@ -1478,8 +1475,8 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
>                   ? TCG_TYPE_I64 : TCG_TYPE_I32);
>
>      /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */

The field names in this comment are out of date, I think ?

> -    tcg_out_ld(s, mask_type, TCG_REG_X0, mask_base, mask_ofs);
> -    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, table_base, table_ofs);
> +    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
> +                 TLB_MASK_TABLE_OFS(mem_index), 1, 0);

Can we have a compile time assert somewhere that the
mask and table fields are at the offsets in CPUTLBDescFast
that we expect them to be?

thanks
-- PMM

