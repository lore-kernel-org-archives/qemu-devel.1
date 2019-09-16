Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC7C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB692067D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB692067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lBy-0008Hx-9z
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i9lBA-0007or-SO
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i9lB8-0001KE-K5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:12:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i9lB8-0001JE-5y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:12:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 551AEC03D478;
 Mon, 16 Sep 2019 07:12:04 +0000 (UTC)
Received: from [10.36.116.33] (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68AC8608C0;
 Mon, 16 Sep 2019 07:11:52 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190812074531.28970-2-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <57ddb99c-3c38-db87-0763-c4a0d8039e45@redhat.com>
Date: Mon, 16 Sep 2019 09:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190812074531.28970-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 16 Sep 2019 07:12:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 1/4] intel_iommu: Sanity check vfio-pci
 config on machine init done
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Bandan Das <bsd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,
On 8/12/19 9:45 AM, Peter Xu wrote:
> This check was previously only happened when the IOMMU is enabled in
s/happened/happening
> the guest.  It was always too late because the enabling of IOMMU
> normally only happens during the boot of guest OS.  It means that we
> can bail out and exit directly during the guest OS boots if the
> configuration of devices are not supported.  Or, if the guest didn't
> enable vIOMMU at all, then the user can use the guest normally but as
> long as it reconfigure the guest OS to enable the vIOMMU then reboot,
reconfigures, and then reboots
> the user will see the panic right after the reset when the next boot
> starts.
> 
> Let's make this failure even earlier so that we force the user to use
> caching-mode for vfio-pci devices when with the vIOMMU.  So the user
> won't get surprise at least during execution of the guest, which seems
> a bit nicer.
> 
> This will affect some user who didn't enable vIOMMU in the guest OS
> but was using vfio-pci and the vtd device in the past.  However I hope
> it's not a majority because not enabling vIOMMU with the device
> attached is actually meaningless.
> 
> We still keep the old assertion for safety so far because the hotplug
> path could still reach it, so far.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index de86f53b4e..642dd595ed 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -61,6 +61,13 @@
>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>  
> +static void vtd_panic_require_caching_mode(void)
> +{
> +    error_report("We need to set caching-mode=on for intel-iommu to enable "
> +                 "device assignment with IOMMU protection.");
> +    exit(1);
> +}
> +
>  static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                              uint64_t wmask, uint64_t w1cmask)
>  {
> @@ -2926,9 +2933,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      IntelIOMMUState *s = vtd_as->iommu_state;
>  
>      if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
> -        error_report("We need to set caching-mode=on for intel-iommu to enable "
> -                     "device assignment with IOMMU protection.");
> -        exit(1);
> +        vtd_panic_require_caching_mode();
>      }
>  
>      /* Update per-address-space notifier flags */
> @@ -3696,6 +3701,32 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>      return true;
>  }
>  
> +static int vtd_machine_done_notify_one(Object *child, void *unused)
> +{
> +    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
> +
> +    /*
> +     * We hard-coded here because vfio-pci is the only special case
> +     * here.  Let's be more elegant in the future when we can, but so
> +     * far there seems to be no better way.
> +     */
> +    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
> +        vtd_panic_require_caching_mode();
> +    }
> +
> +    return 0;
> +}
> +
> +static void vtd_machine_done_hook(Notifier *notifier, void *unused)
> +{
> +    object_child_foreach_recursive(object_get_root(),
> +                                   vtd_machine_done_notify_one, NULL);
> +}
> +
> +static Notifier vtd_machine_done_notify = {
> +    .notify = vtd_machine_done_hook,
> +};
> +
>  static void vtd_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -3741,6 +3772,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
>      /* Pseudo address space under root PCI bus. */
>      pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
> +    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
This does not compile anymore on master. I think sysemu/sysemu.h needs
to be included as declaration of qemu_add_machine_init_done_notifier is
not found.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  }
>  
>  static void vtd_class_init(ObjectClass *klass, void *data)
> 

