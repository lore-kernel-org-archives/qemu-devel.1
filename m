Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C95720770
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95720770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE1L-0005pA-97
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuc-0002Nu-7i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuV-0007oy-Ua
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:01 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-4P2BpnzkNfOJLqv39Bm0mg-1; Fri, 04 Sep 2020 11:45:53 -0400
X-MC-Unique: 4P2BpnzkNfOJLqv39Bm0mg-1
Received: by mail-wm1-f71.google.com with SMTP id c198so2330176wme.5
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qcaQVzFCFTr8Q6j5R5daDHhhkiR0ysp/Af8Ku8Jlt7A=;
 b=UI0dZRfzjLiIEa6/DgGll0Wp0Ja1ZrVAQNcSry1gslMnI6adBSwXjkUhCSUkm4PtK+
 7YfPsUAxOFXOD4mFDmrkjCPoNPnPxKrcIgOjjiSOj7EvZTQnnWoqe4zBpDoQN6X+kERz
 Ut8DbJ5Bl58g/1Sx8oP4A0sW+cck9Gh5T8NDLXnaWD5sQB1z4bJB0C/y5rMnwTy8fo+Y
 8EbVrUClgRd3f5FV0IHWSkVSuxcUc1s716jy7HM6kmSTxtqGtY5ZFwL8jnYf3+A24Hua
 kZscqictRBjqPL9dz/cOP9GcIPLvScaljba5g4fgWJ7uD1HwoTuEeR8z9vV9lrhwQqIl
 AvPw==
X-Gm-Message-State: AOAM533QnWQjOGw/sy4namhTqCWfv1jLpqw7bChuEkorzReAXjB8wg6t
 47XDyItKucEAeCfJNTwXaRYJLTctRmrnOQCTwnYX7oKwkOfjMSJ0TUWWGoree6NjR4hnIQs7otX
 kBELQagsS2BBJaWc=
X-Received: by 2002:adf:f50a:: with SMTP id q10mr8166972wro.319.1599234351483; 
 Fri, 04 Sep 2020 08:45:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmJ7w6Gz7ssxaHsI4/ww3KPDdC7xa2kRdNpSOKDdsFC04TRo9ah8ojm8ANe2PtFY/x7vTg4g==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr8166912wro.319.1599234350934; 
 Fri, 04 Sep 2020 08:45:50 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b2sm11758641wmh.47.2020.09.04.08.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 12/13] dma: Let dma_memory_read/write() take MemTxAttrs
 argument
Date: Fri,  4 Sep 2020 17:44:38 +0200
Message-Id: <20200904154439.643272-13-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.003
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
dma_memory_read() or dma_memory_write().

