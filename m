Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86DDC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6219020CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoFimyud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6219020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZEY-0005OZ-JZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlL-0001v8-26
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlI-0001V7-LZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlI-0001PO-Aq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:28 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so2837603wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0JvaTHvzLsXBw/Wdu/19J5MK8M1pS8N9yWeMOkadhU=;
 b=VoFimyudk9JmDh1KxjE6XhIA9C4f+X/nVIUESXgmzCgzErXQSk0zNC3973HG2VwkmH
 cAe66BF9467rXzly3PhcNnbSP2OIwseCkwHcYFpmsgi4yxToTK55gRu9y9zt+sujjpeQ
 ViVneFQEhSg5OGslxEjEC6j3teMfw9b95a225gLgEusQkCVkhI3viFEG19b0H/9tmgKu
 HVMHZTbHbVgIdohbA7tYbRdIkEkXnoef6tIrk6VgiqrlCQoYbQT/16u5mxvE97XGRGWQ
 2IqED58aVn1iOR8zKS+1zrNP0WpUZ3qmDBD7c61GR49JLoGgTXAU+nQGMSyoVpNXgcgr
 eRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=b0JvaTHvzLsXBw/Wdu/19J5MK8M1pS8N9yWeMOkadhU=;
 b=cLUpxM5eFGlpYObIPLa/AQcD5GpOJYrvboI4CyG55ucyqBbDVJnTvMuhtqWkaBNvHO
 E4W3iKx+QR1g0MR8/rQghHLNp8NwRKFamAz25ymUfalWWPSM8sswZFTQgAM5lRV8CkXT
 ZMhvxyb1Re4C++nqmEFked2fkLNFxMXFcUG9LU1UT2EQ+sjzWNG7QkVQ75U4VYY/gk74
 IXc/epJ4cRMY0RNRLo6NoT6+jXjJEpYYTm6mavv/OomHgTSy6cZSPF6d2LwuS77uqDZW
 V9AcmNPpiBpwVa+c06ZQEkewNcnvXDbnmsSiHcU5Fe4NCb7VZBZyJmiKPRw4/XDiksLx
 sE6Q==
X-Gm-Message-State: APjAAAUjy1elwuWbW7zsqgs87UHJTkBOa+UNEh1FM7Np4iL27xqvj72l
 eRXNf6r+R8MIXB6ZKMdxmXLlWyL8
X-Google-Smtp-Source: APXvYqzYaHb3szGszJF16F3rBfp3Bz9SpTbKHEMq8c33aHk0AMMy08ONGHYV7Mzdy16CN14MQEt1yQ==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4867027wma.24.1582631546577; 
 Tue, 25 Feb 2020 03:52:26 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 086/136] Remove unnecessary cast when using the address_space
 API
Date: Tue, 25 Feb 2020 12:50:16 +0100
Message-Id: <1582631466-13880-86-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Two lines in hw/net/dp8393x.c that Coccinelle produced that
were over 80 characters were re-wrapped by hand.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/boot.c                          |  6 ++----
 hw/dma/rc4030.c                        |  4 ++--
 hw/dma/xlnx-zdma.c                     |  2 +-
 hw/net/cadence_gem.c                   | 21 +++++++++------------
 hw/net/dp8393x.c                       | 28 ++++++++++++++--------------
 hw/s390x/css.c                         |  4 ++--
 qtest.c                                | 12 ++++++------
 scripts/coccinelle/exec_rw_const.cocci | 15 ++++++++++++++-
 target/i386/hvf/vmx.h                  |  2 +-
 target/i386/hvf/x86_mmu.c              |  2 +-
 target/i386/whpx-all.c                 |  2 +-
 target/s390x/mmu_helper.c              |  2 +-
 12 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 0c213ca..fef4072 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -327,8 +327,7 @@ static void set_kernel_args(const struct arm_boot_info *info, AddressSpace *as)
 
         cmdline_size = strlen(info->kernel_cmdline);
         address_space_write(as, p + 8, MEMTXATTRS_UNSPECIFIED,
-                            (const uint8_t *)info->kernel_cmdline,
-                            cmdline_size + 1);
+                            info->kernel_cmdline, cmdline_size + 1);
         cmdline_size = (cmdline_size >> 2) + 1;
         WRITE_WORD(p, cmdline_size + 2);
         WRITE_WORD(p, 0x54410009);
