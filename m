Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D2C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC49B215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC49B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEviZ-0005HQ-BM
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbO-0004Qm-F7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbJ-0005Ed-SN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50546
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iEvbI-00051T-HS
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8UDIH6i134075
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbjd70bw4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:07 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 30 Sep 2019 14:20:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 30 Sep 2019 14:20:00 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8UDJxVx57475284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2019 13:19:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ACFAAE056;
 Mon, 30 Sep 2019 13:19:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DED3AAE04D;
 Mon, 30 Sep 2019 13:19:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2019 13:19:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id 970B7E01C8; Mon, 30 Sep 2019 15:19:58 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/12] kvm: split too big memory section on several memslots
Date: Mon, 30 Sep 2019 15:19:53 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930131955.101131-1-borntraeger@de.ibm.com>
References: <20190930131955.101131-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093013-0028-0000-0000-000003A3FD54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093013-0029-0000-0000-0000246626AE
Message-Id: <20190930131955.101131-11-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Max memslot size supported by kvm on s390 is 8Tb,
move logic of splitting RAM in chunks upto 8T to KVM code.

This way it will hide KVM specific restrictions in KVM code
and won't affect board level design decisions. Which would allow
us to avoid misusing memory_region_allocate_system_memory() API
and eventually use a single hostmem backend for guest RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190924144751.24149-4-imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 accel/kvm/kvm-all.c      | 122 +++++++++++++++++++++++++--------------
 include/sysemu/kvm_int.h |   1 +
 2 files changed, 80 insertions(+), 43 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ff9b95c0d103..aabe097c410f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -140,6 +140,7 @@ bool kvm_direct_msi_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 static bool kvm_immediate_exit;
+static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
@@ -437,7 +438,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
 static int kvm_section_update_flags(KVMMemoryListener *kml,
                                     MemoryRegionSection *section)
 {
-    hwaddr start_addr, size;
+    hwaddr start_addr, size, slot_size;
     KVMSlot *mem;
     int ret = 0;
 
@@ -448,13 +449,18 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
 
     kvm_slots_lock(kml);
 
-    mem = kvm_lookup_matching_slot(kml, start_addr, size);
-    if (!mem) {
-        /* We don't have a slot if we want to trap every access. */
-        goto out;
-    }
+    while (size && !ret) {
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
+        if (!mem) {
+            /* We don't have a slot if we want to trap every access. */
+            goto out;
+        }
 
-    ret = kvm_slot_update_flags(kml, mem, section->mr);
+        ret = kvm_slot_update_flags(kml, mem, section->mr);
+        start_addr += slot_size;
+        size -= slot_size;
+    }
 
 out:
     kvm_slots_unlock(kml);
@@ -527,11 +533,15 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     struct kvm_dirty_log d = {};
     KVMSlot *mem;
     hwaddr start_addr, size;
+    hwaddr slot_size, slot_offset = 0;
     int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
-    if (size) {
-        mem = kvm_lookup_matching_slot(kml, start_addr, size);
+    while (size) {
+        MemoryRegionSection subsection = *section;
+
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
             goto out;
@@ -549,11 +559,11 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
          * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
          * a hope that sizeof(long) won't become >8 any time soon.
          */
-        size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
-                     /*HOST_LONG_BITS*/ 64) / 8;
         if (!mem->dirty_bmap) {
+            hwaddr bitmap_size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
+                                        /*HOST_LONG_BITS*/ 64) / 8;
             /* Allocate on the first log_sync, once and for all */
-            mem->dirty_bmap = g_malloc0(size);
+            mem->dirty_bmap = g_malloc0(bitmap_size);
         }
 
         d.dirty_bitmap = mem->dirty_bmap;
@@ -564,7 +574,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             goto out;
         }
 
