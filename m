Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155D02222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGmWIlLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155D02222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnEy-0007xA-0E
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSnDp-0006xh-7Z; Wed, 14 Oct 2020 16:18:06 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSnDn-0000IS-9r; Wed, 14 Oct 2020 16:18:04 -0400
Received: by mail-io1-xd43.google.com with SMTP id l8so756422ioh.11;
 Wed, 14 Oct 2020 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b52mQAc54r/mbVOyFRmNJjD6Ch7cO3NIPF3DHAOz7Bg=;
 b=lGmWIlLNgCrXkH4z4ZSZD6BxdPr4i8Qk6MDE4aWKYSD0KbVufznUF/IyFmXBRzOBTq
 1p5EwaAWHx5j1N20DwjSqClgLOiQFBlOs43Yo7F8pagPh71LSJfAJG2lRDtstl7Tho8G
 i7p+98dRUSle10VkZzxH94jHqY2jZDF6OwCW9uAHaHDGMB78K32+Sv0/rssJV+b5JJu0
 CsUigCPFVtK96Arntffpb6HzL0mliDow2O2HQA74TCd84WSCTm7ww6JFwMLvXHdJr2/1
 ZW+lLRmb97Mv2qSVXdOaVN2yZvXoJxQwJtvlrb2KpDBwUx0Ty5nNUMbtnVEbA34UR5Fv
 n0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b52mQAc54r/mbVOyFRmNJjD6Ch7cO3NIPF3DHAOz7Bg=;
 b=iA0qUHi9pDmm1aiZlFpBTyJfq4kdQLvfA+u0MCz3IyYZSCQDuKECW2BEMa5zOR4BU0
 LUx7rTGZso3odf2A52IRGcAknklQV3t1/sTOZpJ7w6nLFZa+WcSawnSsgRlvWafPe95C
 MA392SEjHA0rQrb455YZWnxpRXf9IHJS9PuPrh9wl59malyklKlAxzhX9/fNKAjlPd52
 GRg244VCdrgnPARDyupb0PGkO8OooN0GBVHsFLjyveabY3ZjSWia35c31KB/IVzrdPpV
 +/DkruZMqSY+4/QK9UKadLT2aS1+/T0jIUh05b2e7HzCfDxGljVtXW5dEqmX2GfF7my9
 0oag==
X-Gm-Message-State: AOAM532cSay0coHTuGXf15hrxODw4D109YeX4LnPesj1cpBUOwtUVCEr
 cg3KusNuBZfGQ6aOPRnqAhBWbxj57qupeZ40aFQ=
X-Google-Smtp-Source: ABdhPJxVt/aJvaa+hmZzJ0JWIs4bm/rAv72//t/O5t7gyKlVF2OH+wy7NUBauah4S1Fe8TrqGEMn3iMjQQCB60f6Cw8=
X-Received: by 2002:a02:c956:: with SMTP id u22mr980817jao.135.1602706681484; 
 Wed, 14 Oct 2020 13:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201014101728.848-1-jiangyifei@huawei.com>
