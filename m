Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45BAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E02520644
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E02520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lOT-0003X5-8N
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i9lMb-0001uj-FZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i9lMZ-0007ir-7u
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i9lMZ-0007iY-2e
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D9F73086258;
 Mon, 16 Sep 2019 07:23:53 +0000 (UTC)
Received: from [10.36.116.33] (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9893F19C69;
 Mon, 16 Sep 2019 07:23:40 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190812074531.28970-4-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4177fdbe-480f-20ce-2d0a-eedec6387f13@redhat.com>
Date: Mon, 16 Sep 2019 09:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190812074531.28970-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 16 Sep 2019 07:23:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 3/4] pc/q35: Disallow vfio-pci hotplug
 without VT-d caching mode
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
> Instead of bailing out when trying to hotplug a vfio-pci device with
> below configuration:
> 
>   -device intel-iommu,caching-mode=off
> 
> With this we can return a warning message to the user via QMP/HMP and
> the VM will continue to work after failing the hotplug:
> 
>   (qemu) device_add vfio-pci,bus=root.3,host=05:00.0,id=vfio1
>   Error: Device assignment is not allowed without enabling caching-mode=on for Intel IOMMU.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/pc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..4ea00c7bd2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2905,6 +2905,26 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>      }
>  }
>  
> +
> +static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
> +{
> +    X86IOMMUState *iommu = x86_iommu_get_default();
> +    IntelIOMMUState *intel_iommu;
> +
> +    if (iommu &&
> +        object_dynamic_cast((Object *)iommu, TYPE_INTEL_IOMMU_DEVICE) &&
> +        object_dynamic_cast((Object *)dev, "vfio-pci")) {
> +        intel_iommu = INTEL_IOMMU_DEVICE(iommu);
> +        if (!intel_iommu->caching_mode) {
> +            error_setg(errp, "Device assignment is not allowed without "
> +                       "enabling caching-mode=on for Intel IOMMU.");
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> @@ -2929,6 +2949,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->pvh_enabled = true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = pc_get_hotplug_handler;
> +    mc->hotplug_allowed = pc_hotplug_allowed;
>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>      mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
> 

