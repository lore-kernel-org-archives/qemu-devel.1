Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B5E2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5E2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdB5P-0005fm-5r
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdB4M-0004MM-TP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:15:01 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:59317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdB4L-0007eN-E2
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:14:58 -0400
Received: from player694.ha.ovh.net (unknown [10.108.42.184])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id BD8FE161689
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 13:14:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id B1FED129773D0;
 Mon, 25 May 2020 11:14:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0027a4b149b-0bfb-403d-8187-646cad0b4dc9,22A89661A4361147AF88D80C9EA00EFFECB1F326)
 smtp.auth=groug@kaod.org
Date: Mon, 25 May 2020 13:14:31 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 17/18] spapr: Added PEF based guest memory protection
Message-ID: <20200525131431.329f39f5@bahia.lan>
In-Reply-To: <20200521034304.340040-18-david@gibson.dropbear.id.au>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-18-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12154652446889843174
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.34.113; envelope-from=groug@kaod.org;
 helo=3.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 07:14:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 13:43:03 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Some upcoming POWER machines have a system called PEF (Protected
> Execution Framework) which uses a small ultravisor to allow guests to

s/Framework/Facility

> run in a way that they can't be eavesdropped by the hypervisor.  The
> effect is roughly similar to AMD SEV, although the mechanisms are
> quite different.
> 
> Most of the work of this is done between the guest, KVM and the
> ultravisor, with little need for involvement by qemu.  However qemu
> does need to tell KVM to allow secure VMs.
> 
> Because the availability of secure mode is a guest visible difference
> which depends on havint the right hardware and firmware, we don't

s/havint/having

> enable this by default.  In order to run a secure guest you need to
> create a "pef-guest" object and set the guest-memory-protection machine property to point to it.
> 

Wrap line after "machine" maybe ?

> Note that this just *allows* secure guests, the architecture of PEF is
> such that the guest still needs to talk to the ultravisor to enter
> secure mode, so we can't know if the guest actually is secure until
> well after machine creation time.
> 

Maybe worth mentioning that this is for KVM only. Also, this is
silently ignored with TCG since pef_kvm_init() isn't called in
this case. Would it make sense to print some warning like we
do for these spapr caps that we don't support with TCG ?

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/Makefile.objs |  2 +-
>  target/ppc/pef.c         | 81 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 target/ppc/pef.c
> 
> diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
> index e8fa18ce13..ac93b9700e 100644
> --- a/target/ppc/Makefile.objs
> +++ b/target/ppc/Makefile.objs
> @@ -6,7 +6,7 @@ obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
>  obj-$(TARGET_PPC64) += mmu-hash64.o mmu-book3s-v3.o compat.o
>  obj-$(TARGET_PPC64) += mmu-radix64.o
>  endif
> -obj-$(CONFIG_KVM) += kvm.o
> +obj-$(CONFIG_KVM) += kvm.o pef.o
>  obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>  obj-y += dfp_helper.o
>  obj-y += excp_helper.o
> diff --git a/target/ppc/pef.c b/target/ppc/pef.c
> new file mode 100644
> index 0000000000..823daf3e9c
> --- /dev/null
> +++ b/target/ppc/pef.c
> @@ -0,0 +1,81 @@
> +/*
> + * PEF (Protected Execution Framework) for POWER support

s/Framework/Facility

> + *
> + * Copyright David Gibson, Redhat Inc. 2020
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +

I had to include some more headers to build this.

#include "exec/guest-memory-protection.h"
#include "qapi/error.h"
#include "qom/object_interfaces.h"
#include "sysemu/kvm.h"

> +#define TYPE_PEF_GUEST "pef-guest"
> +#define PEF_GUEST(obj)                                  \
> +    OBJECT_CHECK(PefGuestState, (obj), TYPE_SEV_GUEST)

s/TYPE_SEV_GUEST/TYPE_PEF_GUEST

> +
> +typedef struct PefGuestState PefGuestState;
> +
> +/**
> + * PefGuestState:
> + *
> + * The PefGuestState object is used for creating and managing a PEF
> + * guest.
> + *
> + * # $QEMU \
> + *         -object pef-guest,id=pef0 \
> + *         -machine ...,guest-memory-protection=pef0
> + */
> +struct PefGuestState {
> +    Object parent_obj;
> +};
> +
> +static Error *pef_mig_blocker;

Unused.

> +
> +static int pef_kvm_init(GuestMemoryProtection *gmpo, Error **errp)
> +{
> +    PefGuestState *pef = PEF_GUEST(gmpo);

Unused.

> +
> +    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_SECURE_GUEST)) {
> +        error_setg(errp,
> +                   "KVM implementation does not support Secure VMs (is an ultravisor running?)");
> +        return -1;
> +    } else {
> +        int ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_SECURE_GUEST, 0, 1);
> +
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "Error enabling PEF with KVM");
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static void pef_guest_class_init(ObjectClass *oc, void *data)
> +{
> +    GuestMemoryProtectionClass *gmpc = GUEST_MEMORY_PROTECTION_CLASS(oc);
> +
> +    gmpc->kvm_init = pef_kvm_init;
> +}
> +
> +static const TypeInfo pef_guest_info = {
> +    .parent = TYPE_OBJECT,
> +    .name = TYPE_PEF_GUEST,
> +    .instance_size = sizeof(PefGuestState),
> +    .class_init = pef_guest_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_GUEST_MEMORY_PROTECTION },
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void
> +pef_register_types(void)
> +{
> +    type_register_static(&pef_guest_info);
> +}
> +
> +type_init(pef_register_types);


