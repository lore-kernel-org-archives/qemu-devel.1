Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF2F21556
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF2F21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9noY-00086p-Ts
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j9nnU-0007G6-BZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j9nnT-00054A-1M
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:32:08 -0500
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:54869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j9nnS-00050V-RD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:32:06 -0500
Received: from player788.ha.ovh.net (unknown [10.108.54.52])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id DF462877AA
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 11:32:02 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id C7B35101DCD5A;
 Thu,  5 Mar 2020 10:31:53 +0000 (UTC)
Date: Thu, 5 Mar 2020 11:31:46 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200305113146.6850f04b@bahia.home>
In-Reply-To: <20200305043009.611636-2-david@gibson.dropbear.id.au>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15357837682151823846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.80
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Mar 2020 15:30:08 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> the guess mostly like classic PCI, even if some of the individual
> devices on the bus are PCI Express.  One consequence of that is that
> virtio-pci devices still default to being in transitional mode, though
> legacy mode is now disabled by default on current q35 x86 machine
> types.
> 
> Legacy mode virtio devices aren't really necessary any more, and are
> causing some problems for future changes.  Therefore, for the
> pseries-5.0 machine type (and onwards), switch to modern-only
> virtio-pci devices by default.
> 
> This does mean we no longer support guest kernels prior to 4.0, unless
> they have modern virtio support backported (which some distro kernels
> like that in RHEL7 do).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

FWIW, I could test the following:
- allows a RHEL7 guest with pre 4.0 kernel to boot, as mentioned
  in the changelog
- breaks boot of older RHEL 6.10 guests as expected
- allows migration of older machine types to/from QEMU 4.2

Tested-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2eb0d8f70d..3cfc98ac61 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -65,6 +65,7 @@
>  
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> +#include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost-scsi-common.h"
>  
> @@ -4566,8 +4567,20 @@ static const TypeInfo spapr_machine_info = {
>  
>  static void spapr_machine_latest_class_options(MachineClass *mc)
>  {
> +    /*
> +     * Most defaults for the latest behaviour are inherited from the
> +     * base class, but we need to override the (non ppc specific)
> +     * default behaviour for virtio.  We can't do that from the base
> +     * class since it doesn't have a compat_props.
> +     */
> +    static GlobalProperty compat[] = {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +    };
> +
>      mc->alias = "pseries";
>      mc->is_default = true;
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
>  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
> @@ -4607,6 +4620,9 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] = {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> +    };
>  
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> @@ -4614,6 +4630,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
>      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>      smc->rma_limit = 16 * GiB;
>      mc->nvdimm_supported = false;
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);