Patch created mechanically using spatch with this script:

  @@
  expression E1, E2, E3, E4;
  @@
  (
  - dma_memory_read(E1, E2, E3, E4)
  + dma_memory_read(E1, E2, E3, E4, MEMTXATTRS_UNSPECIFIED)
  |
  - dma_memory_write(E1, E2, E3, E4)
  + dma_memory_write(E1, E2, E3, E4, MEMTXATTRS_UNSPECIFIED)
  )

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ppc/spapr_vio.h    |  6 ++++--
 include/sysemu/dma.h          | 20 ++++++++++++--------
 hw/arm/musicpal.c             | 13 +++++++------
 hw/arm/smmu-common.c          |  3 ++-
 hw/arm/smmuv3.c               | 14 +++++++++-----
 hw/core/generic-loader.c      |  3 ++-
 hw/dma/pl330.c                | 12 ++++++++----
 hw/dma/sparc32_dma.c          | 16 ++++++++++------
 hw/dma/xlnx-zynq-devcfg.c     |  6 ++++--
 hw/dma/xlnx_dpdma.c           | 10 ++++++----
 hw/i386/amd_iommu.c           | 16 +++++++++-------
 hw/i386/intel_iommu.c         | 28 +++++++++++++++++-----------
 hw/ide/macio.c                |  2 +-
 hw/intc/xive.c                |  7 ++++---
 hw/misc/bcm2835_property.c    |  3 ++-
 hw/misc/macio/mac_dbdma.c     | 10 ++++++----
 hw/net/allwinner-sun8i-emac.c | 21 ++++++++++++++-------
 hw/net/ftgmac100.c            | 25 ++++++++++++++++---------
 hw/net/imx_fec.c              | 32 ++++++++++++++++++++------------
 hw/nvram/fw_cfg.c             |  9 ++++++---
 hw/pci-host/pnv_phb3.c        |  5 +++--
 hw/pci-host/pnv_phb3_msi.c    |  9 ++++++---
 hw/pci-host/pnv_phb4.c        |  7 ++++---
 hw/sd/allwinner-sdhost.c      | 14 ++++++++------
 hw/sd/sdhci.c                 | 35 ++++++++++++++++++++++-------------
 hw/usb/hcd-dwc2.c             |  8 ++++----
 hw/usb/hcd-ehci.c             |  6 ++++--
 hw/usb/hcd-ohci.c             | 18 +++++++++++-------
 28 files changed, 221 insertions(+), 137 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 6e5c0840248..8168f4fc5a5 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -102,14 +102,16 @@ static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t taddr,
 static inline int spapr_vio_dma_read(SpaprVioDevice *dev, uint64_t taddr,
                                      void *buf, uint32_t size)
 {
-    return (dma_memory_read(&dev->as, taddr, buf, size) != 0) ?
+    return (dma_memory_read(&dev->as, taddr,
+                            buf, size, MEMTXATTRS_UNSPECIFIED) != 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
 
 static inline int spapr_vio_dma_write(SpaprVioDevice *dev, uint64_t taddr,
                                       const void *buf, uint32_t size)
 {
-    return (dma_memory_write(&dev->as, taddr, buf, size) != 0) ?
+    return (dma_memory_write(&dev->as, taddr,
+                             buf, size, MEMTXATTRS_UNSPECIFIED) != 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 0695d430119..b9cb9c8944b 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -143,12 +143,14 @@ static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
  * @addr: address within that address space
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
+ * @attrs: memory transaction attributes
  */
 static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
-                                          void *buf, dma_addr_t len)
+                                          void *buf, dma_addr_t len,
+                                          MemTxAttrs attrs)
 {
     return dma_memory_rw(as, addr, buf, len,
-                         DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                         DMA_DIRECTION_TO_DEVICE, attrs);
 }
 
 /**
@@ -162,12 +164,14 @@ static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
  * @addr: address within that address space
  * @buf: buffer with the data transferred
  * @len: the number of bytes to write
+ * @attrs: memory transaction attributes
  */
 static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
-                                           const void *buf, dma_addr_t len)
+                                           const void *buf, dma_addr_t len,
+                                           MemTxAttrs attrs)
 {
     return dma_memory_rw(as, addr, (void *)buf, len,
-                         DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                         DMA_DIRECTION_FROM_DEVICE, attrs);
 }
 
 /**
@@ -240,7 +244,7 @@ static inline void dma_memory_unmap(AddressSpace *as,
                                                             dma_addr_t addr) \
     {                                                                   \
         uint##_bits##_t val;                                            \
-        dma_memory_read(as, addr, &val, (_bits) / 8);                   \
+        dma_memory_read(as, addr, &val, (_bits) / 8, MEMTXATTRS_UNSPECIFIED); \
         return _end##_bits##_to_cpu(val);                               \
     }                                                                   \
     static inline void st##_sname##_##_end##_dma(AddressSpace *as,      \
@@ -248,20 +252,20 @@ static inline void dma_memory_unmap(AddressSpace *as,
                                                  uint##_bits##_t val)   \
     {                                                                   \
         val = cpu_to_##_end##_bits(val);                                \
-        dma_memory_write(as, addr, &val, (_bits) / 8);                  \
+        dma_memory_write(as, addr, &val, (_bits) / 8, MEMTXATTRS_UNSPECIFIED); \
     }
 
 static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr)
 {
     uint8_t val;
 
-    dma_memory_read(as, addr, &val, 1);
+    dma_memory_read(as, addr, &val, 1, MEMTXATTRS_UNSPECIFIED);
     return val;
 }
 
 static inline void stb_dma(AddressSpace *as, dma_addr_t addr, uint8_t val)
 {
-    dma_memory_write(as, addr, &val, 1);
+    dma_memory_write(as, addr, &val, 1, MEMTXATTRS_UNSPECIFIED);
 }
 
 DEFINE_LDST_DMA(uw, w, 16, le);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index f2f4fc02649..5d9959e8ddd 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -187,13 +187,13 @@ static void eth_rx_desc_put(AddressSpace *dma_as, uint32_t addr,
     cpu_to_le16s(&desc->buffer_size);
     cpu_to_le32s(&desc->buffer);
     cpu_to_le32s(&desc->next);
-    dma_memory_write(dma_as, addr, desc, sizeof(*desc));
+    dma_memory_write(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
 }
 
 static void eth_rx_desc_get(AddressSpace *dma_as, uint32_t addr,
                             mv88w8618_rx_desc *desc)
 {
-    dma_memory_read(dma_as, addr, desc, sizeof(*desc));
+    dma_memory_read(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
     le32_to_cpus(&desc->cmdstat);
     le16_to_cpus(&desc->bytes);
     le16_to_cpus(&desc->buffer_size);
@@ -217,7 +217,7 @@ static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             eth_rx_desc_get(&s->dma_as, desc_addr, &desc);
             if ((desc.cmdstat & MP_ETH_RX_OWN) && desc.buffer_size >= size) {
                 dma_memory_write(&s->dma_as, desc.buffer + s->vlan_header,
-                                          buf, size);
+                                 buf, size, MEMTXATTRS_UNSPECIFIED);
                 desc.bytes = size + s->vlan_header;
                 desc.cmdstat &= ~MP_ETH_RX_OWN;
                 s->cur_rx[i] = desc.next;
@@ -243,13 +243,13 @@ static void eth_tx_desc_put(AddressSpace *dma_as, uint32_t addr,
     cpu_to_le16s(&desc->bytes);
     cpu_to_le32s(&desc->buffer);
     cpu_to_le32s(&desc->next);
-    dma_memory_write(dma_as, addr, desc, sizeof(*desc));
+    dma_memory_write(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
 }
 
 static void eth_tx_desc_get(AddressSpace *dma_as, uint32_t addr,
                             mv88w8618_tx_desc *desc)
 {
-    dma_memory_read(dma_as, addr, desc, sizeof(*desc));
+    dma_memory_read(dma_as, addr, desc, sizeof(*desc), MEMTXATTRS_UNSPECIFIED);
     le32_to_cpus(&desc->cmdstat);
     le16_to_cpus(&desc->res);
     le16_to_cpus(&desc->bytes);
@@ -271,7 +271,8 @@ static void eth_send(mv88w8618_eth_state *s, int queue_index)
         if (desc.cmdstat & MP_ETH_TX_OWN) {
             len = desc.bytes;
             if (len < 2048) {
-                dma_memory_read(&s->dma_as, desc.buffer, buf, len);
+                dma_memory_read(&s->dma_as, desc.buffer, buf, len,
+                                MEMTXATTRS_UNSPECIFIED);
                 qemu_send_packet(qemu_get_queue(s->nic), buf, len);
             }
             desc.cmdstat &= ~MP_ETH_TX_OWN;
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3838db13952..f42ee237204 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -188,7 +188,8 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte));
+    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte),
+                          MEMTXATTRS_UNSPECIFIED);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0122700e725..71d0eea2af1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -101,7 +101,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, void *data)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
 
-    return dma_memory_read(&address_space_memory, addr, data, q->entry_size);
+    return dma_memory_read(&address_space_memory, addr, data, q->entry_size,
+                           MEMTXATTRS_UNSPECIFIED);
 }
 
 static MemTxResult queue_write(SMMUQueue *q, void *data)
@@ -109,7 +110,8 @@ static MemTxResult queue_write(SMMUQueue *q, void *data)
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
 
-    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size);
+    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size,
+                           MEMTXATTRS_UNSPECIFIED);
     if (ret != MEMTX_OK) {
         return ret;
     }
@@ -283,7 +285,8 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
+                          MEMTXATTRS_UNSPECIFIED);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -304,7 +307,8 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
 
     trace_smmuv3_get_cd(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf));
+    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
+                          MEMTXATTRS_UNSPECIFIED);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -409,7 +413,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
         ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
-                              sizeof(l1std));
+                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index a242c076f69..ba48ebae993 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -57,7 +57,8 @@ static void generic_loader_reset(void *opaque)
 
     if (s->data_len) {
         assert(s->data_len < sizeof(s->data));
-        dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len);
+        dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
+                         MEMTXATTRS_UNSPECIFIED);
     }
 }
 
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 0bd63a43f50..0361524c067 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1107,7 +1107,8 @@ static inline const PL330InsnDesc *pl330_fetch_insn(PL330Chan *ch)
     uint8_t opcode;
     int i;
 
-    dma_memory_read(&address_space_memory, ch->pc, &opcode, 1);
+    dma_memory_read(&address_space_memory, ch->pc, &opcode, 1,
+                    MEMTXATTRS_UNSPECIFIED);
     for (i = 0; insn_desc[i].size; i++) {
         if ((opcode & insn_desc[i].opmask) == insn_desc[i].opcode) {
             return &insn_desc[i];
@@ -1121,7 +1122,8 @@ static inline void pl330_exec_insn(PL330Chan *ch, const PL330InsnDesc *insn)
     uint8_t buf[PL330_INSN_MAXSIZE];
 
     assert(insn->size <= PL330_INSN_MAXSIZE);
-    dma_memory_read(&address_space_memory, ch->pc, buf, insn->size);
+    dma_memory_read(&address_space_memory, ch->pc, buf, insn->size,
+                    MEMTXATTRS_UNSPECIFIED);
     insn->exec(ch, buf[0], &buf[1], insn->size - 1);
 }
 
@@ -1185,7 +1187,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
     if (q != NULL && q->len <= pl330_fifo_num_free(&s->fifo)) {
         int len = q->len - (q->addr & (q->len - 1));
 
-        dma_memory_read(&address_space_memory, q->addr, buf, len);
+        dma_memory_read(&address_space_memory, q->addr, buf, len,
+                        MEMTXATTRS_UNSPECIFIED);
         trace_pl330_exec_cycle(q->addr, len);
         if (trace_event_get_state_backends(TRACE_PL330_HEXDUMP)) {
             pl330_hexdump(buf, len);
@@ -1216,7 +1219,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
             fifo_res = pl330_fifo_get(&s->fifo, buf, len, q->tag);
         }
         if (fifo_res == PL330_FIFO_OK || q->z) {
-            dma_memory_write(&address_space_memory, q->addr, buf, len);
+            dma_memory_write(&address_space_memory, q->addr, buf, len,
+                             MEMTXATTRS_UNSPECIFIED);
             trace_pl330_exec_cycle(q->addr, len);
             if (trace_event_get_state_backends(TRACE_PL330_HEXDUMP)) {
                 pl330_hexdump(buf, len);
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index bcd1626fbd5..00c22232ceb 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -81,11 +81,11 @@ void ledma_memory_read(void *opaque, hwaddr addr,
     addr |= s->dmaregs[3];
     trace_ledma_memory_read(addr, len);
     if (do_bswap) {
-        dma_memory_read(&is->iommu_as, addr, buf, len);
+        dma_memory_read(&is->iommu_as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
     } else {
         addr &= ~1;
         len &= ~1;
-        dma_memory_read(&is->iommu_as, addr, buf, len);
+        dma_memory_read(&is->iommu_as, addr, buf, len, MEMTXATTRS_UNSPECIFIED);
         for(i = 0; i < len; i += 2) {
             bswap16s((uint16_t *)(buf + i));
         }
@@ -103,7 +103,8 @@ void ledma_memory_write(void *opaque, hwaddr addr,
     addr |= s->dmaregs[3];
     trace_ledma_memory_write(addr, len);
     if (do_bswap) {
-        dma_memory_write(&is->iommu_as, addr, buf, len);
+        dma_memory_write(&is->iommu_as, addr, buf, len,
+                         MEMTXATTRS_UNSPECIFIED);
     } else {
         addr &= ~1;
         len &= ~1;
@@ -114,7 +115,8 @@ void ledma_memory_write(void *opaque, hwaddr addr,
             for(i = 0; i < l; i += 2) {
                 tmp_buf[i >> 1] = bswap16(*(uint16_t *)(buf + i));
             }
-            dma_memory_write(&is->iommu_as, addr, tmp_buf, l);
+            dma_memory_write(&is->iommu_as, addr, tmp_buf, l,
+                             MEMTXATTRS_UNSPECIFIED);
             len -= l;
             buf += l;
             addr += l;
@@ -148,7 +150,8 @@ void espdma_memory_read(void *opaque, uint8_t *buf, int len)
     IOMMUState *is = (IOMMUState *)s->iommu;
 
     trace_espdma_memory_read(s->dmaregs[1], len);
-    dma_memory_read(&is->iommu_as, s->dmaregs[1], buf, len);
+    dma_memory_read(&is->iommu_as, s->dmaregs[1], buf, len,
+                    MEMTXATTRS_UNSPECIFIED);
     s->dmaregs[1] += len;
 }
 
@@ -158,7 +161,8 @@ void espdma_memory_write(void *opaque, uint8_t *buf, int len)
     IOMMUState *is = (IOMMUState *)s->iommu;
 
     trace_espdma_memory_write(s->dmaregs[1], len);
-    dma_memory_write(&is->iommu_as, s->dmaregs[1], buf, len);
+    dma_memory_write(&is->iommu_as, s->dmaregs[1], buf, len,
+                     MEMTXATTRS_UNSPECIFIED);
     s->dmaregs[1] += len;
 }
 
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index e33112b6f0e..f5ad1a0d22c 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -161,12 +161,14 @@ static void xlnx_zynq_devcfg_dma_go(XlnxZynqDevcfg *s)
             btt = MIN(btt, dmah->dest_len);
         }
         DB_PRINT("reading %x bytes from %x\n", btt, dmah->src_addr);
-        dma_memory_read(&address_space_memory, dmah->src_addr, buf, btt);
+        dma_memory_read(&address_space_memory, dmah->src_addr, buf, btt,
+                        MEMTXATTRS_UNSPECIFIED);
         dmah->src_len -= btt;
         dmah->src_addr += btt;
         if (loopback && (dmah->src_len || dmah->dest_len)) {
             DB_PRINT("writing %x bytes from %x\n", btt, dmah->dest_addr);
-            dma_memory_write(&address_space_memory, dmah->dest_addr, buf, btt);
+            dma_memory_write(&address_space_memory, dmah->dest_addr, buf, btt,
+                             MEMTXATTRS_UNSPECIFIED);
             dmah->dest_len -= btt;
             dmah->dest_addr += btt;
         }
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index b40c897de2c..321f30a6535 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -652,7 +652,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
         }
 
         if (dma_memory_read(&address_space_memory, desc_addr, &desc,
-                            sizeof(DPDMADescriptor))) {
+                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
             s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
             xlnx_dpdma_update_irq(s);
             s->operation_finished[channel] = true;
@@ -708,7 +708,8 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
                     if (dma_memory_read(&address_space_memory,
                                         source_addr[0],
                                         &s->data[channel][ptr],
-                                        line_size)) {
+                                        line_size,
+                                        MEMTXATTRS_UNSPECIFIED)) {
                         s->registers[DPDMA_ISR] |= ((1 << 12) << channel);
                         xlnx_dpdma_update_irq(s);
                         DPRINTF("Can't get data.\n");
@@ -736,7 +737,8 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
                     if (dma_memory_read(&address_space_memory,
                                         source_addr[frag],
                                         &(s->data[channel][ptr]),
-                                        fragment_len)) {
+                                        fragment_len,
+                                        MEMTXATTRS_UNSPECIFIED)) {
                         s->registers[DPDMA_ISR] |= ((1 << 12) << channel);
                         xlnx_dpdma_update_irq(s);
                         DPRINTF("Can't get data.\n");
@@ -754,7 +756,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             DPRINTF("update the descriptor with the done flag set.\n");
             xlnx_dpdma_desc_set_done(&desc);
             dma_memory_write(&address_space_memory, desc_addr, &desc,
-                             sizeof(DPDMADescriptor));
+                             sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
         }
 
         if (xlnx_dpdma_desc_completion_interrupt(&desc)) {
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 74a93a5d93f..3c2a1a61db5 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -181,7 +181,7 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
     }
 
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail,
-                         evt, AMDVI_EVENT_LEN)) {
+                         evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
@@ -376,7 +376,8 @@ static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
     }
     if (extract64(cmd[0], 0, 1)) {
         if (dma_memory_write(&address_space_memory, addr, &data,
-            AMDVI_COMPLETION_DATA_SIZE)) {
+                             AMDVI_COMPLETION_DATA_SIZE,
+                             MEMTXATTRS_UNSPECIFIED)) {
             trace_amdvi_completion_wait_fail(addr);
         }
     }
@@ -502,7 +503,7 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
     uint64_t cmd[2];
 
     if (dma_memory_read(&address_space_memory, s->cmdbuf + s->cmdbuf_head,
-        cmd, AMDVI_COMMAND_SIZE)) {
+                        cmd, AMDVI_COMMAND_SIZE, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_command_read_fail(s->cmdbuf, s->cmdbuf_head);
         amdvi_log_command_error(s, s->cmdbuf + s->cmdbuf_head);
         return;
@@ -836,7 +837,7 @@ static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
     uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
 
     if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
-        AMDVI_DEVTAB_ENTRY_SIZE)) {
+                        AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_dte_get_fail(s->devtab, offset);
         /* log error accessing dte */
         amdvi_log_devtab_error(s, devid, s->devtab + offset, 0);
