Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E631C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF662070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0wrEkF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF662070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHg2-0008NP-Ev
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcV-0004Z9-5P
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaHcU-0001Ic-Bf
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:38:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so8424087wre.13
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 04:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dgT5N5e/Hw5TD5vn9opgkvYdIJNN9dDH5/0pQTdacOM=;
 b=i0wrEkF1qndS/4WsmxkApN3ec+rg6Dr6G3p/1nKiTh0Zfe/qSZQbMPhr9jRyNaXTBw
 JK0LX7h8+qZbARqDcIk7PjIK17QZUm4ZJ1/+hp/+afIkfANbcxFMZBVeKJR36waX3JP9
 FJI4SsLgHFmW+E/c89mEg8mfzNJRPMQXxWrlMBjv0TupNzslRrO3N9GIqJTY9LipcGRj
 2mldHT8km+Noh6HViqWDz2N0c0FJz2PTagn68lFiicpMiTTsRhphdGdPL5VVb20/cZ8M
 HibXyvkWJoQxh7Vg8EtN4z9jTUzS7+Jz9V6MUbxLXeZoEE6nt2OgAIEKgj1kqjXDYJ1G
 MK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dgT5N5e/Hw5TD5vn9opgkvYdIJNN9dDH5/0pQTdacOM=;
 b=BqtOGPsBIYRHQuW4DfpFOeK7l/drtWryFZmStrTDSvS/Kan3EEVYKiHmVTFMX2kFAy
 8nK3u8C0BNmWnwoIK4Iq/P0qLr0i8fq+21Aj1hibXF6PXE22FntxwM2HJgrrf2FoRYky
 HY7Zmst1BVKBGML+7g6xhBqnsoUe0h6+k4x2tAKXVgcj+a0N6wZMf23gt+PcA9fmdz4J
 EPAXSKe4HAO+Ra7awYx/KcjScquRv8kaXkjqubUJgqLOvq2ZfibPr7dxdPvRGWJ0c8aN
 blvmGXvARrwW7SzDTZG3KG391+zU86Znq+spCeUkddvdC5nsRXaKs7rXnHHeCmGkx8OO
 BjZA==
X-Gm-Message-State: AOAM532e1zHSWUvQNW/jD8Neqa2b+tET2sKHEg5qXQ8+0DmWCWogYXkN
 PL8MQ+1CecUSk0YoM9Wc4uI4nsu96es=
X-Google-Smtp-Source: ABdhPJykSMQszinO0b1MriNkEZO4raT4Zx1sw2hdG/GVT594RAFOyQsj1RnmH+e/H3eLVU9z0KrGbQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr14750911wrt.132.1589715492261; 
 Sun, 17 May 2020 04:38:12 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id u10sm11660451wmc.31.2020.05.17.04.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 04:38:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] exec: Do not let flatview_read/write_continue do
 (too) short accesses
