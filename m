Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852A4C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFB4218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLS9WXdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFB4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZsL-0006on-ER
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlT-0002JR-SK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlQ-00023j-MH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlQ-00021t-90
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id m16so14334881wrx.11
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ajT0loLv4ti8fVF0C0hJ96vAbNNoCOzFc3Ve6164+T8=;
 b=DLS9WXdCCqVROUKxf04ZFmW+RndcqxJPHxYH5O8DlQvLTCuTxTrc+X49HKXAsEQ0qx
 kSgpOcGGVkAlJcu82xTh/a62emOOlAoMUja37kmhiwptLSls61Z5ZtpCxT7oFWx62IAC
 dHQu0bMVwEjajjgF29HljB8G+EaQBapc3o8Ah7hDUPdcdXZrDIoqrkoxzNdwVAt6SEf5
 Nar0dOcw1SZI8Cqhc/tTHiGWHoFtmCHaNVYzm5sc+XH56oICBjMkryCHyvsDaOpip1YI
 csrHUGWfRzAhqmvjfTQ/XG4+xXETW4KJSae4Lz030/nhr8klvGhcO04MBpemC9rlGT4I
 Lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ajT0loLv4ti8fVF0C0hJ96vAbNNoCOzFc3Ve6164+T8=;
 b=Mza6fLNI7AAKREuN3Ikz/iURePG27tJiQYGPUPLYG+i7DIRIM3/dxjKhyr/v7ZoD/+
 TL6SXJRx8I2szAyb/pDdhqHRjhFbL1ir6b7vVMSoLd0cyM7varEFay9MSNpH7W0fL8Xc
 fu+sAJ/3omHCIcGCQldLVfM7pH2et7hfkk9GV+DHvp6PBM6qoB+ksoFuD6AqARinqtCM
 Hkk70vog93fwxV4ZTxeKRSwEgd3WC62nE14ACfbKk/iZi+kJMPmF6D1iQWSHJ5aqHMdv
 bU3kJh8Hels18XIHgpit7UVBnpPbg+r1YaMEZnbX7eznYVlSC5zHZxx6v+JK8N7RVK9t
 alrg==
X-Gm-Message-State: APjAAAU49gaP6Ne1NXYiEG9KSIjWr3ayjXBOjhoxeLAKpekWXE7NnDib
 gsRkvH1lbhFhP4IRT44e2PGXrJhv
X-Google-Smtp-Source: APXvYqyhqVFygySqhSJzQ2unLUrS6JpZ3MLjI+AN2o7LKPefhqL8cUakbR0HV9oPe+mE5dtKajXU9Q==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr71986678wrw.319.1582631554301; 
 Tue, 25 Feb 2020 03:52:34 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 095/136] Avoid address_space_rw() with a constant is_write
 argument
Date: Tue, 25 Feb 2020 12:50:25 +0100
Message-Id: <1582631466-13880-95-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The address_space_rw() function allows either reads or writes
depending on the is_write argument passed to it; this is useful
when the direction of the access is determined programmatically
(as for instance when handling the KVM_EXIT_MMIO exit reason).
Under the hood it just calls either address_space_write() or
address_space_read_full().

We also use it a lot with a constant is_write argument, though,
which has two issues:
 * when reading "address_space_rw(..., 1)" this is less
   immediately clear to the reader as being a write than
   "address_space_write(...)"
 * calling address_space_rw() bypasses the optimization
   in address_space_read() that fast-paths reads of a
   fixed length

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.cocci.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200218112457.22712-1-peter.maydell@linaro.org>
[PMD: Update macvm_set_cr0() reported by Laurent Vivier]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 accel/kvm/kvm-all.c                    |  6 +--
 dma-helpers.c                          |  4 +-
 exec.c                                 |  4 +-
 hw/dma/xlnx-zdma.c                     | 11 ++----
 hw/net/dp8393x.c                       | 70 ++++++++++++++++++----------------
 hw/net/i82596.c                        | 22 +++++------
 hw/net/lasi_i82596.c                   |  5 ++-
 hw/ppc/pnv_lpc.c                       |  8 ++--
 hw/s390x/css.c                         | 12 +++---
 qtest.c                                | 52 ++++++++++++-------------
 scripts/coccinelle/exec_rw_const.cocci | 13 +++++++
 target/i386/hvf/vmx.h                  |  7 ++--
 target/i386/hvf/x86_mmu.c              | 12 +++---
 13 files changed, 119 insertions(+), 107 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312..0cfe6fd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2178,9 +2178,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
             ent = &ring->coalesced_mmio[ring->first];
 
             if (ent->pio == 1) {
-                address_space_rw(&address_space_io, ent->phys_addr,
-                                 MEMTXATTRS_UNSPECIFIED, ent->data,
-                                 ent->len, true);
+                address_space_write(&address_space_io, ent->phys_addr,
+                                    MEMTXATTRS_UNSPECIFIED, ent->data,
+                                    ent->len);
             } else {
                 cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
             }
