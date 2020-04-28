Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F54C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3E0206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2QzmBcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3E0206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWd2-0004pw-RI
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXW-0007yu-MM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWU0-0004Em-6e
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTz-0004CQ-NE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7cZKxuteEXSYDoI49xeS5MTvgBO9o2UUzrB1670/T4=;
 b=N2QzmBcZ5JhQLTlbWlrzzf9FYnibzsUNOfN+4foXj53hKiOknAVo5BFG/Nm6HGEEAFP+uF
 ZsBW4DrjgKfJ85t6QaVLj+zAAacUO6r3dcfgTBSA/7TEC9BOjAzJNwa2g7sah+68jTUgXu
 vmWhnOJ3aPNSVhfPXwxxJvE7orUlx+E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-1gZVTwsTP56R6_PNZJ-7Dw-1; Tue, 28 Apr 2020 16:05:29 -0400
X-MC-Unique: 1gZVTwsTP56R6_PNZJ-7Dw-1
Received: by mail-qt1-f200.google.com with SMTP id v18so25812313qtq.22
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fS4jWDgrSptjjyOMhj/BjINMgbDQWDJYgx5SYZkfOPA=;
 b=MYKGa5P8SenzLt9x94OT/mNhsgPYgjGMyfofnPBjfRzU7iGHKmOIOkc7psK9nI96n9
 jhmFBe9yrWAN2YjBjJrM/Dn2oLIcWgX6inw7go6bQx3/tnFn7TdRodqn95SqxgQSUw4B
 YPWOmoDSakmtizVv3tMoRsmnuqd4YUmTgkWrIAOy8JJPwsso/27cUCbYirgsl0o89D1q
 UknJlCJGM7ZHFWCtqo5IxONBXz1ovCQyKIoapv49oWL8Y+PdNpTAW9ZIs99vCdh5jGxE
 acO9EF5jn8iphLknrTqFh5zzT1HUq8/vFJC7ZnVWopuh1eVu2EZS/ewxzy+dJGMrtSUY
 WnRA==
X-Gm-Message-State: AGi0PubJKTHGIjjnD4g1j2WMhGGK9bICAZVUmpriVXI6+m4ZNGKXsJyj
 ryUV3eGn8BBs/u4eBAs5og3IuUoAVwz/B+L2gKBtXr2yLMlI138sUFJHDslyK4OqoUW3aMXrE64
 QvLXf5vHnaGb0Ois=
X-Received: by 2002:a37:a0d5:: with SMTP id
 j204mr28938604qke.112.1588104327809; 
 Tue, 28 Apr 2020 13:05:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypJdkuV+Q1GelkdNKVrlzRd60hPhhQMlKsEH1BXxVtp545bSQiMeHkYXMVueq61LcbAks0bgWg==
X-Received: by 2002:a37:a0d5:: with SMTP id
 j204mr28938561qke.112.1588104327211; 
 Tue, 28 Apr 2020 13:05:27 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 9/9] KVM: Dirty ring support
Date: Tue, 28 Apr 2020 16:05:09 -0400
Message-Id: <20200428200509.13150-7-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

KVM dirty ring is a new interface to pass over dirty bits from kernel to th=
e
userspace.  Instead of using a bitmap for each memory region, the dirty rin=
g
contains an array of dirtied GPAs to fetch (in the form of offset in slots)=
.
For each vcpu there will be one dirty ring that binds to it.

kvm_dirty_ring_reap() is the major function to collect dirty rings.  It can=
 be
called either by a standalone reaper thread that runs in the background,
collecting dirty pages for the whole VM.  It can also be called directly by=
 any
thread that has BQL taken.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 341 ++++++++++++++++++++++++++++++++++++++++-
 accel/kvm/trace-events |   7 +
 include/hw/core/cpu.h  |   8 +
 3 files changed, 353 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fbb0a3b1e9..236dbcd536 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <poll.h>
=20
 #include <linux/kvm.h>
=20
@@ -75,6 +76,25 @@ struct KVMParkedVcpu {
     QLIST_ENTRY(KVMParkedVcpu) node;
 };