@@ -881,7 +882,8 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 {
     uint64_t pte;
 
-    if (dma_memory_read(&address_space_memory, pte_addr, &pte, sizeof(pte))) {
+    if (dma_memory_read(&address_space_memory, pte_addr,
+                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_get_pte_hwerror(pte_addr);
         amdvi_log_pagetab_error(s, devid, pte_addr, 0);
         pte = 0;
@@ -1048,7 +1050,7 @@ static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
     trace_amdvi_ir_irte(irte_root, offset);
 
     if (dma_memory_read(&address_space_memory, irte_root + offset,
-                        irte, sizeof(*irte))) {
+                        irte, sizeof(*irte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_ir_err("failed to get irte");
         return -AMDVI_IR_GET_IRTE;
     }
@@ -1108,7 +1110,7 @@ static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
     trace_amdvi_ir_irte(irte_root, offset);
 
     if (dma_memory_read(&address_space_memory, irte_root + offset,
-                        irte, sizeof(*irte))) {
+                        irte, sizeof(*irte), MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_ir_err("failed to get irte_ga");
         return -AMDVI_IR_GET_IRTE;
     }
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 749eb6ad632..8de57dd995e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -570,7 +570,8 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
     dma_addr_t addr;
 
     addr = s->root + index * sizeof(*re);
-    if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        re, sizeof(*re), MEMTXATTRS_UNSPECIFIED)) {
         re->lo = 0;
         return -VTD_FR_ROOT_TABLE_INV;
     }
@@ -603,7 +604,8 @@ static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
     }
 
     addr = addr + index * ce_size;
-    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        ce, ce_size, MEMTXATTRS_UNSPECIFIED)) {
         return -VTD_FR_CONTEXT_TABLE_INV;
     }
 