diff --git a/dma-helpers.c b/dma-helpers.c
index d3871dc..e8a26e8 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -28,8 +28,8 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l = len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |= address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                  fillbuf, l, true);
+        error |= address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
+                                     fillbuf, l);
         len -= l;
         addr += l;
     }
diff --git a/exec.c b/exec.c
index 90ac015..ec6e460 100644
--- a/exec.c
+++ b/exec.c
@@ -3815,8 +3815,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                     attrs, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
-                             l, false);
+            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
+                               l);
         }
         len -= l;
         buf += l;
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 683abbe..1c1b142 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -311,8 +311,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
         return false;
     }
 
-    address_space_rw(s->dma_as, addr, s->attr,
-                     buf, sizeof(XlnxZDMADescr), false);
+    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
     return true;
 }
 
@@ -364,7 +363,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
     } else {
         addr = zdma_get_regaddr64(s, basereg);
         addr += sizeof(s->dsc_dst);
-        address_space_rw(s->dma_as, addr, s->attr, &next, 8, false);
+        address_space_read(s->dma_as, addr, s->attr, &next, 8);
         zdma_put_regaddr64(s, basereg, next);
     }
     return next;
@@ -416,8 +415,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
             }
         }
 
-        address_space_rw(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen,
-                         true);
+        address_space_write(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen);
         if (burst_type == AXI_BURST_INCR) {
             s->dsc_dst.addr += dlen;
         }
