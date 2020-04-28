Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DCC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D940206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArFq1Jsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D940206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWfn-0000Uf-IQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXS-0007yd-W2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTu-00046U-Pa
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTu-000435-9s
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdTGxlavWNG4hCcyTcnyjmLabQ4Q1qfNUSi/H4pnRSU=;
 b=ArFq1JsmNIg2HfEzsTY6yWv8PCiA1iV+rSLSR9+pjMyxG7QfuGzIg3mUvufGRQSkbTC9Jt
 5RLfmlpy3vgeXfOipXcf52veIDHT1XguGLMsLLj0pd+rw0Htckj1lQy/RN5Dz1la/J5TY1
 8D584noSTMLdr/YzuaFT+5ihedvm310=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-iKvUXWTeOluhUKs5aj5Mog-1; Tue, 28 Apr 2020 16:05:24 -0400
X-MC-Unique: iKvUXWTeOluhUKs5aj5Mog-1
Received: by mail-qv1-f71.google.com with SMTP id m20so23890986qvy.13
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aPZzfB45yuZ2H25uVujO+WCBSsI+yNhUnbytesMWyqU=;
 b=ay8HM5a2XKSxFRzxxTCZU9SgGE4J0HhmdyJtyY6VuxIEsgqtUot5+dx4ZaUBacRA3S
 WTUnOvvylMeP0DjCeJISIc6vbc1gtuHOcrBB2zgdvIvWi1DRqW25PqS7fUmdS1ldUEle
 W6Guq/Xosj0ZoU1YBIBdDuObfh88ZicvtrN1jUGN9pAwcm9CwhVRgm0Kd+01p5dfwSYm
 vOaSn9mNbNdoiQBgf/FGgbbyvjzLN2rTIRJgLbHXPfEGZBmBVqKbM9Engno57+cE4MRM
 ThwW5FTWmoOwHD+RdQeTc2wRw4vWncYx8SQtPT7vTDDtjVF2RefpfgX2aEVACoTet7+M
 7X1w==
X-Gm-Message-State: AGi0PubYJAhA5nga2XvZ68jbg9ZvcxHCS8aPu1rJdjOoIi/0i3vq0rFV
 NglSzj0/O8gdsoFGkx1/+58dxq+jKrb1ak5CQ/9I9shgoFwX4GjYi61X65Cx/xDbxxwAXBGr3kt
 l0nI/dZF/ls5c4VY=
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr29879250qvb.6.1588104322831; 
 Tue, 28 Apr 2020 13:05:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJHzOphQcvX/amVj62JHtt1NmgnzAMWk3vfZ1HVeSWwr6SfP3caBgUAvCt8wb2rMX+jMbHADg==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr29879232qvb.6.1588104322573; 
 Tue, 28 Apr 2020 13:05:22 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 6/9] KVM: Provide helper to sync dirty bitmap from slot
 to ramblock
Date: Tue, 28 Apr 2020 16:05:06 -0400
Message-Id: <20200428200509.13150-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm_physical_sync_dirty_bitmap() calculates the ramblock offset in an
awkward way from the MemoryRegionSection that passed in from the
caller.  The truth is for each KVMSlot the ramblock offset never
change for the lifecycle.  Cache the ramblock offset for each KVMSlot
into the structure when the KVMSlot is created.

With that, we can further simplify kvm_physical_sync_dirty_bitmap()
with a helper to sync KVMSlot dirty bitmap to the ramblock dirty
bitmap of a specific KVMSlot.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 37 +++++++++++++++++--------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 436b8fd899..dd21b86efa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -525,15 +525,12 @@ static void kvm_log_stop(MemoryListener *listener,
 }
=20
 /* get kvm's dirty pages bitmap and update qemu's */
-static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
-                                         unsigned long *bitmap)
+static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
 {
-    ram_addr_t start =3D section->offset_within_region +
-                       memory_region_get_ram_addr(section->mr);
-    ram_addr_t pages =3D int128_get64(section->size) / qemu_real_host_page=
_size;
+    ram_addr_t start =3D slot->ram_start_offset;
+    ram_addr_t pages =3D slot->memory_size / qemu_real_host_page_size;
=20
-    cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
-    return 0;
+    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages)=
;
 }
=20
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
@@ -595,12 +592,10 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryL=
istener *kml,
     KVMState *s =3D kvm_state;
     KVMSlot *mem;
     hwaddr start_addr, size;
-    hwaddr slot_size, slot_offset =3D 0;
+    hwaddr slot_size;
=20
     size =3D kvm_align_section(section, &start_addr);
     while (size) {
-        MemoryRegionSection subsection =3D *section;
-
         slot_size =3D MIN(kvm_max_slot_size, size);
         mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
@@ -609,12 +604,7 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryLi=
stener *kml,
         }
=20
         kvm_slot_get_dirty_log(s, mem);
-
-        subsection.offset_within_region +=3D slot_offset;
-        subsection.size =3D int128_make64(slot_size);
-        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
-
-        slot_offset +=3D slot_size;
+        kvm_slot_sync_dirty_pages(mem);
         start_addr +=3D slot_size;
         size -=3D slot_size;
     }
@@ -1036,7 +1026,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr =3D section->mr;
     bool writeable =3D !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size, slot_size;
+    hwaddr start_addr, size, slot_size, mr_offset;
+    ram_addr_t ram_start_offset;
     void *ram;
=20
     if (!memory_region_is_ram(mr)) {
@@ -1054,9 +1045,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
=20
-    /* use aligned delta to align the ram address */
-    ram =3D memory_region_get_ram_ptr(mr) + section->offset_within_region =
+
-          (start_addr - section->offset_within_address_space);
+    /* The offset of the kvmslot within the memory region */
+    mr_offset =3D section->offset_within_region + start_addr -
+        section->offset_within_address_space;
+
+    /* use aligned delta to align the ram address and offset */
+    ram =3D memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_start_offset =3D memory_region_get_ram_addr(mr) + mr_offset;
=20
     kvm_slots_lock(kml);
=20
@@ -1092,6 +1087,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->as_id =3D kml->as_id;
         mem->memory_size =3D slot_size;
         mem->start_addr =3D start_addr;
+        mem->ram_start_offset =3D ram_start_offset;
         mem->ram =3D ram;
         mem->flags =3D kvm_mem_flags(mr);
         kvm_slot_init_dirty_bitmap(mem);
@@ -1102,6 +1098,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
         start_addr +=3D slot_size;
+        ram_start_offset +=3D slot_size;
         ram +=3D slot_size;
         size -=3D slot_size;
     } while (size);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 4434e15ec7..1a19bfef80 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -25,6 +25,8 @@ typedef struct KVMSlot
     unsigned long *dirty_bmap;
     /* Cache of the address space ID */
     int as_id;
+    /* Cache of the offset in ram address space */
+    ram_addr_t ram_start_offset;
 } KVMSlot;
=20
 typedef struct KVMMemoryListener {
--=20
2.24.1


