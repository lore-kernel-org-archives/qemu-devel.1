Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD0C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023F92064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU0W8JNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023F92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsWyu-0006TW-8M
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 14:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hsWyW-00063T-FF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hsWyV-00080f-3E
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 14:35:52 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hsWyU-0007yQ-8D; Tue, 30 Jul 2019 14:35:51 -0400
Received: by mail-lf1-x141.google.com with SMTP id u10so6703959lfm.12;
 Tue, 30 Jul 2019 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GksNWIKk90TrrPRZNTPGfSJT9d/t1KYvp4rKxyHxnDY=;
 b=QU0W8JNffRu9ejIA8osKoTRjNBFuuUjDJ1M6TqAUuP9lxJb3AHhFleseozymDMZ+3i
 CjDA++tsUPmai7i98o42yk4HvcDtuxPcM4WUrih5Heody3DF9Dr9MbBYctig3kE5Mopz
 6sOZcd9+6pV04j4T96sY4rt5vZZruXpvJGLW0XgPxpCLZZwmCYJaHLH9UczNbUh2vTrL
 RwvN4ODUyDXmrtTAG4rvAlUVj4tqKsfnRUYLFVsvUtQQ5VmNYoFj0Sbg1EUAsFFiQ48L
 A3nf6TBUL8XceUCco7FGVa8sYXFVBmdROQQLJ/uvmvwJokpsV3RYenOg8pA66aUPn5O2
 Dcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GksNWIKk90TrrPRZNTPGfSJT9d/t1KYvp4rKxyHxnDY=;
 b=OJDYtlcpLv+T244tX0CuTxLl2msgpXm+S5areMKx2vfd1fwbiKUsJT8cpw2pfMRtcF
 CQelM89CuGwjszUD0I+Fk6zAv00UDDsZy9SfLZecW9kQ9/zLEoF2cm/Z/h6i34lW7raM
 gq8JUOQobaozoYBiXL3JOKyKcCNKDj125CGZA8xDEQ4+uYA0IBYTOf4gnt60dD/tkHCZ
 PenSLlghxGEvNFL5yTCs7Cq3sIrr3agcAVPH/QwSxkw1yI5XXDAHP4GxArirkGqg0Aff
 wLD7G3hTMlovxmIBVz/3gXFMXPAufZxSKZcBTX7kH3xBnVRyB/ZObkEV/x793O8lTV4W
 PlfA==
X-Gm-Message-State: APjAAAUUHbQlGCGQ4ITeGrxtqGPDsW80egaPRl7ons0qXR0qy5z+e2Lb
 vi1IiEQZJ+Ve1YnqoW1GVQQBfFa80v7l0XQcToI=
X-Google-Smtp-Source: APXvYqy5thzXeVMsnMDFhsMO3cw8v1exf0tABstt9uAqsF6xsJWbgOE2qFzcDslg704wkzAXz6IT7kdIFg6E0sbKK1s=
X-Received: by 2002:a19:c6d4:: with SMTP id
 w203mr55888282lff.135.1564511746902; 
 Tue, 30 Jul 2019 11:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <edea77ff4aa6900d01ab7146d5b52c2dae4a856e.1564080680.git.alistair.francis@wdc.com>
 <CAEiOBXU-4KLv64pZJ__gszG8RyC6cE_GxwTt+przwbDkmS9vgQ@mail.gmail.com>
In-Reply-To: <CAEiOBXU-4KLv64pZJ__gszG8RyC6cE_GxwTt+przwbDkmS9vgQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jul 2019 11:32:13 -0700
Message-ID: <CAKmqyKMZxR_Yeq5i8Xs1Z5GtpbA=B2piGWP2doNvCNUu0JCy0A@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH-4.2 v1 4/6] target/riscv:
 Create function to test if FP is enabled
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 9:56 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Fri, Jul 26, 2019 at 2:55 AM Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> Let's creaate a function that tests if floating point support is
>> enabled. We can then protect all floating point operations based on if
>> they are enabled.
>>
>> This patch so far doesn't change anything, it's just preparing for the
>> Hypervisor support for floating point operations.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  target/riscv/cpu.h        |  6 +++++-
>>  target/riscv/cpu_helper.c | 10 ++++++++++
>>  target/riscv/csr.c        | 19 ++++++++++---------
>>  3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 0adb307f32..2dc9b17678 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -255,6 +255,7 @@ void riscv_cpu_do_interrupt(CPUState *cpu);
>>  int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>>  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>> +bool riscv_cpu_fp_enabled(CPURISCVState *env);
>>  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
>>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>>  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>> @@ -298,7 +299,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>>  #ifdef CONFIG_USER_ONLY
>>      *flags = TB_FLAGS_MSTATUS_FS;
>>  #else
>> -    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
>> +    *flags = cpu_mmu_index(env, 0);
>> +    if (riscv_cpu_fp_enabled(env)) {
>> +        *flags |= env->mstatus & MSTATUS_FS;
>> +    }
>>  #endif
>>  }
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index f027be7f16..225e407cff 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -71,6 +71,16 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>>
>>  #if !defined(CONFIG_USER_ONLY)
>>
>> +/* Return true is floating point support is currently enabled */
>> +bool riscv_cpu_fp_enabled(CPURISCVState *env)
>> +{
>> +    if (env->mstatus & MSTATUS_FS) {
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
>>  {
>>      CPURISCVState *env = &cpu->env;
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index af3b762c8b..7b73b73cf7 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
>>  static int fs(CPURISCVState *env, int csrno)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>  #endif
>> @@ -108,7 +108,7 @@ static int pmp(CPURISCVState *env, int csrno)
>>  static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>  #endif
>> @@ -119,7 +119,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
>>  static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>      env->mstatus |= MSTATUS_FS;
>> @@ -131,7 +131,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>>  static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>  #endif
>> @@ -142,7 +142,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
>>  static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>      env->mstatus |= MSTATUS_FS;
>> @@ -154,7 +154,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>>  static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>  #endif
>> @@ -166,7 +166,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
>>  static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>>  {
>>  #if !defined(CONFIG_USER_ONLY)
>> -    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
>> +    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>>          return -1;
>>      }
>>      env->mstatus |= MSTATUS_FS;
>> @@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>>  {
>>      target_ulong mstatus = env->mstatus;
>>      target_ulong mask = 0;
>> +    int dirty;
>>
>>      /* flush tlb on mstatus fields that affect VM */
>>      if (env->priv_ver <= PRIV_VERSION_1_09_1) {
>> @@ -340,8 +341,8 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>>
>>      mstatus = (mstatus & ~mask) | (val & mask);
>>
>> -    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
>> -                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>> +    dirty = riscv_cpu_fp_enabled(env) |
>> +            ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>
>
>   FS are 2bits
>   original:
>         only 3 is true
>   new
>        1, 2, 3 all make dirty true
>
>   Since only 3 means dirty, keeps this part unchanged should be reasonable.

Good point, I have updated this.

Alistair

>
> chihmin
>
>>      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
>>      env->mstatus = mstatus;
>>
>> --
>> 2.22.0
>>
>>

