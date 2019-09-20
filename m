Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC352086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0JNvVrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC352086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBG3q-0007eC-DD
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2Z-0006TS-Oj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2Y-0004pG-IY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iBG2Y-0004oy-DK; Fri, 20 Sep 2019 06:21:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id b24so1723280wmj.5;
 Fri, 20 Sep 2019 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GBmysqlZGeXiOxLfV2wubdlWdwMk7uVesxCmd07aVgc=;
 b=A0JNvVrRS1hvL84Ghupg1hnm8vyxTWIFQsQjUncwmW09fxSD2JMa4cALbONyE05pPu
 phRZiMBFQY2OBB9xXklPX5i2PuNDqDL63++Sl1621dW11a3Di/qAeSFapzJEs/BVFxjS
 acPKJbCvM2ww06roIALie+1X8fjUmEq6Va+lDljT7+dMLvS6ONbo3y6srDCjcPvZ29Dg
 4JQFOk83B0qIErX1nKr3KagFwsi2gJ5lZhsrKJq2aT5Is8TMBPBjPAJTpFk/zES1FHs9
 b3eqCAWui5Pw05O4MltdoTa2wSlpFhlkykSa1N1NQ5d1VRx0GKnLaE5iqAxme4M+lLyY
 2YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=GBmysqlZGeXiOxLfV2wubdlWdwMk7uVesxCmd07aVgc=;
 b=nWQnHU3L/3CMgHUebUfVtfFVWEtZwFt3io0Kbgdg8q2NMSSKMgR7SUuRcf/g/3CUMC
 7vhmD1cJZQfYG/etwlUMmQDVI+NutG3RofVxbEgc8yyTbyE6YYOopsaY/+fJ8CRQrvac
 2MAU8N16sonWz3HX1v9nKMY+8a5oZIijj4VhADReLuhhSQGqzfVTUHnWc1NhN8Rz94Ap
 o16dVnbcAyfjbDdYA/Td9jtJZLwYCwswIvnHJFyg4ysMfCkKNJDO2bvpRh5vSNOCapJ0
 JTGwldGXdlaja/vTKfNokPaxLnbN1Rn55rO5Ik3rZSBRJz1vRR59exlZmjz4daXHstgx
 AAvQ==
X-Gm-Message-State: APjAAAWMIQ7/DOBbKwjWIhAnvUiNZo+L3pbTeHVvL9R+LU3YLfce0HW1
 dW1FdVF6nOw5cZlsf6yIfkLr/CkN
X-Google-Smtp-Source: APXvYqzeNNkCC+W8me4F8I27T3GPnbUsEVBi3TQXEO1ggCQJv39v+iEv+fYpgqiXFFODk2v0321j8Q==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr3093504wma.161.1568974885051; 
 Fri, 20 Sep 2019 03:21:25 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u10sm1331274wmm.0.2019.09.20.03.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 03:21:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] kvm: extract kvm_log_clear_one_slot
Date: Fri, 20 Sep 2019 12:21:21 +0200
Message-Id: <1568974882-7419-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
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
Cc: dgilbert@redhat.com, peterx@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We may need to clear the dirty bitmap for more than one KVM memslot.
First do some code movement with no semantic change.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 102 ++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b09bad0..e9e6086 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -575,55 +575,13 @@ out:
 #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
 #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
 
-/**
- * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
- *
- * NOTE: this will be a no-op if we haven't enabled manual dirty log
- * protection in the host kernel because in that case this operation
- * will be done within log_sync().
- *
- * @kml:     the kvm memory listener
- * @section: the memory range to clear dirty bitmap
- */
-static int kvm_physical_log_clear(KVMMemoryListener *kml,
-                                  MemoryRegionSection *section)
+static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start, uint64_t size)
 {
     KVMState *s = kvm_state;
+    uint64_t end, bmap_start, start_delta, bmap_npages;
     struct kvm_clear_dirty_log d;
-    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
     unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
-    KVMSlot *mem = NULL;
-    int ret, i;
-
-    if (!s->manual_dirty_log_protect) {
-        /* No need to do explicit clear */
-        return 0;
-    }
-
-    start = section->offset_within_address_space;
-    size = int128_get64(section->size);
-
-    if (!size) {
-        /* Nothing more we can do... */
-        return 0;
-    }
-
-    kvm_slots_lock(kml);
-
-    /* Find any possible slot that covers the section */
-    for (i = 0; i < s->nr_slots; i++) {
-        mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
-            break;
-        }
-    }
-
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
+    int ret;
 
     /*
      * We need to extend either the start or the size or both to
@@ -694,7 +652,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* It should never overflow.  If it happens, say something */
     assert(bmap_npages <= UINT32_MAX);
     d.num_pages = bmap_npages;
-    d.slot = mem->slot | (kml->as_id << 16);
+    d.slot = mem->slot | (as_id << 16);
 
     if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
         ret = -errno;
@@ -717,6 +675,58 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                  size / psize);
     /* This handles the NULL case well */
     g_free(bmap_clear);
+    return ret;
+}
+
+
+/**
+ * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
+ *
+ * NOTE: this will be a no-op if we haven't enabled manual dirty log
+ * protection in the host kernel because in that case this operation
+ * will be done within log_sync().
+ *
+ * @kml:     the kvm memory listener
+ * @section: the memory range to clear dirty bitmap
+ */
+static int kvm_physical_log_clear(KVMMemoryListener *kml,
+                                  MemoryRegionSection *section)
+{
+    KVMState *s = kvm_state;
+    uint64_t start, size;
+    KVMSlot *mem = NULL;
+    int ret, i;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start = section->offset_within_address_space;
+    size = int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    /* Find any possible slot that covers the section */
+    for (i = 0; i < s->nr_slots; i++) {
+        mem = &kml->slots[i];
+        if (mem->start_addr <= start &&
+            start + size <= mem->start_addr + mem->memory_size) {
+            break;
+        }
+    }
+
+    /*
+     * We should always find one memslot until this point, otherwise
+     * there could be something wrong from the upper layer
+     */
+    assert(mem && i != s->nr_slots);
+    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
 
     kvm_slots_unlock(kml);
 
-- 
1.8.3.1



