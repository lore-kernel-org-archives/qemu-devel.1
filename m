Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80794C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4945224676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvEA+lPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4945224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX7z-0007QZ-R2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3j-0001Qt-8P
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3i-0003gd-1j
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:59 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:37941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3h-0003gA-T6; Mon, 06 Jan 2020 13:24:57 -0500
Received: by mail-qv1-xf43.google.com with SMTP id t6so19445797qvs.5;
 Mon, 06 Jan 2020 10:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1daSF8Ke50vf7L1lkiX0k78v3ttDXfxEHmXKjiAnDM=;
 b=fvEA+lPfmF5uzZTGgJKwCrnrb0+IU9t4oJ74GmQhGsUw8ayTq0kCoiOsWnTHyXEZzA
 HM02mY9S0Ppzbk6pg5VFW3FBLfI9LN+Y9vf8OT/Upj5c2TgmYOeeCwGWrdCE2z+ubUSW
 HbLFak51A2jvycRPrk+GJ9ilsqbhQMMLS4/mwtjlrlW5D7hHtf5PlWbZC99MEcePiCLN
 NK5FjV+21LTBZSBcF+o0niXd7C4nHn7lvM5KXfrpUaQlPBV2PlRoQQdjzzNlj4rjq7lA
 R6Lunp1SY/5fUqYyvqeVV4fbvbu36wQxWATOw4FZmoPt/fsD7N/lVN+0yYAV964e8QUU
 zosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1daSF8Ke50vf7L1lkiX0k78v3ttDXfxEHmXKjiAnDM=;
 b=hU99zO16K70HC2No3uyBaNfwHehSnfivFPakkJieQOanjUPZvRptHs2R6E5yaJ25Iu
 nEeE8mKKnz3AzxVZUniLwGF2C2T1D4s4YneMKflPjPA34wC6FyaK+ADKLT560tPPZgO7
 +W2xRHI/qzKxqTXAp5ROyVGjwNG/TJUe5kAu4jfstgvYKtTYWfjfus+hQ+wHn++rwWWV
 yVL7hzoDuqyp8le7DZ/VroBFmP9zycAmSZXZViN9+r+8NrWy4x4J1Py3xjcAioRkA33C
 9c5WGadZui8uQSY6HE2BmUVVCFpBH1+W3BNvDXC2dTBMJf4oBH1P9j8PqzQwEYx1ukKH
 xnPA==
X-Gm-Message-State: APjAAAVLm8ORWIExG6w4YjuZvmrO/Ibvq5YrJ6dm7oClefTpjZVy3Tzi
 ejmmfQzJNFIRHZ9lhypyjHo428d3
X-Google-Smtp-Source: APXvYqxWTlBIt1KcA9as9yiBJamQ7BhAdA9fJnTkcj1X7G95+rr5BfkNXkOu4UuKsXjqGexd6u42yg==
X-Received: by 2002:a0c:8605:: with SMTP id p5mr80154235qva.109.1578335097141; 
 Mon, 06 Jan 2020 10:24:57 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:24:56 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/59] kvm-all.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:23:29 -0300
Message-Id: <20200106182425.20312-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Labels 'err' and 'out' from kvm_destroy_vcpu(), kvm_init_vcpu()
and kvm_physical_sync_dirty_bitmap() can be replaced by
'return' with the appropriate return value.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 accel/kvm/kvm-all.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b2f1a5bcb5..09ca99e082 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -329,26 +329,24 @@ int kvm_destroy_vcpu(CPUState *cpu)
 
     ret = kvm_arch_destroy_vcpu(cpu);
     if (ret < 0) {
-        goto err;
+        return ret;
     }
 
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
-        ret = mmap_size;
         DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
-        goto err;
+        return mmap_size;
     }
 
     ret = munmap(cpu->kvm_run, mmap_size);
     if (ret < 0) {
-        goto err;
+        return ret;
     }
 
     vcpu = g_malloc0(sizeof(*vcpu));
     vcpu->vcpu_id = kvm_arch_vcpu_id(cpu);
     vcpu->kvm_fd = cpu->kvm_fd;
     QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
-err:
     return ret;
 }
 
@@ -381,7 +379,7 @@ int kvm_init_vcpu(CPUState *cpu)
     ret = kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
     if (ret < 0) {
         DPRINTF("kvm_create_vcpu failed\n");
-        goto err;
+        return ret;
     }
 
     cpu->kvm_fd = ret;
@@ -390,17 +388,15 @@ int kvm_init_vcpu(CPUState *cpu)
 
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
-        ret = mmap_size;
         DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
-        goto err;
+        return mmap_size;
     }
 
     cpu->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
                         cpu->kvm_fd, 0);
     if (cpu->kvm_run == MAP_FAILED) {
-        ret = -errno;
         DPRINTF("mmap'ing vcpu state failed\n");
-        goto err;
+        return -errno;
     }
 
     if (s->coalesced_mmio && !s->coalesced_mmio_ring) {
@@ -408,9 +404,7 @@ int kvm_init_vcpu(CPUState *cpu)
             (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
     }
 
-    ret = kvm_arch_init_vcpu(cpu);
-err:
-    return ret;
+    return kvm_arch_init_vcpu(cpu);
 }
 
 /*
@@ -565,7 +559,6 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     KVMSlot *mem;
     hwaddr start_addr, size;
     hwaddr slot_size, slot_offset = 0;
-    int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
     while (size) {
@@ -575,7 +568,7 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
-            goto out;
+            return 0;
         }
 
         if (!mem->dirty_bmap) {
@@ -587,8 +580,7 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            ret = -1;
-            goto out;
+            return -1;
         }
 
         subsection.offset_within_region += slot_offset;
@@ -599,8 +591,8 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         start_addr += slot_size;
         size -= slot_size;
     }
-out:
-    return ret;
+
+    return 0;
 }
 
 /* Alignment requirement for KVM_CLEAR_DIRTY_LOG - 64 pages */
-- 
2.24.1


