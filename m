Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21046C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C968D2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C968D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE1W-0006KH-Sa
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDuc-0002Ot-Ih
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDua-0007rv-Py
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:46:02 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-AECqWGmiNy-Michc6Enrcw-1; Fri, 04 Sep 2020 11:45:58 -0400
X-MC-Unique: AECqWGmiNy-Michc6Enrcw-1
Received: by mail-wm1-f69.google.com with SMTP id b14so1847932wmj.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/a/Z9w+Xg03zgl0GWIeP84t4ZkpMkDDsK/6zyzxs+s0=;
 b=ghPt8/wUvtuHQYXL6xj9SnacKUg8BAYm2Gh1EvgbT8yq9HJfgDp1XHhhaizoR0TlWf
 xE8/sKAFbw0DYmpQL6SUuxHRM4Lfv+KNcB0fjh9F9VO1Gem67ayXFX1DaTe4XOES+V5V
 5bWisbDd2PyHWUiku7RJ5PF8Fr1ueLnBrCdkFwG/Cn56XTHKRn0ZBCmL5I4vHkRj+/eV
 pzI6adp3qHkpfICQaMkItpaFZeNxFrgDuKuRI90QNkEzCcyJG9f/KaIlHQqkPbzl2oPg
 2DD1X5OkXIpTcFdvp3CaNBE6PunKC3b96FuToW3vyn+m8dYdzVD/05Yh69J/Zzpi9VlW
 i6nQ==
X-Gm-Message-State: AOAM532IxVWkT9p0qFznoZXvKEm0UDFKiUnZmo3wYBOKI8/XjaM64d6/
 PRnC9aXB1v8MulrVLGr03Mm2yD4zZCVb1WwIvFaI8r+q63B5Mdb0b/QZ5mADn2cnVCSw4ioXBGZ
 6qGmj8y5JYx0f27Q=
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr8625259wrj.92.1599234356871; 
 Fri, 04 Sep 2020 08:45:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/oJMH4Gz0XL4ibc+RCIbeSoPtnS3XS3mvUh5UgN0dA8mdFS9HXw7uHS7Xhl0QgWZ3rNGywA==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr8625224wrj.92.1599234356604; 
 Fri, 04 Sep 2020 08:45:56 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id y1sm11646185wma.36.2020.09.04.08.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/13] dma: Let dma_memory_map() take MemTxAttrs argument
Date: Fri,  4 Sep 2020 17:44:39 +0200
Message-Id: <20200904154439.643272-14-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
dma_memory_map().

Patch created mechanically using spatch with this script:

  @@
  expression E1, E2, E3, E4;
  @@
  - dma_memory_map(E1, E2, E3, E4)
  + dma_memory_map(E1, E2, E3, E4, MEMTXATTRS_UNSPECIFIED)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h    | 3 ++-
 include/sysemu/dma.h    | 5 +++--
 dma-helpers.c           | 3 ++-
 hw/display/virtio-gpu.c | 8 ++++++--
 hw/hyperv/vmbus.c       | 8 +++++---
 hw/ide/ahci.c           | 9 ++++++---
 hw/usb/libhw.c          | 3 ++-
 hw/virtio/virtio.c      | 6 ++++--
 8 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 0c3217e019c..a221dfb3b08 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -831,7 +831,8 @@ static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
 {
     void *buf;
 
-    buf = dma_memory_map(pci_get_address_space(dev), addr, plen, dir);
+    buf = dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
+                         MEMTXATTRS_UNSPECIFIED);
     return buf;
 }
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index b9cb9c8944b..bb8b0a059f5 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -203,16 +203,17 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
  * @addr: address within that address space
  * @len: pointer to length of buffer; updated on return
  * @dir: indicates the transfer direction
+ * @attrs: memory attributes
  */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
-                                   DMADirection dir)
+                                   DMADirection dir, MemTxAttrs attrs)
 {
     hwaddr xlen = *len;
     void *p;
 
     p = address_space_map(as, addr, &xlen, dir == DMA_DIRECTION_FROM_DEVICE,
-                          MEMTXATTRS_UNSPECIFIED);
+                          attrs);
     *len = xlen;
     return p;
 }
