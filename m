Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F473C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CAF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcEXyIjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CAF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvliV-0002yA-7S
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgZ-0001Xk-AH
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlgV-0005kI-4S
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGGrg1tV6O9KwPzHb7vQjRfsLFswx+NckauSw3FXcr0=;
 b=TcEXyIjtdWHOQgUSs7CeuYYuE1V6HxuYr0s5DTRU6f6XiTkQXvHJkdL/elraVatnOVqlwG
 u/mLqkZBWixK6H9NE9Q9cLpVoL86GOvTesS+3M+rlwFcjyOWknH+z67dwbgFIxXN85/We7
 VIeTvDTzddlBVEeFD5ZOB1sG8hQwHiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-hYuYOD3WOSuYGlRXWxMiXQ-1; Wed, 15 Jul 2020 13:59:02 -0400
X-MC-Unique: hYuYOD3WOSuYGlRXWxMiXQ-1
Received: by mail-wm1-f72.google.com with SMTP id v6so1454507wmg.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TGGrg1tV6O9KwPzHb7vQjRfsLFswx+NckauSw3FXcr0=;
 b=a+10UHTjZJ4AXQuAJsaWQh7gJY3lM9uu0vxMQAnDeAG8tuXA6NStfMLGLfvSslEQTZ
 BITLhzv2rZNxDZw/0w6SoULSaXsBUxYepdC5h2Aetc0NgKBkEFHIW9bq+iHYD6hNoDFv
 FfattOWn96/sc79Y0EKgzqi4+cU280SOWuFIJtLHVKPItKHD6K6kVZJhxC5mAEFs8Tmd
 LNqQCRV9GBPyzevnLjwYGYxmYqfg0ozK2HutZmjtRZoDmw+ewlSsbC4FmmXce25icOFg
 1jS4H7bOKrweXQxUhCrlQH/lHpEWtDEplfQdxcPlXtHTac/5vcm0XHemt+Bkteojt9/6
 B66A==
X-Gm-Message-State: AOAM533XZGSTDuEQZ4hqOrxqBsSux9sBpJ6r8p55w8oo9cnQ4oTkyVQp
 JvOP84jlRjwy4fabi/lME8IYnN8bpcBuppeUoZh/gHfZ0G2wmYk3Kn97jmzmRotWEH0BaepscvK
 ZzHxfVCakjnfUCgQ=
X-Received: by 2002:a5d:6045:: with SMTP id j5mr520560wrt.209.1594835939082;
 Wed, 15 Jul 2020 10:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynVCxrnwiF+hdtgSS9QE8fANDibtimSsCzAxRSyVbtVCax3UFSgTPToJOGlmN9ztpKEKzrrA==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr520463wrt.209.1594835937363;
 Wed, 15 Jul 2020 10:58:57 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id s203sm4676316wms.32.2020.07.15.10.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:58:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 4/5] qom: Let ObjectPropertyGet functions return a
 boolean value
Date: Wed, 15 Jul 2020 19:58:34 +0200
Message-Id: <20200715175835.27744-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200715175835.27744-1-philmd@redhat.com>
References: <20200715175835.27744-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commits 1c94a35164..7b3cb8037c simplified the error propagation.

Similarly to commit 73ac1aac39 ("qdev: Make functions taking
Error ** return bool, not void") let the ObjectPropertyGet
functions return a boolean value, not void.

See commit e3fe3988d7 ("error: Document Error API usage rules")
for rationale.

Cc: armbru@redhat.com
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Sorry I don't see how to split that patch without using
ugly casts in the middle.
---
 include/qom/object.h             |  4 +-
 accel/kvm/kvm-all.c              |  4 +-
 accel/tcg/tcg-all.c              |  4 +-
 authz/list.c                     |  4 +-
 backends/cryptodev.c             |  4 +-
 backends/hostmem-file.c          |  4 +-
 backends/hostmem-memfd.c         |  4 +-
 backends/hostmem.c               | 13 +++---
 backends/tpm/tpm_util.c          |  4 +-
 block/throttle-groups.c          |  8 ++--
 bootdevice.c                     |  4 +-
 chardev/char-socket.c            |  4 +-
 crypto/secret_keyring.c          |  5 +-
 hw/acpi/ich9.c                   |  4 +-
 hw/arm/virt.c                    |  4 +-
 hw/block/xen-block.c             |  6 +--
 hw/core/machine.c                |  4 +-
 hw/core/qdev-properties-system.c | 20 ++++----
 hw/core/qdev-properties.c        | 80 ++++++++++++++++----------------
 hw/core/qdev.c                   |  5 +-
 hw/cpu/core.c                    |  8 ++--
 hw/gpio/aspeed_gpio.c            |  8 ++--
 hw/i386/microvm.c                | 12 ++---
 hw/i386/pc.c                     | 12 ++---
 hw/i386/x86.c                    |  8 ++--
 hw/ide/qdev.c                    |  4 +-
 hw/intc/apic_common.c            |  4 +-
 hw/mem/nvdimm.c                  |  8 ++--
 hw/mem/pc-dimm.c                 |  6 +--
 hw/misc/aspeed_sdmc.c            |  4 +-
 hw/misc/pca9552.c                |  8 ++--
 hw/misc/tmp105.c                 |  4 +-
 hw/misc/tmp421.c                 |  8 ++--
 hw/net/ne2000-isa.c              |  4 +-
 hw/pci-host/i440fx.c             | 16 +++----
 hw/pci-host/q35.c                | 16 +++----
 hw/ppc/spapr_caps.c              | 14 +++---
 hw/ppc/spapr_drc.c               | 21 +++++----
 hw/riscv/sifive_u.c              |  4 +-
 hw/s390x/css.c                   |  4 +-
 hw/s390x/s390-pci-bus.c          |  4 +-
 hw/usb/dev-storage.c             |  4 +-
 hw/vfio/pci-quirks.c             | 14 +++---
 hw/virtio/virtio-balloon.c       | 16 ++++---
 hw/virtio/virtio-mem.c           | 12 ++---
 iothread.c                       |  4 +-
 net/colo-compare.c               |  8 ++--
 net/dump.c                       |  4 +-
 net/filter-buffer.c              |  4 +-
 qom/object.c                     | 65 +++++++++++++++-----------
 softmmu/memory.c                 | 14 +++---
 target/arm/cpu64.c               | 14 +++---
 target/i386/cpu.c                | 48 +++++++++++--------
 target/ppc/compat.c              |  4 +-
 target/s390x/cpu.c               | 11 +++--
 target/s390x/cpu_models.c        | 14 +++---
 target/sparc/cpu.c               |  4 +-
 57 files changed, 325 insertions(+), 281 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e9496ba970..7ba2172932 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -333,9 +333,11 @@ typedef void (ObjectPropertySet)(Object *obj,
  * @opaque: the object property opaque
  * @errp: a pointer to an Error that is filled if getting fails.
  *
+ * Return true on success, false on failure.
+ *
  * Called when trying to get a property.
  */
-typedef void (ObjectPropertyGet)(Object *obj,
+typedef bool (ObjectPropertyGet)(Object *obj,
                                  Visitor *v,
                                  const char *name,
                                  void *opaque,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..dfbc60fd6f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3098,14 +3098,14 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
     return false;
 }
 
-static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
+static bool kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
     int64_t value = s->kvm_shadow_mem;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index eace2c113b..114c149744 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -167,14 +167,14 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     }
 }
 
-static void tcg_get_tb_size(Object *obj, Visitor *v,
+static bool tcg_get_tb_size(Object *obj, Visitor *v,
                             const char *name, void *opaque,
                             Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
     uint32_t value = s->tb_size;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void tcg_set_tb_size(Object *obj, Visitor *v,
diff --git a/authz/list.c b/authz/list.c
index 8e904bfc93..9a195defab 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -83,13 +83,13 @@ qauthz_list_prop_get_policy(Object *obj,
 }
 
 
-static void
+static bool
 qauthz_list_prop_get_rules(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     QAuthZList *lauthz = QAUTHZ_LIST(obj);
 
-    visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
+    return visit_type_QAuthZListRuleList(v, name, &lauthz->rules, errp);
 }
 
 static void
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index ada4ebe78b..e0c5aa61ac 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -139,14 +139,14 @@ int cryptodev_backend_crypto_operation(
     return -VIRTIO_CRYPTO_ERR;
 }
 
-static void
+static bool
 cryptodev_backend_get_queues(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     CryptoDevBackend *backend = CRYPTODEV_BACKEND(obj);
     uint32_t value = backend->conf.peers.queues;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 5b819020b4..2a1e0e8dc5 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -94,14 +94,14 @@ static void file_memory_backend_set_discard_data(Object *o, bool value,
     MEMORY_BACKEND_FILE(o)->discard_data = value;
 }
 
-static void file_memory_backend_get_align(Object *o, Visitor *v,
+static bool file_memory_backend_get_align(Object *o, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
     uint64_t val = fb->align;
 
-    visit_type_size(v, name, &val, errp);
+    return visit_type_size(v, name, &val, errp);
 }
 
 static void file_memory_backend_set_align(Object *o, Visitor *v,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 4c040a7541..278bdb3308 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -95,14 +95,14 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
     m->hugetlbsize = value;
 }
 
-static void
+static bool
 memfd_backend_get_hugetlbsize(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
     uint64_t value = m->hugetlbsize;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static bool
diff --git a/backends/hostmem.c b/backends/hostmem.c
index c614f1bdc1..230a76571d 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -39,14 +39,14 @@ host_memory_backend_get_name(HostMemoryBackend *backend)
     return object_get_canonical_path(OBJECT(backend));
 }
 
-static void
+static bool
 host_memory_backend_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     uint64_t value = backend->size;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void
@@ -74,7 +74,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     backend->size = value;
 }
 
-static void
+static bool
 host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -104,7 +104,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
     } while (true);
 
 ret:
-    visit_type_uint16List(v, name, &host_nodes, errp);
+    return visit_type_uint16List(v, name, &host_nodes, errp);
 }
 
 static void
@@ -239,11 +239,12 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
     }
 }
 
-static void host_memory_backend_get_prealloc_threads(Object *obj, Visitor *v,
+static bool host_memory_backend_get_prealloc_threads(Object *obj, Visitor *v,
     const char *name, void *opaque, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    visit_type_uint32(v, name, &backend->prealloc_threads, errp);
+
+    return visit_type_uint32(v, name, &backend->prealloc_threads, errp);
 }
 
 static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 235b006498..66103b8d63 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -32,7 +32,7 @@
 
 /* tpm backend property */
 
-static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -40,7 +40,7 @@ static void get_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
     g_autofree char *p;
 
     p = g_strdup(*be ? (*be)->id : "");
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 03a53c89ea..8d5fd02b1d 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -852,7 +852,7 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
     }
 }
 
