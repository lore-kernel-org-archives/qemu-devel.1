Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF0C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3904920768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVrUUUqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWLX-0007p8-Cg
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jEWKv-0007If-Rb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jEWKu-0002lD-Cd
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:54:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33231)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jEWKu-0002jh-8N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584528847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nndRWJJN8+IkWJsPNKQxYyahZ7jq88M8h1RzMXdEDoU=;
 b=cVrUUUqPTD69pxtY7PGvKNJ6g9nk4S4V7P0kX3WVMs6dP0J+YBOiN1GuNOV7sxi/rGyvjp
 ByEqi5GM9Oy9uGlRW70Ce0W6mJuKisEAujxJBCJMDmGHrncpsT5OYqPK/j94VMULVEh3qq
 D39VvKrU6P8UI/d4Rz44B1Jg13jGgbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-mD7OZXXeMk2Iu2-PCTOlFg-1; Wed, 18 Mar 2020 06:54:04 -0400
X-MC-Unique: mD7OZXXeMk2Iu2-PCTOlFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE2961005516;
 Wed, 18 Mar 2020 10:54:02 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 568C48AC30;
 Wed, 18 Mar 2020 10:53:56 +0000 (UTC)
Subject: Re: [PATCH v8 0/8] virtio-iommu: VFIO integration
To: Bharat Bhushan <bbhushan2@marvell.com>, peter.maydell@linaro.org,
 peterx@redhat.com, eric.auger.pro@gmail.com, alex.williamson@redhat.com,
 kevin.tian@intel.com, mst@redhat.com, tnowicki@marvell.com,
 drjones@redhat.com, linuc.decode@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, bharatb.linux@gmail.com, jean-philippe@linaro.org,
 yang.zhong@intel.com
References: <20200318101159.8767-1-bbhushan2@marvell.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <591c50e8-b811-9aae-e933-1a0d6248ac8c@redhat.com>
Date: Wed, 18 Mar 2020 11:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200318101159.8767-1-bbhushan2@marvell.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat

On 3/18/20 11:11 AM, Bharat Bhushan wrote:
> This patch series integrates VFIO with virtio-iommu.
> This is only applicable for PCI pass-through with virtio-iommu.
> 
> This series is available at:
> https://github.com/bharat-bhushan-devel/qemu.git virtio-iommu-vfio-integration-v8
> 
> This is tested with assigning more than one pci devices to Virtual Machine.
> 
> This series is based on:
>   - virtio-iommu device emulation by Eric Augur.
Auger ;-)
>     [v16,00/10] VIRTIO-IOMMU device
>     https://github.com/eauger/qemu/tree/v4.2-virtio-iommu-v16
This is now upstream so no need to put that ref anymore

Thanks

Eric
> 
>   - Linux 5.6.0-rc4
> 
> v7->v8:
>   - Set page size mask as per host
>     This fixes issue with 64K host/guest 
>   - Device list from IOMMUDevice directly removed VirtioIOMMUNotifierNode
>   - Add missing iep->viommu init on post-load
> 
> v6->v7:
>   - corrected email-address
> 
> v5->v6:
>   - Rebase to v16 version from Eric
>   - Tested with upstream Linux
>   - Added a patch from Eric/Myself on removing mmio-region error print in vfio
> 
> v4->v5:
>  - Rebase to v9 version from Eric
>  - PCIe device hotplug fix
>  - Added Patch 1/5 from Eric previous series (Eric somehow dropped in
>    last version.
>  - Patch "Translate the MSI doorbell in kvm_arch_fixup_msi_route"
>    already integrated with vsmmu3
> 
> v3->v4:
>  - Rebase to v4 version from Eric
>  - Fixes from Eric with DPDK in VM
>  - Logical division in multiple patches
> 
> v2->v3:
>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>    Which is based on top of v2.10-rc0 that
>  - Fixed issue with two PCI devices
>  - Addressed review comments
> 
> v1->v2:
>   - Added trace events
>   - removed vSMMU3 link in patch description
> 
> Bharat Bhushan (8):
>   hw/vfio/common: Remove error print on mmio region translation by
>     viommu
>   memory: Add interface to set iommu page size mask
>   vfio: set iommu page size as per host supported page size
>   virtio-iommu: set supported page size mask
>   virtio-iommu: Add iommu notifier for map/unmap
>   virtio-iommu: Call iommu notifier for attach/detach
>   virtio-iommu: add iommu replay
>   virtio-iommu: add iommu notifier memory-region
> 
>  include/exec/memory.h            |  20 ++++
>  include/hw/virtio/virtio-iommu.h |   2 +
>  hw/vfio/common.c                 |   5 +-
>  hw/virtio/virtio-iommu.c         | 192 ++++++++++++++++++++++++++++++-
>  memory.c                         |  10 ++
>  hw/virtio/trace-events           |   5 +
>  6 files changed, 231 insertions(+), 3 deletions(-)
> 


