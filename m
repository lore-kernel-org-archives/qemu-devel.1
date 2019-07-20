Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA18C76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E284A2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgJMV5cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E284A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51627 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor9q-00031E-MG
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8W-0006A6-0h
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8U-00089F-Jf
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8U-00088o-Ci
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id f17so31488909wme.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VBJk++nebu5jmHNwt1imGPj0wqleJbW5DLRUX54D6/4=;
 b=OgJMV5cvE/QkBaY2XX7+62GD5t7UB7FUCxYP0kWVg9NbinL0+TIBiaE8UVN9eYhUkV
 4Ta3Zrz/qXbGIcpUeOrW05dyT7I1F9AHcaml8DMOipAQ/+0dLfzgoFkeu1xglcKqO2cp
 hAzM9gtF7QCVWUaCtka1xyj6gNZs+oGRmBMZKTio5TK9PhusQuFor/NZ7GKGyVI+hHXC
 j0vBeVRQkyJL8sqRqHeq8ubMG07r7k7U3oj2uj0SwjMm9zcW4zVBHE3vPTV0KdVTNceM
 39r1qrJ/Z4QlZEVellJvAxBj4T6e85G2sXP4P64o6T8h0Pn1IDWNCzVYPiKo9BmvXhkZ
 Ea9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VBJk++nebu5jmHNwt1imGPj0wqleJbW5DLRUX54D6/4=;
 b=LvS8ZOhEuw+QEKS4G+t9w645SKpzivpK5Iiy6lbE6boS/WVT453SGaHsGAgRlCahiM
 UtueXJvOhtSD3DJOVdyy5IetDImwgWxBM+XvgW7G79aJT3zchjWAzuDv39OKZi3gQ6g2
 mE7V1qURNiQ6ncWIll3YzeUJU5y4jsL8NCscMVoPgALgkzmJPj2n2PKks3o5iCAMVYqn
 tMNFVdJpYIEwCTW59Pn7kY/+ih0x98wPNT0vK0n+wnWDZlWmiPnlC5tnpV5ol2W5eD4S
 t/c7exn1mP4XWJVjuukDlgNP7O8cJa6nqiri7t/71I+GXJO1NkFXODCZYT9tUoydDWSg
 F9nw==
X-Gm-Message-State: APjAAAXOkuuM+oIfGOCHggkD6gQv8C8nq+geX5ZiPWzi+dYQG62D3Acj
 iW0spmYTBC3IWrWqrIPsl8Q0TYUYTBQ=
X-Google-Smtp-Source: APXvYqzsMBRceFO+BYko5tFiBxrsKzibpORqR8dUU5fsi6eJygF2HVaJdtqSefMKM60C3njSFKts8Q==
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr54303524wmc.133.1563635937141; 
 Sat, 20 Jul 2019 08:18:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:42 +0200
Message-Id: <20190720151846.7450-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 08/12] hmp: Print if memory section is
 registered with an accelerator
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds an accelerator name to the "into mtree -f" to tell the user if
a particular memory section is registered with the accelerator;
the primary user for this is KVM and such information is useful
for debugging purposes.

This adds a has_memory() callback to the accelerator class allowing any
accelerator to have a label in that memory tree dump.

Since memory sections are passed to memory listeners and get registered
in accelerators (rather than memory regions), this only prints new labels
for flatviews attached to the system address space.

An example:
 Root memory region: system
  0000000000000000-0000002fffffffff (prio 0, ram): /objects/mem0 kvm
  0000003000000000-0000005fffffffff (prio 0, ram): /objects/mem1 kvm
  0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
  0000200080000000-000020008000003f (prio 0, i/o): capabilities

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190614015237.82463-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/sysemu/accel.h |  3 +++
 memory.c               | 22 ++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 35ea3cb..f450f25 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,6 +111,13 @@ struct KVMState
     /* memory encryption */
     void *memcrypt_handle;
     int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
+
+    /* For "info mtree -f" to tell if an MR is registered in KVM */
+    int nr_as;
+    struct KVMAs {
+        KVMMemoryListener *ml;
+        AddressSpace *as;
+    } *as;
 };
 
 KVMState *kvm_state;
@@ -1159,6 +1166,14 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
     kml->listener.priority = 10;
 
     memory_listener_register(&kml->listener, as);
+
+    for (i = 0; i < s->nr_as; ++i) {
+        if (!s->as[i].as) {
+            s->as[i].as = as;
+            s->as[i].ml = kml;
+            break;
+        }
+    }
 }
 
 static MemoryListener kvm_io_listener = {
@@ -1809,6 +1824,12 @@ static int kvm_init(MachineState *ms)
         s->nr_slots = 32;
     }
 
+    s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
+    if (s->nr_as <= 1) {
+        s->nr_as = 1;
+    }
+    s->as = g_new0(struct KVMAs, s->nr_as);
+
     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
     if (mc->kvm_type) {
         type = mc->kvm_type(ms, kvm_type);
@@ -2828,11 +2849,28 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
     return r;
 }
 
+static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
+                                 hwaddr start_addr, hwaddr size)
+{
+    KVMState *kvm = KVM_STATE(ms->accelerator);
+    int i;
+
+    for (i = 0; i < kvm->nr_as; ++i) {
+        if (kvm->as[i].as == as && kvm->as[i].ml) {
+            return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
+                                                    start_addr, size);
+        }
+    }
+
+    return false;
+}
+
 static void kvm_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "KVM";
     ac->init_machine = kvm_init;
+    ac->has_memory = kvm_accel_has_memory;
     ac->allowed = &kvm_allowed;
 }
 
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 81293cd..89ce57e 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -25,6 +25,7 @@
 
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
+#include "exec/hwaddr.h"
 
 typedef struct AccelState {
     /*< private >*/
@@ -39,6 +40,8 @@ typedef struct AccelClass {
     const char *name;
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
+    bool (*has_memory)(MachineState *ms, AddressSpace *as,
+                       hwaddr start_addr, hwaddr size);
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
diff --git a/memory.c b/memory.c
index d4579bb..5d8c9a9 100644
--- a/memory.c
+++ b/memory.c
@@ -30,7 +30,9 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
+#include "sysemu/accel.h"
 #include "hw/qdev-properties.h"
+#include "hw/boards.h"
 #include "migration/vmstate.h"
 
 //#define DEBUG_UNASSIGNED
@@ -2999,6 +3001,8 @@ struct FlatViewInfo {
     int counter;
     bool dispatch_tree;
     bool owner;
+    AccelClass *ac;
+    const char *ac_name;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -3061,6 +3065,17 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         if (fvi->owner) {
             mtree_print_mr_owner(mr);
         }
+
+        if (fvi->ac) {
+            for (i = 0; i < fv_address_spaces->len; ++i) {
+                as = g_array_index(fv_address_spaces, AddressSpace*, i);
+                if (fvi->ac->has_memory(current_machine, as,
+                                        int128_get64(range->addr.start),
+                                        MR_SIZE(range->addr.size) + 1)) {
+                    qemu_printf(" %s", fvi->ac_name);
+                }
+            }
+        }
         qemu_printf("\n");
         range++;
     }
@@ -3101,6 +3116,13 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
         };
         GArray *fv_address_spaces;
         GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
+        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+
+        if (ac->has_memory) {
+            fvi.ac = ac;
+            fvi.ac_name = current_machine->accel ? current_machine->accel :
+                object_class_get_name(OBJECT_CLASS(ac));
+        }
 
         /* Gather all FVs in one table */
         QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-- 
1.8.3.1



