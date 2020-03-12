Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE857C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A808206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A808206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJnq-0003jk-Qj
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCJjo-0003zp-QA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1jCJjn-0006rI-CP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:02:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1jCJjn-0006qu-7e
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:02:43 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02C90bgL055539
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:02:42 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yqe67nyqm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:02:42 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Thu, 12 Mar 2020 08:50:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Mar 2020 08:50:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02C8nYKe48431414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 08:49:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EF9852054;
 Thu, 12 Mar 2020 08:50:34 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.141])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F7CD5204F;
 Thu, 12 Mar 2020 08:50:34 +0000 (GMT)
Subject: Re: [PATCH v9 06/15] s390x: Add SIDA memory ops
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-7-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date: Thu, 12 Mar 2020 09:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311132151.172389-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031208-0008-0000-0000-0000035BFB55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031208-0009-0000-0000-00004A7D4448
Message-Id: <83a4e6f4-c3ab-5ca6-68ce-b9daefd74598@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_01:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120048
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.03.20 14:21, Janosch Frank wrote:
> Protected guests save the instruction control blocks in the SIDA
> instead of QEMU/KVM directly accessing the guest's memory.
> 
> Let's introduce new functions to access the SIDA.
> 
> Also the new memops are available with KVM_CAP_S390_PROTECTED, so
> let's check for that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/cpu.h        |  7 ++++++-
>  target/s390x/kvm.c        | 25 +++++++++++++++++++++++++
>  target/s390x/kvm_s390x.h  |  2 ++
>  target/s390x/mmu_helper.c | 14 ++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 1d17709d6e10b5e0..035427521cec2528 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -823,7 +823,12 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
>  #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
>          s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
>  void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
> -
> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
> +                       int len, bool is_write);
> +#define s390_cpu_pv_mem_read(cpu, offset, dest, len)    \
> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, false)
> +#define s390_cpu_pv_mem_write(cpu, offset, dest, len)       \
> +        s390_cpu_pv_mem_rw(cpu, offset, dest, len, true)
>  
>  /* sigp.c */
>  int s390_cpu_restart(S390CPU *cpu);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index eec0b92479465b9c..cdcd538b4f7fb318 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -154,6 +154,7 @@ static int cap_ri;
>  static int cap_gs;
>  static int cap_hpage_1m;
>  static int cap_vcpu_resets;
> +static int cap_protected;
>  
>  static int active_cmma;
>  
> @@ -346,6 +347,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>      cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
>      cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
> +    cap_protected = kvm_check_extension(s, KVM_CAP_S390_PROTECTED);
>  
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> @@ -846,6 +848,29 @@ int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>      return ret;
>  }
>  
> +int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offset, void *hostbuf,
> +                       int len, bool is_write)
> +{
> +    struct kvm_s390_mem_op mem_op = {
> +        .sida_offset = offset,
> +        .size = len,
> +        .op = is_write ? KVM_S390_MEMOP_SIDA_WRITE
> +                       : KVM_S390_MEMOP_SIDA_READ,
> +        .buf = (uint64_t)hostbuf,
> +    };
> +    int ret;
> +
> +    if (!cap_mem_op || !cap_protected) {
> +        return -ENOSYS;
> +    }
> +
> +    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_S390_MEM_OP, &mem_op);
> +    if (ret < 0) {
> +        error_report("KVM_S390_MEM_OP failed: %s", strerror(-ret));
> +    }
> +    return ret;
> +}
> +
>  /*
>   * Legacy layout for s390:
>   * Older S390 KVM requires the topmost vma of the RAM to be
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index 0b21789796d7c462..9c38f6ccce83e39e 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -19,6 +19,8 @@ void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
>  void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code);
>  int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
>                      int len, bool is_write);
> +int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
> +                       bool is_write);
>  void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
>  int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
>  void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 0be2f300bbe4ac8b..7d9f3059cd502c49 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -474,6 +474,20 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
>      return 0;
>  }
>  
> +int s390_cpu_pv_mem_rw(S390CPU *cpu, unsigned int offset, void *hostbuf,
> +                       int len, bool is_write)
> +{
> +    int ret;
> +
> +    if (kvm_enabled()) {
> +        ret = kvm_s390_mem_op_pv(cpu, offset, hostbuf, len, is_write);
> +    } else {
> +        /* Protected Virtualization is a KVM/Hardware only feature */
> +        g_assert_not_reached();
> +    }
> +    return ret;
> +}
> +
>  /**
>   * s390_cpu_virt_mem_rw:
>   * @laddr:     the logical start address
> 


