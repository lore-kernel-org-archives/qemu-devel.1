Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731B5206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731B5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsNpx-0007GU-MM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 04:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54882)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hsNpF-0006Ec-8j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hsNpD-0002fO-SF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 04:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1hsNpB-0002Yr-SN; Tue, 30 Jul 2019 04:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5441D30ADC7F;
 Tue, 30 Jul 2019 08:49:33 +0000 (UTC)
Received: from ptitpuce (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D41B5D6B0;
 Tue, 30 Jul 2019 08:49:30 +0000 (UTC)
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
Date: Tue, 30 Jul 2019 10:49:26 +0200
Message-ID: <m1zhkvoqjt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 30 Jul 2019 08:49:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 4/6] target/riscv: Create function
 to test if FP is enabled
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com, palmer@sifive.com,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis writes:

> Let's creaate a function that tests if floating point support is

Typo: create

> enabled. We can then protect all floating point operations based on if
> they are enabled.
>
> This patch so far doesn't change anything, it's just preparing for the
> Hypervisor support for floating point operations.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        |  6 +++++-
>  target/riscv/cpu_helper.c | 10 ++++++++++
>  target/riscv/csr.c        | 19 ++++++++++---------
>  3 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..2dc9b17678 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -255,6 +255,7 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
>  int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
> +bool riscv_cpu_fp_enabled(CPURISCVState *env);
>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> @@ -298,7 +299,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  #ifdef CONFIG_USER_ONLY
>      *flags = TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> +    *flags = cpu_mmu_index(env, 0);
> +    if (riscv_cpu_fp_enabled(env)) {
> +        *flags |= env->mstatus & MSTATUS_FS;
> +    }
>  #endif
>  }
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index f027be7f16..225e407cff 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -71,6 +71,16 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>
>  #if !defined(CONFIG_USER_ONLY)
>
> +/* Return true is floating point support is currently enabled */
> +bool riscv_cpu_fp_enabled(CPURISCVState *env)
> +{
> +    if (env->mstatus & MSTATUS_FS) {
> +        return true;
> +    }
> +
> +    return false;

Will there be more conditions that lead to the "true" case?
If not, please consider making it a one-liner for readability, e.g.

   return env->mstatus & MSTATUS_FS;

(just a personal preference, feel free to ignore)

> +}
> +
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>  {
>      CPURISCVState *env = &cpu->env;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index af3b762c8b..7b73b73cf7 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
>  static int fs(CPURISCVState *env, int csrno)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {

This was existing behavior, but I'm curious why all these
tests are disabled when env->debugger is set. This was introduced
in 753e3fe20, but I see no rationale in the commit message.
I find it odd, maybe even suspicious, that activating the debugger
would change the behavior :-)

>          return -1;
>      }
>  #endif
> @@ -108,7 +108,7 @@ static int pmp(CPURISCVState *env, int csrno)
>  static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -119,7 +119,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>  static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |= MSTATUS_FS;
> @@ -131,7 +131,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>  static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -142,7 +142,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
>  static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |= MSTATUS_FS;
> @@ -154,7 +154,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>  static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>  #endif
> @@ -166,7 +166,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>  static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
>      env->mstatus |= MSTATUS_FS;
> @@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      target_ulong mstatus = env->mstatus;
>      target_ulong mask = 0;
> +    int dirty;
>
>      /* flush tlb on mstatus fields that affect VM */
>      if (env->priv_ver <= PRIV_VERSION_1_09_1) {
> @@ -340,8 +341,8 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>
>      mstatus = (mstatus & ~mask) | (val & mask);
>
> -    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
> -                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> +    dirty = riscv_cpu_fp_enabled(env) |
> +            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
>      env->mstatus = mstatus;

Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>

--
Cheers,
Christophe de Dinechin (IRC c3d)

