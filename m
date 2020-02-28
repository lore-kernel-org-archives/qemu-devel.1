Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6720C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720052467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPK0GPyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720052467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iKM-0002Wi-M2
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIX-0007u1-I3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIV-0006Qa-S4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIV-0006QQ-N6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azQI//x1XHTCYM2Kx0VH4YlnHHSvW/fbim95OF/v5Tg=;
 b=YPK0GPyRyrYGXq4wZY52e3tJNbw4y/MmRsT3FzCZTECgDHWmSaXuSi580+FuhGdFZDFZzE
 DUQ46Nv3AsP5fnA1KE1n+PW8kHC54OeL+92d8fcHLm3Zb953hTRAuHnT3qL/bo600oQXj0
 2erp/XHs6nWL0JeDYiSWT2SzgNXTqLs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-aqovlrubNnuVdQdBo9MfRA-1; Fri, 28 Feb 2020 11:15:29 -0500
X-MC-Unique: aqovlrubNnuVdQdBo9MfRA-1
Received: by mail-qk1-f197.google.com with SMTP id t186so3277211qkf.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8c1sdU/yqohOemAqqHR7iCiEMoLJYx26Ueh5v2B5KQU=;
 b=MXFTDG0du7QU3xghhaTo5RV1ziGvhc2ctVfERdhCn80bEt+/g792HRdsnpBP7dyqnM
 m7TVecE1BOMjksmfgTEiFoQvVOoUNQRlBZ47p15d6ANJh3bZbh1tgPIQsZzZjg5ZCcxt
 IRLab6c9YNHz5cRcIyk/HmJ5HK42AF8icy9awBQeimF9k2oeDEqKnU1wSNmlflYnaxsJ
 jYWs8e7YV0SfzSCrquS6QweymgzIXnDSBv0VLRWKAUSfyF9eIx/MrjduGak3BMOmlM30
 TaA3S045g8Jnm7Mk2fHs0Yg1GpPTW0/QZJObo0TwV9ZK/jLAqvjEpVU0wyXY3NHUcpL2
 LmQA==
X-Gm-Message-State: APjAAAUCLOTThn3aKOIDF+Tx7gjhjegz/ddI3/Fn3PabgwdC5wISSN4p
 Fk1HR24gsN/OFbag9wuMbisBnTAPaio2X2PLyC/gl0odVV9sSPiH6H3vdWA8JHgR2h5YbTJewTa
 XGioZ4qpb7JTCSF8=
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr4490678qvb.80.1582906528171; 
 Fri, 28 Feb 2020 08:15:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqx95/PxjR+vuf+l7cHAZ2lh39ZXkbL4hbTQVDfvUt7LFM+FgRDXHh8xolLoj910tzwwgT4jQw==
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr4490646qvb.80.1582906527743; 
 Fri, 28 Feb 2020 08:15:27 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v9sm5172492qkv.79.2020.02.28.08.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] KVM: Kick resamplefd for split kernel irqchip
Date: Fri, 28 Feb 2020 11:15:02 -0500
Message-Id: <20200228161503.382656-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is majorly only for X86 because that's the only one that supports
split irqchip for now.

When the irqchip is split, we face a dilemma that KVM irqfd will be
enabled, however the slow irqchip is still running in the userspace.
It means that the resamplefd in the kernel irqfds won't take any
effect and it will miss to ack INTx interrupts on EOIs.

One example is split irqchip with VFIO INTx, which will break if we
use the VFIO INTx fast path.

This patch can potentially supports the VFIO fast path again for INTx,
that the IRQ delivery will still use the fast path, while we don't
need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
callers of vfio_eoi() hook).  However the EOI of the INTx will still
need to be done from the userspace by caching all the resamplefds in
QEMU and kick properly for IOAPIC EOI broadcast.

This is tricky because in this case the userspace ioapic irr &
remote-irr will be bypassed.  However such a change will greatly boost
performance for assigned devices using INTx irqs (TCP_RR boosts 46%
after this patch applied).

When the userspace is responsible for the resamplefd kickup, don't
register it on the kvm_irqfd anymore, because on newer kernels (after
commit 654f1f13ea56, 5.2+) the KVM_IRQFD will fail if with both split
irqchip and resamplefd.  This will make sure that the fast path will
work for all supported kernels.

