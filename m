Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B3C8300A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCC120B80
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+9ntDsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCC120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWaq-0001mv-4J
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXU-0007yl-CA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTy-0004C3-Nu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTy-00046w-9C
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrE5LZkr68jWjuEjIcgWLcaBl9XGx69+ktzvmgweIdw=;
 b=N+9ntDsBJdLBDaod6rQwGMJp/Kt5U7bkuSzkoGr32ZlNa68ScnNJ9gk5x98CMTlJ/MfYWt
 WO8zmAJiBcLF9fJLOWyFS2VWyN+0gUQyKkutPlqw47rUxwUa+HPLATx3YEGTH0y3LMTz8W
 LGfLZDkL6qf29EAE2DvqReQuifmsL7I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-t_x3v2IwNGSll4tcCNDmyQ-1; Tue, 28 Apr 2020 16:05:26 -0400
X-MC-Unique: t_x3v2IwNGSll4tcCNDmyQ-1
Received: by mail-qv1-f71.google.com with SMTP id dh14so23961701qvb.4
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kqF+l5qd3CVbIOa0BR+c6tRuUFlT6yEu/7alzCqAkbE=;
 b=fGWlSNhz8P7FdlEUh3H7UVvlYB4dQWz3GhiplTrMV/jxX4aK7SxJnRZH2/CN7Pq32G
 HlcEtqQCscuAJofp4BLz2hFBfMNRm1jMzg/w8PQ5aKdSHpTKqkCkN1FmB0FSDgJhu499
 uha9IS8J35iA64JM4f/vQlKjgnvO5pokXEBWkpODvbUj0vxGd2UPQ2WWF52DHYhPX48C
 jmhbNhDVgTvJXV/7veA6HmEtIwwkw3/Z9zCRn2I/nzCq53Ks1jFyMkA08qy5JrVzfBqm
 fLJyPVtLOw0qqQ6YJWjeX44gOItxdcd3TXaWwcdMxJxO8ol5116Od+pfmIUA5C14Ub6i
 hPEQ==
X-Gm-Message-State: AGi0PuY3N8/P69B5W06qMFaeLEqDOYDL8devBAl9MIx22uO0hz0SczxY
 5RixHCvXJSV/2+bUrwxnbr+dhLqTpeIAuxG2wxmeuv/bQEJYtag6PSwBxgHPZRhhjN/GpjjoyS7
 O1ZbElr1nDZzhf/k=
X-Received: by 2002:ac8:33fd:: with SMTP id d58mr27867698qtb.213.1588104325813; 
 Tue, 28 Apr 2020 13:05:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgjpwYk5ZShWA9IJUKXNtOM+JDNyUlXcb+z1W4hN8Zz8V5LQDU8ceHEltdk2JHiZ0APYmZDQ==
X-Received: by 2002:ac8:33fd:: with SMTP id d58mr27867675qtb.213.1588104325468; 
 Tue, 28 Apr 2020 13:05:25 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:24 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 8/9] KVM: Add dirty-gfn-count property
Date: Tue, 28 Apr 2020 16:05:08 -0400
Message-Id: <20200428200509.13150-6-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

Add a parameter for dirty gfn count for dirty rings.  If zero, dirty ring i=
s
disabled.  Otherwise dirty ring will be enabled with the per-vcpu gfn count=
 as
specified.  If dirty ring cannot be enabled due to unsupported kernel or
illegal parameter, it'll fallback to dirty logging.

By default, dirty ring is not enabled (dirty-gfn-count default to 0).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx     |  5 ++++
 2 files changed, 77 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2d581013cc..fbb0a3b1e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,9 @@ struct KVMState
         KVMMemoryListener *ml;
         AddressSpace *as;
     } *as;
+    bool kvm_dirty_ring_enabled;    /* Whether KVM dirty ring is enabled *=
/
+    uint64_t kvm_dirty_ring_size;   /* Size of the per-vcpu dirty ring */
+    uint32_t kvm_dirty_gfn_count;   /* Number of dirty GFNs per ring */
 };
=20
 KVMState *kvm_state;