-static void throttle_group_get(Object *obj, Visitor *v, const char *name,
+static bool throttle_group_get(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
@@ -876,7 +876,7 @@ static void throttle_group_get(Object *obj, Visitor *v, const char *name,
         break;
     }
 
-    visit_type_int64(v, name, &value, errp);
+    return visit_type_int64(v, name, &value, errp);
 }
 
 static void throttle_group_set_limits(Object *obj, Visitor *v,
@@ -907,7 +907,7 @@ unlock:
     return;
 }
 
-static void throttle_group_get_limits(Object *obj, Visitor *v,
+static bool throttle_group_get_limits(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
@@ -922,7 +922,7 @@ static void throttle_group_get_limits(Object *obj, Visitor *v,
 
     throttle_config_to_limits(&cfg, argp);
 
-    visit_type_ThrottleLimits(v, name, &argp, errp);
+    return visit_type_ThrottleLimits(v, name, &argp, errp);
 }
 
 static bool throttle_group_can_be_deleted(UserCreatable *uc)
diff --git a/bootdevice.c b/bootdevice.c
index add4e3d2d1..227c183c06 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -283,11 +283,11 @@ typedef struct {
     DeviceState *dev;
 } BootIndexProperty;
 
-static void device_get_bootindex(Object *obj, Visitor *v, const char *name,
+static bool device_get_bootindex(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     BootIndexProperty *prop = opaque;
-    visit_type_int32(v, name, prop->bootindex, errp);
+    return visit_type_int32(v, name, prop->bootindex, errp);
 }
 
 static void device_set_bootindex(Object *obj, Visitor *v, const char *name,
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ef62dbf3d7..12468dbba1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1462,13 +1462,13 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->addr = addr;
 }
 
-static void
+static bool
 char_socket_get_addr(Object *obj, Visitor *v, const char *name,
                      void *opaque, Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
-    visit_type_SocketAddress(v, name, &s->addr, errp);
+    return visit_type_SocketAddress(v, name, &s->addr, errp);
 }
 
 static bool
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 8bfc58ebf4..55459aab0b 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -91,14 +91,15 @@ qcrypto_secret_prop_set_key(Object *obj, Visitor *v,
 }
 
 
-static void
+static bool
 qcrypto_secret_prop_get_key(Object *obj, Visitor *v,
                             const char *name, void *opaque,
                             Error **errp)
 {
     QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(obj);
     int32_t value = secret->serial;
-    visit_type_int32(v, name, &value, errp);
+
+    return visit_type_int32(v, name, &value, errp);
 }
 
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 6a19070cec..93d48231ba 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -313,13 +313,13 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
     }
 }
 
-static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
+static bool ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     ICH9LPCPMRegs *pm = opaque;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static bool ich9_pm_get_memory_hotplug_support(Object *obj, Error **errp)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9005dae356..3282e1fc3a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2030,13 +2030,13 @@ bool virt_is_acpi_enabled(VirtMachineState *vms)
     return true;
 }
 
-static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
+static bool virt_get_acpi(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     OnOffAuto acpi = vms->acpi;
 
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return visit_type_OnOffAuto(v, name, &acpi, errp);
 }
 
 static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 8c23b895d9..49b2133efc 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -332,7 +332,7 @@ static char *disk_to_vbd_name(unsigned int disk)
     return name;
 }
 
-static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
+static bool xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -362,10 +362,10 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
     }
     default:
         error_setg(errp, "invalid vdev type");
-        return;
+        return false;
     }
 
-    visit_type_str(v, name, &str, errp);
+    return visit_type_str(v, name, &str, errp);
 }
 
 static int vbd_name_to_disk(const char *name, const char **endp,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index eb267b828d..af4279c6b7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -275,14 +275,14 @@ static void machine_set_dumpdtb(Object *obj, const char *value, Error **errp)
     ms->dumpdtb = g_strdup(value);
 }
 