@@ -420,8 +419,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
     }
     s = info->kernel_cmdline;
     if (s) {
-        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED,
-                            (const uint8_t *)s, strlen(s) + 1);
+        address_space_write(as, p, MEMTXATTRS_UNSPECIFIED, s, strlen(s) + 1);
     } else {
         WRITE_WORD(p, 0);
     }
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index c4cf823..ca0becd 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -513,8 +513,8 @@ static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     if (i < s->dma_tl_limit / sizeof(entry)) {
         entry_address = (s->dma_tl_base & 0x7fffffff) + i * sizeof(entry);
         if (address_space_read(ret.target_as, entry_address,
-                               MEMTXATTRS_UNSPECIFIED, (unsigned char *)&entry,
-                               sizeof(entry)) == MEMTX_OK) {
+                               MEMTXATTRS_UNSPECIFIED, &entry, sizeof(entry))
+                == MEMTX_OK) {
             ret.translated_addr = entry.frame & ~(DMA_PAGESIZE - 1);
             ret.perm = IOMMU_RW;
         }
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 8fb83f5..683abbe 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -364,7 +364,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
     } else {
         addr = zdma_get_regaddr64(s, basereg);
         addr += sizeof(s->dsc_dst);
-        address_space_rw(s->dma_as, addr, s->attr, (void *) &next, 8, false);
+        address_space_rw(s->dma_as, addr, s->attr, &next, 8, false);
         zdma_put_regaddr64(s, basereg, next);
     }
     return next;
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 871fcf2..ddabdb3 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -871,7 +871,7 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
 
     /* read current descriptor */
     address_space_read(&s->dma_as, desc_addr, MEMTXATTRS_UNSPECIFIED,
-                       (uint8_t *)s->rx_desc[q],
+                       s->rx_desc[q],
                        sizeof(uint32_t) * gem_get_desc_len(s, true));
 
     /* Descriptor owned by software ? */
@@ -1029,9 +1029,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
         /* Descriptor write-back.  */
         desc_addr = gem_get_rx_desc_addr(s, q);
-        address_space_write(&s->dma_as, desc_addr,
-                            MEMTXATTRS_UNSPECIFIED,
-                            (uint8_t *)s->rx_desc[q],
+        address_space_write(&s->dma_as, desc_addr, MEMTXATTRS_UNSPECIFIED,
+                            s->rx_desc[q],
                             sizeof(uint32_t) * gem_get_desc_len(s, true));
 
         /* Next descriptor */
@@ -1137,7 +1136,7 @@ static void gem_transmit(CadenceGEMState *s)
 
         DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
         address_space_read(&s->dma_as, packet_desc_addr,
-                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
+                           MEMTXATTRS_UNSPECIFIED, desc,
                            sizeof(uint32_t) * gem_get_desc_len(s, false));
         /* Handle all descriptors owned by hardware */
         while (tx_desc_get_used(desc) == 0) {
@@ -1185,14 +1184,12 @@ static void gem_transmit(CadenceGEMState *s)
                  * the processor.
                  */
                 address_space_read(&s->dma_as, desc_addr,
-                                   MEMTXATTRS_UNSPECIFIED,
-                                   (uint8_t *)desc_first,
+                                   MEMTXATTRS_UNSPECIFIED, desc_first,
                                    sizeof(desc_first));
                 tx_desc_set_used(desc_first);
                 address_space_write(&s->dma_as, desc_addr,
-                                  MEMTXATTRS_UNSPECIFIED,
-                                  (uint8_t *)desc_first,
-                                   sizeof(desc_first));
+                                    MEMTXATTRS_UNSPECIFIED, desc_first,
+                                    sizeof(desc_first));
                 /* Advance the hardware current descriptor past this packet */
                 if (tx_desc_get_wrap(desc)) {
                     s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
@@ -1246,8 +1243,8 @@ static void gem_transmit(CadenceGEMState *s)
             }
             DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
             address_space_read(&s->dma_as, packet_desc_addr,
-                              MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
-                              sizeof(uint32_t) * gem_get_desc_len(s, false));
+                               MEMTXATTRS_UNSPECIFIED, desc,
+                               sizeof(uint32_t) * gem_get_desc_len(s, false));
         }
 
         if (tx_desc_get_used(desc)) {
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 580ae44..b461101 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -276,7 +276,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
         s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
@@ -294,7 +294,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
     s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
@@ -312,7 +312,7 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
     address_space_rw(&s->as, dp8393x_rrp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
 
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
@@ -427,7 +427,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
         address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
         tx_len = 0;
 
         /* Update registers */
@@ -461,7 +461,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 size = sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                                 MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
                 s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
@@ -495,17 +495,17 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
-            dp8393x_ttda(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
+                         dp8393x_ttda(s),
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
             size = sizeof(uint16_t) * width;
             address_space_rw(&s->as,
-                dp8393x_ttda(s) +
+                             dp8393x_ttda(s) +
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
-                MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
             s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -768,7 +768,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, size, 0);
+                         s->data, size, 0);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -790,7 +790,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_len);
     address += rx_len;
     address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
+                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, 1);
     rx_len += 4;
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
@@ -819,12 +819,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
     s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,7 +838,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         }
         s->data[0] = 0;
         address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, sizeof(uint16_t), 1);