@@ -640,8 +642,8 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
     assert(index < VTD_SL_PT_ENTRY_NR);
 
     if (dma_memory_read(&address_space_memory,
-                        base_addr + index * sizeof(slpte), &slpte,
-                        sizeof(slpte))) {
+                        base_addr + index * sizeof(slpte),
+                        &slpte, sizeof(slpte), MEMTXATTRS_UNSPECIFIED)) {
         slpte = (uint64_t)-1;
         return slpte;
     }
@@ -705,7 +707,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     index = VTD_PASID_DIR_INDEX(pasid);
     entry_size = VTD_PASID_DIR_ENTRY_SIZE;
     addr = pasid_dir_base + index * entry_size;
-    if (dma_memory_read(&address_space_memory, addr, pdire, entry_size)) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
         return -VTD_FR_PASID_TABLE_INV;
     }
 
@@ -729,7 +732,8 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
     addr = addr + index * entry_size;
-    if (dma_memory_read(&address_space_memory, addr, pe, entry_size)) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
         return -VTD_FR_PASID_TABLE_INV;
     }
 
@@ -2262,7 +2266,8 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
     uint32_t dw = s->iq_dw ? 32 : 16;
     dma_addr_t addr = base_addr + offset * dw;
 
-    if (dma_memory_read(&address_space_memory, addr, inv_desc, dw)) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        inv_desc, dw, MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("Read INV DESC failed.");
         return false;
     }
@@ -2295,8 +2300,9 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         dma_addr_t status_addr = inv_desc->hi;
         trace_vtd_inv_desc_wait_sw(status_addr, status_data);
         status_data = cpu_to_le32(status_data);
-        if (dma_memory_write(&address_space_memory, status_addr, &status_data,
-                             sizeof(status_data))) {
+        if (dma_memory_write(&address_space_memory, status_addr,
+                             &status_data, sizeof(status_data),
+                             MEMTXATTRS_UNSPECIFIED)) {
             trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
             return false;
         }
@@ -3106,8 +3112,8 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     }
 
     addr = iommu->intr_root + index * sizeof(*entry);
-    if (dma_memory_read(&address_space_memory, addr, entry,
-                        sizeof(*entry))) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        entry, sizeof(*entry), MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("%s: read failed: ind=0x%x addr=0x%" PRIx64,
                           __func__, index, addr);
         return -VTD_FR_IR_ROOT_INVAL;
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 62a599a0751..a93a2b75a85 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -97,7 +97,7 @@ static void pmac_ide_atapi_transfer_cb(void *opaque, int ret)
         /* Non-block ATAPI transfer - just copy to RAM */
         s->io_buffer_size = MIN(s->io_buffer_size, io->len);
         dma_memory_write(&address_space_memory, io->addr, s->io_buffer,
-                         s->io_buffer_size);
+                         s->io_buffer_size, MEMTXATTRS_UNSPECIFIED);
         io->len = 0;
         ide_atapi_cmd_ok(s);
         m->dma_active = false;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 489e6256ef7..8e8618c1ab4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1236,8 +1236,8 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor *mon)
         uint64_t qaddr = qaddr_base + (qindex << 2);
         uint32_t qdata = -1;
 