Date: Sun, 17 May 2020 13:38:04 +0200
Message-Id: <20200517113804.9063-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200517113804.9063-1-f4bug@amsat.org>
References: <20200517113804.9063-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Li Zhijian <lizhijian@cn.fujitsu.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of accessing a device with an invalid short size,
return MEMTX_ERROR to indicate the transaction failed (as
the device won't accept the transaction anyway).

Reported by libFuzzer. sdhci_sdma_transfer_multi_blocks()
ends calling dma_memory_rw() with size < 4, while the DMA
MMIO regions are restricted to 32-bit accesses:

  qemu-fuzz-arm: hw/dma/bcm2835_dma.c:153: uint64_t bcm2835_dma_read(BCM2835DMAState *, hwaddr, unsigned int, unsigned int): Assertion `size == 4' failed.
  ==27332== ERROR: libFuzzer: deadly signal
    #8 0x7f0ffa1f5565 in __GI___assert_fail (/lib64/libc.so.6+0x30565)
    #9 0x562fe3c9c83f in bcm2835_dma_read (qemu-fuzz-arm+0x1d2e83f)
    #10 0x562fe3c9f81b in bcm2835_dma15_read (qemu-fuzz-arm+0x1d3181b)
    #11 0x562fe307d265 in memory_region_read_accessor (qemu-fuzz-arm+0x110f265)
    #12 0x562fe304ecb3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e0cb3)
    #13 0x562fe304cb37 in memory_region_dispatch_read1 (qemu-fuzz-arm+0x10deb37)
    #14 0x562fe304c553 in memory_region_dispatch_read (qemu-fuzz-arm+0x10de553)
    #15 0x562fe2e7fd1d in flatview_read_continue (qemu-fuzz-arm+0xf11d1d)
    #16 0x562fe2e8147d in flatview_read (qemu-fuzz-arm+0xf1347d)
    #17 0x562fe2e80fd4 in address_space_read_full (qemu-fuzz-arm+0xf12fd4)
    #18 0x562fe2e820fa in address_space_rw (qemu-fuzz-arm+0xf140fa)
    #19 0x562fe411e485 in dma_memory_rw_relaxed (qemu-fuzz-arm+0x21b0485)
    #20 0x562fe411deb5 in dma_memory_rw (qemu-fuzz-arm+0x21afeb5)
    #21 0x562fe411d837 in dma_memory_read (qemu-fuzz-arm+0x21af837)
    #22 0x562fe41190a6 in sdhci_sdma_transfer_multi_blocks (qemu-fuzz-arm+0x21ab0a6)
    #23 0x562fe41217c1 in sdhci_write (qemu-fuzz-arm+0x21b37c1)
    #24 0x562fe304f147 in memory_region_write_accessor (qemu-fuzz-arm+0x10e1147)
    #25 0x562fe304ecb3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e0cb3)
    #26 0x562fe304d853 in memory_region_dispatch_write (qemu-fuzz-arm+0x10df853)
    #27 0x562fe2e91e0b in flatview_write_continue (qemu-fuzz-arm+0xf23e0b)
    #28 0x562fe2e81d02 in flatview_write (qemu-fuzz-arm+0xf13d02)
    #29 0x562fe2e81834 in address_space_write (qemu-fuzz-arm+0xf13834)

  qemu-fuzz-arm: hw/dma/bcm2835_dma.c:200: void bcm2835_dma_write(BCM2835DMAState *, hwaddr, uint64_t, unsigned int, unsigned int): Assertion `size == 4' failed.
  ==16113== ERROR: libFuzzer: deadly signal
    #8 0x7fd823d3d565 in __GI___assert_fail (/lib64/libc.so.6+0x30565)
    #9 0x557a62b72ec3 in bcm2835_dma_write (qemu-fuzz-arm+0x1d2eec3)
    #10 0x557a62b725e8 in bcm2835_dma0_write (qemu-fuzz-arm+0x1d2e5e8)
    #11 0x557a61f25147 in memory_region_write_accessor (qemu-fuzz-arm+0x10e1147)
    #12 0x557a61f24cb3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e0cb3)
    #13 0x557a61f23853 in memory_region_dispatch_write (qemu-fuzz-arm+0x10df853)
    #14 0x557a61d67e0b in flatview_write_continue (qemu-fuzz-arm+0xf23e0b)
    #15 0x557a61d57d02 in flatview_write (qemu-fuzz-arm+0xf13d02)
    #16 0x557a61d57834 in address_space_write (qemu-fuzz-arm+0xf13834)
    #17 0x557a61d58054 in address_space_rw (qemu-fuzz-arm+0xf14054)
    #18 0x557a62ff4485 in dma_memory_rw_relaxed (qemu-fuzz-arm+0x21b0485)
    #19 0x557a62ff3eb5 in dma_memory_rw (qemu-fuzz-arm+0x21afeb5)
    #20 0x557a62ff379a in dma_memory_write (qemu-fuzz-arm+0x21af79a)
    #21 0x557a62fee9dc in sdhci_sdma_transfer_multi_blocks (qemu-fuzz-arm+0x21aa9dc)
    #22 0x557a62ff77c1 in sdhci_write (qemu-fuzz-arm+0x21b37c1)
    #23 0x557a61f25147 in memory_region_write_accessor (qemu-fuzz-arm+0x10e1147)
    #24 0x557a61f24cb3 in access_with_adjusted_size (qemu-fuzz-arm+0x10e0cb3)
    #25 0x557a61f23853 in memory_region_dispatch_write (qemu-fuzz-arm+0x10df853)
    #26 0x557a61d67e0b in flatview_write_continue (qemu-fuzz-arm+0xf23e0b)
    #27 0x557a61d57d02 in flatview_write (qemu-fuzz-arm+0xf13d02)
    #28 0x557a61d57834 in address_space_write (qemu-fuzz-arm+0xf13834)

  ==5448==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x619000024380 at pc 0x55aac095e2cc bp 0x7fff9144ead0 sp 0x7fff9144e280
  WRITE of size 4 at 0x619000024380 thread T0
    #0 0x55aac095e2cb in __asan_memcpy (qemu-fuzz-arm+0xeb92cb)
    #1 0x55aac09de163 in stl_he_p (qemu-fuzz-arm+0xf39163)
    #2 0x55aac09b796f in stn_he_p (qemu-fuzz-arm+0xf1296f)
    #3 0x55aac09b6ec5 in flatview_read_continue (qemu-fuzz-arm+0xf11ec5)
    #4 0x55aac09b86dd in flatview_read (qemu-fuzz-arm+0xf136dd)
    #5 0x55aac09b8234 in address_space_read_full (qemu-fuzz-arm+0xf13234)
    #6 0x55aac09b935a in address_space_rw (qemu-fuzz-arm+0xf1435a)
    #7 0x55aac1c55b35 in dma_memory_rw_relaxed (qemu-fuzz-arm+0x21b0b35)
    #8 0x55aac1c55565 in dma_memory_rw (qemu-fuzz-arm+0x21b0565)
    #9 0x55aac1c54ee7 in dma_memory_read (qemu-fuzz-arm+0x21afee7)
    #10 0x55aac1c5074e in sdhci_sdma_transfer_multi_blocks (qemu-fuzz-arm+0x21ab74e)
    #11 0x55aac1c58e71 in sdhci_write (qemu-fuzz-arm+0x21b3e71)
    #12 0x55aac0b86417 in memory_region_write_accessor (qemu-fuzz-arm+0x10e1417)
    #13 0x55aac0b85f87 in access_with_adjusted_size (qemu-fuzz-arm+0x10e0f87)
    #14 0x55aac0b84ab3 in memory_region_dispatch_write (qemu-fuzz-arm+0x10dfab3)
    #15 0x55aac09c906b in flatview_write_continue (qemu-fuzz-arm+0xf2406b)
    #16 0x55aac09b8f62 in flatview_write (qemu-fuzz-arm+0xf13f62)
    #17 0x55aac09b8a94 in address_space_write (qemu-fuzz-arm+0xf13a94)

Reported-by: Clang combined libFuzzer with AddressSanitizer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 exec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index d3ec30f995..100c2754f2 100644
--- a/exec.c
+++ b/exec.c
@@ -3136,13 +3136,20 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
 
     for (;;) {
         if (!memory_access_is_direct(mr, true)) {
+            /* I/O case */
+            hwaddr l2;
+
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
+            l2 = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
-            val = ldn_he_p(buf, l);
-            result |= memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l), attrs);
+            if (l <= l2) {
+                val = ldn_he_p(buf, l);
+                result |= memory_region_dispatch_write(mr, addr1, val,
+                                                       size_memop(l), attrs);
+            } else {
+                result = MEMTX_ERROR;
+            }
         } else {
             /* RAM case */
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3202,11 +3209,17 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
     for (;;) {
         if (!memory_access_is_direct(mr, false)) {
             /* I/O case */
+            hwaddr l2;
+
             release_lock |= prepare_mmio_access(mr);
-            l = memory_access_size(mr, l, addr1);
-            result |= memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l), attrs);
-            stn_he_p(buf, l, val);
+            l2 = memory_access_size(mr, l, addr1);
+            if (l <= l2) {
+                result |= memory_region_dispatch_read(mr, addr1, &val,
+                                                      size_memop(l), attrs);
+                stn_he_p(buf, l, val);
+            } else {
+                result = MEMTX_ERROR;
+            }
         } else {
             /* RAM case */
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-- 
2.21.3


