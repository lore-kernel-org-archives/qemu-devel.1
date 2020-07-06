Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D158C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D988620715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3TpSwDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D988620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRzT-0004au-6U
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jsRyq-00042u-QC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:20:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jsRyo-0001q0-Ur
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594045221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVGKpKSecHSU71jiyNlRxogt1XSAg1pUNGpY/NUCCZQ=;
 b=P3TpSwDmOXXoszCLg4H3NH4GxZt4gwAiQUjmF1tzs++F/D0INwUoX/LdbFFfwwOrkS59L3
 MtJbyFHIo9eIsOu3ihGokYXJunDLZo7fx4NQPJJqaEUxUk3c53+sJH8IT/I8fhBI98gNl5
 qasLxYj2FgxceEfYLrsmRFCchBUOxRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-oOrppSPHNm6CuFM46R-uhA-1; Mon, 06 Jul 2020 10:20:14 -0400
X-MC-Unique: oOrppSPHNm6CuFM46R-uhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C22F01883624;
 Mon,  6 Jul 2020 14:20:12 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86B275D9D7;
 Mon,  6 Jul 2020 14:20:09 +0000 (UTC)
Date: Mon, 6 Jul 2020 08:20:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: DMA region abruptly removed from PCI device
Message-ID: <20200706082004.5c887c67@x1.home>
In-Reply-To: <MW2PR02MB3723509CC4795066274C9D4C8B690@MW2PR02MB3723.namprd02.prod.outlook.com>
References: <MW2PR02MB3723509CC4795066274C9D4C8B690@MW2PR02MB3723.namprd02.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 10:55:00 +0000
Thanos Makatos <thanos.makatos@nutanix.com> wrote:

> We have an issue when using the VFIO-over-socket libmuser PoC
> (https://www.mail-archive.com/qemu-devel@nongnu.org/msg692251.html) instead of
> the VFIO kernel module: we notice that DMA regions used by the emulated device
> can be abruptly removed while the device is still using them.
> 
> The PCI device we've implemented is an NVMe controller using SPDK, so it polls
> the submission queues for new requests. We use the latest SeaBIOS where it tries
> to boot from the NVMe controller. Several DMA regions are registered
> (VFIO_IOMMU_MAP_DMA) and then the admin and a submission queues are created.
> From this point SPDK polls both queues. Then, the DMA region where the
> submission queue lies is removed (VFIO_IOMMU_UNMAP_DMA) and then re-added at the
> same IOVA but at a different offset. SPDK crashes soon after as it accesses
> invalid memory. There is no other event (e.g. some PCI config space or NVMe
> register write) happening between unmapping and mapping the DMA region. My guess
> is that this behavior is legitimate and that this is solved in the VFIO kernel
> module by releasing the DMA region only after all references to it have been
> released, which is handled by vfio_pin/unpin_pages, correct? If this is the case
> then I suppose we need to implement the same logic in libmuser, but I just want
> to make sure I'm not missing anything as this is a substantial change.

The vfio_{pin,unpin}_pages() interface only comes into play for mdev
devices and even then it's an announcement that a given mapping is
going away and the vendor driver is required to release references.
For normal PCI device assignment, vfio-pci is (aside from a few quirks)
device agnostic and the IOMMU container mappings are independent of the
device.  We do not have any device specific knowledge to know if DMA
pages still have device references.  The user's unmap request is
absolute, it cannot fail (aside from invalid usage) and upon return
there must be no residual mappings or references of the pages.

If you say there's no config space write, ex. clearing bus master from
the command register, then something like turning on a vIOMMU might
cause a change in the entire address space accessible by the device.
This would cause the identity map of IOVA to GPA to be replaced by a
new one, perhaps another identity map if iommu=pt or a more restricted
mapping if the vIOMMU is used for isolation.

It sounds like you have an incomplete device model, physical devices
have their address space adjusted by an IOMMU independent of, but
hopefully in collaboration with a device driver.  If a physical device
manages to bridge this transition, do what it does.  Thanks,

Alex