-        if (dma_memory_read(&address_space_memory, qaddr, &qdata,
-                            sizeof(qdata))) {
+        if (dma_memory_read(&address_space_memory, qaddr,
+                            &qdata, sizeof(qdata), MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to read EQ @0x%"
                           HWADDR_PRIx "\n", qaddr);
             return;
@@ -1300,7 +1300,8 @@ static void xive_end_enqueue(XiveEND *end, uint32_t data)
     uint32_t qdata = cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
     uint32_t qentries = 1 << (qsize + 10);
 
-    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qdata))) {
+    if (dma_memory_write(&address_space_memory, qaddr,
+                         &qdata, sizeof(qdata), MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to write END data @0x%"
                       HWADDR_PRIx "\n", qaddr);
         return;
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 73941bdae97..76ea511d53d 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -69,7 +69,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00010003: /* Get board MAC address */
             resplen = sizeof(s->macaddr.a);
-            dma_memory_write(&s->dma_as, value + 12, s->macaddr.a, resplen);
+            dma_memory_write(&s->dma_as, value + 12, s->macaddr.a, resplen,
+                             MEMTXATTRS_UNSPECIFIED);
             break;
         case 0x00010004: /* Get board serial */
             qemu_log_mask(LOG_UNIMP,
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index e220f1a9277..efcc02609fd 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -94,7 +94,7 @@ static void dbdma_cmdptr_load(DBDMA_channel *ch)
     DBDMA_DPRINTFCH(ch, "dbdma_cmdptr_load 0x%08x\n",
                     ch->regs[DBDMA_CMDPTR_LO]);
     dma_memory_read(&address_space_memory, ch->regs[DBDMA_CMDPTR_LO],
-                    &ch->current, sizeof(dbdma_cmd));
+                    &ch->current, sizeof(dbdma_cmd), MEMTXATTRS_UNSPECIFIED);
 }
 
 static void dbdma_cmdptr_save(DBDMA_channel *ch)
@@ -104,7 +104,7 @@ static void dbdma_cmdptr_save(DBDMA_channel *ch)
                     le16_to_cpu(ch->current.xfer_status),
                     le16_to_cpu(ch->current.res_count));
     dma_memory_write(&address_space_memory, ch->regs[DBDMA_CMDPTR_LO],
-                     &ch->current, sizeof(dbdma_cmd));
+                     &ch->current, sizeof(dbdma_cmd), MEMTXATTRS_UNSPECIFIED);
 }
 
 static void kill_channel(DBDMA_channel *ch)
@@ -371,7 +371,8 @@ static void load_word(DBDMA_channel *ch, int key, uint32_t addr,
         return;
     }
 
-    dma_memory_read(&address_space_memory, addr, &current->cmd_dep, len);
+    dma_memory_read(&address_space_memory, addr, &current->cmd_dep, len,
+                    MEMTXATTRS_UNSPECIFIED);
 
     if (conditional_wait(ch))
         goto wait;
@@ -403,7 +404,8 @@ static void store_word(DBDMA_channel *ch, int key, uint32_t addr,
         return;
     }
 
-    dma_memory_write(&address_space_memory, addr, &current->cmd_dep, len);
+    dma_memory_write(&address_space_memory, addr, &current->cmd_dep, len,
+                     MEMTXATTRS_UNSPECIFIED);
 
     if (conditional_wait(ch))
         goto wait;
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 38d328587e3..5189ad77527 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -345,7 +345,8 @@ static uint32_t allwinner_sun8i_emac_next_desc(AwSun8iEmacState *s,
 {
     uint32_t paddr = desc->next;
 
-    dma_memory_read(&s->dma_as, paddr, desc, sizeof(*desc));
+    dma_memory_read(&s->dma_as, paddr, desc, sizeof(*desc),
+                    MEMTXATTRS_UNSPECIFIED);
 
     if ((desc->status & DESC_STATUS_CTL) &&
         (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >= min_size) {
@@ -364,7 +365,8 @@ static uint32_t allwinner_sun8i_emac_get_desc(AwSun8iEmacState *s,
 
     /* Note that the list is a cycle. Last entry points back to the head. */
     while (desc_addr != 0) {
-        dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
+        dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc),
+                        MEMTXATTRS_UNSPECIFIED);
 
         if ((desc->status & DESC_STATUS_CTL) &&
             (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >= min_size) {
@@ -397,7 +399,8 @@ static void allwinner_sun8i_emac_flush_desc(AwSun8iEmacState *s,
                                             FrameDescriptor *desc,
                                             uint32_t phys_addr)
 {
-    dma_memory_write(&s->dma_as, phys_addr, desc, sizeof(*desc));
+    dma_memory_write(&s->dma_as, phys_addr, desc, sizeof(*desc),
+                     MEMTXATTRS_UNSPECIFIED);
 }
 
 static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)
@@ -455,7 +458,8 @@ static ssize_t allwinner_sun8i_emac_receive(NetClientState *nc,
                             << RX_DESC_STATUS_FRM_LEN_SHIFT;
         }
 
-        dma_memory_write(&s->dma_as, desc.addr, buf, desc_bytes);
+        dma_memory_write(&s->dma_as, desc.addr, buf, desc_bytes,
+                         MEMTXATTRS_UNSPECIFIED);
         allwinner_sun8i_emac_flush_desc(s, &desc, s->rx_desc_curr);
         trace_allwinner_sun8i_emac_receive(s->rx_desc_curr, desc.addr,
                                            desc_bytes);
@@ -506,7 +510,8 @@ static void allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
             desc.status |= TX_DESC_STATUS_LENGTH_ERR;
             break;
         }
-        dma_memory_read(&s->dma_as, desc.addr, packet_buf + packet_bytes, bytes);
+        dma_memory_read(&s->dma_as, desc.addr, packet_buf + packet_bytes,
+                        bytes, MEMTXATTRS_UNSPECIFIED);
         packet_bytes += bytes;
         desc.status &= ~DESC_STATUS_CTL;
         allwinner_sun8i_emac_flush_desc(s, &desc, s->tx_desc_curr);
@@ -628,7 +633,8 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
         if (s->tx_desc_curr != 0) {
-            dma_memory_read(&s->dma_as, s->tx_desc_curr, &desc, sizeof(desc));
+            dma_memory_read(&s->dma_as, s->tx_desc_curr, &desc, sizeof(desc),
+                            MEMTXATTRS_UNSPECIFIED);
             value = desc.addr;
         } else {
             value = 0;
@@ -641,7 +647,8 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque, hwaddr offset,
         break;
     case REG_RX_CUR_BUF:        /* Receive Current Buffer */
         if (s->rx_desc_curr != 0) {
-            dma_memory_read(&s->dma_as, s->rx_desc_curr, &desc, sizeof(desc));
+            dma_memory_read(&s->dma_as, s->rx_desc_curr, &desc, sizeof(desc),
+                            MEMTXATTRS_UNSPECIFIED);
             value = desc.addr;
         } else {
             value = 0;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 782ff192ced..ee2da500948 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -453,7 +453,8 @@ static void do_phy_ctl(FTGMAC100State *s)
 
 static int ftgmac100_read_bd(FTGMAC100Desc *bd, dma_addr_t addr)
 {
-    if (dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd))) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        bd, sizeof(*bd), MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read descriptor @ 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
         return -1;
@@ -473,7 +474,8 @@ static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)
     lebd.des1 = cpu_to_le32(bd->des1);
     lebd.des2 = cpu_to_le32(bd->des2);
     lebd.des3 = cpu_to_le32(bd->des3);
-    if (dma_memory_write(&address_space_memory, addr, &lebd, sizeof(lebd))) {
+    if (dma_memory_write(&address_space_memory, addr,
+                         &lebd, sizeof(lebd), MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write descriptor @ 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
         return -1;
@@ -554,7 +556,8 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
             len =  sizeof(s->frame) - frame_size;
         }
 
-        if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
+        if (dma_memory_read(&address_space_memory, bd.des3,
+                            ptr, len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ 0x%x\n",
                           __func__, bd.des3);
             s->isr |= FTGMAC100_INT_AHB_ERR;
@@ -1019,20 +1022,24 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
             bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
 
             if (s->maccr & FTGMAC100_MACCR_RM_VLAN) {
-                dma_memory_write(&address_space_memory, buf_addr, buf, 12);
-                dma_memory_write(&address_space_memory, buf_addr + 12, buf + 16,
-                                 buf_len - 16);
+                dma_memory_write(&address_space_memory, buf_addr, buf, 12,
+                                 MEMTXATTRS_UNSPECIFIED);
+                dma_memory_write(&address_space_memory, buf_addr + 12,
+                                 buf + 16, buf_len - 16,
+                                 MEMTXATTRS_UNSPECIFIED);
             } else {
-                dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+                dma_memory_write(&address_space_memory, buf_addr, buf,
+                                 buf_len, MEMTXATTRS_UNSPECIFIED);
             }
         } else {
             bd.des1 = 0;
-            dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+            dma_memory_write(&address_space_memory, buf_addr, buf, buf_len,
+                             MEMTXATTRS_UNSPECIFIED);
         }
         buf += buf_len;
         if (size < 4) {
             dma_memory_write(&address_space_memory, buf_addr + buf_len,
-                             crc_ptr, 4 - size);
+                             crc_ptr, 4 - size, MEMTXATTRS_UNSPECIFIED);
             crc_ptr += 4 - size;
         }
 
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 2c148040414..ff4c345f09f 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -389,19 +389,22 @@ static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 
 static void imx_fec_read_bd(IMXFECBufDesc *bd, dma_addr_t addr)
 {
-    dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
+    dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd),
+                    MEMTXATTRS_UNSPECIFIED);
 
     trace_imx_fec_read_bd(addr, bd->flags, bd->length, bd->data);
 }
 
 static void imx_fec_write_bd(IMXFECBufDesc *bd, dma_addr_t addr)
 {
-    dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
+    dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd),
+                     MEMTXATTRS_UNSPECIFIED);
 }
 
 static void imx_enet_read_bd(IMXENETBufDesc *bd, dma_addr_t addr)
 {
-    dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
+    dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd),
+                    MEMTXATTRS_UNSPECIFIED);
 
     trace_imx_enet_read_bd(addr, bd->flags, bd->length, bd->data,
                    bd->option, bd->status);
