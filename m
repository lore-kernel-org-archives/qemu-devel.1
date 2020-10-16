Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10998C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3278220848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx3faZwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3278220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPZL-0005Ni-0Y
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTPY3-0004Sb-Es
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTPXz-0005tU-Gz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602854004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KzaS+0Dq5U2B4OHO/ltbVkJ/zZvXt3LBkeGBg3Tmo4w=;
 b=Gx3faZwGzgd0VgPciu63S76rBBQktSgVK3I5VDNe08CjNNeFt6ME+fDqGkRiW7Gqzrkd7s
 cbX7uHMto/PuhQspgqhqScIi/mafj7XTBA5B/jatcU+4J0oYK6cDiBKurMEvbm4/ZGCeSQ
 8JOU7T50vDu0CgdCYsMoZoobjI4TcV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-cFLTttwZOXC6ztBQ9L6eTQ-1; Fri, 16 Oct 2020 09:13:23 -0400
X-MC-Unique: cFLTttwZOXC6ztBQ9L6eTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAE981018F87;
 Fri, 16 Oct 2020 13:13:21 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 331927D4E3;
 Fri, 16 Oct 2020 13:13:09 +0000 (UTC)
Subject: Re: [PATCH v10 00/10] virtio-iommu: VFIO integration
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8d8ddef8-45bc-92ad-c469-95e65fe8aec4@redhat.com>
Date: Fri, 16 Oct 2020 15:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-1-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, bbhushan2@marvell.com, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> This series adds support for VFIO endpoints to virtio-iommu.
> 
> Versions 1 to 9 were posted by Bharat Bhushan, but I am taking over for
> now since he doesn't have much time to spend on it. Thanks again Bharat
> for the work!
> 
> Two major changes since [v9]:
> 
> * Don't use per-endoint page_size_mask properties. Instead keep a global
>   page size for the virtio-iommu device, updated when adding a VFIO
>   endpoint. Reject hotplug if the page size is incompatible.
> 
> * Try to make the MAP/UNMAP paths more efficient, by keeping track of
>   memory region within the endpoint structure.
> 
> More testing would be appreciated, since I can only test using a software
> model as host at the moment. But it does seem to hold well with PCIe
> hotplug/unplug, and pass-through to guest userspace, which are no mean
> feat.

I tested vhost migration and the following configurations:
host 4K- guest 4K: vhost, vfio, vfio hotplug
host 64K - guest 64K: vhost, vfio, vfio hotplug
host 4K - guest 64K: vhost, vfio, vfio hoplug

All those configs worked for me. I haven't noticed any isse with those.

Thanks

Eric
> 
> Note that one page size combination is not supported: host 64kB guest
> 4kB cannot work, because the host IOMMU driver will automatically pick
> 64kB pages which prevents mapping at a smaller granule. Supporting this
> case would require introducing a page size negotiation mechanism from
> the guest all the way to the host IOMMU driver. Possible, but not
> planned at the moment.
> 
> [v9] https://lore.kernel.org/qemu-devel/20200323084617.1782-1-bbhushan2@marvell.com/
> 
> Bharat Bhushan (7):
>   virtio-iommu: Add memory notifiers for map/unmap
>   virtio-iommu: Call memory notifiers in attach/detach
>   virtio-iommu: Add replay() memory region callback
>   virtio-iommu: Add notify_flag_changed() memory region callback
>   memory: Add interface to set iommu page size mask
>   vfio: Set IOMMU page size as per host supported page size
>   virtio-iommu: Set supported page size mask
> 
> Jean-Philippe Brucker (3):
>   virtio-iommu: Fix virtio_iommu_mr()
>   virtio-iommu: Store memory region in endpoint struct
>   vfio: Don't issue full 2^64 unmap
> 
>  include/exec/memory.h    |  26 +++++
>  hw/vfio/common.c         |  19 ++++
>  hw/virtio/virtio-iommu.c | 204 ++++++++++++++++++++++++++++++++++++++-
>  softmmu/memory.c         |  13 +++
>  hw/virtio/trace-events   |   5 +
>  5 files changed, 265 insertions(+), 2 deletions(-)
> 


