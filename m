Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAAC5B578
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F3B20989
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 02:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F3B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hirdd-0004u6-4M
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 22:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hircI-0004MX-QS
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hircH-0007W8-CG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 22:36:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>)
 id 1hircE-0007OS-4P; Wed, 03 Jul 2019 22:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67AE185363;
 Thu,  4 Jul 2019 02:36:52 +0000 (UTC)
Received: from xz-x1 (unknown [10.66.61.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E83BD4E6DA;
 Thu,  4 Jul 2019 02:36:47 +0000 (UTC)
Date: Thu, 4 Jul 2019 10:36:44 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190704023644.GB3796@xz-x1>
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-4-eric.auger@redhat.com>
 <20190703054116.GD10408@xz-x1>
 <ac7cb635-b420-e04d-1a80-6fcfe81d12a8@redhat.com>
 <20190703102122.GA3796@xz-x1>
 <8e3aa297-c374-cb3c-cd3f-f68ad6827e5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e3aa297-c374-cb3c-cd3f-f68ad6827e5e@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 04 Jul 2019 02:36:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/6] hw/vfio/common: Do not replay IOMMU
 mappings in nested case
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 12:45:37PM +0200, Auger Eric wrote:
> Hi Peter,

Hi, Eric,

> On 7/3/19 12:21 PM, Peter Xu wrote:
> > On Wed, Jul 03, 2019 at 11:04:38AM +0200, Auger Eric wrote:
> >> Hi Peter,
> > 
> > Hi, Eric,
> > 
> >>
> >> On 7/3/19 7:41 AM, Peter Xu wrote:
> >>> On Mon, Jul 01, 2019 at 11:30:31AM +0200, Eric Auger wrote:
> >>>> In nested mode, the stage 1 translation tables are owned by
> >>>> the guest and there is no caching on host side. So there is
> >>>> no need to replay the mappings.
> >>>>
> >>>> As of today, the SMMUv3 nested mode is not yet implemented
> >>>> and there is no functional VFIO integration without. But
> >>>> keeping the replay call would execute the default implementation
> >>>> of memory_region_iommu_replay and attempt to translate the whole
> >>>> address range, completely stalling qemu. Keeping the MAP/UNMAP
> >>>> notifier registration allows to hit a warning message in the
> >>>> SMMUv3 device that tells the user which VFIO device will not
> >>>> function properly:
> >>>>
> >>>> "qemu-system-aarch64: -device vfio-pci,host=0000:89:00.0: warning:
> >>>> SMMUv3 does not support notification on MAP: device vfio-pci will not
> >>>> function properly"
> >>>>
> >>>> Besides, removing the replay call now allows the guest to boot.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> ---
> >>>>  hw/vfio/common.c | 7 ++++++-
> >>>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>>> index a859298fda..9ea58df67a 100644
> >>>> --- a/hw/vfio/common.c
> >>>> +++ b/hw/vfio/common.c
> >>>> @@ -604,6 +604,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
> >>>>      if (memory_region_is_iommu(section->mr)) {
> >>>>          VFIOGuestIOMMU *giommu;
> >>>>          IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> >>>> +        bool nested = false;
> >>>>          int iommu_idx;
> >>>>  
> >>>>          trace_vfio_listener_region_add_iommu(iova, end);
> >>>> @@ -631,8 +632,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
> >>>>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
> >>>>  
> >>>>          memory_region_register_iommu_notifier(section->mr, &giommu->n);
> >>>> -        memory_region_iommu_replay(giommu->iommu, &giommu->n);
> >>>>  
> >>>> +        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
> >>>> +                                     (void *)&nested);
> >>>> +        if (!nested) {
> >>>> +            memory_region_iommu_replay(iommu_mr, &giommu->n);
> >>>> +        }
> >>>
> >>> For nested, do we need these IOMMU notifiers after all?
> >>>
> >>> I'm asking because the no-IOMMU case of vfio_listener_region_add()
> >>> seems to suite very well for nested page tables to me.  For example,
> >>> vfio does not need to listen to MAP events any more because we'll
> >>> simply share the guest IOMMU page table to be the 1st level page table
> >>> of the host SMMU IIUC.
> >> We don't need the MAP notifier but we need the UNMAP notifier: when the
> >> guest invalidates an ASID/IOVA we need to propagate this to the physical
> >> IOMMU.
> > 
> > Indeed we need the unmaps.  However I've got a major confusion here:
> > With nested mode, we should need unmap events for the 1st level rather
> > than the 2nd level, am I right?
> 
> yes that's correct
> 
>   I mean, the invalidate request should
> > be a GVA range rather than GPA range?  While here IIUC
> > vfio_listener_region_add() should be working on GPA address space.
> 
> Sorry I don't get your point. My understanding is in
> vfio_listener_region_add() we detect the addition of an IOMMU MR and
> init a notifier that covers the input AS it translates (GVA). When the
> guest sends an IOTLB invalidation on its first stage, this is trapped,
> we notify the UNMAP notifier and this eventually produces a stage1
> invalidation at physical level (through VFIO/IOMMU kernel path). This
> piece is not yet implemented: see below.
> 
> 
> > 
> > I don't know SMMU enough, but for Intel there should have two
> > different kinds of invalidation messages.  Currently because we still
> > don't support nested on Intel so the 1st level invalidation is still
> > not yet implemented (VTD_INV_DESC_PIOTLB).  And IMHO if it is going to
> > be implemented, I think it should be different comparing to current
> > IOMMU_NOTIFIER_UNMAP
> Yes the UNMAP notifier implementation is definitively different. It
> calls a VFIO iotcl that eventually produces a physical IOMMU stage1
> invalidation. See ttps://patchwork.kernel.org/patch/10962721/.

[1]

> 
> Maybe the confusion comes from the fact this patch is *not* an
> integration for nested SMMUv3 with VFIO. SMMUv3/VFIO still does not
> work. It just allows the guest to boot by bypassing the replay function.
> If things are clearer maybe I should simply assert() in case we detect a
> VFIO device protected by an SMMUv3.

Actually that's also my question to your other patch [1]:

+        if (container->iommu_type == VFIO_TYPE1_NESTING_IOMMU) {
+            /* Config notifier to propagate guest stage 1 config changes */
+            giommu = vfio_alloc_guest_iommu(container, iommu_mr, offset);
+            iommu_config_notifier_init(&giommu->n, vfio_iommu_nested_notify,
+                                       IOMMU_NOTIFIER_CONFIG_PASID, iommu_idx);
+            QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+            memory_region_register_iommu_notifier(section->mr, &giommu->n);
+
+            /* IOTLB unmap notifier to propagate guest IOTLB invalidations */
+            giommu = vfio_alloc_guest_iommu(container, iommu_mr, offset);
+            iommu_iotlb_notifier_init(&giommu->n, vfio_iommu_unmap_notify,
+                                      IOMMU_NOTIFIER_IOTLB_UNMAP,
+                                      section->offset_within_region,
+                                      int128_get64(llend),
+                                      iommu_idx);
+            QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+            memory_region_register_iommu_notifier(section->mr, &giommu->n);
+        } else {

It'll be fine if we want to do this way finally, but it just let me
feel a bit confusing when we register these notifiers with current
IOMMU notifiers, because IMHO all these two kinds of events:

  - PASID root pointer
  - PASID-based IOTLB invalidations

should not bind to any memory region at all, and should not have a
concept of "memory range to register".  It'll be easier for me to
understand if vfio simply registers with IOMMU directly (or maybe
registering with the PCI layer could be a bit better from code
prospective?) in this case with these two notifiers and there seems to
have nothing to do with current memory region framework.

My vague memory was that Liu Yi has had some similar work (e.g.,
introduce some PCI level notifers and let VFIO registers to that
instead for the nested case, though that's for Intel but IMHO it
suites too for ARM) but I've totally forgotten the details.

Thanks,

-- 
Peter Xu

