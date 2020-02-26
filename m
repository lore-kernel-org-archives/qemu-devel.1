Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56DC4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E4B20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/YT2zqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E4B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75cW-0001uy-8x
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j75aI-0007Vi-6n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j75aG-0002X4-GW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j75aG-0002Wf-CE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582757716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MFa++5YU3mfigF5LahLlLxn2sMKcgokSyXEySgB2+A=;
 b=i/YT2zqRQ6uTwW8F37mPg2fUjIT21uX1h1/f4dxHVsUuir5K9fCntSm2SI5OfHtHP3yT9u
 BDnUROvM2UFtJ67vqZfR2yYDrm+1Gzr2H7tNAHI+qiRQd1dVIz0IURxFSSQn/vkCqysb3S
 wUpV81fDgmMEkceTkrIaPfczYhH5Pn8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-a8rxqva2P2ewOC_0y_UtWg-1; Wed, 26 Feb 2020 17:55:14 -0500
X-MC-Unique: a8rxqva2P2ewOC_0y_UtWg-1
Received: by mail-qv1-f69.google.com with SMTP id l1so1116749qvu.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gvTPynuCyHMtJhmuLrYJeDk9O0g1fCDRZ/EK0AB+mbc=;
 b=b6/GnSIYz7un5z2P31e/qq6cOLai81Ond7osxEB7iF5feknj6I+uhuyn33Ca0CTVKI
 q+kkDz4ckD+38XJlOCauAfPc3ruVjmBPO5rNn/qdhxembi/SRGIvvHKGc7tlvI17beQu
 cxIElsvHzjj/h8IEmdpyVC5owVbiP+76K4C9S0ZNnI8JDI0YuGphddyf7/xjS6OfaXva
 +WUUmZGn6aF7nKg5gNu48LfAi4HS6ViusCM2FKr30vD44IA6X/QCgEVWP7b1rKIrlVUJ
 VJeV/J04JhErBJEbnf6bJTO4K8zTv1Wju7b201DHdQk5GcySFR7tKNtErDgP5Rjfe5UX
 D22w==
X-Gm-Message-State: APjAAAUTs0MKP576k2wTI6CiwvtRIgLlLs8R3tbdWVJTGT48LAP0pKeU
 rZtAbzST4ZoZQpUbe8qQPD7g3RazsAtH+zgvK53aWezpE+dpMwPotKP7J+yvbH6l0DK3jeRg6Ib
 lCNXyLjkQAh2bnfo=
X-Received: by 2002:a37:7f03:: with SMTP id a3mr1839073qkd.121.1582757713246; 
 Wed, 26 Feb 2020 14:55:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjEnLOi/rGeXCye4RkLvxqTmiX3ngZ/iTizZitSsRgdSe20CJ54B1+/YOwPrAVIAC3Ut0E8w==
X-Received: by 2002:a37:7f03:: with SMTP id a3mr1839049qkd.121.1582757712942; 
 Wed, 26 Feb 2020 14:55:12 -0800 (PST)
Received: from xz-x1.redhat.com
 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id h34sm1985776qtc.62.2020.02.26.14.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 14:55:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] KVM: Kick resamplefd for split kernel irqchip
Date: Wed, 26 Feb 2020 17:55:10 -0500
Message-Id: <20200226225510.217077-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is majorly only for X86 because that's the only one that supports
split irqchip for now.

When the irqchip is split, we face a dilemma that KVM irqfd will be
enabled, however the slow irqchip is still running in the userspace.
It means that the resamplefd in the kernel irqfds won't take any
effect and it can miss to ack INTx interrupts on EOIs.

One example is split irqchip with VFIO INTx, which will break if we
use the VFIO INTx fast path.

This patch can potentially supports the VFIO fast path again for INTx,
that the IRQ delivery will still use the fast path, while we don't
need to trap MMIOs in QEMU for the device to emulate the EIOs (see the
callers of vfio_eoi() hook).  However the EOI of the INTx will still
need to be done from the userspace by caching all the resamplefds in
QEMU and kick properly for IOAPIC EOI broadcast.

https://patchwork.kernel.org/patch/10738541/#22609933

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c    | 67 ++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |  1 +
 hw/intc/ioapic.c       | 11 +++++--
 include/sysemu/kvm.h   |  4 +++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d49b74512a..c7a863552b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -159,9 +159,62 @@ static const KVMCapabilityInfo kvm_required_capabilite=
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
+void kvm_resample_fd_notify(int gsi)
+{
+    KVMResampleFd *rfd;
+
+    if (!kvm_irqchip_is_split()) {
+        return;
+    }
+
+    QLIST_FOREACH(rfd, &kvm_resample_fd_list, node) {
+        if (rfd->gsi =3D=3D gsi) {
+            event_notifier_set(rfd->resample_event);
+            trace_kvm_resample_fd_notify(gsi);
+            break;
+        }
+    }
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s =3D KVM_STATE(current_accel());
@@ -1644,6 +1697,20 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, Eve=
ntNotifier *event,
     if (rfd !=3D -1) {
         irqfd.flags |=3D KVM_IRQFD_FLAG_RESAMPLE;
         irqfd.resamplefd =3D rfd;
+
+        /*
+         * When the slow irqchip (e.g. IOAPIC) is in the userspace,
+         * resamplefd will not work because the EOI of the level
+         * triggered interrupt will be delivered to userspace
+         * instead.  The userspace needs to remember the resamplefd
+         * too and kick it when we receive EOI of this IRQ.
+         */
+        assert(assign);
+        kvm_resample_fd_insert(virq, resample);
+    }
+
+    if (!assign) {
+        kvm_resample_fd_remove(virq);
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
index 15747fe2c2..8c75465c62 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -236,8 +236,15 @@ void ioapic_eoi_broadcast(int vector)
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
+            /* Kick resamplefd if KVM is bypassed */
+            kvm_resample_fd_notify(n);
+
+            if (((entry >> IOAPIC_LVT_TRIGGER_MODE_SHIFT) & 1) !=3D
+                IOAPIC_TRIGGER_LEVEL) {
                 continue;
             }
=20
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 141342de98..b67552c047 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -555,4 +555,8 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *so=
urce);
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
+
+/* Notify resamplefd for EOI of specific level triggered interrupts */
+void kvm_resample_fd_notify(int gsi);
+
 #endif
--=20
2.24.1