In-Reply-To: <20201014101728.848-1-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 13:06:22 -0700
Message-ID: <CAKmqyKMobkSzkph2DrDh-Mpb+KZ+3pYX7n4WGVinUWBZCD4CmA@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: raise exception to HS-mode at
 get_physical_address
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 3:18 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> VS-stage translation at get_physical_address needs to translate pte
> address by G-stage translation. But the G-stage translation error
> can not be distinguished from VS-stage translation error in
> riscv_cpu_tlb_fill. On migration, destination needs to rebuild pte,
> and this G-stage translation error must be handled by HS-mode. So
> introduce TRANSLATE_STAGE2_FAIL so that riscv_cpu_tlb_fill could
> distinguish and raise it to HS-mode.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 10 +++++++---
>  target/riscv/cpu_helper.c | 35 ++++++++++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index de275782e6..de4705bb57 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -82,9 +82,13 @@ enum {
>
>  #define VEXT_VERSION_0_07_1 0x00000701
>
> -#define TRANSLATE_PMP_FAIL 2
> -#define TRANSLATE_FAIL 1
> -#define TRANSLATE_SUCCESS 0
> +enum {
> +    TRANSLATE_SUCCESS,
> +    TRANSLATE_FAIL,
> +    TRANSLATE_PMP_FAIL,
> +    TRANSLATE_G_STAGE_FAIL
> +};
> +
>  #define MMU_USER_IDX 3
>
>  #define MAX_RISCV_PMPS (16)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 904899054d..ae66722d32 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -316,6 +316,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>   * @physical: This will be set to the calculated physical address
>   * @prot: The returned protection attributes
>   * @addr: The virtual address to be translated
> + * @fault_pte_addr: If not NULL, this will be set to fault pte address
> + *                  when a error occurs on pte address translation.
>   * @access_type: The type of MMU access
>   * @mmu_idx: Indicates current privilege level
>   * @first_stage: Are we in first stage translation?
> @@ -324,6 +326,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>   */
>  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>                                  int *prot, target_ulong addr,
> +                                target_ulong *fault_pte_addr,
>                                  int access_type, int mmu_idx,
>                                  bool first_stage, bool two_stage)
>  {
> @@ -447,11 +450,14 @@ restart:
>
>              /* Do the second stage translation on the base PTE address. */
>              int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
> -                                                 base, MMU_DATA_LOAD,
> +                                                 base, NULL, MMU_DATA_LOAD,
>                                                   mmu_idx, false, true);
>
>              if (vbase_ret != TRANSLATE_SUCCESS) {
> -                return vbase_ret;
> +                if (fault_pte_addr) {
> +                    *fault_pte_addr = (base + idx * ptesize) >> 2;
> +                }
> +                return TRANSLATE_G_STAGE_FAIL;
>              }
>
>              pte_addr = vbase + idx * ptesize;
> @@ -632,13 +638,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      int prot;
>      int mmu_idx = cpu_mmu_index(&cpu->env, false);
>
> -    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
> +    if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
>                               true, riscv_cpu_virt_enabled(env))) {
>          return -1;
>      }
>
>      if (riscv_cpu_virt_enabled(env)) {
> -        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
> +        if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
>                                   0, mmu_idx, false, true)) {
>              return -1;
>          }
> @@ -727,19 +733,30 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (riscv_cpu_virt_enabled(env) ||
>          (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
>          /* Two stage lookup */
> -        ret = get_physical_address(env, &pa, &prot, address, access_type,
> +        ret = get_physical_address(env, &pa, &prot, address,
> +                                   &env->guest_phys_fault_addr, access_type,
>                                     mmu_idx, true, true);
>
> +        /*
> +         * A G-stage exception may be triggered during two state lookup.
> +         * And the env->guest_phys_fault_addr has already been set in
> +         * get_physical_address().
> +         */
> +        if (ret == TRANSLATE_G_STAGE_FAIL) {
> +            first_stage_error = false;
> +            access_type = MMU_DATA_LOAD;
> +        }
> +
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
>                        TARGET_FMT_plx " prot %d\n",
>                        __func__, address, ret, pa, prot);
>
> -        if (ret != TRANSLATE_FAIL) {
> +        if (ret == TRANSLATE_SUCCESS) {
>              /* Second stage lookup */
>              im_address = pa;
>
> -            ret = get_physical_address(env, &pa, &prot2, im_address,
> +            ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
>                                         access_type, mmu_idx, false, true);
>
>              qemu_log_mask(CPU_LOG_MMU,
> @@ -768,8 +785,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          }
>      } else {
>          /* Single stage lookup */
> -        ret = get_physical_address(env, &pa, &prot, address, access_type,
> -                                   mmu_idx, true, false);
> +        ret = get_physical_address(env, &pa, &prot, address, NULL,
> +                                   access_type, mmu_idx, true, false);
>
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s address=%" VADDR_PRIx " ret %d physical "
> --
> 2.19.1
>
>

