Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E1C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 18:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D2E20829
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 18:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcJp083N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2E20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7NMm-0007KT-Uh
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 14:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7NMA-0006s5-TA
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 14:26:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7NM6-0005gZ-OQ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 14:26:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id r4so12726332wrx.9
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=foLrN1/bHDkeocz+h/WD6CFykMSU5DGbqxqlC9JoDZ0=;
 b=XcJp083NiZJQep0L3SjYSS7TBnnmKvVBIa6+1iQiEnz5CEzuq1S8C3XHCwpUHdSzFC
 UMvi9JDk2AXEjjn5b1hlXOIoU/ze4a5g2b+3ZAuoPVu5gwQ4f2aBeMmMQ0tl8hiDFgHY
 GP25+B94IRyaU9YxX3ZHD6Dnk2evE97gI/6Qy3F1wMiv6J+V4wAk0dagsAMUGh81IUIw
 VbTYWAmQ+2CWQ1G/3+KdzS5K2gPsHf5ygUfwaceIe89HWTA9NSa7Vmr06rD22adgxAsk
 z72ffD9l8TixzEkq+RfU2FFRESfqAiSoRvpeL0mu5S7O/ayWWc/y+SxjzbDd0458okL3
 BAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=foLrN1/bHDkeocz+h/WD6CFykMSU5DGbqxqlC9JoDZ0=;
 b=FkuJ9TFlJ4OxnnNYfeIzLuJ3F7IoQMiu54DRI/gnkKoggQSZgIPPmU4/ZjYDf7YRU6
 Ad/SuhnttddG98cZ+/5ngYnCPmd0IxaEbjNJdkOd8ua+T1SgZ9l4TRc4E+795AopbGwM
 BAdaKJL4/8tFVPpnObzad2LIiCYH3P6VoYtQJwBZqOfpfCuQfKw1jY95nh8n/GrN/W/V
 0O5JiglQrqSaR57YXiqKEaWNz0LimHRly321O0m4+sxRr/5FV20SjiL38EVtVTj2K0Bt
 STYaCGp67f3EveuOyYTMR2FI6t2TzBFUm942vHY2hOUxlI3TxgAeI7fMsP9jAdz+GA6Z
 OaKw==
X-Gm-Message-State: AOAM533oAGdEkzDJsCQBNgvi82Y5Qq57x87XXzhPsJt7c09zy1GQMUQe
 NrKR1S65LWA2+SSzXEGBkqySypt4PXo=
X-Google-Smtp-Source: ABdhPJzRFJf/+Mejp5ebiQENr6A7tJIaOeJ6kM7/MwJJ2WKMQ8akKQpG1DaOA0mi9r4SbDHrzYR42A==
X-Received: by 2002:a05:6000:118c:: with SMTP id
 g12mr11541210wrx.212.1597602364656; 
 Sun, 16 Aug 2020 11:26:04 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p22sm24809489wmc.38.2020.08.16.11.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2020 11:26:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Initialize MemoryRegionOps for RAM memory regions
Date: Sun, 16 Aug 2020 20:26:02 +0200
Message-Id: <20200816182602.352-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an issue when using memory_region_dispatch_read() or
memory_region_dispatch_write() on RAM memory regions.

RAM memory regions are initialized as:

  memory_region_init_ram()
  -> memory_region_init_ram_nomigrate()
     -> memory_region_init_ram_shared_nomigrate()
        -> memory_region_init()
           -> object_initialize(TYPE_MEMORY_REGION)
              -> memory_region_initfn()
                 -> mr->ops = &unassigned_mem_ops;

Later when accessing the alias, the memory_region_dispatch_read()
flow is:

  memory_region_dispatch_read()
  -> memory_region_dispatch_read1()
     -> if (mr->ops->read) { ... }
                   ^^^^^^
                   NULL deref as unassigned_mem_ops.read is NULL.

  memory_region_dispatch_write()
  -> if (mr->ops->write) { ... }
                ^^^^^^^
                NULL deref as unassigned_mem_ops.read is NULL.

Fix by initializing the MemoryRegionOps to ram_device_mem_ops,
this way the memory accesses are properly dispatched using
memory_region_ram_device_read() / memory_region_ram_device_write().

Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..2fce3fef2d 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1509,6 +1509,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, share, mr, &err);
@@ -1533,6 +1535,8 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
@@ -1558,6 +1562,8 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->align = align;
@@ -1581,6 +1587,8 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
@@ -1603,6 +1611,8 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
 {
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
-- 
2.21.3


