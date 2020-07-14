Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2F522201
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2F522201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvI78-0002bK-B8
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jvI5o-0001FZ-9N; Tue, 14 Jul 2020 06:23:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1232
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jvI5l-0008JO-K4; Tue, 14 Jul 2020 06:23:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06EA2OJd040837; Tue, 14 Jul 2020 06:23:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 327tna5ta6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2020 06:23:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06EA2c9c042462;
 Tue, 14 Jul 2020 06:23:14 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 327tna5t87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2020 06:23:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06EABHkT004267;
 Tue, 14 Jul 2020 10:17:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 3274pgu4r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2020 10:17:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06EAHLUg3997994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2020 10:17:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2ADCCAE04D;
 Tue, 14 Jul 2020 10:17:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76DEEAE055;
 Tue, 14 Jul 2020 10:17:20 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.7.230])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2020 10:17:20 +0000 (GMT)
Date: Tue, 14 Jul 2020 12:17:18 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 3/6] s390x/diag: implement diag260
Message-ID: <20200714121718.45f9f3ed@ibm-vm>
In-Reply-To: <20200710151239.39370-4-david@redhat.com>
References: <20200710151239.39370-1-david@redhat.com>
 <20200710151239.39370-4-david@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-14_02:2020-07-13,
 2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=2 lowpriorityscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140072
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 06:23:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 17:12:36 +0200
David Hildenbrand <david@redhat.com> wrote:

> Let's implement diag260 - "Access Certain Virtual Machine
> Information", used under z/VM to expose the storage configuration
> (especially, layout of storage extends and thereby holes). For now,
> the returned information is completely redundant to the information
> exposed via SCLP.
> 
> We want to reuse diag260 in QEMU to implement memory devices - to
> have a mechanism to indicate to the guest OS that the initial ram
> size and the maximum possible physical address differ.
> 
> The Linux kernel supports diag260 (0x10) to query the available memory
> since v4.20. Ancient Linux versions used diag 260 (0xc), but stopped
> doing so a while ago.
> 
> Let's unconditionally implement the new diag, without any migration
> checks (e.g., compatibility machine, CPU model). Although a guest OS
> could observe this when migrating between QEMU evrsions, it's somewhat
> unlikely to ever trigger due to the way diag260 is used within a guest
> OS - called only once or twice during boot.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c        | 51
> ++++++++++++++++++++++++++++++++++++++ target/s390x/internal.h    |
> 2 ++ target/s390x/kvm.c         | 11 ++++++++
>  target/s390x/misc_helper.c |  6 +++++
>  target/s390x/translate.c   |  7 ++++++
>  5 files changed, 77 insertions(+)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index be70aecd72..5378fcf582 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -23,6 +23,57 @@
>  #include "hw/s390x/pv.h"
>  #include "kvm_s390x.h"
>  
> +void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3,
> uintptr_t ra) +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const ram_addr_t initial_ram_size = ms->ram_size;
> +    const uint64_t subcode = env->regs[r3];
> +
> +    switch (subcode) {
> +    case 0xc:
> +        /* The first storage extent maps to our initial ram. */
> +        env->regs[r1] = initial_ram_size - 1;
> +        /* The highest addressable byte maps to the initial ram size
> for now. */
> +        env->regs[r3] = initial_ram_size - 1;
> +        break;
> +    case 0x10: {
> +        ram_addr_t addr, length;
> +        uint64_t tmp;
> +
> +        if (r1 & 1) {
> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +            return;
> +        }
> +
> +        addr = env->regs[r1];
> +        length = env->regs[r1 + 1];
> +        if (!QEMU_IS_ALIGNED(addr, 16) || !QEMU_IS_ALIGNED(length,
> 16) ||
> +            !length) {
> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +            return;
> +        }
> +        if (!address_space_access_valid(&address_space_memory, addr,
> length,
> +                                        true,
> MEMTXATTRS_UNSPECIFIED)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        /* Indicate our initial memory ([0 .. ram_size - 1]) */
> +        tmp = cpu_to_be64(0);
> +        cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
> +        tmp = cpu_to_be64(initial_ram_size - 1);
> +        cpu_physical_memory_write(addr + sizeof(tmp), &tmp,
> sizeof(tmp)); +
> +        /* Exactly one entry was stored, it always fits into the
> area. */

maybe I missed something, but I have the impression that your
implementation of DIAG 260 always only returns the first extent?

shouldn't it return all the hotplugged areas once hotplugging is
enabled?

> +        env->regs[r3] = 1;
> +        setcc(env_archcpu(env), 0);
> +        break;
> +    }
> +    default:
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +}
> +
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  {
>      uint64_t func = env->regs[r1];
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index b1e0ebf67f..a7a3df9a3b 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -372,6 +372,8 @@ int mmu_translate_real(CPUS390XState *env,
> target_ulong raddr, int rw, 
>  
>  /* misc_helper.c */
> +void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3,
> +                     uintptr_t ra);
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
>                       uintptr_t ra);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index f2f75d2a57..d6de3ad86c 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1565,6 +1565,14 @@ static int handle_hypercall(S390CPU *cpu,
> struct kvm_run *run) return ret;
>  }
>  
> +static void kvm_handle_diag_260(S390CPU *cpu, struct kvm_run *run)
> +{
> +    const uint64_t r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    const uint64_t r3 = run->s390_sieic.ipa & 0x000f;
> +
> +    handle_diag_260(&cpu->env, r1, r3, 0);
> +}
> +
>  static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
>  {
>      uint64_t r1, r3;
> @@ -1614,6 +1622,9 @@ static int handle_diag(S390CPU *cpu, struct
> kvm_run *run, uint32_t ipb) */
>      func_code = decode_basedisp_rs(&cpu->env, ipb, NULL) &
> DIAG_KVM_CODE_MASK; switch (func_code) {
> +    case 0x260:
> +        kvm_handle_diag_260(cpu, run);
> +        break;
>      case DIAG_TIMEREVENT:
>          kvm_handle_diag_288(cpu, run);
>          break;
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 58dbc023eb..d7274eb320 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -116,6 +116,12 @@ void HELPER(diag)(CPUS390XState *env, uint32_t
> r1, uint32_t r3, uint32_t num) uint64_t r;
>  
>      switch (num) {
> +    case 0x260:
> +        qemu_mutex_lock_iothread();
> +        handle_diag_260(env, r1, r3, GETPC());
> +        qemu_mutex_unlock_iothread();
> +        r = 0;
> +        break;
>      case 0x500:
>          /* KVM hypercall */
>          qemu_mutex_lock_iothread();
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 4f6f1e31cd..e3358395f0 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2397,6 +2397,13 @@ static DisasJumpType op_diag(DisasContext *s,
> DisasOps *o) TCGv_i32 r3 = tcg_const_i32(get_field(s, r3));
>      TCGv_i32 func_code = tcg_const_i32(get_field(s, i2));
>  
> +    /*
> +     * Diag 0x260 updates the CC - only for some subcodes. Calculate
> the
> +     * current cc, such that the helper can simply overwrite it
> conditionally.
> +     */
> +    if (get_field(s, i2) == 0x260) {
> +        gen_op_calc_cc(s);
> +    }
>      gen_helper_diag(cpu_env, r1, r3, func_code);
>  
>      tcg_temp_free_i32(func_code);


