Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA06C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B0720409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSbGY4XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B0720409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGWCQ-0001YT-Ah
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 19:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jGWBf-00013B-Nh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 19:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jGWBd-0007v8-TA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 19:08:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jGWBd-0007uc-J3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 19:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585004928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xplLJ56MVWTvyGrI32x6Qz4ZpXbqBjG9ojd3SDfNrrk=;
 b=jSbGY4XCeJK4IAVoTT2EoIqDYudwT5DN9XTBAIz37Msne6Jc1DWu7iusCvN3HB2VVhYaBk
 vwpiDrv12fSQG+EQ/b62A2ZvV/J7Vp7J/EptfcmNMlmnUlA9gF7/UJK/k+IMiS4MapTj8f
 b4agM+dr0OF/BRvtTVV+k5YS6VLFVeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-GCRnyuOSNfygB1WgDMKLxw-1; Mon, 23 Mar 2020 19:08:47 -0400
X-MC-Unique: GCRnyuOSNfygB1WgDMKLxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44103800D5B;
 Mon, 23 Mar 2020 23:08:45 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1105619C4F;
 Mon, 23 Mar 2020 23:08:36 +0000 (UTC)
Date: Mon, 23 Mar 2020 17:08:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on mmio
 region translation by viommu
Message-ID: <20200323170835.5021f845@w520.home>
In-Reply-To: <20200323084617.1782-2-bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 linuc.decode@gmail.com, David Gibson <david@gibson.dropbear.id.au>,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc +dwg who originated this warning]

On Mon, 23 Mar 2020 14:16:09 +0530
Bharat Bhushan <bbhushan2@marvell.com> wrote:

> On ARM, the MSI doorbell is translated by the virtual IOMMU.
> As such address_space_translate() returns the MSI controller
> MMIO region and we get an "iommu map to non memory area"
> message. Let's remove this latter.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  hw/vfio/common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5ca11488d6..c586edf47a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>                                   &xlat, &len, writable,
>                                   MEMTXATTRS_UNSPECIFIED);
>      if (!memory_region_is_ram(mr)) {
> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
> -                     xlat);
>          return false;
>      }
>  

I'm a bit confused here, I think we need more justification beyond "we
hit this warning and we don't want to because it's ok in this one
special case, therefore remove it".  I assume the special case is that
the device MSI address is managed via the SET_IRQS ioctl and therefore
we won't actually get DMAs to this range.  But I imagine the case that
was in mind when adding this warning was general peer-to-peer between
and assigned and emulated device.  Maybe there's an argument to be made
that such a p2p mapping might also be used in a non-vIOMMU case.  We
skip creating those mappings and drivers continue to work, maybe
because nobody attempts to do p2p DMA with the types of devices we
emulate, maybe because p2p DMA is not absolutely reliable on bare metal
and drivers test it before using it.  Anyway, I need a better argument
why this is ok.  Thanks,

Alex