@@ -409,7 +412,8 @@ static void imx_enet_read_bd(IMXENETBufDesc *bd, dma_addr_t addr)
 
 static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
 {
-    dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
+    dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd),
+                     MEMTXATTRS_UNSPECIFIED);
 }
 
 static void imx_eth_update(IMXFECState *s)
@@ -476,7 +480,8 @@ static void imx_fec_do_tx(IMXFECState *s)
             len = ENET_MAX_FRAME_SIZE - frame_size;
             s->regs[ENET_EIR] |= ENET_INT_BABT;
         }
-        dma_memory_read(&address_space_memory, bd.data, ptr, len);
+        dma_memory_read(&address_space_memory, bd.data, ptr, len,
+                        MEMTXATTRS_UNSPECIFIED);
         ptr += len;
         frame_size += len;
         if (bd.flags & ENET_BD_L) {
@@ -557,7 +562,8 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
             len = ENET_MAX_FRAME_SIZE - frame_size;
             s->regs[ENET_EIR] |= ENET_INT_BABT;
         }
-        dma_memory_read(&address_space_memory, bd.data, ptr, len);
+        dma_memory_read(&address_space_memory, bd.data, ptr, len,
+                        MEMTXATTRS_UNSPECIFIED);
         ptr += len;
         frame_size += len;
         if (bd.flags & ENET_BD_L) {
@@ -1109,11 +1115,12 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
             buf_len += size - 4;
         }
         buf_addr = bd.data;
-        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len,
+                         MEMTXATTRS_UNSPECIFIED);
         buf += buf_len;
         if (size < 4) {
             dma_memory_write(&address_space_memory, buf_addr + buf_len,
-                             crc_ptr, 4 - size);
+                             crc_ptr, 4 - size, MEMTXATTRS_UNSPECIFIED);
             crc_ptr += 4 - size;
         }
         bd.flags &= ~ENET_BD_E;
@@ -1216,8 +1223,8 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
              */
             const uint8_t zeros[2] = { 0 };
 
-            dma_memory_write(&address_space_memory, buf_addr,
-                             zeros, sizeof(zeros));
+            dma_memory_write(&address_space_memory, buf_addr, zeros,
+                             sizeof(zeros), MEMTXATTRS_UNSPECIFIED);
 
             buf_addr += sizeof(zeros);
             buf_len  -= sizeof(zeros);
@@ -1226,11 +1233,12 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
             shift16 = false;
         }
 
-        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len,
+                         MEMTXATTRS_UNSPECIFIED);
         buf += buf_len;
         if (size < 4) {
             dma_memory_write(&address_space_memory, buf_addr + buf_len,
-                             crc_ptr, 4 - size);
+                             crc_ptr, 4 - size, MEMTXATTRS_UNSPECIFIED);
             crc_ptr += 4 - size;
         }
         bd.flags &= ~ENET_BD_E;
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a15de06a10c..877df8752a0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -355,7 +355,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     dma_addr = s->dma_addr;
     s->dma_addr = 0;
 
