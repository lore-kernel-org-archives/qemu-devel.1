Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3AE206E7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3AE206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDvX-00042v-F6
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDti-0001A7-5x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDtf-0007SD-9Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:05 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-CoIrDsahOmSsIci_nLpWBg-1; Fri, 04 Sep 2020 11:45:01 -0400
X-MC-Unique: CoIrDsahOmSsIci_nLpWBg-1
Received: by mail-wr1-f69.google.com with SMTP id g6so2463563wrv.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NBNySzGMTXJs2pDI5BsQ+zAeetphAuLxBRAjAf+BQcE=;
 b=Kq2QQb4oz/AGrcDYV7RvtKMVX3MkgDnhrwps+TPdH54plyC87c9Y0ugBqddzpTfg9X
 hVqFRseas3nxNiZMIJehBqtjXnjeRr/wBKqtlaEAYuHOaBd7JOp8ujO/pTDVzZh+7dfV
 ZicsRBoOcSyHVcTKSRvJyDUG17HyYXm6HVroXkVk2sTbwqmxV0s8V7t7fgViTmKKR2VZ
 bpEfij2eSCuoUqiYdAHUGTcckOgbraL8OWpLJvKEGg7jPczWui0cVOdux0aCiaJDzRQW
 3YqTcFLEmr2K9tnDsLaqTcjN6Cvcyy8981ShPIIM4wdtgcE7it55kTA/WeJRmctk0VFU
 4G3Q==
X-Gm-Message-State: AOAM531VBRz/ym14aTUCrFPPTPfcUKnFL7fUQ7R3yUr1hcA0/Mz/dKdb
 A7yoCEqosyG6xOdsRUjBuXFTZF0Fdwx66vNQA0ZkeS+4m37hheSbkkqX148+6LURQp7FB7/u/bb
 CvXEZp7BRyHd3diE=
X-Received: by 2002:a1c:56d6:: with SMTP id k205mr8168125wmb.88.1599234299958; 
 Fri, 04 Sep 2020 08:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFxiYDEEqBUW6jemEzqr0197NXQuJsZ/5BdTi1biAgAKoiz3JWSdkEC9UC1GEvatNNhWXXUg==
X-Received: by 2002:a1c:56d6:: with SMTP id k205mr8168088wmb.88.1599234299679; 
 Fri, 04 Sep 2020 08:44:59 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c206sm12217832wmf.47.2020.09.04.08.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:44:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 03/13] dma: Document address_space_map/address_space_unmap()
 prototypes
Date: Fri,  4 Sep 2020 17:44:29 +0200
Message-Id: <20200904154439.643272-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add documentation based on address_space_map / address_space_unmap.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 80c5bc3e02d..19bc9ad1b69 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009, 2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -125,6 +125,20 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
 
 int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
 
+/**
+ * address_space_map: Map a physical memory region into a DMA controller
+ *                    virtual address
+ *
+ * May map a subset of the requested range, given by and returned in @plen.
+ * May return %NULL and set *@plen to zero(0), if resources needed to perform
+ * the mapping are exhausted.
+ * Use only for reads OR writes - not for read-modify-write operations.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @dir: indicates the transfer direction
+ */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
                                    DMADirection dir)
@@ -138,6 +152,20 @@ static inline void *dma_memory_map(AddressSpace *as,
     return p;
 }
 
+/**
+ * address_space_unmap: Unmaps a memory region previously mapped
+ *                      by dma_memory_map()
+ *
+ * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
+ * @access_len gives the amount of memory that was actually read or written
+ * by the caller.
+ *
+ * @as: #AddressSpace used
+ * @buffer: host pointer as returned by address_space_map()
+ * @len: buffer length as returned by address_space_map()
+ * @dir: indicates the transfer direction
+ * @access_len: amount of data actually transferred
+ */
 static inline void dma_memory_unmap(AddressSpace *as,
                                     void *buffer, dma_addr_t len,
                                     DMADirection dir, dma_addr_t access_len)
-- 
2.26.2