=20
+enum KVMDirtyRingReaperState {
+    KVM_DIRTY_RING_REAPER_NONE =3D 0,
+    /* The reaper is sleeping */
+    KVM_DIRTY_RING_REAPER_WAIT,
+    /* The reaper is reaping for dirty pages */
+    KVM_DIRTY_RING_REAPER_REAPING,
+};
+
+/*
+ * KVM reaper instance, responsible for collecting the KVM dirty bits
+ * via the dirty ring.
+ */
+struct KVMDirtyRingReaper {
+    /* The reaper thread */
+    QemuThread reaper_thr;
+    volatile uint64_t reaper_iteration; /* iteration number of reaper thr =
*/
+    volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state =
*/
+};
+
 struct KVMState
 {
     AccelState parent_obj;
@@ -121,7 +141,6 @@ struct KVMState
     void *memcrypt_handle;
     int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len)=
;
=20
-    /* For "info mtree -f" to tell if an MR is registered in KVM */
     int nr_as;
     struct KVMAs {
         KVMMemoryListener *ml;
@@ -130,6 +149,7 @@ struct KVMState
     bool kvm_dirty_ring_enabled;    /* Whether KVM dirty ring is enabled *=
/
     uint64_t kvm_dirty_ring_size;   /* Size of the per-vcpu dirty ring */
     uint32_t kvm_dirty_gfn_count;   /* Number of dirty GFNs per ring */
+    struct KVMDirtyRingReaper reaper;
 };
=20
 KVMState *kvm_state;
@@ -359,6 +379,13 @@ int kvm_destroy_vcpu(CPUState *cpu)
         goto err;
     }
=20
+    if (cpu->kvm_dirty_gfns) {
+        ret =3D munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_size);
+        if (ret < 0) {
+            goto err;
+        }
+    }
+
     vcpu =3D g_malloc0(sizeof(*vcpu));
     vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
     vcpu->kvm_fd =3D cpu->kvm_fd;
@@ -423,6 +450,19 @@ int kvm_init_vcpu(CPUState *cpu)
             (void *)cpu->kvm_run + s->coalesced_mmio * PAGE_SIZE;
     }
=20
+    if (s->kvm_dirty_ring_enabled) {
+        /* Use MAP_SHARED to share pages with the kernel */
+        cpu->kvm_dirty_gfns =3D mmap(NULL, s->kvm_dirty_ring_size,
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   cpu->kvm_fd,
+                                   PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
+        if (cpu->kvm_dirty_gfns =3D=3D MAP_FAILED) {
+            ret =3D -errno;
+            DPRINTF("mmap'ing vcpu dirty gfns failed: %d\n", ret);
+            goto err;
+        }
+    }
+
     ret =3D kvm_arch_init_vcpu(cpu);
 err:
     return ret;
@@ -536,6 +576,11 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
     cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages)=
;
 }
=20
+static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
+{
+    memset(slot->dirty_bmap, 0, slot->dirty_bmap_size);
+}
+
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
 /* Allocate the dirty bitmap for a slot  */
@@ -579,6 +624,198 @@ static void kvm_slot_get_dirty_log(KVMState *s, KVMSl=
ot *slot)
     }
 }