@@ -493,8 +491,7 @@ static void zdma_process_descr(XlnxZDMA *s)
                 len = s->cfg.bus_width / 8;
             }
         } else {
-            address_space_rw(s->dma_as, src_addr, s->attr, s->buf, len,
-                             false);
+            address_space_read(s->dma_as, src_addr, s->attr, s->buf, len);
             if (burst_type == AXI_BURST_INCR) {
                 src_addr += len;
             }
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b4363e3..7045193 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -275,8 +275,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
-        address_space_rw(&s->as, dp8393x_cdp(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+        address_space_read(&s->as, dp8393x_cdp(s),
+                           MEMTXATTRS_UNSPECIFIED, s->data, size);
         s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
@@ -293,8 +293,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     }
 
     /* Read CAM enable */
-    address_space_rw(&s->as, dp8393x_cdp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as, dp8393x_cdp(s),
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
     s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
@@ -311,8 +311,8 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     /* Read memory */
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
-    address_space_rw(&s->as, dp8393x_rrp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as, dp8393x_rrp(s),
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
 
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
@@ -426,8 +426,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         size = sizeof(uint16_t) * 6 * width;
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
-        address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+        address_space_read(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
+                           MEMTXATTRS_UNSPECIFIED, s->data, size);
         tx_len = 0;
 
         /* Update registers */
@@ -451,18 +451,19 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
             if (tx_len + len > sizeof(s->tx_buffer)) {
                 len = sizeof(s->tx_buffer) - tx_len;
             }
-            address_space_rw(&s->as, dp8393x_tsa(s),
-                             MEMTXATTRS_UNSPECIFIED,
-                             &s->tx_buffer[tx_len], len, false);
+            address_space_read(&s->as, dp8393x_tsa(s), MEMTXATTRS_UNSPECIFIED,
+                               &s->tx_buffer[tx_len], len);
             tx_len += len;
 
             i++;
             if (i != s->regs[SONIC_TFC]) {
                 /* Read next fragment details */
                 size = sizeof(uint16_t) * 3 * width;
-                address_space_rw(&s->as,
-                    dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                                 MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+                address_space_read(&s->as,
+                                   dp8393x_ttda(s)
+                                   + sizeof(uint16_t) * width * (4 + 3 * i),
+                                   MEMTXATTRS_UNSPECIFIED, s->data,
+                                   size);
                 s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
@@ -495,18 +496,18 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         dp8393x_put(s, width, 0,
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
-        address_space_rw(&s->as,
-                         dp8393x_ttda(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, true);
+        address_space_write(&s->as, dp8393x_ttda(s),
+                            MEMTXATTRS_UNSPECIFIED, s->data, size);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
             size = sizeof(uint16_t) * width;
-            address_space_rw(&s->as,
-                             dp8393x_ttda(s) +
-                             sizeof(uint16_t) *
-                             (4 + 3 * s->regs[SONIC_TFC]) * width,
-                             MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+            address_space_read(&s->as,
+                               dp8393x_ttda(s)
+                               + sizeof(uint16_t) * width
+                                 * (4 + 3 * s->regs[SONIC_TFC]),
+                               MEMTXATTRS_UNSPECIFIED, s->data,
+                               size);
             s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -768,8 +769,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* Are we still in resource exhaustion? */
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
-        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         s->data, size, false);
+        address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                           s->data, size);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -788,10 +789,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address = dp8393x_crba(s);
-    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_len);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        buf, rx_len);
     address += rx_len;
-    address_space_rw(&s->as, address,
-                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, true);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        &checksum, 4);
     rx_len += 4;
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
@@ -819,13 +821,15 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
-    address_space_rw(&s->as, dp8393x_crda(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, true);
+    address_space_write(&s->as, dp8393x_crda(s),
+                        MEMTXATTRS_UNSPECIFIED,
+                        s->data, size);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
-    address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as,
+                       dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
     s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,8 +842,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
             offset += sizeof(uint16_t);
         }
         s->data[0] = 0;
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         s->data, sizeof(uint16_t), true);
+        address_space_write(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                            s->data, sizeof(uint16_t));
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 11537f7..fe9f239 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -148,8 +148,8 @@ static void i82596_transmit(I82596State *s, uint32_t addr)
 
         if (s->nic && len) {
             assert(len <= sizeof(s->tx_buffer));
-            address_space_rw(&address_space_memory, tba,
-                             MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, false);
+            address_space_read(&address_space_memory, tba,
+                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len);
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
             DBG(printf("Sending %d bytes\n", len));
             qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
@@ -172,8 +172,8 @@ static void set_individual_address(I82596State *s, uint32_t addr)
 
     nc = qemu_get_queue(s->nic);
     m = s->conf.macaddr.a;
-    address_space_rw(&address_space_memory, addr + 8,
-                     MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, false);
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
     qemu_format_nic_info_str(nc, m);
     trace_i82596_new_mac(nc->info_str);
 }
@@ -190,9 +190,8 @@ static void set_multicast_list(I82596State *s, uint32_t addr)
     }
     for (i = 0; i < mc_count; i++) {
         uint8_t multicast_addr[ETH_ALEN];
-        address_space_rw(&address_space_memory,
-            addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
-                         multicast_addr, ETH_ALEN, false);
+        address_space_read(&address_space_memory, addr + i * ETH_ALEN,
+                           MEMTXATTRS_UNSPECIFIED, multicast_addr, ETH_ALEN);
         DBG(printf("Add multicast entry " MAC_FMT "\n",
                     MAC_ARG(multicast_addr)));
         unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
@@ -260,9 +259,8 @@ static void command_loop(I82596State *s)
             byte_cnt = MAX(byte_cnt, 4);
             byte_cnt = MIN(byte_cnt, sizeof(s->config));
             /* copy byte_cnt max. */
-            address_space_rw(&address_space_memory, s->cmd_p + 8,
-                             MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt,
-                             false);
+            address_space_read(&address_space_memory, s->cmd_p + 8,
+                               MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
             /* config byte according to page 35ff */
             s->config[2] &= 0x82; /* mask valid bits */
             s->config[2] |= 0x40;
@@ -647,8 +645,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
             buf += num;
             len -= num;
             if (len == 0) { /* copy crc */
-                address_space_rw(&address_space_memory, rba - 4,
-                                 MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, true);
+                address_space_write(&address_space_memory, rba - 4,
+                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
             }
 
             num |= 0x4000; /* set F BIT */
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 8bff419..52637a5 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -55,8 +55,9 @@ static void lasi_82596_mem_write(void *opaque, hwaddr addr,
          * Provided for SeaBIOS only. Write MAC of Network card to addr @val.
          * Needed for the PDC_LAN_STATION_ID_READ PDC call.
          */
-        address_space_rw(&address_space_memory, val, MEMTXATTRS_UNSPECIFIED,
-                         d->state.conf.macaddr.a, ETH_ALEN, true);
+        address_space_write(&address_space_memory, val,
+                            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a,
+                            ETH_ALEN);
         break;
     }
 }
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 5989d72..f150dec 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -238,16 +238,16 @@ static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
                      int sz)
 {
     /* XXX Handle access size limits and FW read caching here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, false);
+    return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
+                               data, sz);
 }
 
 static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
                       int sz)
 {
     /* XXX Handle access size limits here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, true);
+    return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
+                                data, sz);
 }
 
 #define ECCB_CTL_READ           PPC_BIT(15)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f27f8c4..5d8e086 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -874,18 +874,18 @@ static inline int ida_read_next_idaw(CcwDataStream *cds)
         if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
             return -EINVAL; /* channel program check */
         }
-        ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
-                               sizeof(idaw.fmt2), false);
+        ret = address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
+                                 sizeof(idaw.fmt2));
         cds->cda = be64_to_cpu(idaw.fmt2);
     } else {
         idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
         if (idaw_addr & 0x03 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
             return -EINVAL; /* channel program check */
         }
-        ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
-                               sizeof(idaw.fmt1), false);
+        ret = address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
+                                 sizeof(idaw.fmt1));
         cds->cda = be64_to_cpu(idaw.fmt1);
         if (cds->cda & 0x80000000) {
             return -EINVAL; /* channel program check */
diff --git a/qtest.c b/qtest.c
index 65e33b8..dcb5749 100644
--- a/qtest.c
+++ b/qtest.c
@@ -429,23 +429,23 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 2, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 4, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 8, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                &data, 8);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -463,22 +463,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 2, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 4, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &value, 8, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               &value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -498,8 +498,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           len);
 
         enc = g_malloc(2 * len + 1);
         for (i = 0; i < len; i++) {
@@ -524,8 +524,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           len);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -559,8 +559,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                            len);
         g_free(data);
 
         qtest_send_prefix(chr);
