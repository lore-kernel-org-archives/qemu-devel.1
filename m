Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E30A20748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqPsQpLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E30A20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnwA-0005Pp-6J
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibnv8-0004wj-SM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibnv6-0003Lc-MW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:47:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37455)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibnv6-0003LK-J5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575301647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDooZFvvV14V5795u4VZGGg14Kj5gbo28LbB/sy83Ww=;
 b=GqPsQpLy0MfYhqUUS0XBdRFzG+1nXctudObxxIqxJr7wj+J5FsK1QRdjXw0WLEFfTTRB7J
 GbYORAr39sHnNimUaD7G0LApu2QMHNB768+BAl5UQ3hUn0CZTY654jDm2Xn1PcVxsE3u00
 qqoa7KaT5z4LhecCt8HotVOWdBU1HTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-WYg8Ng0LPYiWEMMZOZMwjg-1; Mon, 02 Dec 2019 10:47:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9763803B9C;
 Mon,  2 Dec 2019 15:47:22 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2789619C68;
 Mon,  2 Dec 2019 15:47:19 +0000 (UTC)
Date: Mon, 2 Dec 2019 16:46:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] s390x: Add missing vcpu reset functions
Message-ID: <20191202164608.1b133a20.cohuck@redhat.com>
In-Reply-To: <20191202140146.3910-3-frankja@linux.ibm.com>
References: <20191202140146.3910-1-frankja@linux.ibm.com>
 <20191202140146.3910-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WYg8Ng0LPYiWEMMZOZMwjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  2 Dec 2019 09:01:45 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Up to now we only had an ioctl to reset vcpu data QEMU couldn't reach
> for the initial reset, which was also called for the clear reset. To

s/which/and that/ ?

> be architecture compliant, we also need to clear local interrupts on a
> normal reset.
> 
> Because of this and the upcoming protvirt support we need to add
> ioctls for the missing clear and normal resets.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/cpu.c       | 14 ++++++++++++--
>  target/s390x/kvm-stub.c  | 10 +++++++++-
>  target/s390x/kvm.c       | 42 ++++++++++++++++++++++++++++++++--------
>  target/s390x/kvm_s390x.h |  4 +++-
>  4 files changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 829ce6ad54..906285888e 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -139,8 +139,18 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>      }
>  
>      /* Reset state inside the kernel that we cannot access yet from QEMU. */

Hm, why does this comment talk about 'yet'? Did we have any plans to
change that?

> -    if (kvm_enabled() && type != S390_CPU_RESET_NORMAL) {
> -        kvm_s390_reset_vcpu(cpu);
> +    if (kvm_enabled()) {
> +        switch (type) {
> +        case S390_CPU_RESET_CLEAR:
> +            kvm_s390_reset_vcpu_clear(cpu);
> +            break;
> +        case S390_CPU_RESET_INITIAL:
> +            kvm_s390_reset_vcpu_initial(cpu);
> +            break;
> +        case S390_CPU_RESET_NORMAL:
> +            kvm_s390_reset_vcpu_normal(cpu);
> +            break;

Add a default case to catch errors?

> +        }
>      }
>  }
>  

(...)

> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ad6e38c876..7a2ec8b9f8 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -151,6 +151,7 @@ static int cap_s390_irq;
>  static int cap_ri;
>  static int cap_gs;
>  static int cap_hpage_1m;
> +static int cap_vcpu_resets;
>  
>  static int active_cmma;
>  
> @@ -342,6 +343,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>      cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>      cap_s390_irq = kvm_check_extension(s, KVM_CAP_S390_INJECT_IRQ);
> +    cap_vcpu_resets = kvm_check_extension(s, KVM_CAP_S390_VCPU_RESETS);
>  
>      if (!kvm_check_extension(s, KVM_CAP_S390_GMAP)
>          || !kvm_check_extension(s, KVM_CAP_S390_COW)) {
> @@ -403,20 +405,44 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
>      return 0;
>  }
>  
> -void kvm_s390_reset_vcpu(S390CPU *cpu)
> +static void kvm_s390_reset_vcpu(S390CPU *cpu, unsigned long type)
>  {
>      CPUState *cs = CPU(cpu);
>  
> -    /* The initial reset call is needed here to reset in-kernel
> -     * vcpu data that we can't access directly from QEMU
> -     * (i.e. with older kernels which don't support sync_regs/ONE_REG).
> -     * Before this ioctl cpu_synchronize_state() is called in common kvm
> -     * code (kvm-all) */
> -    if (kvm_vcpu_ioctl(cs, KVM_S390_INITIAL_RESET, NULL)) {
> -        error_report("Initial CPU reset failed on CPU %i", cs->cpu_index);
> +    /*
> +     * The reset call is needed here to reset in-kernel vcpu data that
> +     * we can't access directly from QEMU (i.e. with older kernels
> +     * which don't support sync_regs/ONE_REG).  Before this ioctl

Is the reference to sync_regs/ONE_REG still relevant? I'm a bit
confused here, especially with regard to what we'll need for protected
virt.

> +     * cpu_synchronize_state() is called in common kvm code
> +     * (kvm-all).
> +     */
> +    if (kvm_vcpu_ioctl(cs, type)) {
> +        error_report("CPU reset failed on CPU %i", cs->cpu_index);
>      }
>  }
>  
> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu)
> +{
> +    kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
> +}
> +
> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu)
> +{
> +    if (!cap_vcpu_resets) {
> +        kvm_s390_reset_vcpu(cpu, KVM_S390_INITIAL_RESET);
> +    } else {
> +        kvm_s390_reset_vcpu(cpu, KVM_S390_CLEAR_RESET);
> +    }

kvm_s390_reset_vcpu(cpu, cap_vcpu_resets ? KVM_S390_CLEAR_RESET : KVM_S390_INITIAL_RESET);

One line, but maybe the conventional if is still better :)

> +}
> +
> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
> +{
> +    if (!cap_vcpu_resets) {
> +        return;
> +    }
> +    kvm_s390_reset_vcpu(cpu, KVM_S390_NORMAL_RESET);
> +}
> +
>  static int can_sync_regs(CPUState *cs, int regs)
>  {
>      return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
> diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
> index caf985955b..0b21789796 100644
> --- a/target/s390x/kvm_s390x.h
> +++ b/target/s390x/kvm_s390x.h
> @@ -34,7 +34,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
>                                      int vq, bool assign);
>  int kvm_s390_cmma_active(void);
>  void kvm_s390_cmma_reset(void);
> -void kvm_s390_reset_vcpu(S390CPU *cpu);
> +void kvm_s390_reset_vcpu_clear(S390CPU *cpu);
> +void kvm_s390_reset_vcpu_normal(S390CPU *cpu);
> +void kvm_s390_reset_vcpu_initial(S390CPU *cpu);
>  int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
>  void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
>  void kvm_s390_crypto_reset(void);


