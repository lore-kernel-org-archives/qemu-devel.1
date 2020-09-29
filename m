Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4FC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803732075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoCtnw1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803732075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAci-00035I-El
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9za-0005qU-L5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9zY-00021j-OL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:24:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ah7mc5RocJKu5k38pc3bIhhlNP7PQMywKwtP1B1qEw0=;
 b=AoCtnw1vEYc63i/qwNLO69tmBgTVtdhdk12dpVmI2VDhoVOfwJoViqkCunSolHsjeQG5q8
 zxYjx2rKEUFuYJHHpDC7XPOXAGwcglxNpMG42AsWV69y1LydvJABiVIpigc2yRFlPpdNtF
 X8FyY3maSXUcnK+fTmlujVKj0TkrzdE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-pg3dWQO6MTCVTZhYQNmRWA-1; Tue, 29 Sep 2020 03:21:27 -0400
X-MC-Unique: pg3dWQO6MTCVTZhYQNmRWA-1
Received: by mail-wm1-f69.google.com with SMTP id a7so1462323wmc.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ah7mc5RocJKu5k38pc3bIhhlNP7PQMywKwtP1B1qEw0=;
 b=mmpmxkYFvRfkHEgRRrAAPGYOEuBTVe0LECf/EkWJ4T1ZP9AVpssfSOsnmYlEbtjT6z
 RhkzYP72O0JNXxRybMGIoCgdJW8iWlK9uX1Q4fbhU/ZD6my4TJQrkLbKn29IcIiHQTyk
 9uGiExKid8LJuX14LbmUk/tIwO5fqAQK333v2xygPyjdym4VOn3l+oXFuEct09tugUCI
 joGtR9Qfuan9q9N/HXfw4wl/PBpis9b0y7FaRG1b+B2AaPimo6+kSzmoipHD5/KHYnDf
 84rKWWB/oIVMdry4hwPswx5kq9nxNFIc6X4OlfMqIi/BG9Xiw/FugXuYQ/VS41EarEix
 R9Ug==
X-Gm-Message-State: AOAM533ptW3Pg+62FKNXkIpi+7R665+DPVUfpCxlbsDHm5BddOhJh3by
 yxhId03AsszwatZ7rfq2yjZoYRcavZ6Qss+iMjJgw6wt5UAbr9KHTwBWQbv5/mVXFhtl4fxS5Y7
 7YIX2FQbNL8grvd8=
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr2429767wrw.425.1601364085685; 
 Tue, 29 Sep 2020 00:21:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRbMwRFZ9pWhOHmAUD+WFik+UvC0HK0qS4MxnIZyQjRLoVoM6g/oegQBIBIONjlXDkU8xRhw==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr2429751wrw.425.1601364085536; 
 Tue, 29 Sep 2020 00:21:25 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id g8sm3948392wmd.12.2020.09.29.00.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:24 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 12/48] virtio-pmem-pci: force virtio version 1
Message-ID: <20200929071948.281157-13-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

 Qemu fails with below error when trying to run with virtio pmem:

 (qemu) qemu-system-x86_64: -device virtio-pmem-pci,memdev=mem1,id=nv1:
  device is modern-only, use disable-legacy=on

 This patch fixes this by forcing virtio 1 with virtio-pmem.

fixes: adf0748a49 ("virtio-pci: Proxy for virtio-pmem")
Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Message-Id: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pmem-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index 21a457d151..2b2a0b1eae 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -22,6 +22,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&pmem_pci->vdev);
 
+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-- 
MST


