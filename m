Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0D6C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9A92075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqemLmbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9A92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50263 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdG2-000371-TX
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:15:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYd5e-0003yz-E0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hYd5Y-0001RD-Ej
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:04:54 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hYd5T-00013m-FT; Wed, 05 Jun 2019 17:04:48 -0400
Received: by mail-lf1-x143.google.com with SMTP id q26so20171627lfc.3;
	Wed, 05 Jun 2019 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qcXdaZTey46TXYdfN37Xdz/5yLen0016lB6K5BXvTB0=;
	b=VqemLmbtfZQeGR9hgn0ZS4fhZVxj8/AqoNOxXyOGetszS5g9TJpn+tLl/a+AJ0yOCF
	n94VfglipJBzJAUViivewCTrHQoQLy9zsLfmJvCJ+Xn6QmUX+qHiXIAtcV1ifHHmC6OV
	2JWtbYGEt6Gao/KGZfTcaHtEfjfUq+vIbMT2coy5U0YkLxKpab60xf5YWIyAZPqbVmI3
	rrZutEQMdhnR1mD38A4HUVJbKJKBl+jQjJx/qWNZAQhgEevsPOuxF+LC9iIX6CxLOH0r
	6EGMslqNAQu7g+1M/Hbu9zBaXtcOy2i85T99QJ8vrYN4kxDzxVkdhLgvjrDtUH5wayUU
	fD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qcXdaZTey46TXYdfN37Xdz/5yLen0016lB6K5BXvTB0=;
	b=jFsEKiWi/Bh74OK/2YtQSLiIR7ERo5zzWBLJ/veD1seDPhwSVgnCk0GwCXRrVecF77
	TI7y6j6HOldgpChBP+olye3WWneCjPT+if4FmxgqbRRvh19SdkzhYLHT38X5Nyt4aoXg
	FJzjVKuxQkAWW9qOw7E8FU1xkxNEBs7QgW9ty9/8cvjpwMzvh2BDTBlURNzdRczU7pc1
	30+aXu2WifdmludNiKQUb4me1iBA3gOYRhRj7Ka/BaHyWThEYLUicfzozc7bXopWzrBc
	77ZU6/BVRAEdj2aGQHUmvk7agZQTdYQiidAEYL6gPxl9Jqr8+9aqzUxFos9NgRdPFQid
	cu+w==
X-Gm-Message-State: APjAAAVHVrVQimcCASsFjk8MbRpAkaoox3QXl55R4OqT4xct20TZ/pwI
	LwJ39xkvjksXi6fy+s2p/5uTMFfrdfZO7R0Bj58=
X-Google-Smtp-Source: APXvYqyUM11OCHeqfgE2bG3Ky4obsLz06bQcoKamztFxW/OmXbsAi2AmtbCbKFwHica4B7ZO23PO1qlKLkp5Sxo2zmw=
X-Received: by 2002:a19:710b:: with SMTP id m11mr16684065lfc.135.1559768680212;
	Wed, 05 Jun 2019 14:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135135.19715-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190530135135.19715-3-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190530135135.19715-3-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2019 14:02:07 -0700
Message-ID: <CAKmqyKMF-WXT_UB3tZGznCzdox8Raee9_v9erdMkyvy8XxjeMw@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCHv4 3/6] RISC-V: Check for the effective
 memory privilege mode during PMP checks
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 6:52 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The current PMP check function checks for env->priv which is not the effective
> memory privilege mode.
>
> For example, mstatus.MPRV could be set while executing in M-Mode, and in that
> case the privilege mode for the PMP check should be S-Mode rather than M-Mode
> (in env->priv) if mstatus.MPP == PRV_S.
>
> This patch passes the effective memory privilege mode to the PMP check.
> Functions that call the PMP check should pass the correct memory privilege mode
> after reading mstatus' MPRV/MPP or hstatus.SPRV (if Hypervisor mode exists).
>
> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 10 +++++++++-
>  target/riscv/pmp.c        |  6 +++---
>  target/riscv/pmp.h        |  2 +-
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7c7282c680..5a1cd7cf96 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -392,19 +392,27 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      int prot;
>      bool pmp_violation = false;
>      int ret = TRANSLATE_FAIL;
> +    int mode = mmu_idx;
>
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                    __func__, address, access_type, mmu_idx);
>
>      ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
>
> +    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> +        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        }
> +    }
> +
>      qemu_log_mask(CPU_LOG_MMU,
>                    "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
>                    " prot %d\n", __func__, address, ret, pa, prot);
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
> -        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> +        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
> +        mode)) {
>          pmp_violation = true;
>          ret = TRANSLATE_FAIL;
>      }
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b11c4ae22f..89170bc11d 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -229,7 +229,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pmp_index, target_ulong addr)
>   * Check if the address has required RWX privs to complete desired operation
>   */
>  bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
> -    target_ulong size, pmp_priv_t privs)
> +    target_ulong size, pmp_priv_t privs, target_ulong mode)
>  {
>      int i = 0;
>      int ret = -1;
> @@ -265,7 +265,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>              }
>
>              allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
> -            if ((env->priv != PRV_M) || pmp_is_locked(env, i)) {
> +            if ((mode != PRV_M) || pmp_is_locked(env, i)) {
>                  allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
>              }
>
> @@ -281,7 +281,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>
>      /* No rule matched */
>      if (ret == -1) {
> -        if (env->priv == PRV_M) {
> +        if (mode == PRV_M) {
>              ret = 1; /* Privileged spec v1.10 states if no PMP entry matches an
>                        * M-Mode access, the access succeeds */
>          } else {
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index 66790950eb..8e19793132 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -59,6 +59,6 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>      target_ulong val);
>  target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
>  bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
> -    target_ulong size, pmp_priv_t priv);
> +    target_ulong size, pmp_priv_t priv, target_ulong mode);
>
>  #endif
> --
> 2.17.1
>
>

