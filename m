Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB6C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSjJ/snW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB6C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBG5F-0000nh-Cv
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2a-0006TZ-LX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2Z-0004pY-Cm
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iBG2Z-0004pL-7v; Fri, 20 Sep 2019 06:21:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so1850825wmd.3;
 Fri, 20 Sep 2019 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DgP8/pEnm8kvMDx4y/uLQ5qKZyMG7wRIy9Zx1xfwJ+A=;
 b=LSjJ/snWlox2WJDWTtfQS7lL2dF/2ZodmjaSkdaWN9rJse2MamJqJXTYQ5aQY1slBi
 ngXtIt4j2JUUiErSf+rcO+1VI5J3Jqsh5LrM3GuBOkBUgu2MRfy91u4aTLQFi4ijeMF7
 9EGF7xNarX9hzWVxLQxZXVlwyef1ffGRgz+m/uhjlDawsxoMoVvr5q/Upx1aijBFRvS0
 PQ+fAR0feQd9d6ht5wGbw6sG2gQ0+puJ274blRM5NXAZXkErQtgUSr8pZVsGnegEZBVt
 NXP0PSkAF0totp32x/SuwD/JPPrDStwhTV2Mxyvbs9KOfojb8W+VIxVXJAJ2KFqGkRV9
 UPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=DgP8/pEnm8kvMDx4y/uLQ5qKZyMG7wRIy9Zx1xfwJ+A=;
 b=aZzSbDXZc6qjC2DXc3c/iDkTo4z6KP8PwZceycOkjp0HBm2li3CUwoVEZ1rxmZOB5n
 O0qE133H3QLmpkulxi5lfYEG1AkTJ4l13XP7VVji1VVRM/CKpcmjQgoLZB7O4/EJeWtF
 8LVVnf69rr6IfDOTc2nHaAVRIA7f5FofDo7wKCD2lMRXWe5TYXpW74zoHRMdldJ6J/4E
 HfZHK5iTD94FJlP72N58zuI7dAsl+DoHJmKT0w2S/2X9rWzyk0rIPbfWTpQTuOLHi3Qe
 PWWgy3UtratqFz3yri4kwqX/C3AYhA/uoEe652dW6Dqyt/LD3/Y+t2rNGIoizz79Frt2
 FBPg==
X-Gm-Message-State: APjAAAXxpxO10FrmtY4i3sgxYwx18TAQzExfA7ZEayaX18nDRUXrjYLf
 A1gHejvOLsP/g7xvCLqWs+0JQAKu
X-Google-Smtp-Source: APXvYqytK/KN2dxGYQvkw5ooNAo5uIgPCenPypzuAcGLGf2c7tbm4MWm6tib2wIKjIMlvM/yolgC8A==
X-Received: by 2002:a05:600c:2208:: with SMTP id
 z8mr3091863wml.113.1568974886040; 
 Fri, 20 Sep 2019 03:21:26 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u10sm1331274wmm.0.2019.09.20.03.21.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 03:21:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] kvm: clear dirty bitmaps from all overlapping memslots
Date: Fri, 20 Sep 2019 12:21:22 +0200
Message-Id: <1568974882-7419-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Since the KVM dirty page reporting works on guest physical addresses,
we need to clear all of the aliases when a page is migrated, or there
is a risk of losing writes to the aliases that were not cleared.

Note that this is only an issue for manual clearing of the bitmap;
if the bitmap is cleared at the same time as it's retrieved, all
the aliases get cleared correctly.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Fixes: ff4aa11419242c835b03d274f08f797c129ed7ba
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e9e6086..315a915 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -588,8 +588,8 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start, uint6
      * satisfy the KVM interface requirement.  Firstly, do the start
      * page alignment on 64 host pages
      */
-    bmap_start = (start - mem->start_addr) & KVM_CLEAR_LOG_MASK;
-    start_delta = start - mem->start_addr - bmap_start;
+    bmap_start = start & KVM_CLEAR_LOG_MASK;
+    start_delta = start - bmap_start;
     bmap_start /= psize;
 
     /*
@@ -693,8 +693,8 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                                   MemoryRegionSection *section)
 {
     KVMState *s = kvm_state;
-    uint64_t start, size;
-    KVMSlot *mem = NULL;
+    uint64_t start, size, offset, count;
+    KVMSlot *mem;
     int ret, i;
 
     if (!s->manual_dirty_log_protect) {
@@ -712,22 +712,30 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock(kml);
 
-    /* Find any possible slot that covers the section */
     for (i = 0; i < s->nr_slots; i++) {
         mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
+        /* Discard slots that are empty or do not overlap the section */
+        if (!mem->memory_size ||
+            mem->start_addr > start + size - 1 ||
+            start > mem->start_addr + mem->memory_size - 1) {
+            continue;
+        }
+
+        if (start >= mem->start_addr) {
+            /* The slot starts before section or is aligned to it.  */
+            offset = start - mem->start_addr;
+            count = MIN(mem->memory_size - offset, size);
+        } else {
+            /* The slot starts after section.  */
+            offset = 0;
+            count = MIN(mem->memory_size, size - (mem->start_addr - start));
+        }
+        ret = kvm_log_clear_one_slot(mem, kml->as_id, offset, count);
+        if (ret < 0) {
             break;
         }
     }
 
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
-    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
-
     kvm_slots_unlock(kml);
 
     return ret;
-- 
1.8.3.1