+                         s->data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 844caab..f27f8c4 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -875,7 +875,7 @@ static inline int ida_read_next_idaw(CcwDataStream *cds)
             return -EINVAL; /* channel program check */
         }
         ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
+                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
                                sizeof(idaw.fmt2), false);
         cds->cda = be64_to_cpu(idaw.fmt2);
     } else {
@@ -884,7 +884,7 @@ static inline int ida_read_next_idaw(CcwDataStream *cds)
             return -EINVAL; /* channel program check */
         }
         ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
+                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
                                sizeof(idaw.fmt1), false);
         cds->cda = be64_to_cpu(idaw.fmt1);
         if (cds->cda & 0x80000000) {
diff --git a/qtest.c b/qtest.c
index 12432f9..65e33b8 100644
--- a/qtest.c
+++ b/qtest.c
@@ -435,17 +435,17 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             uint16_t data = value;
             tswap16s(&data);
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 2, true);
+                             &data, 2, true);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 4, true);
+                             &data, 4, true);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 8, true);
+                             &data, 8, true);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -469,16 +469,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else if (words[0][4] == 'w') {
             uint16_t data;
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 2, false);
+                             &data, 2, false);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 4, false);
+                             &data, 4, false);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
             address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &value, 8, false);
+                             &value, 8, false);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 87897dd..fe2cf91 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -25,10 +25,23 @@ expression E1, E2, E3, E4;
 
 // Remove useless cast
 @@
-expression E1, E2, E3, E4;
+expression E1, E2, E3, E4, E5, E6;
 type T;
 @@
 (
+- address_space_rw(E1, E2, E3, (T *)(E4), E5, E6)
++ address_space_rw(E1, E2, E3, E4, E5, E6)
+|
+- address_space_read(E1, E2, E3, (T *)(E4), E5)
++ address_space_read(E1, E2, E3, E4, E5)
+|
+- address_space_write(E1, E2, E3, (T *)(E4), E5)
++ address_space_write(E1, E2, E3, E4, E5)
+|
+- address_space_write_rom(E1, E2, E3, (T *)(E4), E5)
++ address_space_write_rom(E1, E2, E3, E4, E5)
+|
+
 - dma_memory_read(E1, E2, (T *)(E3), E4)
 + dma_memory_read(E1, E2, E3, E4)
 |
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index eb8894c..a115ca1 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -128,7 +128,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
         address_space_rw(&address_space_memory,
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)pdpte, 32, 0);
+                         pdpte, 32, 0);
         /* Only set PDPTE when appropriate. */
         for (i = 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index d5a0efe..6a62064 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -89,7 +89,7 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
 
     index = gpt_entry(pt->gva, level, pae);
     address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size(pae), 0);
+                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), 0);
 
     pt->pte[level - 1] = pte;
 
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 3ed2aa1..0a1f244 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -540,7 +540,7 @@ static HRESULT CALLBACK whpx_emu_ioport_callback(
 {
     MemTxAttrs attrs = { 0 };
     address_space_rw(&address_space_io, IoAccess->Port, attrs,
-                     (uint8_t *)&IoAccess->Data, IoAccess->AccessSize,
+                     &IoAccess->Data, IoAccess->AccessSize,
                      IoAccess->Direction);
     return S_OK;
 }
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index c9f3f34..0be2f30 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -106,7 +106,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      * We treat them as absolute addresses and don't wrap them.
      */
     if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
-                                    (uint8_t *)entry, sizeof(*entry)) !=
+                                    entry, sizeof(*entry)) !=
                  MEMTX_OK)) {
         return false;
     }
-- 
1.8.3.1