=20
+/* Should be with all slots_lock held for the address spaces. */
+static void kvm_dirty_ring_mark_page(KVMState *s, uint32_t as_id,
+                                     uint32_t slot_id, uint64_t offset)
+{
+    KVMMemoryListener *kml;
+    KVMSlot *mem;
+
+    if (as_id >=3D s->nr_as) {
+        return;
+    }
+
+    kml =3D s->as[as_id].ml;
+    mem =3D &kml->slots[slot_id];
+
+    if (!mem->memory_size || offset >=3D (mem->memory_size / TARGET_PAGE_S=
IZE)) {
+        return;
+    }
+
+    set_bit(offset, mem->dirty_bmap);
+}
+
+static bool dirty_gfn_is_dirtied(struct kvm_dirty_gfn *gfn)
+{
+    return gfn->flags =3D=3D KVM_DIRTY_GFN_F_DIRTY;
+}
+
+static void dirty_gfn_set_collected(struct kvm_dirty_gfn *gfn)
+{
+    gfn->flags =3D KVM_DIRTY_GFN_F_RESET;
+}
+
+/*
+ * Should be with all slots_lock held for the address spaces.  It returns =
the
+ * dirty page we've collected on this dirty ring.
+ */
+static uint32_t kvm_dirty_ring_reap_one(KVMState *s, CPUState *cpu)
+{
+    struct kvm_dirty_gfn *dirty_gfns =3D cpu->kvm_dirty_gfns, *cur;
+    uint32_t gfn_count =3D s->kvm_dirty_gfn_count;
+    uint32_t count =3D 0, fetch =3D cpu->kvm_fetch_index;
+
+    assert(dirty_gfns && gfn_count);
+    trace_kvm_dirty_ring_reap_vcpu(cpu->cpu_index);
+
+    while (true) {
+        cur =3D &dirty_gfns[fetch % gfn_count];
+        if (!dirty_gfn_is_dirtied(cur)) {
+            break;
+        }
+        kvm_dirty_ring_mark_page(s, cur->slot >> 16, cur->slot & 0xffff,
+                                 cur->offset);
+        dirty_gfn_set_collected(cur);
+        trace_kvm_dirty_ring_page(cpu->cpu_index, fetch, cur->offset);
+        fetch++;
+        count++;
+    }
+    cpu->kvm_fetch_index =3D fetch;
+
+    return count;
+}
+
+/*
+ * Currently for simplicity, we must hold BQL before calling this.  We can
+ * consider to drop the BQL if we're clear with all the race conditions.
+ */
+static uint64_t kvm_dirty_ring_reap(KVMState *s)
+{
+    KVMMemoryListener *kml;
+    int ret, i, locked_count =3D s->nr_as;
+    CPUState *cpu;
+    uint64_t total =3D 0;
+    int64_t stamp;
+
+    /*
+     * We need to lock all kvm slots for all address spaces here,
+     * because:
+     *
+     * (1) We need to mark dirty for dirty bitmaps in multiple slots
+     *     and for tons of pages, so it's better to take the lock here
+     *     once rather than once per page.  And more importantly,
+     *
+     * (2) We must _NOT_ publish dirty bits to the other threads
+     *     (e.g., the migration thread) via the kvm memory slot dirty
+     *     bitmaps before correctly re-protect those dirtied pages.
+     *     Otherwise we can have potential risk of data corruption if
+     *     the page data is read in the other thread before we do
+     *     reset below.
+     */
+    for (i =3D 0; i < s->nr_as; i++) {
+        kml =3D s->as[i].ml;
+        if (!kml) {
+            /*
+             * This is tricky - we grow s->as[] dynamically now.  Take
+             * care of that case.  We also assumed the as[] will fill
+             * one by one starting from zero.  Without this, we race
+             * with register_smram_listener.
+             *
+             * TODO: make all these prettier...
+             */
+            locked_count =3D i;
+            break;
+        }
+        kvm_slots_lock(kml);
+    }
+
+    stamp =3D get_clock();
+
+    CPU_FOREACH(cpu) {
+        total +=3D kvm_dirty_ring_reap_one(s, cpu);
+    }
+
+    if (total) {
+        ret =3D kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
+        assert(ret =3D=3D total);
+    }
+
+    stamp =3D get_clock() - stamp;
+
+    if (total) {
+        trace_kvm_dirty_ring_reap(total, stamp / 1000);
+    }
+
+    /* Unlock whatever locks that we have locked */
+    for (i =3D 0; i < locked_count; i++) {
+        kvm_slots_unlock(s->as[i].ml);
+    }
+
+    return total;
+}
+
+static void do_kvm_cpu_synchronize_kick(CPUState *cpu, run_on_cpu_data arg=
)
+{
+    /* No need to do anything */
+}
+
+/*
+ * Kick all vcpus out in a synchronized way.  When returned, we
+ * guarantee that every vcpu has been kicked and at least returned to
+ * userspace once.
+ */
+static void kvm_cpu_synchronize_kick_all(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        run_on_cpu(cpu, do_kvm_cpu_synchronize_kick, RUN_ON_CPU_NULL);
+    }
+}
+
+/*
+ * Flush all the existing dirty pages to the KVM slot buffers.  When
+ * this call returns, we guarantee that all the touched dirty pages
+ * before calling this function have been put into the per-kvmslot
+ * dirty bitmap.
+ *
+ * To achieve this, we need to:
+ *
+ * (1) Kick all vcpus out, this will make sure that we flush all the
+ *     dirty buffers that potentially in the hardware (PML) into the
+ *     dirty rings, after that,
+ *
+ * (2) Kick the reaper thread and make sure it reaps all the dirty
+ *     page that is in the dirty rings.
+ *
+ * This function must be called with BQL held.
+ */
+static void kvm_dirty_ring_flush(struct KVMDirtyRingReaper *r)
+{
+    trace_kvm_dirty_ring_flush(0);
+
+    /*
+     * The function needs to be serialized.  Since this function
+     * should always be with BQL held, serialization is guaranteed.
+     * However, let's be sure of it.
+     */
+    assert(qemu_mutex_iothread_locked());
+
+    /*
+     * First make sure to flush the hardware buffers by kicking all
+     * vcpus out in a synchronous way.
+     */
+    kvm_cpu_synchronize_kick_all();
+
+    /*
+     * Recycle the dirty bits outside the reaper thread.  We're safe becau=
se
+     * kvm_dirty_ring_reap() is internally protected by a mutex.
+     */
+    kvm_dirty_ring_reap(kvm_state);
+
+    trace_kvm_dirty_ring_flush(1);
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -1111,6 +1348,51 @@ out:
     kvm_slots_unlock(kml);
 }