@@ -2087,6 +2090,40 @@ static int kvm_init(MachineState *ms)
     s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_mmio_reg=
ion;
     s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesce_mmio_r=
egion;
=20
+    /*
+     * Enable KVM dirty ring if supported, otherwise fall back to
+     * dirty logging mode
+     */
+    if (s->kvm_dirty_gfn_count > 0) {
+        uint64_t ring_size;
+
+        ring_size =3D s->kvm_dirty_gfn_count * sizeof(struct kvm_dirty_gfn=
);
+
+        /* Read the max supported pages */
+        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LOG_RING);
+        if (ret > 0) {
+            if (ring_size > ret) {
+                error_report("KVM dirty GFN count %" PRIu32 " too big "
+                             "(maximum is %ld).  Please use a smaller valu=
e.",
+                             s->kvm_dirty_gfn_count,
+                             ret / sizeof(struct kvm_dirty_gfn));
+                ret =3D -EINVAL;
+                goto err;
+            }
+
+            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0, ring_s=
ize);
+            if (ret) {
+                error_report("Enabling of KVM dirty ring failed: %d. "
+                             "Suggested mininum value is 1024. "
+                             "Please also make sure it's a power of two.",=
 ret);
+                goto err;
+            }
+
+            s->kvm_dirty_ring_size =3D ring_size;
+            s->kvm_dirty_ring_enabled =3D true;
+        }
+    }
+
     kvm_memory_listener_register(s, &s->memory_listener,
                                  &address_space_memory, 0);
     memory_listener_register(&kvm_io_listener,
@@ -3047,6 +3084,33 @@ bool kvm_kernel_irqchip_split(void)
     return kvm_state->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON;
 }
=20
+static void kvm_get_dirty_gfn_count(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s =3D KVM_STATE(obj);
+    uint32_t value =3D s->kvm_dirty_gfn_count;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void kvm_set_dirty_gfn_count(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    KVMState *s =3D KVM_STATE(obj);
+    Error *error =3D NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    s->kvm_dirty_gfn_count =3D value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s =3D KVM_STATE(obj);
@@ -3054,6 +3118,8 @@ static void kvm_accel_instance_init(Object *obj)
     s->kvm_shadow_mem =3D -1;
     s->kernel_irqchip_allowed =3D true;
     s->kernel_irqchip_split =3D ON_OFF_AUTO_AUTO;
+    /* KVM dirty ring is by default off */
+    s->kvm_dirty_gfn_count =3D 0;
 }
=20
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
@@ -3075,6 +3141,12 @@ static void kvm_accel_class_init(ObjectClass *oc, vo=
id *data)
         NULL, NULL, &error_abort);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size", &error_abort);
+
+    object_class_property_add(oc, "dirty-gfn-count", "uint32",
+        kvm_get_dirty_gfn_count, kvm_set_dirty_gfn_count,
+        NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, "dirty-gfn-count",
+        "KVM dirty GFN count (=3D0 to disable dirty ring)", &error_abort);
 }
=20
 static const TypeInfo kvm_accel_type =3D {
diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0c..62e88f012c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -124,6 +124,7 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "                kernel-irqchip=3Don|off|split controls accelerated ir=
qchip support (default=3Don)\n"
     "                kvm-shadow-mem=3Dsize of KVM shadow MMU in bytes\n"
     "                tb-size=3Dn (TCG translation block cache size)\n"
+    "                dirty-gfn-count=3Dn (KVM dirty ring GFN count, defaul=
t 0)\n"
     "                thread=3Dsingle|multi (enable multi-threaded TCG)\n",=
 QEMU_ARCH_ALL)
 SRST
 ``-accel name[,prop=3Dvalue[,...]]``
@@ -158,6 +159,10 @@ SRST
         where both the back-end and front-ends support it and no
         incompatible TCG features have been enabled (e.g.
         icount/replay).
+
+    ``dirty-gfn-count=3Dn``
+        Controls the per-vcpu KVM dirty ring GFN count (=3D0 to disable).
+
 ERST
=20
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
--=20
2.24.1