-        kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
+        subsection.offset_within_region += slot_offset;
+        subsection.size = int128_make64(slot_size);
+        kvm_get_dirty_pages_log_range(&subsection, d.dirty_bitmap);
+
+        slot_offset += slot_size;
+        start_addr += slot_size;
+        size -= slot_size;
     }
 out:
     return ret;
@@ -972,6 +988,14 @@ kvm_check_extension_list(KVMState *s, const KVMCapabilityInfo *list)
     return NULL;
 }
 
+void kvm_set_max_memslot_size(hwaddr max_slot_size)
+{
+    g_assert(
+        ROUND_UP(max_slot_size, qemu_real_host_page_size) == max_slot_size
+    );
+    kvm_max_slot_size = max_slot_size;
+}
+
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
 {
@@ -979,7 +1003,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size;
+    hwaddr start_addr, size, slot_size;
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
@@ -1004,41 +1028,52 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     kvm_slots_lock(kml);
 
     if (!add) {
-        mem = kvm_lookup_matching_slot(kml, start_addr, size);
-        if (!mem) {
-            goto out;
-        }
-        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
-            kvm_physical_sync_dirty_bitmap(kml, section);
-        }
+        do {
+            slot_size = MIN(kvm_max_slot_size, size);
+            mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
+            if (!mem) {
+                goto out;
+            }
+            if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+                kvm_physical_sync_dirty_bitmap(kml, section);
+            }
 
-        /* unregister the slot */
-        g_free(mem->dirty_bmap);
-        mem->dirty_bmap = NULL;
-        mem->memory_size = 0;
-        mem->flags = 0;
-        err = kvm_set_user_memory_region(kml, mem, false);
-        if (err) {
-            fprintf(stderr, "%s: error unregistering slot: %s\n",
-                    __func__, strerror(-err));
-            abort();
-        }
+            /* unregister the slot */
+            g_free(mem->dirty_bmap);
+            mem->dirty_bmap = NULL;
+            mem->memory_size = 0;
+            mem->flags = 0;
+            err = kvm_set_user_memory_region(kml, mem, false);
+            if (err) {
+                fprintf(stderr, "%s: error unregistering slot: %s\n",
+                        __func__, strerror(-err));
+                abort();
+            }
+            start_addr += slot_size;
+            size -= slot_size;
+        } while (size);
         goto out;
     }
 
     /* register the new slot */
-    mem = kvm_alloc_slot(kml);
-    mem->memory_size = size;
-    mem->start_addr = start_addr;
-    mem->ram = ram;
-    mem->flags = kvm_mem_flags(mr);
+    do {
+        slot_size = MIN(kvm_max_slot_size, size);
+        mem = kvm_alloc_slot(kml);
+        mem->memory_size = slot_size;
+        mem->start_addr = start_addr;
+        mem->ram = ram;
+        mem->flags = kvm_mem_flags(mr);
 
-    err = kvm_set_user_memory_region(kml, mem, true);
-    if (err) {
-        fprintf(stderr, "%s: error registering slot: %s\n", __func__,
-                strerror(-err));
-        abort();
-    }
+        err = kvm_set_user_memory_region(kml, mem, true);
+        if (err) {
+            fprintf(stderr, "%s: error registering slot: %s\n", __func__,
+                    strerror(-err));
+            abort();
+        }
+        start_addr += slot_size;
+        ram += slot_size;
+        size -= slot_size;
+    } while (size);
 
 out:
     kvm_slots_unlock(kml);
@@ -2878,6 +2913,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
 
     for (i = 0; i < kvm->nr_as; ++i) {
         if (kvm->as[i].as == as && kvm->as[i].ml) {
+            size = MIN(kvm_max_slot_size, size);
             return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
                                                     start_addr, size);
         }
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 72b2d1b3aea5..ac2d1f8b5682 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -41,4 +41,5 @@ typedef struct KVMMemoryListener {
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id);
 
+void kvm_set_max_memslot_size(hwaddr max_slot_size);
 #endif
-- 
2.21.0