=20
+static void *kvm_dirty_ring_reaper_thread(void *data)
+{
+    KVMState *s =3D data;
+    struct KVMDirtyRingReaper *r =3D &s->reaper;
+
+    rcu_register_thread();
+
+    trace_kvm_dirty_ring_reaper("init");
+
+    while (true) {
+        r->reaper_state =3D KVM_DIRTY_RING_REAPER_WAIT;
+        trace_kvm_dirty_ring_reaper("wait");
+        /*
+         * TODO: provide a smarter timeout rather than a constant?
+         */
+        sleep(1);
+
+        trace_kvm_dirty_ring_reaper("wakeup");
+        r->reaper_state =3D KVM_DIRTY_RING_REAPER_REAPING;
+
+        qemu_mutex_lock_iothread();
+        kvm_dirty_ring_reap(s);
+        qemu_mutex_unlock_iothread();
+
+        r->reaper_iteration++;
+    }
+
+    trace_kvm_dirty_ring_reaper("exit");
+
+    rcu_unregister_thread();
+
+    return NULL;
+}
+
+static int kvm_dirty_ring_reaper_init(KVMState *s)
+{
+    struct KVMDirtyRingReaper *r =3D &s->reaper;
+
+    qemu_thread_create(&r->reaper_thr, "kvm-reaper",
+                       kvm_dirty_ring_reaper_thread,
+                       s, QEMU_THREAD_JOINABLE);
+
+    return 0;
+}
+
 static void kvm_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
@@ -1139,6 +1421,36 @@ static void kvm_log_sync(MemoryListener *listener,
     kvm_slots_unlock(kml);
 }
