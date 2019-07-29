Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93150C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3D72070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3D72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6gs-00051U-MU
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hs6gD-0004XO-J9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hs6gB-0001rJ-Vs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:31:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hs6gB-0001qp-OZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:31:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so12198998wrr.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NuWnszGpoifyzdQlegGiqLEiuwq3F2L9p9cqt9lz5a0=;
 b=UlMW7RCGYJzfaClm8gwFxZO6/ujYPxUwhUfDpVkyaoSi5x1CWju3tdBCPUn8VI9B/s
 O9mgOmz+7OkSpq9FULYfBqQz9VclyVsa/sw1cQ5pEVNpcg2andMQ3QcpAXa35OW13IiZ
 xW0MJU2FsM3kKJLWh56nsa6digdKkwOMuQsRaxJWGYi4WSMss0E6LeM81wkJ2CwAWX+t
 zfNJQP6+9Xm1XBqf7hrtCKwF+jDsMZgwosjR31RTOcfXiErFDPzNoF0rp4LUwLpSKXcZ
 eKUByt38JAzURmWRDyL+hHreTEYBZNSc9lzzWozYf9NEDgbZiywV+hgsCfK1ozNsKBRm
 fnGg==
X-Gm-Message-State: APjAAAUKMgRu7mTchRtydewwam7plwDviE4YwEudQUjojcxNHkSwkOjN
 I+dPXSh2ntOsejwRRCBQ4RFjPg==
X-Google-Smtp-Source: APXvYqw+DTrW6We/by7UIR+klWkDNVEYfHd5cyba2N/fEDXSKMtLawzp31vxyjSaYIshZ/XH7J6vaw==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr31846073wrn.316.1564410670782; 
 Mon, 29 Jul 2019 07:31:10 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id w7sm70997396wrn.11.2019.07.29.07.31.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 07:31:10 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5c724ba5-b370-6ed7-a387-50080d434a59@redhat.com>
Date: Mon, 29 Jul 2019 16:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: alistair23@gmail.com, palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 8:52 PM, Alistair Francis wrote:
> Let's creaate a function that tests if floating point support is

"create"

> enabled. We can then protect all floating point operations based on if
> they are enabled.
> 
> This patch so far doesn't change anything, it's just preparing for the
> Hypervisor support for floating point operations.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
>  
> 

