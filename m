Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E96C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13FB20866
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 09:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13FB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94IM-0008M0-Rv
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 04:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j94He-0007Tl-4D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j94Hc-000895-Ci
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:56:13 -0500
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:52418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j94Hc-00085M-6k
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 04:56:12 -0500
Received: from player698.ha.ovh.net (unknown [10.110.208.168])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id BE43F22909F
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 10:56:09 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 74A7BFF61C1F;
 Tue,  3 Mar 2020 09:55:48 +0000 (UTC)
Date: Tue, 3 Mar 2020 10:55:37 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 14/17] spapr: Don't attempt to clamp RMA to VRMA
 constraint
Message-ID: <20200303105537.2c7ece09@bahia.home>
In-Reply-To: <20200303034351.333043-15-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-15-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3006434229036947942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.104.253
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Mar 2020 14:43:48 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The Real Mode Area (RMA) is the part of memory which a guest can access
> when in real (MMU off) mode.  Of course, for a guest under KVM, the MMU
> isn't really turned off, it's just in a special translation mode - Virtual
> Real Mode Area (VRMA) - which looks like real mode in guest mode.
> 
> The mechanics of how this works when using the hash MMU (HPT) put a
> constraint on the size of the RMA, which depends on the size of the
> HPT.  So, the latter part of spapr_setup_hpt_and_vrma() clamps the RMA
> we advertise to the guest based on this VRMA limit.
> 
> There are several things wrong with this:
>  1) spapr_setup_hpt_and_vrma() doesn't actually clamp, it takes the minimum
>     of Node 0 memory size and the VRMA limit.  That will *often* work the
>     same as clamping, but there can be other constraints on RMA size which
>     supersede Node 0 memory size.  We have real bugs caused by this
>     (currently worked around in the guest kernel)
>  2) Some callers of spapr_setup_hpt_and_vrma() are in a situation where
>     we're past the point that we can actually advertise an RMA limit to the
>     guest
>  3) But most fundamentally, the VRMA limit depends on host configuration
>     (page size) which shouldn't be visible to the guest, but this partially
>     exposes it.  This can cause problems with migration in certain edge
>     cases, although we will mostly get away with it.
> 
> In practice, this clamping is almost never applied anyway.  With 64kiB
> pages and the normal rules for sizing of the HPT, the theoretical VRMA
> limit will be 4x(guest memory size) and so never hit.  It will hit with
> 4kiB pages, where it will be (guest memory size)/4.  However all mainstream
> distro kernels for POWER have used a 64kiB page size for at least 10 years.
> 
> So, simply replace this logic with a check that the RMA we've calculated
> based only on guest visible configuration will fit within the host implied
> VRMA limit.  This can break if running HPT guests on a host kernel with
> 4kiB page size.  As noted that's very rare.  There also exist several
> possible workarounds:
>   * Change the host kernel to use 64kiB pages
>   * Use radix MMU (RPT) guests instead of HPT
>   * Use 64kiB hugepages on the host to back guest memory
>   * Increase the guest memory size so that the RMA hits one of the fixed
>     limits before the RMA limit.  This is relatively easy on POWER8 which
>     has a 16GiB limit, harder on POWER9 which has a 1TiB limit.
>   * Use a guest NUMA configuration which artificially constrains the RMA
>     within the VRMA limit (the RMA must always fit within Node 0).
> 
> Previously, on KVM, we also temporarily reduced the rma_size to 256M so
> that the we'd load the kernel and initrd safely, regardless of the VRMA
> limit.  This was a) confusing, b) could significantly limit the size of
> images we could load and c) introduced a behavioural difference between
> KVM and TCG.  So we remove that as well.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         | 28 ++++++++++------------------
>  hw/ppc/spapr_hcall.c   |  4 ++--
>  include/hw/ppc/spapr.h |  3 +--
>  3 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 18bf4bc3de..ef7667455c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1569,7 +1569,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>      spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
>  }
>  
> -void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
> +void spapr_setup_hpt(SpaprMachineState *spapr)
>  {
>      int hpt_shift;
>  
> @@ -1585,10 +1585,16 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
>      }
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
> -    if (spapr->vrma_adjust) {
> +    if (kvm_enabled()) {
>          hwaddr vrma_limit = kvmppc_vrma_limit(spapr->htab_shift);
>  
> -        spapr->rma_size = MIN(spapr_node0_size(MACHINE(spapr)), vrma_limit);
> +        /* Check our RMA fits in the possible VRMA */
> +        if (vrma_limit < spapr->rma_size) {
> +            error_report("Unable to create %" HWADDR_PRIu
> +                         "MiB RMA (VRMA only allows %" HWADDR_PRIu "MiB",
> +                         spapr->rma_size / MiB, vrma_limit / MiB);
> +            exit(EXIT_FAILURE);
> +        }
>      }
>  }
>  
> @@ -1628,7 +1634,7 @@ static void spapr_machine_reset(MachineState *machine)
>          spapr->patb_entry = PATE1_GR;
>          spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
>      } else {
> -        spapr_setup_hpt_and_vrma(spapr);
> +        spapr_setup_hpt(spapr);
>      }
>  
>      qemu_devices_reset();
> @@ -2695,20 +2701,6 @@ static void spapr_machine_init(MachineState *machine)
>  
>      spapr->rma_size = node0_size;
>  
> -    /* With KVM, we don't actually know whether KVM supports an
> -     * unbounded RMA (PR KVM) or is limited by the hash table size
> -     * (HV KVM using VRMA), so we always assume the latter
> -     *
> -     * In that case, we also limit the initial allocations for RTAS
> -     * etc... to 256M since we have no way to know what the VRMA size
> -     * is going to be as it depends on the size of the hash table
> -     * which isn't determined yet.
> -     */
> -    if (kvm_enabled()) {
> -        spapr->vrma_adjust = 1;
> -        spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
> -    }
> -
>      /* Actually we don't support unbounded RMA anymore since we added
>       * proper emulation of HV mode. The max we can get is 16G which
>       * also happens to be what we configure for PAPR mode so make sure
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c2b3286625..40c86e91eb 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1458,7 +1458,7 @@ static void spapr_check_setup_free_hpt(SpaprMachineState *spapr,
>          spapr_free_hpt(spapr);
>      } else if (!(patbe_new & PATE1_GR)) {
>          /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
> -        spapr_setup_hpt_and_vrma(spapr);
> +        spapr_setup_hpt(spapr);
>      }
>      return;
>  }
> @@ -1845,7 +1845,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>           * (because the guest isn't going to use radix) then set it up here. */
>          if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
>              /* legacy hash or new hash: */
> -            spapr_setup_hpt_and_vrma(spapr);
> +            spapr_setup_hpt(spapr);
>          }
>  
>          if (fdt_bufsize < sizeof(hdr)) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a4216935a1..90dbc55931 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -156,7 +156,6 @@ struct SpaprMachineState {
>      SpaprPendingHpt *pending_hpt; /* in-progress resize */
>  
>      hwaddr rma_size;
> -    int vrma_adjust;
>      uint32_t fdt_size;
>      uint32_t fdt_initial_size;
>      void *fdt_blob;
> @@ -795,7 +794,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
>  void spapr_events_init(SpaprMachineState *sm);
>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
>  void close_htab_fd(SpaprMachineState *spapr);
> -void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
> +void spapr_setup_hpt(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);
>  SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
>  void spapr_tce_table_enable(SpaprTceTable *tcet,