diff --git a/dma-helpers.c b/dma-helpers.c
index 6c3b2200f16..0507a6f95b9 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -143,7 +143,8 @@ static void dma_blk_cb(void *opaque, int ret)
     while (dbs->sg_cur_index < dbs->sg->nsg) {
         cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
         cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
-        mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir);
+        mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir,
+                             MEMTXATTRS_UNSPECIFIED);
         /*
          * Make reads deterministic in icount mode. Windows sometimes issues
          * disk read requests with overlapping SGs. It leads
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5f0dd7c1500..be7f5cdee46 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -648,7 +648,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
         hwaddr len = l;
         (*iov)[i].iov_len = l;
         (*iov)[i].iov_base = dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
-                                            a, &len, DMA_DIRECTION_TO_DEVICE);
+                                            a, &len,
+                                            DMA_DIRECTION_TO_DEVICE,
+                                            MEMTXATTRS_UNSPECIFIED);
         if (addr) {
             (*addr)[i] = a;
         }
@@ -1049,7 +1051,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             hwaddr len = res->iov[i].iov_len;
             res->iov[i].iov_base =
                 dma_memory_map(VIRTIO_DEVICE(g)->dma_as,
-                               res->addrs[i], &len, DMA_DIRECTION_TO_DEVICE);
+                               res->addrs[i], &len,
+                               DMA_DIRECTION_TO_DEVICE,
+                               MEMTXATTRS_UNSPECIFIED);
 
             if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
                 /* Clean up the half-a-mapping we just created... */
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 75af6b83dde..56621d72e5b 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -372,7 +372,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
 
             maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
 
-            iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir);
+            iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
+                                       MEMTXATTRS_UNSPECIFIED);
             if (mlen != pgleft) {
                 dma_memory_unmap(iter->as, iter->map, mlen, iter->dir, 0);
                 iter->map = NULL;
@@ -488,7 +489,8 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
                 goto err;
             }
 
-            iov[ret_cnt].iov_base = dma_memory_map(sgl->as, a, &l, dir);
+            iov[ret_cnt].iov_base = dma_memory_map(sgl->as, a, &l, dir,
+                                                   MEMTXATTRS_UNSPECIFIED);
             if (!l) {
                 ret = -EFAULT;
                 goto err;
@@ -564,7 +566,7 @@ static vmbus_ring_buffer *ringbuf_map_hdr(VMBusRingBufCommon *ringbuf)
     dma_addr_t mlen = sizeof(*rb);
 
     rb = dma_memory_map(ringbuf->as, ringbuf->rb_addr, &mlen,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
     if (mlen != sizeof(*rb)) {
         dma_memory_unmap(ringbuf->as, rb, mlen,
                          DMA_DIRECTION_FROM_DEVICE, 0);
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b696c6291a3..fe1a4e2b1a2 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -249,7 +249,8 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
     }
 
-    *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE);
+    *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE,
+                          MEMTXATTRS_UNSPECIFIED);
     if (len < wanted) {
         dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
         *ptr = NULL;
@@ -938,7 +939,8 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
 
     /* map PRDT */
     if (!(prdt = dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
-                                DMA_DIRECTION_TO_DEVICE))){
+                                DMA_DIRECTION_TO_DEVICE,
+                                MEMTXATTRS_UNSPECIFIED))) {
         trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
         return -1;
     }
@@ -1299,7 +1301,8 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot)
     tbl_addr = le64_to_cpu(cmd->tbl_addr);
     cmd_len = 0x80;
     cmd_fis = dma_memory_map(s->as, tbl_addr, &cmd_len,
-                             DMA_DIRECTION_FROM_DEVICE);
+                             DMA_DIRECTION_FROM_DEVICE,
+                             MEMTXATTRS_UNSPECIFIED);
     if (!cmd_fis) {
         trace_handle_cmd_badfis(s, port);
         return -1;
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index 9c33a1640f7..f350eae443d 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -36,7 +36,8 @@ int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
 
         while (len) {
             dma_addr_t xlen = len;
-            mem = dma_memory_map(sgl->as, base, &xlen, dir);
+            mem = dma_memory_map(sgl->as, base, &xlen, dir,
+                                 MEMTXATTRS_UNSPECIFIED);
             if (!mem) {
                 goto err;
             }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9830252176..c951131ba39 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1320,7 +1320,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
         iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
                                               is_write ?
                                               DMA_DIRECTION_FROM_DEVICE :
-                                              DMA_DIRECTION_TO_DEVICE);
+                                              DMA_DIRECTION_TO_DEVICE,
+                                              MEMTXATTRS_UNSPECIFIED);
         if (!iov[num_sg].iov_base) {
             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
             goto out;
@@ -1369,7 +1370,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
         sg[i].iov_base = dma_memory_map(vdev->dma_as,
                                         addr[i], &len, is_write ?
                                         DMA_DIRECTION_FROM_DEVICE :
-                                        DMA_DIRECTION_TO_DEVICE);
+                                        DMA_DIRECTION_TO_DEVICE,
+                                        MEMTXATTRS_UNSPECIFIED);
         if (!sg[i].iov_base) {
             error_report("virtio: error trying to map MMIO memory");
             exit(1);
-- 
2.26.2


