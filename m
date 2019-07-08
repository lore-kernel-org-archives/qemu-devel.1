Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2EC606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD4021852
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD4021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYRS-000113-NI
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50490)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hkYQ7-0000YT-BU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hkYQ6-0000KR-4g
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:31:23 -0400
Received: from goliath.siemens.de ([192.35.17.28]:45571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hkYQ5-00007I-6j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:31:22 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x68IV7Xj031777
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jul 2019 20:31:08 +0200
Received: from [167.87.37.3] ([167.87.37.3])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x68IV6SC024802;
 Mon, 8 Jul 2019 20:31:07 +0200
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e253d736-8cf5-0c5c-5766-ee71ad808cfd@siemens.com>
Date: Mon, 8 Jul 2019 20:31:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.28
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 21.06.19 13:30, Paolo Bonzini wrote:
> From: Liran Alon <liran.alon@oracle.com>
> 
> Previous commits have added support for migration of nested virtualization
> workloads. This was done by utilising two new KVM capabilities:
> KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
> required in order to correctly migrate such workloads.
> 
> Therefore, change code to add a migration blocker for vCPUs exposed with
> Intel VMX or AMD SVM in case one of these kernel capabilities is
> missing.
> 
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
> Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/kvm.c     | 9 +++++++--
>  target/i386/machine.c | 2 +-
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index c931e9d..e4b4f57 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1640,9 +1640,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                                    !!(c->ecx & CPUID_EXT_SMX);
>      }
>  
> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
> +    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
> +        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
>          error_setg(&nested_virt_mig_blocker,
> -                   "Nested virtualization does not support live migration yet");
> +                   "Kernel do not provide required capabilities for "
> +                   "nested virtualization migration. "
> +                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
> +                   kvm_max_nested_state_length() > 0,
> +                   has_exception_payload);
>          r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index fc49e5a..851b249 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
>  
>  #ifdef CONFIG_KVM
>      /* Verify we have nested virtualization state from kernel if required */
> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
>          error_report("Guest enabled nested virtualization but kernel "
>                  "does not support saving of nested state");
>          return -EINVAL;
> 

Starting with this commit latest (bisection issue...), running Jailhouse in a
guest first stalls L1 (looks like we lose interrupts), and if I try to reset
that VM, I lose my host as well:

kvm: vmptrld           (null)/6eb900000000 failed
kvm: vmclear fail:           (null)/6eb900000000

and then things start to lock up because we seem to lose the CPUs the guest was
running on. Once I had this in the logs:

rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 7-... } 15040
jiffies s: 4673 root: 0x80/.
rcu: blocking rcu_node structures:
Task dump for CPU 7:
qemu-system-x86 R  running task        0 17413  17345 0x00000008
Call Trace:
 ? x86_virt_spec_ctrl+0x7/0xe0
 ? vmx_vcpu_run.part.0+0x2a4/0xfa0 [kvm_intel]
 ? vcpu_enter_guest+0x349/0xe80 [kvm]
 ? kvm_arch_vcpu_ioctl_run+0xff/0x550 [kvm]
 ? kvm_vcpu_ioctl+0x20d/0x590 [kvm]
 ? get_futex_key+0x35d/0x3b0
 ? do_vfs_ioctl+0x447/0x640
 ? do_futex+0x157/0x1d0
 ? ksys_ioctl+0x5e/0x90
 ? __x64_sys_ioctl+0x16/0x20
 ? do_syscall_64+0x60/0x120
 ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

This was on a 5.1.16 distro kernel. Currently rebuilding 5.2 vanilla.

Looks like we have up to two critical bugs here...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

