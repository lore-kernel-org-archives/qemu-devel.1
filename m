Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F59C43141
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F152073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCL/kT3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F152073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWit-0003LN-9i
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhC-0001xe-A7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhB-00035l-2X
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWhA-00035L-SE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id j18so1857551wmk.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nabIz4ztOSzD1wm9cdtMam8zaml9Qa5oErUhfcY/D5U=;
 b=DCL/kT3LClOKw0XwW7Zovx8t6MgGvj8CAjEXStMGMRQgitYewIEYofZhKhtzfzHlMo
 rzuQ0V21sES9GVvTbQ8pu7sVrpofPGzAsf+7wcfjCORHcyv2UrZVGko5NAFWJrMFQ8Jz
 zGCRG+/SvYvbbGYGFHGVOeo0QtNo4e+gufMnxBc9PPEqMXXAD5679/JuLYlUnjVVwiOK
 o63WrNVOWxgBBIsH6LsrZ+cTzUu/3kK90fhavWOnWepGneSUZO7VyfWjXBUTPXahilKO
 ADsvgBbv5q0u2qBfwsd0eTKE5FWuXRdvP6gTCLjLnilLpeOEIutGfkbjIrCaVG5Uilxm
 fqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nabIz4ztOSzD1wm9cdtMam8zaml9Qa5oErUhfcY/D5U=;
 b=EKJvrRGj4uySxdbLIRUwKQQhz1BoR96bkURaPucgpVV188oPfy2zU7YFnP8xIsvWS8
 Gs3oQvNd/y9stt6TNh3mgi04zFHVwXBLsAR8iNjY0RBAhdOfmZXpu7WaIfobaXcHJ/kL
 WyaR1wFZf6GkDCU4bVx+VUSVKjWPAL8/sHBKxDJLzz+hQRXWnryrdKDrJl7LQW8+yxsQ
 YaQ9WjGI07g2zDPHGtmNm2sk02hauiX3rIpkjDmZeacqnK4VziGeJsRFOnFlT6ZCJ9LC
 O1KaYHFvYo2fn7bzlPdnIiXN4hB/8k3ZcAgw/pNlA1E3elO5R2oSmzd1wMtWx7PKYtAc
 o0og==
X-Gm-Message-State: APjAAAWpcKrYLC/5+UItI1zDiA7UJ5WcezMdSZR7V51QIdPqj3qRpE1r
 /eQ3tqvseF8pkr+F2dg1F7a7Ncov
X-Google-Smtp-Source: APXvYqw0bAWsEiINCBxgaGYX+9pDZJm6axEpImS9Zx+MUE8yHaVqKt6IDW9cLZcyg0MmH+I+7pbtnQ==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr3192025wmc.111.1574758779480; 
 Tue, 26 Nov 2019 00:59:39 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] hvf: non-RAM,
 non-ROMD memory ranges are now correctly mapped in
Date: Tue, 26 Nov 2019 09:59:33 +0100
Message-Id: <20191126085936.1689-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
References: <20191126085936.1689-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

If an area is non-RAM and non-ROMD, then remove mappings so accesses
will trap and can be emulated.  Change hvf_find_overlap_slot() to take
a size instead of an end address: it wouldn't return a slot because
callers would pass the same address for start and end.  Don't always
map area as read/write/execute, respect area flags.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <1d8476c8f86959273fbdf23c86f8b4b611f5e2e1.1574625592.git.dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 231732aaf7..0b50cfcbc6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -107,14 +107,14 @@ static void assert_hvf_ok(hv_return_t ret)
 }
 
 /* Memory slots */
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t end)
+hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 {
     hvf_slot *slot;
     int x;
     for (x = 0; x < hvf_state->num_slots; ++x) {
         slot = &hvf_state->slots[x];
         if (slot->size && start < (slot->start + slot->size) &&
-            end > slot->start) {
+            (start + size) > slot->start) {
             return slot;
         }
     }
@@ -129,12 +129,10 @@ struct mac_slot {
 };
 
 struct mac_slot mac_slots[32];
-#define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
 
-static int do_hvf_set_memory(hvf_slot *slot)
+static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
-    hv_memory_flags_t flags;
     hv_return_t ret;
 
     macslot = &mac_slots[slot->slot_id];
@@ -151,8 +149,6 @@ static int do_hvf_set_memory(hvf_slot *slot)
         return 0;
     }
 
-    flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-
     macslot->present = 1;
     macslot->gpa_start = slot->start;
     macslot->size = slot->size;
@@ -165,14 +161,24 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 {
     hvf_slot *mem;
     MemoryRegion *area = section->mr;
+    bool writeable = !area->readonly && !area->rom_device;
+    hv_memory_flags_t flags;
 
     if (!memory_region_is_ram(area)) {
-        return;
+        if (writeable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the hvf memory slot so all accesses will trap.
+             */
+             add = false;
+        }
     }
 
     mem = hvf_find_overlap_slot(
             section->offset_within_address_space,
-            section->offset_within_address_space + int128_get64(section->size));
+            int128_get64(section->size));
 
     if (mem && add) {
         if (mem->size == int128_get64(section->size) &&
@@ -186,7 +192,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     /* Region needs to be reset. set the size to 0 and remap it. */
     if (mem) {
         mem->size = 0;
-        if (do_hvf_set_memory(mem)) {
+        if (do_hvf_set_memory(mem, 0)) {
             error_report("Failed to reset overlapping slot");
             abort();
         }
@@ -196,6 +202,13 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         return;
     }
 
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
+    } else {
+        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
+    }
+
     /* Now make a new slot. */
     int x;
 
@@ -216,7 +229,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->start = section->offset_within_address_space;
     mem->region = area;
 
-    if (do_hvf_set_memory(mem)) {
+    if (do_hvf_set_memory(mem, flags)) {
         error_report("Error registering new memory slot");
         abort();
     }
@@ -345,7 +358,14 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
         return false;
     }
 
-    return !slot;
+    if (!slot) {
+        return true;
+    }
+    if (!memory_region_is_ram(slot->region) &&
+        !(read && memory_region_is_romd(slot->region))) {
+        return true;
+    }
+    return false;
 }
 
 static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
@@ -354,7 +374,7 @@ static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
 
     slot = hvf_find_overlap_slot(
             section->offset_within_address_space,
-            section->offset_within_address_space + int128_get64(section->size));
+            int128_get64(section->size));
 
     /* protect region against writes; begin tracking it */
     if (on) {
@@ -720,7 +740,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             ret = EXCP_INTERRUPT;
             break;
         }
-            /* Need to check if MMIO or unmmaped fault */
+        /* Need to check if MMIO or unmapped fault */
         case EXIT_REASON_EPT_FAULT:
         {
             hvf_slot *slot;
@@ -731,7 +751,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 vmx_set_nmi_blocking(cpu);
             }
 
-            slot = hvf_find_overlap_slot(gpa, gpa);
+            slot = hvf_find_overlap_slot(gpa, 1);
             /* mmio */
             if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
-- 
2.21.0



