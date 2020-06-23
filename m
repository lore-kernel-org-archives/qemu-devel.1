Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB1FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D752080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVnxD73y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D752080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpBC-00049m-C7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <derrick.mckee@gmail.com>)
 id 1jnp0l-00052u-1u; Tue, 23 Jun 2020 15:55:15 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <derrick.mckee@gmail.com>)
 id 1jnp0i-0008QK-TK; Tue, 23 Jun 2020 15:55:14 -0400
Received: by mail-qt1-x844.google.com with SMTP id g13so6018837qtv.8;
 Tue, 23 Jun 2020 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GK3pL52JblkrMAgCVuqUxoVNn02inswLMPdRIlOeNm8=;
 b=vVnxD73y9/TcjjagmKy04IhNkl/ixXzhPc57dH33ctTGbcb1dyoVD884IQpDCKq/Vy
 aVVZErL+GbuZgop3ZKPABRPkxtGngJTim6Vt31syQK2q2uLaoD68XeCZYBEPOnq4jGw7
 8SvlYdgBBfnxDsWQKkmUDEJhKKd03rMfDzISe0cxXXG9vXzq+E6PsyXAArCYNqLWpvVW
 iGnWg2tkXXhZPd0BLHFp7ab1/W25EBM0zrMnHeOl+eGA6BSnONgijMqVW2hK5AMYtTx7
 4R/GeASmrQNj3omv/qY1wOfxdjq1+bwgME3VXEZL3QcE1LUgkpJhxvZXnHcvkozybh6h
 MLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GK3pL52JblkrMAgCVuqUxoVNn02inswLMPdRIlOeNm8=;
 b=ZhcIW21GfVjChTdkORtDdL+uVDYqNl8CtzFaCQENIfrgtLLhfmcCfbYP7ckJWtjLG5
 imKW9mvO2NeYh/M1Gn5l8IvcfwjJTFpmke9KQX7nDteoBqksybwkOSd1vMw/ZvzUi7eb
 rEkXUnMhM+67r+cGP3rC25CjFiAkT/F2zXMHRb1zW1X7aPaR71o1FX4DXtN+hspZX7gL
 cBgICs8jpTh50nnWA6F4rJJfg+Fiey8lFxWYPgHRtgTubQdRlodeFkSePXPdvyk7xP2J
 oiE/061qPvWNkqnOnEa6Vgc2thnp7B5laR8aiBHvwajPcV5ZDvgOGq186R/YxXgCk5SF
 i9GA==
X-Gm-Message-State: AOAM533BNSasIlatZdtMJe4KppnrgWCy9iT2dkJ0MWj07+8yLHMl/uvj
 Khu+JA4S8kmc+RFS/Brm3jmLtelXJc6iqEQ3XAg=
X-Google-Smtp-Source: ABdhPJx5T5/2r+7rIyiImLCdfFVPEQsxc5o1SwjWYVG4IuGANnlD9WbClUDgpCLnQbzNNKm83FbubtkJZ0pSh1NRiiM=
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr22899454qtm.171.1592942110985; 
 Tue, 23 Jun 2020 12:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
From: Derrick McKee <derrick.mckee@gmail.com>
Date: Tue, 23 Jun 2020 15:55:00 -0400
Message-ID: <CAJoBWHy9HfD_hBbJNgG5vsM5Wt_kiYYJyYAnxfTNzq2nuohk+w@mail.gmail.com>
Subject: Re: [PATCH v8 00/45] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=derrick.mckee@gmail.com; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, steplong@quicinc.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, david.spickett@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

I am currently doing research with MTE, and Arm's FVP leaves a lot to
be desired.  Is there some way I can get access to your QEMU changes
that enable MTE for system emulation?  Thanks.