=20
+static void kvm_log_sync_global(MemoryListener *l)
+{
+    KVMMemoryListener *kml =3D container_of(l, KVMMemoryListener, listener=
);
+    KVMState *s =3D kvm_state;
+    KVMSlot *mem;
+    int i;
+
+    /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
+    kvm_dirty_ring_flush(&s->reaper);
+
+    /*
+     * TODO: make this faster when nr_slots is big while there are
+     * only a few used slots (small VMs).
+     */
+    kvm_slots_lock(kml);
+    for (i =3D 0; i < s->nr_slots; i++) {
+        mem =3D &kml->slots[i];
+        if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+            kvm_slot_sync_dirty_pages(mem);
+            /*
+             * This is not needed by KVM_GET_DIRTY_LOG because the
+             * ioctl will unconditionally overwrite the whole region.
+             * However kvm dirty ring has no such side effect.
+             */
+            kvm_slot_reset_dirty_pages(mem);
+        }
+    }
+    kvm_slots_unlock(kml);
+}
+
 static void kvm_log_clear(MemoryListener *listener,
                           MemoryRegionSection *section)
 {
@@ -1245,10 +1557,15 @@ void kvm_memory_listener_register(KVMState *s, KVMM=
emoryListener *kml,
     kml->listener.region_del =3D kvm_region_del;
     kml->listener.log_start =3D kvm_log_start;
     kml->listener.log_stop =3D kvm_log_stop;
-    kml->listener.log_sync =3D kvm_log_sync;
-    kml->listener.log_clear =3D kvm_log_clear;
     kml->listener.priority =3D 10;
=20
+    if (s->kvm_dirty_ring_enabled) {
+        kml->listener.log_sync_global =3D kvm_log_sync_global;
+    } else {
+        kml->listener.log_sync =3D kvm_log_sync;
+        kml->listener.log_clear =3D kvm_log_clear;
+    }
+
     memory_listener_register(&kml->listener, as);
=20
     for (i =3D 0; i < s->nr_as; ++i) {
@@ -2138,6 +2455,13 @@ static int kvm_init(MachineState *ms)
         qemu_balloon_inhibit(true);
     }
=20
+    if (s->kvm_dirty_ring_enabled) {
+        ret =3D kvm_dirty_ring_reaper_init(s);
+        if (ret) {
+            goto err;
+        }
+    }
+
     return 0;
=20
 err:
@@ -2445,6 +2769,17 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_INTERNAL_ERROR:
             ret =3D kvm_handle_internal_error(cpu, run);
             break;
+        case KVM_EXIT_DIRTY_RING_FULL:
+            /*
+             * We shouldn't continue if the dirty ring of this vcpu is
+             * still full.  Got kicked by KVM_RESET_DIRTY_RINGS.
+             */
+            trace_kvm_dirty_ring_full(cpu->cpu_index);
+            qemu_mutex_lock_iothread();
+            kvm_dirty_ring_reap(kvm_state);
+            qemu_mutex_unlock_iothread();
+            ret =3D 0;
+            break;
         case KVM_EXIT_SYSTEM_EVENT:
             switch (run->system_event.type) {
             case KVM_SYSTEM_EVENT_SHUTDOWN:
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4fb6e59d19..89ef99569f 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -16,4 +16,11 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t v=
al, bool assign, uint32_
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, ui=
nt32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: %d m=
atch: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_add=
r, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=
=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"=
PRId32" start 0x%"PRIx64" size 0x%"PRIx32
+kvm_dirty_ring_full(int id) "vcpu %d"
+kvm_dirty_ring_reap_vcpu(int id) "vcpu %d"
+kvm_dirty_ring_page(int vcpu, uint32_t slot, uint64_t offset) "vcpu %d fet=
ch %"PRIu32" offset 0x%"PRIx64
+kvm_dirty_ring_reaper(const char *s) "%s"
+kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (to=
ok %"PRIi64" us)"
+kvm_dirty_ring_reaper_kick(const char *reason) "%s"
+kvm_dirty_ring_flush(int finished) "%d"
=20
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b26fdb5ab8..2d2bf61629 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -340,6 +340,11 @@ struct qemu_work_item;
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
+ * @kvm_dirty_ring_full:
+ *   Whether the kvm dirty ring of this vcpu is soft-full.
+ * @kvm_dirty_ring_avail:
+ *   Semaphore to be posted when the kvm dirty ring of the vcpu is
+ *   available again.
  *
  * State of one CPU core or thread.
  */
@@ -407,9 +412,12 @@ struct CPUState {
      */
     uintptr_t mem_io_pc;
=20
+    /* Only used in KVM */
     int kvm_fd;
     struct KVMState *kvm_state;
     struct kvm_run *kvm_run;
+    struct kvm_dirty_gfn *kvm_dirty_gfns;
+    uint32_t kvm_fetch_index;
=20
     /* Used for events with 'vcpu' and *without* the 'disabled' properties=
 */
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
--=20
2.24.1


