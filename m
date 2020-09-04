Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A8C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B8820791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B8820791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDzF-0002HT-RR
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuG-0001vV-D5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuC-0007g7-Kq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:40 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-9JDt-5nYPT-ctL1wpN0mOg-1; Fri, 04 Sep 2020 11:45:35 -0400
X-MC-Unique: 9JDt-5nYPT-ctL1wpN0mOg-1
Received: by mail-wr1-f72.google.com with SMTP id 3so2471837wrm.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2AmcRETA9oKsnKY8UnfQs5f8OyuGwuYLNWaynUgMlWs=;
 b=Rl59+IjU8nn5YWghPMF5VIl6K2NVyMlkFpG/+rJezUBmKEOvDOjOqMx/V5MtKqOtbB
 oKPBjaEkhMKyq7qMEU4BjpEYGFl0nUi2n6W7Hl/5BX8cXT4XnRUEF3hojhuGKOKe2L47
 kx7kJC1/d5Ypu0t0BP5oOHn62PLfRO8yS/sK1g0yJym1CyeUL8ufIQKHuKLWh22q1HKo
 3Ged/mRKOla5IRCG4LZKLSVppXLmF2ZnaVXjGlEMmlxEHEaWyBUQYpEY4etF14WtJkSS
 UeKvTTB6ZayvxL8ZuX6cKcKCgz2foUIM2Pei85HidrawGDACY4OO3Zms8wcse+VC4ZlV
 SWKQ==
X-Gm-Message-State: AOAM531q7En1Un65WOpc+vfirdlF7rB1q6uSeO+XVL3moxzIffde8hUd
 iPH8O/x7s8//4MXcjldCPSVObQgMfdB6hrrXAR6mhHgfQJXcN0gbJCzj3i3RqNPlyQrS325XlI9
 RiAqlr3IG9pzqslQ=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr8837886wmh.177.1599234333471; 
 Fri, 04 Sep 2020 08:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyaUuqzBsy5mhs9NpcMoj7Eyv0YrRiNFzxz6psHid+BPNYwWOB0q+ockmdVg6Y8ecRU5kqaQ==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr8837832wmh.177.1599234333203; 
 Fri, 04 Sep 2020 08:45:33 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t16sm12218159wrm.57.2020.09.04.08.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/13] dma: Let dma_memory_set() take MemTxAttrs argument
Date: Fri,  4 Sep 2020 17:44:35 +0200
Message-Id: <20200904154439.643272-10-philmd@redhat.com>
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

Let devices specify transaction attributes when calling
dma_memory_set().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ppc/spapr_vio.h | 3 ++-
 include/sysemu/dma.h       | 3 ++-
 dma-helpers.c              | 5 ++---
 hw/nvram/fw_cfg.c          | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index f134f6cf574..6e5c0840248 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -116,7 +116,8 @@ static inline int spapr_vio_dma_write(SpaprVioDevice *dev, uint64_t taddr,
 static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
                                     uint8_t c, uint32_t size)
 {
-    return (dma_memory_set(&dev->as, taddr, c, size) != 0) ?
+    return (dma_memory_set(&dev->as, taddr,
+                           c, size, MEMTXATTRS_UNSPECIFIED) != 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index b322aa5947b..d0381f9ae9b 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -175,9 +175,10 @@ static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
  * @addr: address within that address space
  * @c: constant byte to fill the memory
  * @len: the number of bytes to fill with the constant byte
+ * @attrs: memory transaction attributes
  */
 MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
-                           uint8_t c, dma_addr_t len);
+                           uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 /**
  * address_space_map: Map a physical memory region into a DMA controller
diff --git a/dma-helpers.c b/dma-helpers.c
index 4a9e37d6d06..6a9735386dc 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -19,7 +19,7 @@
 /* #define DEBUG_IOMMU */
 
 MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
-                           uint8_t c, dma_addr_t len)
+                           uint8_t c, dma_addr_t len, MemTxAttrs attrs)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
@@ -31,8 +31,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l = len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |= address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                     fillbuf, l);
+        error |= address_space_write(as, addr, attrs, fillbuf, l);
         len -= l;
         addr += l;
     }
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f3a4728288e..a15de06a10c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -397,7 +397,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
              * tested before.
              */
             if (read) {
-                if (dma_memory_set(s->dma_as, dma.address, 0, len)) {
+                if (dma_memory_set(s->dma_as, dma.address, 0, len,
+                                   MEMTXATTRS_UNSPECIFIED)) {
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
-- 
2.26.2