-static void machine_get_phandle_start(Object *obj, Visitor *v,
+static bool machine_get_phandle_start(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
     MachineState *ms = MACHINE(obj);
     int64_t value = ms->phandle_start;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void machine_set_phandle_start(Object *obj, Visitor *v,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 28682eda31..aee2e906f2 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -49,7 +49,7 @@ static bool check_prop_still_unset(DeviceState *dev, const char *name,
 
 /* --- drive --- */
 
-static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -69,9 +69,9 @@ static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
     } else {
         value = "";
     }
-
     p = g_strdup(value);
-    visit_type_str(v, name, &p, errp);
+
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_drive_helper(Object *obj, Visitor *v, const char *name,
@@ -207,7 +207,7 @@ const PropertyInfo qdev_prop_drive_iothread = {
 
 /* --- character device --- */
 
-static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -215,7 +215,8 @@ static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
     g_autofree char *p;
 
     p = g_strdup(be->chr && be->chr->label ? be->chr->label : "");
-    visit_type_str(v, name, &p, errp);
+
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -279,7 +280,7 @@ const PropertyInfo qdev_prop_chr = {
 };
 
 /* --- netdev device --- */
-static void get_netdev(Object *obj, Visitor *v, const char *name,
+static bool get_netdev(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -288,7 +289,8 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
     g_autofree char *p;
 
     p = g_strdup(peers_ptr->ncs[0] ? peers_ptr->ncs[0]->name : "");
-    visit_type_str(v, name, &p, errp);
+
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_netdev(Object *obj, Visitor *v, const char *name,
@@ -359,7 +361,7 @@ const PropertyInfo qdev_prop_netdev = {
 
 
 /* --- audiodev --- */
-static void get_audiodev(Object *obj, Visitor *v, const char* name,
+static bool get_audiodev(Object *obj, Visitor *v, const char* name,
                          void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -367,7 +369,7 @@ static void get_audiodev(Object *obj, Visitor *v, const char* name,
     QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
     g_autofree char *p = g_strdup(audio_get_id(card));
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_audiodev(Object *obj, Visitor *v, const char* name,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index d5f5aa150b..fa74f2acb1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,14 +51,14 @@ void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
     return ptr;
 }
 
-static void get_enum(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_enum(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     int *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
+    return visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
 }
 
 static void set_enum(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -101,7 +101,7 @@ static void bit_prop_set(DeviceState *dev, Property *props, bool val)
     }
 }
 
-static void prop_get_bit(Object *obj, Visitor *v, const char *name,
+static bool prop_get_bit(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -109,7 +109,7 @@ static void prop_get_bit(Object *obj, Visitor *v, const char *name,
     uint32_t *p = qdev_get_prop_ptr(dev, prop);
     bool value = (*p & qdev_get_prop_mask(prop)) != 0;
 
-    visit_type_bool(v, name, &value, errp);
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void prop_set_bit(Object *obj, Visitor *v, const char *name,
@@ -162,7 +162,7 @@ static void bit64_prop_set(DeviceState *dev, Property *props, bool val)
     }
 }
 
-static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
+static bool prop_get_bit64(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -170,7 +170,7 @@ static void prop_get_bit64(Object *obj, Visitor *v, const char *name,
     uint64_t *p = qdev_get_prop_ptr(dev, prop);
     bool value = (*p & qdev_get_prop_mask64(prop)) != 0;
 
-    visit_type_bool(v, name, &value, errp);
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
@@ -201,14 +201,14 @@ const PropertyInfo qdev_prop_bit64 = {
 
 /* --- bool --- */
 
-static void get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_bool(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     bool *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_bool(v, name, ptr, errp);
+    return visit_type_bool(v, name, ptr, errp);
 }
 
 static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -235,14 +235,14 @@ const PropertyInfo qdev_prop_bool = {
 
 /* --- 8bit integer --- */
 
-static void get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_uint8(v, name, ptr, errp);
+    return visit_type_uint8(v, name, ptr, errp);
 }
 
 static void set_uint8(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -279,14 +279,14 @@ const PropertyInfo qdev_prop_uint8 = {
 
 /* --- 16bit integer --- */
 
-static void get_uint16(Object *obj, Visitor *v, const char *name,
+static bool get_uint16(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint16_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_uint16(v, name, ptr, errp);
+    return visit_type_uint16(v, name, ptr, errp);
 }
 
 static void set_uint16(Object *obj, Visitor *v, const char *name,
@@ -313,14 +313,14 @@ const PropertyInfo qdev_prop_uint16 = {
 
 /* --- 32bit integer --- */
 
-static void get_uint32(Object *obj, Visitor *v, const char *name,
+static bool get_uint32(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_uint32(v, name, ptr, errp);
+    return visit_type_uint32(v, name, ptr, errp);
 }
 
 static void set_uint32(Object *obj, Visitor *v, const char *name,
@@ -338,14 +338,14 @@ static void set_uint32(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, ptr, errp);
 }
 
-static void get_int32(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_int32(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     int32_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_int32(v, name, ptr, errp);
+    return visit_type_int32(v, name, ptr, errp);
 }
 
 static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -379,14 +379,14 @@ const PropertyInfo qdev_prop_int32 = {
 
 /* --- 64bit integer --- */
 
-static void get_uint64(Object *obj, Visitor *v, const char *name,
+static bool get_uint64(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_uint64(v, name, ptr, errp);
+    return visit_type_uint64(v, name, ptr, errp);
 }
 
 static void set_uint64(Object *obj, Visitor *v, const char *name,
@@ -404,14 +404,14 @@ static void set_uint64(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, ptr, errp);
 }
 
-static void get_int64(Object *obj, Visitor *v, const char *name,
+static bool get_int64(Object *obj, Visitor *v, const char *name,
                       void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     int64_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_int64(v, name, ptr, errp);
+    return visit_type_int64(v, name, ptr, errp);
 }
 
 static void set_int64(Object *obj, Visitor *v, const char *name,
@@ -451,7 +451,7 @@ static void release_string(Object *obj, const char *name, void *opaque)
     g_free(*(char **)qdev_get_prop_ptr(DEVICE(obj), prop));
 }
 
-static void get_string(Object *obj, Visitor *v, const char *name,
+static bool get_string(Object *obj, Visitor *v, const char *name,
                        void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -460,10 +460,10 @@ static void get_string(Object *obj, Visitor *v, const char *name,
 
     if (!*ptr) {
         char *str = (char *)"";
-        visit_type_str(v, name, &str, errp);
-    } else {
-        visit_type_str(v, name, ptr, errp);
+        return visit_type_str(v, name, &str, errp);
     }
+
+    return visit_type_str(v, name, ptr, errp);
 }
 
 static void set_string(Object *obj, Visitor *v, const char *name,
@@ -500,7 +500,7 @@ const PropertyInfo qdev_prop_string = {
  *   01:02:03:04:05:06
  *   01-02-03-04-05-06
  */
-static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -513,7 +513,7 @@ static void get_mac(Object *obj, Visitor *v, const char *name, void *opaque,
              mac->a[0], mac->a[1], mac->a[2],
              mac->a[3], mac->a[4], mac->a[5]);
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -575,7 +575,7 @@ const PropertyInfo qdev_prop_macaddr = {
  *   where low/high addresses are uint64_t in hexadecimal
  *   and type is a non-negative decimal integer
  */
-static void get_reserved_region(Object *obj, Visitor *v, const char *name,
+static bool get_reserved_region(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -586,7 +586,7 @@ static void get_reserved_region(Object *obj, Visitor *v, const char *name,
     p = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
                         rr->low, rr->high, rr->type);
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 static void set_reserved_region(Object *obj, Visitor *v, const char *name,
@@ -800,7 +800,7 @@ const PropertyInfo qdev_prop_pci_devfn = {
 
 /* --- 32bit unsigned int 'size' type --- */
 
-static void get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
                        Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -808,7 +808,7 @@ static void get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
     uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
     uint64_t value = *ptr;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -906,7 +906,7 @@ const PropertyInfo qdev_prop_blocksize = {
 
 /* --- pci host address --- */
 
-static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
+static bool get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -926,7 +926,7 @@ static void get_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
         assert(rc == sizeof(buffer) - 1);
     }
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 /*
@@ -1018,7 +1018,7 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
 
 /* --- UUID --- */
 
-static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -1029,7 +1029,7 @@ static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
 
     qemu_uuid_unparse(uuid, buffer);
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 #define UUID_VALUE_AUTO        "auto"
@@ -1358,14 +1358,14 @@ void qdev_prop_set_globals(DeviceState *dev)
 
 /* --- 64bit unsigned int 'size' type --- */
 
-static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
+static bool get_size(Object *obj, Visitor *v, const char *name, void *opaque,
                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint64_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_size(v, name, ptr, errp);
+    return visit_type_size(v, name, ptr, errp);
 }
 
 static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -1413,7 +1413,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
 
 /* --- PCIELinkSpeed 2_5/5/8/16 -- */
 
-static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+static bool get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -1439,7 +1439,7 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+    return visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -1490,7 +1490,7 @@ const PropertyInfo qdev_prop_pcie_link_speed = {
 
 /* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
 
-static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+static bool get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -1525,7 +1525,7 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+    return visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 01796823b4..85c8ec3ddb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -726,7 +726,7 @@ char *qdev_get_dev_path(DeviceState *dev)
  * Legacy property handling
  */
 
-static void qdev_get_legacy_property(Object *obj, Visitor *v,
+static bool qdev_get_legacy_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
@@ -737,7 +737,8 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
     char *ptr = buffer;
 
     prop->info->print(dev, prop, buffer, sizeof(buffer));
-    visit_type_str(v, name, &ptr, errp);
+
+    return visit_type_str(v, name, &ptr, errp);
 }
 
 /**
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 3a659291ea..93c0c4d44c 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -15,13 +15,13 @@
 #include "sysemu/cpus.h"
 #include "hw/boards.h"
 
-static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
+static bool core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
     int64_t value = core->core_id;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
@@ -42,13 +42,13 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
     core->core_id = value;
 }
 
-static void core_prop_get_nr_threads(Object *obj, Visitor *v, const char *name,
+static bool core_prop_get_nr_threads(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
     int64_t value = core->nr_threads;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void core_prop_set_nr_threads(Object *obj, Visitor *v, const char *name,
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 985a259e05..d91b81758d 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -726,7 +726,7 @@ static int get_set_idx(AspeedGPIOState *s, const char *group, int *group_idx)
     return -1;
 }
 
-static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
+static bool aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     int pin = 0xfff;
@@ -739,17 +739,17 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
         /* 1.8V gpio */
         if (sscanf(name, "gpio%3[18A-E]%1d", group, &pin) != 2) {
             error_setg(errp, "%s: error reading %s", __func__, name);
-            return;
+            return false;
         }
     }
     set_idx = get_set_idx(s, group, &group_idx);
     if (set_idx == -1) {
         error_setg(errp, "%s: invalid group %s", __func__, group);
-        return;
+        return false;
     }
     pin =  pin + group_idx * GPIOS_PER_GROUP;
     level = aspeed_gpio_get_pin_level(s, set_idx, pin);
-    visit_type_bool(v, name, &level, errp);
+    return visit_type_bool(v, name, &level, errp);
 }
 
 static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 81d0888930..170b5077dc 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -339,13 +339,13 @@ static void microvm_machine_reset(MachineState *machine)
     }
 }
 
-static void microvm_machine_get_pic(Object *obj, Visitor *v, const char *name,
+static bool microvm_machine_get_pic(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
     OnOffAuto pic = mms->pic;
 
-    visit_type_OnOffAuto(v, name, &pic, errp);
+    return visit_type_OnOffAuto(v, name, &pic, errp);
 }
 
 static void microvm_machine_set_pic(Object *obj, Visitor *v, const char *name,
@@ -356,13 +356,13 @@ static void microvm_machine_set_pic(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &mms->pic, errp);
 }
 
-static void microvm_machine_get_pit(Object *obj, Visitor *v, const char *name,
+static bool microvm_machine_get_pit(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
     OnOffAuto pit = mms->pit;
 
-    visit_type_OnOffAuto(v, name, &pit, errp);
+    return visit_type_OnOffAuto(v, name, &pit, errp);
 }
 
 static void microvm_machine_set_pit(Object *obj, Visitor *v, const char *name,
@@ -373,13 +373,13 @@ static void microvm_machine_set_pit(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &mms->pit, errp);
 }
 
-static void microvm_machine_get_rtc(Object *obj, Visitor *v, const char *name,
+static bool microvm_machine_get_rtc(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
     OnOffAuto rtc = mms->rtc;
 
-    visit_type_OnOffAuto(v, name, &rtc, errp);
+    return visit_type_OnOffAuto(v, name, &rtc, errp);
 }
 
 static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char *name,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..a95252f6c8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1758,7 +1758,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void
+static bool
 pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
@@ -1770,16 +1770,16 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
         value = memory_region_size(&ms->device_memory->mr);
     }
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
-static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
+static bool pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
     OnOffAuto vmport = pcms->vmport;
 
-    visit_type_OnOffAuto(v, name, &vmport, errp);
+    return visit_type_OnOffAuto(v, name, &vmport, errp);
 }
 
 static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
@@ -1832,14 +1832,14 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit_enabled = value;
 }
 
-static void pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
+static bool pc_machine_get_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
     uint64_t value = pcms->max_ram_below_4g;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 67bee1bcb8..583f4e4e52 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -870,13 +870,13 @@ bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
     return false;
 }
 
-static void x86_machine_get_smm(Object *obj, Visitor *v, const char *name,
+static bool x86_machine_get_smm(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
     OnOffAuto smm = x86ms->smm;
 
-    visit_type_OnOffAuto(v, name, &smm, errp);
+    return visit_type_OnOffAuto(v, name, &smm, errp);
 }
 
 static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
@@ -895,13 +895,13 @@ bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
     return true;
 }
 
-static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
+static bool x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
     OnOffAuto acpi = x86ms->acpi;
 
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return visit_type_OnOffAuto(v, name, &acpi, errp);
 }
 
 static void x86_machine_set_acpi(Object *obj, Visitor *v, const char *name,
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..a404596b70 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -230,12 +230,12 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
                          dev->conf.lsecs);
 }
 
-static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
+static bool ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     IDEDevice *d = IDE_DEVICE(obj);
 
-    visit_type_int32(v, name, &d->conf.bootindex, errp);
+    return visit_type_int32(v, name, &d->conf.bootindex, errp);
 }
 
 static void ide_dev_set_bootindex(Object *obj, Visitor *v, const char *name,
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 81addd6390..c428f96a21 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -424,14 +424,14 @@ static Property apic_properties_common[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
+static bool apic_common_get_id(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     APICCommonState *s = APIC_COMMON(obj);
     uint32_t value;
 
     value = s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id : s->id;
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index b55de7dbe1..8b7940ca08 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -32,13 +32,13 @@
 #include "hw/mem/memory-device.h"
 #include "sysemu/hostmem.h"
 
-static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
+static bool nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(obj);
     uint64_t value = nvdimm->label_size;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
@@ -65,7 +65,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     nvdimm->label_size = value;
 }
 
-static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
+static bool nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(obj);
@@ -73,7 +73,7 @@ static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
 
     value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
 
-    visit_type_str(v, name, &value, errp);
+    return visit_type_str(v, name, &value, errp);
 }
 
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9d3f0b9691..d4f2dd69d7 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -147,7 +147,7 @@ static Property pc_dimm_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
+static bool pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     Error *local_err = NULL;
@@ -156,10 +156,10 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     value = memory_device_get_region_size(MEMORY_DEVICE(obj), &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        return false;
     }
 
-    visit_type_uint64(v, name, &value, errp);
+    return visit_type_uint64(v, name, &value, errp);
 }
 
 static void pc_dimm_init(Object *obj)
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0737d8de81..7df5797689 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -208,13 +208,13 @@ static void aspeed_sdmc_reset(DeviceState *dev)
     s->regs[R_CONF] = asc->compute_conf(s, 0);
 }
 
-static void aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *name,
+static bool aspeed_sdmc_get_ram_size(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
     AspeedSDMCState *s = ASPEED_SDMC(obj);
     int64_t value = s->ram_size;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index e4ccdeaf78..c6e25a7ef3 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -249,7 +249,7 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
+static bool pca955x_get_led(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
@@ -260,11 +260,11 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
     rc = sscanf(name, "led%2d", &led);
     if (rc != 1) {
         error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
+        return false;
     }
     if (led < 0 || led > k->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
-        return;
+        return false;
     }
     /*
      * Get the LSx register as the qom interface should expose the device
@@ -273,7 +273,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
      */
     reg = PCA9552_LS0 + led / 4;
     state = (pca955x_read(s, reg) >> (led % 8)) & 0x3;
-    visit_type_str(v, name, (char **)&led_state[state], errp);
+    return visit_type_str(v, name, (char **)&led_state[state], errp);
 }
 
 /*
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index b47120492a..af55ad7996 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -56,13 +56,13 @@ static void tmp105_alarm_update(TMP105State *s)
     tmp105_interrupt_update(s);
 }
 
-static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
+static bool tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP105State *s = TMP105(obj);
     int64_t value = s->temperature * 1000 / 256;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 /* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 49abe2d246..5c8ca3dc51 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -110,7 +110,7 @@ typedef struct TMP421Class {
 static const int32_t mins[2] = { -40000, -55000 };
 static const int32_t maxs[2] = { 127000, 150000 };
 
-static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
+static bool tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP421State *s = TMP421(obj);
@@ -121,17 +121,17 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
 
     if (sscanf(name, "temperature%d", &tempid) != 1) {
         error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
-        return;
+        return false;
     }
 
     if (tempid >= 4 || tempid < 0) {
         error_setg(errp, "error reading %s", name);
-        return;
+        return false;
     }
 
     value = ((s->temperature[tempid] - offset) * 1000 + 128) / 256;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 /* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index a878056426..4b49438e67 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -94,14 +94,14 @@ static void isa_ne2000_class_initfn(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
 
-static void isa_ne2000_get_bootindex(Object *obj, Visitor *v,
+static bool isa_ne2000_get_bootindex(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
     ISANE2000State *isa = ISA_NE2000(obj);
     NE2000State *s = &isa->ne2000;
 
-    visit_type_int32(v, name, &s->c.bootindex, errp);
+    return visit_type_int32(v, name, &s->c.bootindex, errp);
 }
 
 static void isa_ne2000_set_bootindex(Object *obj, Visitor *v,
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 8ed2417f0c..5be78b46c4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -118,7 +118,7 @@ static const VMStateDescription vmstate_i440fx = {
     }
 };
 
-static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
+static bool i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
                                               const char *name, void *opaque,
                                               Error **errp)
 {
@@ -129,10 +129,10 @@ static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
     val64 = range_is_empty(&s->pci_hole) ? 0 : range_lob(&s->pci_hole);
     value = val64;
     assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
-static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
+static bool i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
 {
@@ -143,7 +143,7 @@ static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
     val64 = range_is_empty(&s->pci_hole) ? 0 : range_upb(&s->pci_hole) + 1;
     value = val64;
     assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 /*
@@ -168,13 +168,13 @@ static uint64_t i440fx_pcihost_get_pci_hole64_start_value(Object *obj)
     return value;
 }
 
-static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
+static bool i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
                                                 const char *name,
                                                 void *opaque, Error **errp)
 {
     uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
 
-    visit_type_uint64(v, name, &hole64_start, errp);
+    return visit_type_uint64(v, name, &hole64_start, errp);
 }
 
 /*
@@ -183,7 +183,7 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
  * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
  * that can be configured by the user.
  */
-static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
+static bool i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
                                               const char *name, void *opaque,
                                               Error **errp)
 {
@@ -199,7 +199,7 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
     if (s->pci_hole64_fix && value < hole64_end) {
         value = hole64_end;
     }
-    visit_type_uint64(v, name, &value, errp);
+    return visit_type_uint64(v, name, &value, errp);
 }
 
 static void i440fx_pcihost_initfn(Object *obj)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f..7183c7dc23 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -79,7 +79,7 @@ static const char *q35_host_root_bus_path(PCIHostState *host_bridge,
     return "0000:00";
 }
 
-static void q35_host_get_pci_hole_start(Object *obj, Visitor *v,
+static bool q35_host_get_pci_hole_start(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
@@ -91,10 +91,10 @@ static void q35_host_get_pci_hole_start(Object *obj, Visitor *v,
         ? 0 : range_lob(&s->mch.pci_hole);
     value = val64;
     assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
-static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
+static bool q35_host_get_pci_hole_end(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
@@ -106,7 +106,7 @@ static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
         ? 0 : range_upb(&s->mch.pci_hole) + 1;
     value = val64;
     assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 /*
@@ -131,13 +131,13 @@ static uint64_t q35_host_get_pci_hole64_start_value(Object *obj)
     return value;
 }
 
-static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
+static bool q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
     uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
 
-    visit_type_uint64(v, name, &hole64_start, errp);
+    return visit_type_uint64(v, name, &hole64_start, errp);
 }
 
 /*
@@ -146,7 +146,7 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
  * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
  * that can be configured by the user.
  */
-static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
+static bool q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
@@ -162,7 +162,7 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
     if (s->pci_hole64_fix && value < hole64_end) {
         value = hole64_end;
     }
-    visit_type_uint64(v, name, &value, errp);
+    return visit_type_uint64(v, name, &value, errp);
 }
 
 /*
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index cbc09b24b6..c72c33cc02 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -70,14 +70,14 @@ typedef struct SpaprCapabilityInfo {
     bool (*migrate_needed)(void *opaque);
 } SpaprCapabilityInfo;
 
-static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
+static bool spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     SpaprCapabilityInfo *cap = opaque;
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
     bool value = spapr_get_cap(spapr, cap->index) == SPAPR_CAP_ON;
 
-    visit_type_bool(v, name, &value, errp);
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
@@ -96,7 +96,7 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
 }
 
 
-static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
+static bool spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     SpaprCapabilityInfo *cap = opaque;
@@ -106,12 +106,12 @@ static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *name,
 
     if (value >= cap->possible->num) {
         error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->name);
-        return;
+        return false;
     }
 
     val = g_strdup(cap->possible->vals[value]);
 
-    visit_type_str(v, name, &val, errp);
+    return visit_type_str(v, name, &val, errp);
 }
 
 static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
@@ -144,7 +144,7 @@ out:
     g_free(val);
 }
 
-static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char *name,
+static bool spapr_cap_get_pagesize(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     SpaprCapabilityInfo *cap = opaque;
@@ -152,7 +152,7 @@ static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char *name,
     uint8_t val = spapr_get_cap(spapr, cap->index);
     uint64_t pagesize = (1ULL << val);
 
-    visit_type_size(v, name, &pagesize, errp);
+    return visit_type_size(v, name, &pagesize, errp);
 }
 
 static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 43d12bc33a..2ffbf5ea2b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -289,15 +289,16 @@ static SpaprDREntitySense logical_entity_sense(SpaprDrc *drc)
     }
 }
 
-static void prop_get_index(Object *obj, Visitor *v, const char *name,
+static bool prop_get_index(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(obj);
     uint32_t value = spapr_drc_index(drc);
-    visit_type_uint32(v, name, &value, errp);
+
+    return visit_type_uint32(v, name, &value, errp);
 }
 
-static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
+static bool prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     SpaprDrc *drc = SPAPR_DR_CONNECTOR(obj);
@@ -309,7 +310,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
     if (!drc->fdt) {
         visit_type_null(v, NULL, &null, errp);
         qobject_unref(null);
-        return;
+        return false;
     }
 
     fdt = drc->fdt;
@@ -328,7 +329,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             fdt_depth++;
             name = fdt_get_name(fdt, fdt_offset, &name_len);
             if (!visit_start_struct(v, name, NULL, 0, errp)) {
-                return;
+                return false;
             }
             break;
         case FDT_END_NODE:
@@ -338,7 +339,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             visit_end_struct(v, NULL);
             if (err) {
                 error_propagate(errp, err);
-                return;
+                return false;
             }
             fdt_depth--;
             break;
@@ -347,19 +348,19 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
             name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
             if (!visit_start_list(v, name, NULL, 0, errp)) {
-                return;
+                return false;
             }
             for (i = 0; i < prop_len; i++) {
                 if (!visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i],
                                       errp)) {
-                    return;
+                    return false;
                 }
             }
             visit_check_list(v, &err);
             visit_end_list(v, NULL);
             if (err) {
                 error_propagate(errp, err);
-                return;
+                return false;
             }
             break;
         }
@@ -369,6 +370,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
         }
         fdt_offset = fdt_offset_next;
     } while (fdt_depth != 0);
+
+    return true;
 }
 
 void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 19a976c9a6..692e22cbaa 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -512,11 +512,11 @@ static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error *
     s->start_in_flash = value;
 }
 
-static void sifive_u_machine_get_uint32_prop(Object *obj, Visitor *v,
+static bool sifive_u_machine_get_uint32_prop(Object *obj, Visitor *v,
                                              const char *name, void *opaque,
                                              Error **errp)
 {
-    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+    return visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
 static void sifive_u_machine_set_uint32_prop(Object *obj, Visitor *v,
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 519dc91316..b3163ccc09 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2341,7 +2341,7 @@ void css_reset(void)
     channel_subsys.max_ssid = 0;
 }
 
-static void get_css_devid(Object *obj, Visitor *v, const char *name,
+static bool get_css_devid(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -2365,7 +2365,7 @@ static void get_css_devid(Object *obj, Visitor *v, const char *name,
         snprintf(buffer, sizeof(buffer), "<unset>");
     }
 
-    visit_type_str(v, name, &p, errp);
+    return visit_type_str(v, name, &p, errp);
 }
 
 /*
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 92146a2119..8c6cf66cb5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1244,13 +1244,13 @@ static void s390_pci_device_reset(DeviceState *dev)
     fmb_timer_free(pbdev);
 }
 
-static void s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
+static bool s390_pci_get_fid(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
     Property *prop = opaque;
     uint32_t *ptr = qdev_get_prop_ptr(DEVICE(obj), prop);
 
-    visit_type_uint32(v, name, ptr, errp);
+    return visit_type_uint32(v, name, ptr, errp);
 }
 
 static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 2ed6a8df24..caca911fb0 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -719,13 +719,13 @@ static void usb_msd_class_storage_initfn(ObjectClass *klass, void *data)
     device_class_set_props(dc, msd_properties);
 }
 
-static void usb_msd_get_bootindex(Object *obj, Visitor *v, const char *name,
+static bool usb_msd_get_bootindex(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     USBDevice *dev = USB_DEVICE(obj);
     MSDState *s = USB_STORAGE_DEV(dev);
 
-    visit_type_int32(v, name, &s->conf.bootindex, errp);
+    return visit_type_int32(v, name, &s->conf.bootindex, errp);
 }
 
 static void usb_msd_set_bootindex(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 3a14b7c303..8e2f441c01 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1484,7 +1484,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
  *
  * https://lists.gnu.org/archive/html/qemu-devel/2017-08/pdfUda5iEpgOS.pdf
  */
-static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
+static bool get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
@@ -1492,7 +1492,7 @@ static void get_nv_gpudirect_clique_id(Object *obj, Visitor *v,
     Property *prop = opaque;
     uint8_t *ptr = qdev_get_prop_ptr(dev, prop);
 
-    visit_type_uint8(v, name, ptr, errp);
+    return visit_type_uint8(v, name, ptr, errp);
 }
 
 static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
@@ -1565,20 +1565,22 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
+static bool vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
                                      const char *name,
                                      void *opaque, Error **errp)
 {
     uint64_t tgt = (uintptr_t) opaque;
-    visit_type_uint64(v, name, &tgt, errp);
+
+    return visit_type_uint64(v, name, &tgt, errp);
 }
 
-static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
+static bool vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
                                                  const char *name,
                                                  void *opaque, Error **errp)
 {
     uint32_t link_speed = (uint32_t)(uintptr_t) opaque;
-    visit_type_uint32(v, name, &link_speed, errp);
+
+    return visit_type_uint32(v, name, &link_speed, errp);
 }
 
 int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e670f1e595..befac94eaf 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -232,11 +232,12 @@ static void balloon_stats_poll_cb(void *opaque)
     s->stats_vq_elem = NULL;
 }
 
-static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
+static bool balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     Error *err = NULL;
     VirtIOBalloon *s = opaque;
+    bool ret;
     int i;
 
     if (!visit_start_struct(v, name, NULL, 0, &err)) {
@@ -254,25 +255,28 @@ static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
             goto out_nested;
         }
     }
-    visit_check_struct(v, &err);
+    ret = visit_check_struct(v, &err);
 out_nested:
     visit_end_struct(v, NULL);
 
-    if (!err) {
-        visit_check_struct(v, &err);
+    if (!ret) {
+        ret = visit_check_struct(v, &err);
     }
 out_end:
     visit_end_struct(v, NULL);
 out:
     error_propagate(errp, err);
+
+    return ret;
 }
 
-static void balloon_stats_get_poll_interval(Object *obj, Visitor *v,
+static bool balloon_stats_get_poll_interval(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
 {
     VirtIOBalloon *s = opaque;
-    visit_type_int(v, name, &s->stats_poll_interval, errp);
+
+    return visit_type_int(v, name, &s->stats_poll_interval, errp);
 }
 
 static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 65850530e7..ddf09ed1bf 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -663,23 +663,23 @@ static void virtio_mem_remove_size_change_notifier(VirtIOMEM *vmem,
     notifier_remove(notifier);
 }
 
-static void virtio_mem_get_size(Object *obj, Visitor *v, const char *name,
+static bool virtio_mem_get_size(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value = vmem->size;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
-static void virtio_mem_get_requested_size(Object *obj, Visitor *v,
+static bool virtio_mem_get_requested_size(Object *obj, Visitor *v,
                                           const char *name, void *opaque,
                                           Error **errp)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value = vmem->requested_size;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void virtio_mem_set_requested_size(Object *obj, Visitor *v,
@@ -727,13 +727,13 @@ static void virtio_mem_set_requested_size(Object *obj, Visitor *v,
     }
 }
 
-static void virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
+static bool virtio_mem_get_block_size(Object *obj, Visitor *v, const char *name,
                                       void *opaque, Error **errp)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value = vmem->block_size;
 
-    visit_type_size(v, name, &value, errp);
+    return visit_type_size(v, name, &value, errp);
 }
 
 static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
diff --git a/iothread.c b/iothread.c
index 0598a6d20d..b4349b28ea 100644
--- a/iothread.c
+++ b/iothread.c
@@ -223,14 +223,14 @@ static PollParamInfo poll_shrink_info = {
     "poll-shrink", offsetof(IOThread, poll_shrink),
 };
 
-static void iothread_get_poll_param(Object *obj, Visitor *v,
+static bool iothread_get_poll_param(Object *obj, Visitor *v,
         const char *name, void *opaque, Error **errp)
 {
     IOThread *iothread = IOTHREAD(obj);
     PollParamInfo *info = opaque;
     int64_t *field = (void *)iothread + info->offset;
 
-    visit_type_int64(v, name, field, errp);
+    return visit_type_int64(v, name, field, errp);
 }
 
 static void iothread_set_poll_param(Object *obj, Visitor *v,
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 398b7546ff..50492dfe4c 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1078,14 +1078,14 @@ static void compare_set_notify_dev(Object *obj, const char *value, Error **errp)
     s->notify_dev = g_strdup(value);
 }
 
-static void compare_get_timeout(Object *obj, Visitor *v,
+static bool compare_get_timeout(Object *obj, Visitor *v,
                                 const char *name, void *opaque,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
     uint32_t value = s->compare_timeout;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void compare_set_timeout(Object *obj, Visitor *v,
@@ -1106,14 +1106,14 @@ static void compare_set_timeout(Object *obj, Visitor *v,
     s->compare_timeout = value;
 }
 
-static void compare_get_expired_scan_cycle(Object *obj, Visitor *v,
+static bool compare_get_expired_scan_cycle(Object *obj, Visitor *v,
                                            const char *name, void *opaque,
                                            Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
     uint32_t value = s->expired_scan_cycle;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
diff --git a/net/dump.c b/net/dump.c
index 11a737a4bc..1e57bc63e7 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -179,13 +179,13 @@ static void filter_dump_setup(NetFilterState *nf, Error **errp)
     net_dump_state_init(&nfds->ds, nfds->filename, nfds->maxlen, errp);
 }
 
-static void filter_dump_get_maxlen(Object *obj, Visitor *v, const char *name,
+static bool filter_dump_get_maxlen(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     NetFilterDumpState *nfds = FILTER_DUMP(obj);
     uint32_t value = nfds->maxlen;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void filter_dump_set_maxlen(Object *obj, Visitor *v, const char *name,
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index dfa211794b..ee814aa1e3 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -155,14 +155,14 @@ static void filter_buffer_class_init(ObjectClass *oc, void *data)
     nfc->status_changed = filter_buffer_status_changed;
 }
 
-static void filter_buffer_get_interval(Object *obj, Visitor *v,
+static bool filter_buffer_get_interval(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
     FilterBufferState *s = FILTER_BUFFER(obj);
     uint32_t value = s->interval;
 
-    visit_type_uint32(v, name, &value, errp);
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void filter_buffer_set_interval(Object *obj, Visitor *v,
diff --git a/qom/object.c b/qom/object.c
index 7c13117f7d..ec288b288e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1644,7 +1644,7 @@ Object *object_get_internal_root(void)
     return internal_root;
 }
 
-static void object_get_child_property(Object *obj, Visitor *v,
+static bool object_get_child_property(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
@@ -1652,7 +1652,7 @@ static void object_get_child_property(Object *obj, Visitor *v,
     g_autofree char *path;
 
     path = object_get_canonical_path(child);
-    visit_type_str(v, name, &path, errp);
+    return visit_type_str(v, name, &path, errp);
 }
 
 static Object *object_resolve_child_property(Object *parent, void *opaque,
@@ -1731,22 +1731,24 @@ object_link_get_targetp(Object *obj, LinkProperty *lprop)
     }
 }
 
-static void object_get_link_property(Object *obj, Visitor *v,
+static bool object_get_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
     LinkProperty *lprop = opaque;
     Object **targetp = object_link_get_targetp(obj, lprop);
     char *path;
+    bool ret;
 
     if (*targetp) {
         path = object_get_canonical_path(*targetp);
-        visit_type_str(v, name, &path, errp);
+        ret = visit_type_str(v, name, &path, errp);
         g_free(path);
     } else {
         path = (char *)"";
-        visit_type_str(v, name, &path, errp);
+        ret = visit_type_str(v, name, &path, errp);
     }
+    return ret;
 }
 
 /*
@@ -2094,7 +2096,7 @@ typedef struct StringProperty
     void (*set)(Object *, const char *, Error **);
 } StringProperty;
 
-static void property_get_str(Object *obj, Visitor *v, const char *name,
+static bool property_get_str(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     StringProperty *prop = opaque;
@@ -2104,10 +2106,10 @@ static void property_get_str(Object *obj, Visitor *v, const char *name,
     value = prop->get(obj, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
 
-    visit_type_str(v, name, &value, errp);
+    return visit_type_str(v, name, &value, errp);
 }
 
 static void property_set_str(Object *obj, Visitor *v, const char *name,
@@ -2172,7 +2174,7 @@ typedef struct BoolProperty
     void (*set)(Object *, bool, Error **);
 } BoolProperty;
 
-static void property_get_bool(Object *obj, Visitor *v, const char *name,
+static bool property_get_bool(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     BoolProperty *prop = opaque;
@@ -2182,10 +2184,10 @@ static void property_get_bool(Object *obj, Visitor *v, const char *name,
     value = prop->get(obj, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
 
-    visit_type_bool(v, name, &value, errp);
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void property_set_bool(Object *obj, Visitor *v, const char *name,
@@ -2242,7 +2244,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
                                      prop);
 }
 
-static void property_get_enum(Object *obj, Visitor *v, const char *name,
+static bool property_get_enum(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     EnumProperty *prop = opaque;
@@ -2252,10 +2254,10 @@ static void property_get_enum(Object *obj, Visitor *v, const char *name,
     value = prop->get(obj, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
 
-    visit_type_enum(v, name, &value, prop->lookup, errp);
+    return visit_type_enum(v, name, &value, prop->lookup, errp);
 }
 
 static void property_set_enum(Object *obj, Visitor *v, const char *name,
@@ -2321,21 +2323,22 @@ typedef struct TMProperty {
     void (*get)(Object *, struct tm *, Error **);
 } TMProperty;
 
-static void property_get_tm(Object *obj, Visitor *v, const char *name,
+static bool property_get_tm(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     TMProperty *prop = opaque;
     Error *err = NULL;
     struct tm value;
+    bool ret = false;
 
     prop->get(obj, &value, &err);
     if (err) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
 
     if (!visit_start_struct(v, name, NULL, 0, errp)) {
-        return;
+        return false;
     }
     if (!visit_type_int32(v, "tm_year", &value.tm_year, errp)) {
         goto out_end;
@@ -2355,9 +2358,11 @@ static void property_get_tm(Object *obj, Visitor *v, const char *name,
     if (!visit_type_int32(v, "tm_sec", &value.tm_sec, errp)) {
         goto out_end;
     }
-    visit_check_struct(v, errp);
+    ret = visit_check_struct(v, errp);
 out_end:
     visit_end_struct(v, NULL);
+
+    return ret;
 }
 
 static void property_release_tm(Object *obj, const char *name,
@@ -2399,11 +2404,12 @@ static char *object_get_type(Object *obj, Error **errp)
     return g_strdup(object_get_typename(obj));
 }
 
-static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
+static bool property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     uint8_t value = *(uint8_t *)opaque;
-    visit_type_uint8(v, name, &value, errp);
+
+    return visit_type_uint8(v, name, &value, errp);
 }
 
 static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
@@ -2419,11 +2425,12 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
+static bool property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     uint16_t value = *(uint16_t *)opaque;
-    visit_type_uint16(v, name, &value, errp);
+
+    return visit_type_uint16(v, name, &value, errp);
 }
 
 static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
@@ -2439,11 +2446,12 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
+static bool property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     uint32_t value = *(uint32_t *)opaque;
-    visit_type_uint32(v, name, &value, errp);
+
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
@@ -2459,11 +2467,12 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
     *field = value;
 }
 
-static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
+static bool property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
                                     void *opaque, Error **errp)
 {
     uint64_t value = *(uint64_t *)opaque;
-    visit_type_uint64(v, name, &value, errp);
+
+    return visit_type_uint64(v, name, &value, errp);
 }
 
 static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
@@ -2644,12 +2653,12 @@ typedef struct {
     char *target_name;
 } AliasProperty;
 
-static void property_get_alias(Object *obj, Visitor *v, const char *name,
+static bool property_get_alias(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     AliasProperty *prop = opaque;
 
-    object_property_get(prop->target_obj, prop->target_name, v, errp);
+    return object_property_get(prop->target_obj, prop->target_name, v, errp);
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 9200b20130..66631433c5 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1170,20 +1170,22 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
-static void memory_region_get_container(Object *obj, Visitor *v,
+static bool memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
     char *path = (char *)"";
+    bool ret;
 
     if (mr->container) {
         path = object_get_canonical_path(OBJECT(mr->container));
     }
-    visit_type_str(v, name, &path, errp);
+    ret = visit_type_str(v, name, &path, errp);
     if (mr->container) {
         g_free(path);
     }
+    return ret;
 }
 
 static Object *memory_region_resolve_container(Object *obj, void *opaque,
@@ -1194,23 +1196,23 @@ static Object *memory_region_resolve_container(Object *obj, void *opaque,
     return OBJECT(mr->container);
 }
 
-static void memory_region_get_priority(Object *obj, Visitor *v,
+static bool memory_region_get_priority(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
     int32_t value = mr->priority;
 
-    visit_type_int32(v, name, &value, errp);
+    return visit_type_int32(v, name, &value, errp);
 }
 
-static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
+static bool memory_region_get_size(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
     uint64_t value = memory_region_size(mr);
 
-    visit_type_uint64(v, name, &value, errp);
+    return visit_type_uint64(v, name, &value, errp);
 }
 
 static void memory_region_initfn(Object *obj)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 15494002d2..436eb86f8e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -445,7 +445,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     cpu->sve_max_vq = max_vq;
 }
 
-static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
+static bool cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -457,7 +457,8 @@ static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
     } else {
         value = cpu->sve_max_vq;
     }
-    visit_type_uint32(v, name, &value, errp);
+
+    return visit_type_uint32(v, name, &value, errp);
 }
 
 static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
@@ -486,7 +487,7 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
     cpu->sve_max_vq = max_vq;
 }
 
-static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
+static bool cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -499,7 +500,8 @@ static void cpu_arm_get_sve_vq(Object *obj, Visitor *v, const char *name,
     } else {
         value = test_bit(vq - 1, cpu->sve_vq_map);
     }
-    visit_type_bool(v, name, &value, errp);
+
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
@@ -527,13 +529,13 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
     set_bit(vq - 1, cpu->sve_vq_init);
 }
 
-static void cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
+static bool cpu_arm_get_sve(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     bool value = cpu_isar_feature(aa64_sve, cpu);
 
-    visit_type_bool(v, name, &value, errp);
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e5123251d..5bdc726d4e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4394,7 +4394,7 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     }
 }
 
-static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
+static bool x86_cpuid_version_get_family(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
 {
@@ -4406,7 +4406,8 @@ static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
     if (value == 0xf) {
         value += (env->cpuid_version >> 20) & 0xff;
     }
-    visit_type_int(v, name, &value, errp);
+
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
@@ -4436,7 +4437,7 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
     }
 }
 
-static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
+static bool x86_cpuid_version_get_model(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
@@ -4446,7 +4447,8 @@ static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
 
     value = (env->cpuid_version >> 4) & 0xf;
     value |= ((env->cpuid_version >> 16) & 0xf) << 4;
-    visit_type_int(v, name, &value, errp);
+
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
@@ -4472,7 +4474,7 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
     env->cpuid_version |= ((value & 0xf) << 4) | ((value >> 4) << 16);
 }
 
-static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
+static bool x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
                                            const char *name, void *opaque,
                                            Error **errp)
 {
@@ -4481,7 +4483,8 @@ static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
     int64_t value;
 
     value = env->cpuid_version & 0xf;
-    visit_type_int(v, name, &value, errp);
+
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
@@ -4578,14 +4581,15 @@ static void x86_cpuid_set_model_id(Object *obj, const char *model_id,
     }
 }
 
-static void x86_cpuid_get_tsc_freq(Object *obj, Visitor *v, const char *name,
+static bool x86_cpuid_get_tsc_freq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     X86CPU *cpu = X86_CPU(obj);
     int64_t value;
 
     value = cpu->env.tsc_khz * 1000;
-    visit_type_int(v, name, &value, errp);
+
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
@@ -4609,7 +4613,7 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
 }
 
 /* Generic getter for "feature-words" and "filtered-features" properties */
-static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
+static bool x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
@@ -4641,7 +4645,8 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
         list = &list_entries[w];
     }
 
-    visit_type_X86CPUFeatureWordInfoList(v, "feature-words", &list, errp);
+    return visit_type_X86CPUFeatureWordInfoList(v, "feature-words",
+                                                &list, errp);
 }
 
 /* Convert all '_' in a feature string option name to '-', to make feature
@@ -4804,7 +4809,7 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     }
 }
 
-static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
+static bool x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
                                              const char *name, void *opaque,
                                              Error **errp)
 {
@@ -4812,7 +4817,8 @@ static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
     strList *result = NULL;
 
     x86_cpu_list_feature_names(xc->filtered_features, &result);
-    visit_type_strList(v, "unavailable-features", &result, errp);
+
+    return visit_type_strList(v, "unavailable-features", &result, errp);
 }
 
 /* Check for missing features that may prevent the CPU class from
@@ -6766,14 +6772,15 @@ typedef struct BitProperty {
     uint64_t mask;
 } BitProperty;
 
-static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
+static bool x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
     uint64_t f = cpu->env.features[fp->w];
     bool value = (f & fp->mask) == fp->mask;
-    visit_type_bool(v, name, &value, errp);
+
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -6883,27 +6890,30 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 
     return panic_info;
 }
-static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+static bool x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
     CPUState *cs = CPU(obj);
     GuestPanicInformation *panic_info;
+    bool ret;
 
     if (!cs->crash_occurred) {
         error_setg(errp, "No crash occured");
-        return;
+        return false;
     }
 
     panic_info = x86_cpu_get_crash_info(cs);
     if (panic_info == NULL) {
         error_setg(errp, "No crash information");
-        return;
+        return false;
     }
 
-    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
-                                     errp);
+    ret = visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                           errp);
     qapi_free_GuestPanicInformation(panic_info);
+
+    return ret;
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 08aede88dc..d59eadd4da 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -238,7 +238,7 @@ int ppc_compat_max_vthreads(PowerPCCPU *cpu)
     return n_threads;
 }
 
-static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
+static bool ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
     uint32_t compat_pvr = *((uint32_t *)opaque);
@@ -254,7 +254,7 @@ static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
         value = compat->name;
     }
 
-    visit_type_str(v, name, (char **)&value, errp);
+    return visit_type_str(v, name, (char **)&value, errp);
 }
 
 static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 08eb674d22..0f4f5c0eec 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -265,23 +265,26 @@ static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
     return panic_info;
 }
 
-static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+static bool s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
     CPUState *cs = CPU(obj);
     GuestPanicInformation *panic_info;
+    bool ret;
 
     if (!cs->crash_occurred) {
         error_setg(errp, "No crash occurred");
-        return;
+        return false;
     }
 
     panic_info = s390_cpu_get_crash_info(cs);
 
-    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
-                                     errp);
+    ret = visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                           errp);
     qapi_free_GuestPanicInformation(panic_info);
+
+    return ret;
 }
 #endif
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c2af226174..4d884be759 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -978,7 +978,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
 #endif
 }
 
-static void get_feature(Object *obj, Visitor *v, const char *name,
+static bool get_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
     S390Feat feat = (S390Feat) opaque;
@@ -988,11 +988,12 @@ static void get_feature(Object *obj, Visitor *v, const char *name,
     if (!cpu->model) {
         error_setg(errp, "Details about the host CPU model are not available, "
                          "features cannot be queried.");
-        return;
+        return false;
     }
 
     value = test_bit(feat, cpu->model->features);
-    visit_type_bool(v, name, &value, errp);
+
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void set_feature(Object *obj, Visitor *v, const char *name,
@@ -1029,7 +1030,7 @@ static void set_feature(Object *obj, Visitor *v, const char *name,
     }
 }
 
-static void get_feature_group(Object *obj, Visitor *v, const char *name,
+static bool get_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     S390FeatGroup group = (S390FeatGroup) opaque;
@@ -1041,13 +1042,14 @@ static void get_feature_group(Object *obj, Visitor *v, const char *name,
     if (!cpu->model) {
         error_setg(errp, "Details about the host CPU model are not available, "
                          "features cannot be queried.");
-        return;
+        return false;
     }
 
     /* a group is enabled if all features are enabled */
     bitmap_and(tmp, cpu->model->features, def->feat, S390_FEAT_MAX);
     value = bitmap_equal(tmp, def->feat, S390_FEAT_MAX);
-    visit_type_bool(v, name, &value, errp);
+
+    return visit_type_bool(v, name, &value, errp);
 }
 
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd85f..aafb2a7960 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -786,13 +786,13 @@ static void sparc_cpu_initfn(Object *obj)
     }
 }
 
-static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
+static bool sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
     SPARCCPU *cpu = SPARC_CPU(obj);
     int64_t value = cpu->env.def.nwindows;
 
-    visit_type_int(v, name, &value, errp);
+    return visit_type_int(v, name, &value, errp);
 }
 
 static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
-- 
2.21.3