-    if (dma_memory_read(s->dma_as, dma_addr, &dma, sizeof(dma))) {
+    if (dma_memory_read(s->dma_as, dma_addr,
+                        &dma, sizeof(dma), MEMTXATTRS_UNSPECIFIED)) {
         stl_be_dma(s->dma_as, dma_addr + offsetof(FWCfgDmaAccess, control),
                    FW_CFG_DMA_CTL_ERROR);
         return;
@@ -417,7 +418,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
              */
             if (read) {
                 if (dma_memory_write(s->dma_as, dma.address,
-                                    &e->data[s->cur_offset], len)) {
+                                     &e->data[s->cur_offset], len,
+                                     MEMTXATTRS_UNSPECIFIED)) {
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
@@ -425,7 +427,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
                 if (!e->allow_write ||
                     len != dma.length ||
                     dma_memory_read(s->dma_as, dma.address,
-                                    &e->data[s->cur_offset], len)) {
+                                    &e->data[s->cur_offset], len,
+                                    MEMTXATTRS_UNSPECIFIED)) {
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 } else if (e->write_cb) {
                     e->write_cb(e->callback_opaque, s->cur_offset, len);
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 82132c12ca9..3e0938e5f4e 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -714,7 +714,8 @@ static bool pnv_phb3_resolve_pe(PnvPhb3DMASpace *ds)
     bus_num = pci_bus_num(ds->bus);
     addr = rtt & PHB_RTT_BASE_ADDRESS_MASK;
     addr += 2 * ((bus_num << 8) | ds->devfn);
-    if (dma_memory_read(&address_space_memory, addr, &rte, sizeof(rte))) {
+    if (dma_memory_read(&address_space_memory, addr, &rte,
+                        sizeof(rte), MEMTXATTRS_UNSPECIFIED)) {
         phb3_error(ds->phb, "Failed to read RTT entry at 0x%"PRIx64, addr);
         /* Set error bits ? fence ? ... */
         return false;
@@ -793,7 +794,7 @@ static void pnv_phb3_translate_tve(PnvPhb3DMASpace *ds, hwaddr addr,
             /* Grab the TCE address */
             taddr = base | (((addr >> sh) & ((1ul << tbl_shift) - 1)) << 3);
             if (dma_memory_read(&address_space_memory, taddr, &tce,
-                                sizeof(tce))) {
+                                sizeof(tce), MEMTXATTRS_UNSPECIFIED)) {
                 phb3_error(phb, "Failed to read TCE at 0x%"PRIx64, taddr);
                 return;
             }
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index 099d2092a2c..8bcbc2cc4f3 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -53,7 +53,8 @@ static bool phb3_msi_read_ive(PnvPHB3 *phb, int srcno, uint64_t *out_ive)
         return false;
     }
 
-    if (dma_memory_read(&address_space_memory, ive_addr, &ive, sizeof(ive))) {
+    if (dma_memory_read(&address_space_memory, ive_addr,
+                        &ive, sizeof(ive), MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Failed to read IVE at 0x%" PRIx64,
                       ive_addr);
         return false;
@@ -73,7 +74,8 @@ static void phb3_msi_set_p(Phb3MsiState *msi, int srcno, uint8_t gen)
         return;
     }
 
-    if (dma_memory_write(&address_space_memory, ive_addr + 4, &p, 1)) {
+    if (dma_memory_write(&address_space_memory, ive_addr + 4,
+                         &p, 1, MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Failed to write IVE (set P) at 0x%" PRIx64, ive_addr);
     }
@@ -89,7 +91,8 @@ static void phb3_msi_set_q(Phb3MsiState *msi, int srcno)
         return;
     }
 
-    if (dma_memory_write(&address_space_memory, ive_addr + 5, &q, 1)) {
+    if (dma_memory_write(&address_space_memory, ive_addr + 5,
+                         &q, 1, MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Failed to write IVE (set Q) at 0x%" PRIx64, ive_addr);
     }
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 75ad766fe0b..4369a97b9d2 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -889,7 +889,8 @@ static bool pnv_phb4_resolve_pe(PnvPhb4DMASpace *ds)
     bus_num = pci_bus_num(ds->bus);
     addr = rtt & PHB_RTT_BASE_ADDRESS_MASK;
     addr += 2 * ((bus_num << 8) | ds->devfn);
-    if (dma_memory_read(&address_space_memory, addr, &rte, sizeof(rte))) {
+    if (dma_memory_read(&address_space_memory, addr,
+                        &rte, sizeof(rte), MEMTXATTRS_UNSPECIFIED)) {
         phb_error(ds->phb, "Failed to read RTT entry at 0x%"PRIx64, addr);
         /* Set error bits ? fence ? ... */
         return false;
@@ -958,8 +959,8 @@ static void pnv_phb4_translate_tve(PnvPhb4DMASpace *ds, hwaddr addr,
         while ((lev--) >= 0) {
             /* Grab the TCE address */
             taddr = base | (((addr >> sh) & ((1ul << tbl_shift) - 1)) << 3);
-            if (dma_memory_read(&address_space_memory, taddr, &tce,
-                                sizeof(tce))) {
+            if (dma_memory_read(&address_space_memory, taddr,
+                                &tce, sizeof(tce), MEMTXATTRS_UNSPECIFIED)) {
                 phb_error(ds->phb, "Failed to read TCE at 0x%"PRIx64, taddr);
                 return;
             }
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index e82afb75eb6..e98956ebb76 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -309,7 +309,8 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
     uint8_t buf[1024];
 
     /* Read descriptor */
-    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
+    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc),
+                    MEMTXATTRS_UNSPECIFIED);
     if (desc->size == 0) {
         desc->size = klass->max_desc_size;
     } else if (desc->size > klass->max_desc_size) {
@@ -335,23 +336,24 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
         /* Write to SD bus */
         if (is_write) {
             dma_memory_read(&s->dma_as,
-                            (desc->addr & DESC_SIZE_MASK) + num_done,
-                            buf, buf_bytes);
+                            (desc->addr & DESC_SIZE_MASK) + num_done, buf,
+                            buf_bytes, MEMTXATTRS_UNSPECIFIED);
             sdbus_write_data(&s->sdbus, buf, buf_bytes);
 
         /* Read from SD bus */
         } else {
             sdbus_read_data(&s->sdbus, buf, buf_bytes);
             dma_memory_write(&s->dma_as,
-                             (desc->addr & DESC_SIZE_MASK) + num_done,
-                             buf, buf_bytes);
+                             (desc->addr & DESC_SIZE_MASK) + num_done, buf,
+                             buf_bytes, MEMTXATTRS_UNSPECIFIED);
         }
         num_done += buf_bytes;
     }
 
     /* Clear hold flag and flush descriptor */
     desc->status &= ~DESC_STATUS_HOLD;
-    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc));
+    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc),
+                     MEMTXATTRS_UNSPECIFIED);
 
     return num_done;
 }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1785d7e1f79..987d76e72ae 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -604,8 +604,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            dma_memory_write(s->dma_as, s->sdmasysad,
-                             &s->fifo_buffer[begin], s->data_count - begin);
+            dma_memory_write(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+                             s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
                 s->data_count = 0;
@@ -626,8 +626,8 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
-            dma_memory_read(s->dma_as, s->sdmasysad,
-                            &s->fifo_buffer[begin], s->data_count - begin);
+            dma_memory_read(s->dma_as, s->sdmasysad, &s->fifo_buffer[begin],
+                            s->data_count - begin, MEMTXATTRS_UNSPECIFIED);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
                 sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
@@ -659,9 +659,11 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 
     if (s->trnmod & SDHC_TRNS_READ) {
         sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
-        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
+        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+                         MEMTXATTRS_UNSPECIFIED);
     } else {
-        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
+        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt,
+                        MEMTXATTRS_UNSPECIFIED);
         sdbus_write_data(&s->sdbus, s->fifo_buffer, datacnt);
     }
     s->blkcnt--;
@@ -683,7 +685,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2));
+        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
+                        MEMTXATTRS_UNSPECIFIED);
         adma2 = le64_to_cpu(adma2);
         /* The spec does not specify endianness of descriptor table.
          * We currently assume that it is LE.
@@ -694,7 +697,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->incr = 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1));
+        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
+                        MEMTXATTRS_UNSPECIFIED);
         adma1 = le32_to_cpu(adma1);
         dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
         dscr->attr = (uint8_t)extract32(adma1, 0, 7);
@@ -706,10 +710,13 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1);
-        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2);
+        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
+                        MEMTXATTRS_UNSPECIFIED);
+        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
+                        MEMTXATTRS_UNSPECIFIED);
         dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8);
+        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
+                        MEMTXATTRS_UNSPECIFIED);
         dscr->addr = le64_to_cpu(dscr->addr);
         dscr->attr &= (uint8_t) ~0xC0;
         dscr->incr = 12;
@@ -767,7 +774,8 @@ static void sdhci_do_adma(SDHCIState *s)
                     }
                     dma_memory_write(s->dma_as, dscr.addr,
                                      &s->fifo_buffer[begin],
-                                     s->data_count - begin);
+                                     s->data_count - begin,
+                                     MEMTXATTRS_UNSPECIFIED);
                     dscr.addr += s->data_count - begin;
                     if (s->data_count == block_size) {
                         s->data_count = 0;
@@ -791,7 +799,8 @@ static void sdhci_do_adma(SDHCIState *s)
                     }
                     dma_memory_read(s->dma_as, dscr.addr,
                                     &s->fifo_buffer[begin],
-                                    s->data_count - begin);
+                                    s->data_count - begin,
+                                    MEMTXATTRS_UNSPECIFIED);
                     dscr.addr += s->data_count - begin;
                     if (s->data_count == block_size) {
                         sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 97688d21bf0..fe684f92b7a 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -261,8 +261,8 @@ static void dwc2_handle_packet(DWC2State *s, uint32_t devadr, USBDevice *dev,
 
         if (pid != USB_TOKEN_IN) {
             trace_usb_dwc2_memory_read(hcdma, tlen);
-            if (dma_memory_read(&s->dma_as, hcdma,
-                                s->usb_buf[chan], tlen) != MEMTX_OK) {
+            if (dma_memory_read(&s->dma_as, hcdma, s->usb_buf[chan], tlen,
+                                MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: dma_memory_read failed\n",
                               __func__);
             }
@@ -317,8 +317,8 @@ babble:
 
         if (pid == USB_TOKEN_IN) {
             trace_usb_dwc2_memory_write(hcdma, actual);
-            if (dma_memory_write(&s->dma_as, hcdma, s->usb_buf[chan],
-                                 actual) != MEMTX_OK) {
+            if (dma_memory_write(&s->dma_as, hcdma, s->usb_buf[chan], actual,
+                                 MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
                 qemu_log_mask(LOG_GUEST_ERROR, "%s: dma_memory_write failed\n",
                               __func__);
             }
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 2b995443fbf..03ea5279f9b 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -383,7 +383,8 @@ static inline int get_dwords(EHCIState *ehci, uint32_t addr,
     }
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
-        dma_memory_read(ehci->as, addr, buf, sizeof(*buf));
+        dma_memory_read(ehci->as, addr, buf, sizeof(*buf),
+                        MEMTXATTRS_UNSPECIFIED);
         *buf = le32_to_cpu(*buf);
     }
 
@@ -405,7 +406,8 @@ static inline int put_dwords(EHCIState *ehci, uint32_t addr,
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
         uint32_t tmp = cpu_to_le32(*buf);
-        dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp));
+        dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp),
+                         MEMTXATTRS_UNSPECIFIED);
     }
 
     return num;
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index bac1adf439c..3df6a141b5f 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -452,7 +452,8 @@ static inline int get_dwords(OHCIState *ohci,
     addr += ohci->localmem_base;
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
-        if (dma_memory_read(ohci->as, addr, buf, sizeof(*buf))) {
+        if (dma_memory_read(ohci->as, addr,
+                            buf, sizeof(*buf), MEMTXATTRS_UNSPECIFIED)) {
             return -1;
         }
         *buf = le32_to_cpu(*buf);
@@ -471,7 +472,8 @@ static inline int put_dwords(OHCIState *ohci,
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
         uint32_t tmp = cpu_to_le32(*buf);
-        if (dma_memory_write(ohci->as, addr, &tmp, sizeof(tmp))) {
+        if (dma_memory_write(ohci->as, addr,
+                             &tmp, sizeof(tmp), MEMTXATTRS_UNSPECIFIED)) {
             return -1;
         }
     }
@@ -488,7 +490,8 @@ static inline int get_words(OHCIState *ohci,
     addr += ohci->localmem_base;
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
-        if (dma_memory_read(ohci->as, addr, buf, sizeof(*buf))) {
+        if (dma_memory_read(ohci->as, addr,
+                            buf, sizeof(*buf), MEMTXATTRS_UNSPECIFIED)) {
             return -1;
         }
         *buf = le16_to_cpu(*buf);
@@ -507,7 +510,8 @@ static inline int put_words(OHCIState *ohci,
 
     for (i = 0; i < num; i++, buf++, addr += sizeof(*buf)) {
         uint16_t tmp = cpu_to_le16(*buf);
-        if (dma_memory_write(ohci->as, addr, &tmp, sizeof(tmp))) {
+        if (dma_memory_write(ohci->as, addr,
+                             &tmp, sizeof(tmp), MEMTXATTRS_UNSPECIFIED)) {
             return -1;
         }
     }
@@ -537,8 +541,8 @@ static inline int ohci_read_iso_td(OHCIState *ohci,
 static inline int ohci_read_hcca(OHCIState *ohci,
                                  dma_addr_t addr, struct ohci_hcca *hcca)
 {
-    return dma_memory_read(ohci->as, addr + ohci->localmem_base,
-                           hcca, sizeof(*hcca));
+    return dma_memory_read(ohci->as, addr + ohci->localmem_base, hcca,
+                           sizeof(*hcca), MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int ohci_put_ed(OHCIState *ohci,
@@ -572,7 +576,7 @@ static inline int ohci_put_hcca(OHCIState *ohci,
     return dma_memory_write(ohci->as,
                             addr + ohci->localmem_base + HCCA_WRITEBACK_OFFSET,
                             (char *)hcca + HCCA_WRITEBACK_OFFSET,
-                            HCCA_WRITEBACK_SIZE);
+                            HCCA_WRITEBACK_SIZE, MEMTXATTRS_UNSPECIFIED);
 }
 
 /* Read/Write the contents of a TD from/to main memory.  */
-- 
2.26.2