https://patchwork.kernel.org/patch/10738541/#22609933

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 85 +++++++++++++++++++++++++++++++++++++++++-
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 23 +++++++++++-
 include/sysemu/kvm.h   |  7 ++++
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d49b74512a..89771ea114 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -159,9 +159,65 @@ static const KVMCapabilityInfo kvm_required_capabilite=
s[] =3D {
 static NotifierList kvm_irqchip_change_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(kvm_irqchip_change_notifiers);
=20
+struct KVMResampleFd {
+    int gsi;
+    EventNotifier *resample_event;
+    QLIST_ENTRY(KVMResampleFd) node;
+};
+typedef struct KVMResampleFd KVMResampleFd;
+
+/*
+ * Only used with split irqchip where we need to do the resample fd
+ * kick for the kernel from userspace.
+ */
+static QLIST_HEAD(, KVMResampleFd) kvm_resample_fd_list =3D
+    QLIST_HEAD_INITIALIZER(kvm_resample_fd_list);
+
 #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
 #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
=20
+static inline void kvm_resample_fd_remove(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            QLIST_REMOVE(rfd, node);
+            g_free(rfd);
+            break;
+        }
+    }
+}
+
+static inline void kvm_resample_fd_insert(int gsi, EventNotifier *event)
+{
+    KVMResampleFd *rfd =3D g_new0(KVMResampleFd, 1);
+
+    rfd->gsi =3D gsi;
+    rfd->resample_event =3D event;
+
+    QLIST_INSERT_HEAD(&kvm_resample_fd_list, rfd, node);
+}
+
+bool kvm_resample_fd_notify(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    if (!kvm_irqchip_is_split()) {
+        return false;
+    }
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            event_notifier_set(rfd->resample_event);
+            trace_kvm_resample_fd_notify(gsi);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_accel());
@@ -1642,8 +1698,33 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, Eve=
ntNotifier *event,
     };
=20
     if (rfd !=3D -1) {
-        irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
-        irqfd.resamplefd =3D rfd;
+        assert(assign);
+        if (kvm_irqchip_is_split()) {
+            /*
+             * When the slow irqchip (e.g. IOAPIC) is in the
+             * userspace, KVM kernel resamplefd will not work because
+             * the EOI of the interrupt will be delivered to userspace
+             * instead, so the KVM kernel resamplefd kick will be
+             * skipped.  The userspace here mimics what the kernel
+             * provides with resamplefd, remember the resamplefd and
+             * kick it when we receive EOI of this IRQ.
+             *
+             * This is hackery because IOAPIC is mostly bypassed
+             * (except EOI broadcasts) when irqfd is used.  However
+             * this can bring much performance back for split irqchip
+             * with INTx IRQs (for VFIO, this gives 93% perf of the
+             * full fast path, which is 46% perf boost comparing to
+             * the INTx slow path).
+             */
+            kvm_resample_fd_insert(virq, resample);
+        } else {
+            irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
+            irqfd.resamplefd =3D rfd;
+        }
+    } else if (!assign) {
+        if (kvm_irqchip_is_split()) {
+            kvm_resample_fd_remove(virq);
+        }
     }
=20
     if (!kvm_irqfds_enabled()) {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 4fb6e59d19..a68eb66534 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -16,4 +16,5 @@ kvm_set_ioeventfd_mmio(int fd, uint64_t addr, uint32_t va=
l, bool assign, uint32_
 kvm_set_ioeventfd_pio(int fd, uint16_t addr, uint32_t val, bool assign, ui=
nt32_t size, bool datamatch) "fd: %d @0x%x val=3D0x%x assign: %d size: %d m=
atch: %d"
 kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t guest_phys_add=
r, uint64_t memory_size, uint64_t userspace_addr, int ret) "Slot#%d flags=
=3D0x%x gpa=3D0x%"PRIx64 " size=3D0x%"PRIx64 " ua=3D0x%"PRIx64 " ret=3D%d"
 kvm_clear_dirty_log(uint32_t slot, uint64_t start, uint32_t size) "slot#%"=
PRId32" start 0x%"PRIx64" size 0x%"PRIx32
+kvm_resample_fd_notify(int gsi) "gsi %d"
=20
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 15747fe2c2..13921b333d 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -236,8 +236,27 @@ void ioapic_eoi_broadcast(int vector)
         for (n =3D 0; n < IOAPIC_NUM_PINS; n++) {
             entry =3D s->ioredtbl[n];
=20
-            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector ||
-                ((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D IOAPIC=
_TRIGGER_LEVEL) {
+            if ((entry & IOAPIC_VECTOR_MASK) !=3D vector) {
+                continue;
+            }
+
+            /*
+             * When IOAPIC is in the userspace while APIC is still in
+             * the kernel (i.e., split irqchip), we have a trick to
+             * kick the resamplefd logic for registered irqfds from
+             * userspace to deactivate the IRQ.  When that happens, it
+             * means the irq bypassed userspace IOAPIC (so the irr and
+             * remote-irr of the table entry should be bypassed too
+             * even if interrupt come), then we don't need to clear
+             * the remote-IRR and check irr again because they'll
+             * always be zeros.
+             */
+            if (kvm_resample_fd_notify(n)) {
+                continue;
+            }
+
+            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
+                IOAPIC_TRIGGER_LEVEL) {
                 continue;
             }
=20
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 141342de98..3f0830cc4f 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -555,4 +555,11 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *s=
ource);
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
+
+/*
+ * Notify resamplefd for EOI of specific interrupts.  Returns true
+ * when one resamplefd is notified, false if no such IRQ found.
+ */
+bool kvm_resample_fd_notify(int gsi);
+
 #endif
--=20
2.24.1