On Tue, Jun 23, 2020 at 3:37 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 8 incorporates quite a bit of review (thanks, PMM):
>
>  * Include HCR_DCT in the HCR_EL2 update.
>  * Use a separate decode function for ADDG/SUBG.
>  * Use the system arm_cpu_do_unaligned_access for user-only as well.
>  * Fix alignment for LDG.
>  * Fix no-fault for mte_probe1.
>  * Rearrage how tagged pages are recorded.
>
> and perhaps most visibly, for those tracking the kernel patches:
>
>  * Add arm,armv8.5-memtag to the dtb.
>
>
> r~
>
>
> In need of review:
> 0010-target-arm-Revise-decoding-for-disas_add_sub_imm.patch
> 0011-target-arm-Implement-the-ADDG-SUBG-instructions.patch
> 0014-target-arm-Define-arm_cpu_do_unaligned_access-for.patch
> 0015-target-arm-Implement-LDG-STG-ST2G-instructions.patch
> 0025-target-arm-Implement-helper_mte_check1.patch
> 0028-target-arm-Use-mte_checkN-for-sve-unpredicated-lo.patch
> 0029-target-arm-Use-mte_checkN-for-sve-unpredicated-st.patch
> 0030-target-arm-Use-mte_check1-for-sve-LD1R.patch
> 0031-target-arm-Tidy-trans_LD1R_zpri.patch
> 0032-target-arm-Add-arm_tlb_bti_gp.patch
> 0033-target-arm-Add-mte-helpers-for-sve-scalar-int-loa.patch
> 0034-target-arm-Add-mte-helpers-for-sve-scalar-int-sto.patch
> 0035-target-arm-Add-mte-helpers-for-sve-scalar-int-ff-.patch
> 0036-target-arm-Handle-TBI-for-sve-scalar-int-memory-o.patch
> 0037-target-arm-Add-mte-helpers-for-sve-scatter-gather.patch
> 0038-target-arm-Complete-TBI-clearing-for-user-only-fo.patch
> 0041-target-arm-Always-pass-cacheattr-to-get_phys_addr.patch
> 0042-target-arm-Cache-the-Tagged-bit-for-a-page-in-Mem.patch
> 0043-target-arm-Create-tagged-ram-when-MTE-is-enabled.patch
> 0044-target-arm-Add-allocation-tag-storage-for-system-.patch
> 0045-target-arm-Enable-MTE.patch
>
>
> Richard Henderson (45):
>   target/arm: Add isar tests for mte
>   target/arm: Improve masking of SCR RES0 bits
>   target/arm: Add support for MTE to SCTLR_ELx
>   target/arm: Add support for MTE to HCR_EL2 and SCR_EL3
>   target/arm: Rename DISAS_UPDATE to DISAS_UPDATE_EXIT
>   target/arm: Add DISAS_UPDATE_NOCHAIN
>   target/arm: Add MTE system registers
>   target/arm: Add MTE bits to tb_flags
>   target/arm: Implement the IRG instruction
>   target/arm: Revise decoding for disas_add_sub_imm
>   target/arm: Implement the ADDG, SUBG instructions
>   target/arm: Implement the GMI instruction
>   target/arm: Implement the SUBP instruction
>   target/arm: Define arm_cpu_do_unaligned_access for user-only
>   target/arm: Implement LDG, STG, ST2G instructions
>   target/arm: Implement the STGP instruction
>   target/arm: Restrict the values of DCZID.BS under TCG
>   target/arm: Simplify DC_ZVA
>   target/arm: Implement the LDGM, STGM, STZGM instructions
>   target/arm: Implement the access tag cache flushes
>   target/arm: Move regime_el to internals.h
>   target/arm: Move regime_tcr to internals.h
>   target/arm: Add gen_mte_check1
>   target/arm: Add gen_mte_checkN
>   target/arm: Implement helper_mte_check1
>   target/arm: Implement helper_mte_checkN
>   target/arm: Add helper_mte_check_zva
>   target/arm: Use mte_checkN for sve unpredicated loads
>   target/arm: Use mte_checkN for sve unpredicated stores
>   target/arm: Use mte_check1 for sve LD1R
>   target/arm: Tidy trans_LD1R_zpri
>   target/arm: Add arm_tlb_bti_gp
>   target/arm: Add mte helpers for sve scalar + int loads
>   target/arm: Add mte helpers for sve scalar + int stores
>   target/arm: Add mte helpers for sve scalar + int ff/nf loads
>   target/arm: Handle TBI for sve scalar + int memory ops
>   target/arm: Add mte helpers for sve scatter/gather memory ops
>   target/arm: Complete TBI clearing for user-only for SVE
>   target/arm: Implement data cache set allocation tags
>   target/arm: Set PSTATE.TCO on exception entry
>   target/arm: Always pass cacheattr to get_phys_addr
>   target/arm: Cache the Tagged bit for a page in MemTxAttrs
>   target/arm: Create tagged ram when MTE is enabled
>   target/arm: Add allocation tag storage for system mode
>   target/arm: Enable MTE
>
>  include/hw/arm/boot.h          |    3 +
>  target/arm/cpu.h               |   50 +-
>  target/arm/helper-a64.h        |   16 +
>  target/arm/helper-sve.h        |  488 ++++++++++++
>  target/arm/helper.h            |    2 +
>  target/arm/internals.h         |  153 +++-
>  target/arm/translate-a64.h     |    5 +
>  target/arm/translate.h         |   23 +-
>  hw/arm/boot.c                  |   12 +-
>  hw/arm/virt.c                  |   57 +-
>  target/arm/cpu.c               |   77 +-
>  target/arm/cpu64.c             |    1 +
>  target/arm/helper-a64.c        |   94 +--
>  target/arm/helper.c            |  423 +++++++---
>  target/arm/m_helper.c          |   11 +-
>  target/arm/mte_helper.c        |  901 +++++++++++++++++++++
>  target/arm/op_helper.c         |   16 +
>  target/arm/sve_helper.c        |  616 +++++++++++---
>  target/arm/tlb_helper.c        |   13 +-
>  target/arm/translate-a64.c     |  652 +++++++++++++--
>  target/arm/translate-sve.c     | 1366 +++++++++++++++++++++-----------
>  target/arm/translate-vfp.inc.c |    2 +-
>  target/arm/translate.c         |   16 +-
>  target/arm/Makefile.objs       |    1 +
>  24 files changed, 4164 insertions(+), 834 deletions(-)
>  create mode 100644 target/arm/mte_helper.c
>
> --
> 2.25.1
>
>


--
Derrick McKee
Phone: (703) 957-9362
Email: derrick.mckee@gmail.com

