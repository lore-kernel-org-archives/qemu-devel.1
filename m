Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F888C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A656A2087D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDmoeKgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A656A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhRX-0001ue-QQ
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLg-00030m-Jr; Sun, 11 Oct 2020 15:49:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLd-0000IS-8m; Sun, 11 Oct 2020 15:49:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id b127so2544481wmb.3;
 Sun, 11 Oct 2020 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SDIyb5n7P2r5vl2AEidPZJyv8Pk8oGY5haZC+t+fmMk=;
 b=cDmoeKgWEhFiacoidrflBcXHnqOYg2fZWCT64uknbTOf6DwQl432yKQk8edGKd33X3
 Ka6ZlMMzDhBbAtq12cpQiCbWwQ2q0Ig409p66knzAnqReVGuyj47vOB35g4m9eC7rnr+
 Q7hpBnf7+Wkx0KhRuSwaRpIShHDBHfblAiYdNLJsAcCrs4eJgjumb+PGpBgoel/DPq7i
 GDKZlrVSEigesebzAJlWe+NmVznPppB0J8c8DeUEsz30E6hWYozQHqgfY9yFpGjwd0oI
 fUL34wSs0M+32+SEZ4yJe+ycnhy+QCbVQ5JosUYLHS/GuDOcbHcDpbcTk8UAYLx2Kp6D
 HLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SDIyb5n7P2r5vl2AEidPZJyv8Pk8oGY5haZC+t+fmMk=;
 b=i/cYADAY7ymzhNOY/4PhIPJD7u8T4LYjXW6CFeG1BSwtPefuWziMqPox5L8vpjm5sd
 NPXe6kUck+XjdQ2LNIS2Yz8ujZAF2aFGUQRUnbg+yCwEPgz7rWCK5yIDmPKkI4XDWZfH
 hxPkAn/LH1JTXhT/oRNrdwrCqu0GiZh4hzwnwEvm8JcCl5I9Kms82taCKZ+3iyVgpu6g
 K0yjxHlw+ZDma1B5zIs598b1bvi6JSrNDqa6lmRIxu5RT5hQo2O+pa/dKo8hx7YxhgA4
 ymJZVslwIyL8uoxiT5VCZpgy/J1mpy4wx/o4XQ5kMpQvDfRXbDjywpubJl6PgyPL+sGv
 j7Wg==
X-Gm-Message-State: AOAM530d6HlS3WAGNeM+MWlxD1Ve7h1v+VNfHsU5QkhhBAxO6dQwhRtv
 jMvUab5QuQBaC561Ov8/6HUweQtaWGI=
X-Google-Smtp-Source: ABdhPJyOpExsBJBvhmpoY5SXvj2cs4sQwfuU2ubJ778/DMTXlMvZ+HB1GZvm+Lx3hzLpfNl5JU9KSQ==
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr7490260wmi.149.1602445775112; 
 Sun, 11 Oct 2020 12:49:35 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q4sm21420475wru.65.2020.10.11.12.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:49:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/pci-host/versatile: Add WINDOW_COUNT definition to
 replace magic '3'
Date: Sun, 11 Oct 2020 21:49:17 +0200
Message-Id: <20201011194918.3219195-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011194918.3219195-1-f4bug@amsat.org>
References: <20201011194918.3219195-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit WINDOW_COUNT definition instead of a magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/versatile.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index b4951023f4e..4d9565de4b1 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -72,6 +72,8 @@ enum {
     PCI_VPB_IRQMAP_FORCE_OK,
 };
 
+#define WINDOW_COUNT 3
+
 struct PCIVPBState {
     PCIHostState parent_obj;
 
@@ -86,18 +88,18 @@ struct PCIVPBState {
      * The offsets into pci_mem_space are controlled by the imap registers.
      */
     MemoryRegion pci_io_window;
-    MemoryRegion pci_mem_window[3];
+    MemoryRegion pci_mem_window[WINDOW_COUNT];
     PCIBus pci_bus;
     PCIDevice pci_dev;
 
     /* Constant for life of device: */
     int realview;
-    uint32_t mem_win_size[3];
+    uint32_t mem_win_size[WINDOW_COUNT];
     uint8_t irq_mapping_prop;
 
     /* Variable state: */
-    uint32_t imap[3];
-    uint32_t smap[3];
+    uint32_t imap[WINDOW_COUNT];
+    uint32_t smap[WINDOW_COUNT];
     uint32_t selfid;
     uint32_t flags;
     uint8_t irq_mapping;
@@ -130,7 +132,7 @@ static void pci_vpb_update_all_windows(PCIVPBState *s)
     /* Update all alias windows based on the current register state */
     int i;
 
-    for (i = 0; i < 3; i++) {
+    for (i = 0; i < WINDOW_COUNT; i++) {
         pci_vpb_update_window(s, i);
     }
 }
@@ -148,8 +150,8 @@ static const VMStateDescription pci_vpb_vmstate = {
     .minimum_version_id = 1,
     .post_load = pci_vpb_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(imap, PCIVPBState, 3),
-        VMSTATE_UINT32_ARRAY(smap, PCIVPBState, 3),
+        VMSTATE_UINT32_ARRAY(imap, PCIVPBState, WINDOW_COUNT),
+        VMSTATE_UINT32_ARRAY(smap, PCIVPBState, WINDOW_COUNT),
         VMSTATE_UINT32(selfid, PCIVPBState),
         VMSTATE_UINT32(flags, PCIVPBState),
         VMSTATE_UINT8(irq_mapping, PCIVPBState),
@@ -371,12 +373,10 @@ static void pci_vpb_reset(DeviceState *d)
 {
     PCIVPBState *s = PCI_VPB(d);
 
-    s->imap[0] = 0;
-    s->imap[1] = 0;
-    s->imap[2] = 0;
-    s->smap[0] = 0;
-    s->smap[1] = 0;
-    s->smap[2] = 0;
+    for (int i = 0; i < WINDOW_COUNT; i++) {
+        s->imap[i] = 0;
+        s->smap[i] = 0;
+    }
     s->selfid = 0;
     s->flags = 0;
     s->irq_mapping = s->irq_mapping_prop;
@@ -453,7 +453,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
      * PCI memory space. The sizes vary from board to board; the base
      * offsets are guest controllable via the IMAP registers.
      */
-    for (i = 0; i < 3; i++) {
+    for (i = 0; i < WINDOW_COUNT; i++) {
         memory_region_init_alias(&s->pci_mem_window[i], OBJECT(s), "pci-vbp-window",
                                  &s->pci_mem_space, 0, s->mem_win_size[i]);
         sysbus_init_mmio(sbd, &s->pci_mem_window[i]);
-- 
2.26.2