@@ -582,8 +582,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, len, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                data, len);
             g_free(data);
         }
 
@@ -616,8 +616,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                            len);
 
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 493d79c..4f0e634 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -35,6 +35,19 @@ expression E1, E2, E3, E4;
 + address_space_write(E1, E2, E3, V, E4)
 )
 
+// Avoid uses of address_space_rw() with a constant is_write argument.
+@@
+expression E1, E2, E3, E4, E5;
+symbol true, false;
+@@
+(
+- address_space_rw(E1, E2, E3, E4, E5, false)
++ address_space_read(E1, E2, E3, E4, E5)
+|
+- address_space_rw(E1, E2, E3, E4, E5, true)
++ address_space_write(E1, E2, E3, E4, E5)
+)
+
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 19af029..03d2c79 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -125,10 +125,9 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
 
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
-        address_space_rw(&address_space_memory,
-                         rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
-                         MEMTXATTRS_UNSPECIFIED,
-                         pdpte, 32, false);
+        address_space_read(&address_space_memory,
+                           rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
+                           MEMTXATTRS_UNSPECIFIED, pdpte, 32);
         /* Only set PDPTE when appropriate. */
         for (i = 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 451dcc9..65d4603 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -88,8 +88,8 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
     }
 
     index = gpt_entry(pt->gva, level, pae);
-    address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), false);
+    address_space_read(&address_space_memory, gpa + index * pte_size(pae),
+                       MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae));
 
     pt->pte[level - 1] = pte;
 
@@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         } else {
-            address_space_rw(&address_space_memory, gpa,
-                             MEMTXATTRS_UNSPECIFIED, data, copy, true);
+            address_space_write(&address_space_memory, gpa,
+                                MEMTXATTRS_UNSPECIFIED, data, copy);
         }
 
         bytes -= copy;
@@ -259,8 +259,8 @@ void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes)
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         }
-        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-                         data, copy, false);
+        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                           data, copy);
 
         bytes -= copy;
         gva += copy;
-- 
1.8.3.1



