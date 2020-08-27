Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A52C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26890207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEyfOVQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26890207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIAf-0004RQ-E1
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI93-0001dJ-BT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI91-0006LA-6J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ClDOcff+wtkvg45OPGxJst3ciUDP9rU2GNJXIg6PAc=;
 b=ZEyfOVQnlCQBeE3H3gqeWch0fdbGVvqbyhScjTqdxMHQMNijAfArcYWV95SZ7l7CXdlB33
 dCT75Rb99OqIwoUNTcV9w9HzLQcBCiVGU6n5gfrKQUWTBhb27WWqbCJxDU18GEWT5SD1Ye
 nbc34Yxx/XpmmAnGtlu8SQ+BoA1isQA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-P_rE05lTO-m9gLnUqIbupA-1; Thu, 27 Aug 2020 09:40:44 -0400
X-MC-Unique: P_rE05lTO-m9gLnUqIbupA-1
Received: by mail-wr1-f70.google.com with SMTP id d15so1555111wrp.10
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/ClDOcff+wtkvg45OPGxJst3ciUDP9rU2GNJXIg6PAc=;
 b=mo/eX+VrD6Ue5x7iObwnFoUnVhgsrH9VCzWgQKOiH6UTruTrVsl6I9rvrAILkVaL0c
 eC8qz9Nhwau8UJVO2ump42ZR4U0uyYCyc6+MW1oO2xlbZQikXQx0R54u6VZvFY7bcMT7
 dnVCdixWDZc97DS9s/shwhPKMZVJC8SAXWrmHbbpNkpSE7JGfKL3ni1Z2JTYalCxwCzb
 FNKxw0fwB09YVQmzD1P98/mvrNsUjpAq+qOQEi4oXbv5WsBIegRP+jDq9qQuYn+asxbN
 PzbxWFdrP0XJaCJd26ko/ss5Zn664hW4IWDJUipkZT/dE4VzFnrYMb9so2eZTvKvyCab
 tLzg==
X-Gm-Message-State: AOAM530M2or8mI8orljQRqBQOqJ6FQwN7DYKs4UT82TN2YO8RQRLXh1x
 IuvWmVBQ4WLPxii6mvwf86ViaLE7rU6DGhnF/NH09rWZCRKMrxPair7649/lxf6cfQp22pZS7Yi
 G5/R/N3rG+CUFaj0=
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr17215136wrr.365.1598535642879; 
 Thu, 27 Aug 2020 06:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywa6yMwaH70voVF213MlHbmVeYQUkPS3Czv/pBqLCaYXMIb+rBh9foOdEbkEqRIApv+1c5Tg==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr17215120wrr.365.1598535642649; 
 Thu, 27 Aug 2020 06:40:42 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id l21sm4769314wmj.25.2020.08.27.06.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:42 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] virtio-pci: add virtio_pci_optimal_num_queues() helper
Message-ID: <20200827133954.2118749-8-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Multi-queue devices achieve the best performance when each vCPU has a
dedicated queue. This ensures that virtqueue used notifications are
handled on the same vCPU that submitted virtqueue buffers.  When another
vCPU handles the the notification an IPI will be necessary to wake the
submission vCPU and this incurs a performance overhead.

Provide a helper function that virtio-pci devices will use in later
patches to automatically select the optimal number of queues.

The function handles guests with large numbers of CPUs by limiting the
number of queues to fit within the following constraints:
1. The maximum number of MSI-X vectors.
2. The maximum number of virtqueues.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200818143348.310613-4-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h |  9 +++++++++
 hw/virtio/virtio-pci.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index e2eaaa9182..91096f0291 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -243,4 +243,13 @@ typedef struct VirtioPCIDeviceTypeInfo {
 /* Register virtio-pci type(s).  @t must be static. */
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t);
 
+/**
+ * virtio_pci_optimal_num_queues:
+ * @fixed_queues: number of queues that are always present
+ *
+ * Returns: The optimal number of queues for a multi-queue device, excluding
+ * @fixed_queues.
+ */
+unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues);
+
 #endif
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ccdf54e81c..fc69570dcc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,6 +19,7 @@
 
 #include "exec/memop.h"
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/boards.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
@@ -2058,6 +2059,37 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     g_free(base_name);
 }
 
+unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues)
+{
+    /*
+     * 1:1 vq to vCPU mapping is ideal because the same vCPU that submitted
+     * virtqueue buffers can handle their completion. When a different vCPU
+     * handles completion it may need to IPI the vCPU that submitted the
+     * request and this adds overhead.
+     *
+     * Virtqueues consume guest RAM and MSI-X vectors. This is wasteful in
+     * guests with very many vCPUs and a device that is only used by a few
+     * vCPUs. Unfortunately optimizing that case requires manual pinning inside
+     * the guest, so those users might as well manually set the number of
+     * queues. There is no upper limit that can be applied automatically and
+     * doing so arbitrarily would result in a sudden performance drop once the
+     * threshold number of vCPUs is exceeded.
+     */
+    unsigned num_queues = current_machine->smp.cpus;
+
+    /*
+     * The maximum number of MSI-X vectors is PCI_MSIX_FLAGS_QSIZE + 1, but the
+     * config change interrupt and the fixed virtqueues must be taken into
+     * account too.
+     */
+    num_queues = MIN(num_queues, PCI_MSIX_FLAGS_QSIZE - fixed_queues);
+
+    /*
+     * There is a limit to how many virtqueues a device can have.
+     */
+    return MIN(num_queues, VIRTIO_QUEUE_MAX - fixed_queues);
+}
+
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
-- 
MST


