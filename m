Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90483C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6403620663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6403620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNaF-0000xa-H8
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifNZO-0000HH-3j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifNZM-0006DW-GA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:27:49 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:49897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifNZM-00061T-7u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:27:48 -0500
Received: from player750.ha.ovh.net (unknown [10.108.57.178])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0F1A412950A
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 13:27:38 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 8A8BAD2EFBF3;
 Thu, 12 Dec 2019 12:27:26 +0000 (UTC)
Date: Thu, 12 Dec 2019 13:27:23 +0100
From: Greg Kurz <groug@kaod.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191212132723.5fdfee47@bahia.tlslab.ibm.com>
In-Reply-To: <20191212055059.9399-3-bharata@linux.ibm.com>
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3619205253579119094
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.148
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxram@us.ibm.com,
 qemu-devel@nongnu.org, paulus@ozlabs.org, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 11:20:59 +0530
Bharata B Rao <bharata@linux.ibm.com> wrote:

> A pseries guest can be run as a secure guest on Ultravisor-enabled
> POWER platforms. When such a secure guest is reset, we need to
> release/reset a few resources both on ultravisor and hypervisor side.
> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> machine reset path.
> 
> As part of this ioctl, the secure guest is essentially transitioned
> back to normal mode so that it can reboot like a regular guest and
> become secure again.
> 
> This ioctl has no effect when invoked for a normal guest. If this ioctl
> fails for a secure guest, the guest is terminated.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
>  hw/ppc/spapr.c       | 15 +++++++++++++++
>  target/ppc/kvm.c     |  7 +++++++
>  target/ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f11422fc41..25e1a3446e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *machine)
>      void *fdt;
>      int rc;
>  
> +    /*
> +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> +     * exit in that case. However check for -ENOTTY explicitly
> +     * to ensure that we don't terminate normal guests that are
> +     * running on kernels which don't support this ioctl.
> +     *
> +     * Also, this ioctl returns 0 for normal guests on kernels where
> +     * this ioctl is supported.
> +     */
> +    rc = kvmppc_svm_off();
> +    if (rc && rc != -ENOTTY) {

This ioctl can also return -EINVAL if the ultravisor actually failed to move
the guest back to non-secure mode or -EBUSY if a vCPU is still running. I
agree that the former deserve the VM to be terminated. What about the latter ?
Can this happen and if yes, why ? Should we try again as suggested by Alexey ?
Could this reveal a bug in QEMU, in which case we should maybe abort ?

> +        error_report("Reset of secure guest failed, exiting...");
> +        exit(EXIT_FAILURE);
> +    }
> +
>      spapr_caps_apply(spapr);
>  
>      first_ppc_cpu = POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7406d18945..1a86fa4f0c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2900,3 +2900,10 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
>      }
>  }
> +
> +int kvmppc_svm_off(void)
> +{
> +    KVMState *s = KVM_STATE(current_machine->accelerator);
> +
> +    return kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 47b08a4030..5cc812e486 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> +int kvmppc_svm_off(void);
>  #ifndef CONFIG_USER_ONLY
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
> @@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>      return 0;
>  }
>  
> +static inline int kvmppc_svm_off(void)
> +{
> +    return 0;
> +}
> +
>  static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
>                                               unsigned int online)
>  {


