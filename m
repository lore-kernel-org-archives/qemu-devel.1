Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2520C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43942086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nrwh0NM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43942086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39Pp-0008Hs-UT
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k39P0-0007Dr-FC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:43:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1k39Ox-0005rk-7q
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:43:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id r21so21678123ota.10
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 19:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=p0Qufu7iydgjsjL0sratpYg3H1nHBbeoxoJFtiZLn1U=;
 b=nrwh0NM3kIk/aLF+Myn7XnaMgtlAi1ir7FGLVk/Orhg/Y31njhc+AgQIfUVVw9plZ0
 bXwsUjI2kNMUUEYtZJnITDBMRG3t1Pv2KmeLZI1XVWgFVwmBrxA4qzMzUbpjyp6fixIp
 RfX+or6guImArnp1lH+pNY0gENntcEeD6l6r/VRqP/fhcSIcd5ol/Zu0xlqaev+M75Uy
 p1wFoxs9LOmdFJ25Ycq0BhSgPZmkEpKiH5fTWkSFfvAMAD/2c2L+XFN7tXz6t0BY1jjh
 V/m61GM0xXDqOuFnQ0rvPQKyovwecoXOGpJr8s+CUZPyidHWPmyNsCc7rJDibmYtpN6n
 RTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=p0Qufu7iydgjsjL0sratpYg3H1nHBbeoxoJFtiZLn1U=;
 b=kXJ5Yyq9lybzMDn85FtQZ6EIvqgbsO5tQ8IULdWaUg7+wOmQSEXr9V02QLvS6nFVK+
 OEkO3lbRzpuocJj30vZC4HhN6ZPpSVcn7nAx9Z86Hp9zPAe8CFb12HVzTxlaL7qaBfH4
 niV8x1iuBL/bcaqfqQjNx5TyBhZTCSdDoDawdu/vFxJTlrCaLhnER1PabG7CO2YJXDU7
 wMNDIlUTkJ07M2Le0krLph7+jPnVEGsdcIAOHT2MB2Hz9FSeIoy3124UcA9h3m/fOrtx
 p2TIVnKHNIBL0JLRFNn8h2Waf5wIWMc+WrRYOC2HHdnQ9KI4WAMLpzX7hu23RMkY/B76
 zDUA==
X-Gm-Message-State: AOAM533jB0Gm+2TWZ+WahmwNhwFhLl8zn+a9JCxD5pEpmmcbS0wduJph
 Yw6x++SAE+Ren3WDnU+c5ghc/oa7J2+DdRM563AoFg==
X-Google-Smtp-Source: ABdhPJwEJNo/fy+S7t6svahfWyxI9C2YnKPTAs2EO4YKRCKn1yHBNt0fxpenSBYmJxTSYIeK7d+tzbivU1nXDM8/JyA=
X-Received: by 2002:a9d:6292:: with SMTP id x18mr921613otk.33.1596595413136;
 Tue, 04 Aug 2020 19:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595924470.git.zong.li@sifive.com>
 <6b0bf48662ef26ab4c15381a08e78a74ebd7ca79.1595924470.git.zong.li@sifive.com>
In-Reply-To: <6b0bf48662ef26ab4c15381a08e78a74ebd7ca79.1595924470.git.zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 5 Aug 2020 10:43:22 +0800
Message-ID: <CANXhq0ouxYh+q8Lj2Q6B4cGLc7wUj+SfrjMFvLz-8Z+Xpf+3sg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] target/riscv: Change the TLB page size depends on
 PMP entries.
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=zong.li@sifive.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 4:26 PM Zong Li <zong.li@sifive.com> wrote:
>
> The minimum granularity of PMP is 4 bytes, it is small than 4KB page
> size, therefore, the pmp checking would be ignored if its range doesn't
> start from the alignment of one page. This patch detects the pmp entries
> and sets the small page size to TLB if there is a PMP entry which cover
> the page size.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  target/riscv/cpu_helper.c | 10 ++++++--
>  target/riscv/pmp.c        | 52 +++++++++++++++++++++++++++++++++++++++
>  target/riscv/pmp.h        |  2 ++
>  3 files changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2f337e418c..fd1d373b6f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -693,6 +693,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      bool first_stage_error = true;
>      int ret = TRANSLATE_FAIL;
>      int mode = mmu_idx;
> +    target_ulong tlb_size = 0;
>
>      env->guest_phys_fault_addr = 0;
>
> @@ -784,8 +785,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      }
>
>      if (ret == TRANSLATE_SUCCESS) {
> -        tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> -                     prot, mmu_idx, TARGET_PAGE_SIZE);
> +        if (pmp_is_range_in_tlb(env, pa & TARGET_PAGE_MASK, &tlb_size)) {
> +            tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
> +                         prot, mmu_idx, tlb_size);
> +        } else {
> +            tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> +                         prot, mmu_idx, TARGET_PAGE_SIZE);
> +        }
>          return true;
>      } else if (probe) {
>          return false;
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index aeba796484..adadf6e9ba 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -393,3 +393,55 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>
>      return val;
>  }
> +
> +/*
> + * Calculate the TLB size if the start address or the end address of
> + * PMP entry is presented in thie TLB page.
> + */
> +static target_ulong pmp_get_tlb_size(CPURISCVState *env, int pmp_index,
> +    target_ulong tlb_sa, target_ulong tlb_ea)
> +{
> +    target_ulong pmp_sa = env->pmp_state.addr[pmp_index].sa;
> +    target_ulong pmp_ea = env->pmp_state.addr[pmp_index].ea;
> +
> +    if (pmp_sa >= tlb_sa && pmp_ea <= tlb_ea) {
> +        return pmp_ea - pmp_sa + 1;
> +    }
> +
> +    if (pmp_sa >= tlb_sa && pmp_sa <= tlb_ea && pmp_ea >= tlb_ea) {
> +        return tlb_ea - pmp_sa + 1;
> +    }
> +
> +    if (pmp_ea <= tlb_ea && pmp_ea >= tlb_sa && pmp_sa <= tlb_sa) {
> +        return pmp_ea - tlb_sa + 1;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Check is there a PMP entry whcih range covers this page. If so,
> + * try to find the minimum granularity for the TLB size.
> + */
> +bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
> +    target_ulong *tlb_size)
> +{
> +    int i;
> +    target_ulong val;
> +    target_ulong tlb_ea = (tlb_sa + TARGET_PAGE_SIZE - 1);
> +
> +    for (i = 0; i < MAX_RISCV_PMPS; i++) {
> +        val = pmp_get_tlb_size(env, i, tlb_sa, tlb_ea);
> +        if (val) {
> +            if (*tlb_size == 0 || *tlb_size > val) {
> +                *tlb_size = val;
> +            }
> +        }
> +    }
> +
> +    if (*tlb_size != 0) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 8e19793132..c70f2ea4c4 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -60,5 +60,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
>  bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>      target_ulong size, pmp_priv_t priv, target_ulong mode);
> +bool pmp_is_range_in_tlb(CPURISCVState *env, hwaddr tlb_sa,
> +    target_ulong *tlb_size);
>
>  #endif
> --
> 2.27.0
>

ping

