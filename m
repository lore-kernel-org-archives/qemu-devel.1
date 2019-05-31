Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF0DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2D8269E7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAa4Nw2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2D8269E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi3D-0001ka-6k
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:58:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhor-0007Vf-3C
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhop-0000QN-Ln
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:41 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhop-0000PJ-FF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id i2so8224755otr.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gyvqL6c4/oaHwFa3XHYMgL2lVq/nblv9jYZvWQQxxMs=;
	b=KAa4Nw2AriMhrKHg3Q/NJriL9L9fpRqjo11Qni7wcBSo0/Z84ulhexsjd2QiF9rEgO
	92lnJN0VaFBunOu4snm75LsvJLB/yOKC4JzEaM+CXmuw1hxenrTImEknBTAIvbvz3D85
	kkRi91Q3D5tdKanE1SIWFv4isE85Itoury2ZTtiCv/N0e7CGDRRpBvza2wP3or8IS3xT
	/w+3XQO15y/OYe9t36M8U2zpvTJnR0JgnUfPDfG2k0i/6zkqlBMaXOC/+53QaARMauI3
	uYNt4/nG9YlcCch94rlDo36eXSjSRS/VSu7XKTHqfyZJIm7QQwTKjHoXiC3CXZB5DdWk
	MIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=gyvqL6c4/oaHwFa3XHYMgL2lVq/nblv9jYZvWQQxxMs=;
	b=J5pjBk74cSn2v5+LCNkAJWUcGxbERq3QE/pdkFIsymK/ZmIs4WFYpLF6Pet8dQ8jY2
	O2/yK+sEqzEj7HyxMtdxWmIxiBi3tj6Cy76r3v8SKYvts6uGy3yKdfNapEKns9vPKTHP
	7Y9nkG/4VPXeyiuucFcbe+cApKa8t0NkF6l/fVyg1bv/8yuUedx9lA3gWFjzyfpCCVbf
	hPgl2VPK7h+YU8wLrNnTEbxDwwosHe51YDubD3ha+PinSTEmiswtA6Kx+1h694eVM9Av
	uIaf/lyoBczf6gJWPwdJNWivA69587ke6ad9GvwlhCx2YknzP8ImdEUwA+WztS7aJ2Ax
	JvDg==
X-Gm-Message-State: APjAAAW8Y5GWsGh5eV01s+EDDpvWF9KmI/CYmfk7BGWno9ZC7DkHa1Qb
	S7G83DF8gq3jS13lszPQkwmlRULuRE6H2Q==
X-Google-Smtp-Source: APXvYqx57xT4HbczMW68A5RQFqgWbHDpV0B0t5Lo+bTXeknaIK6b2Jv00Xq1vWMUT3IUTLJmK7TXPw==
X-Received: by 2002:a9d:480a:: with SMTP id c10mr1836044otf.10.1559310218531; 
	Fri, 31 May 2019 06:43:38 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:05 -0500
Message-Id: <20190531134315.4109-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [PATCH v16 13/23] target/rx: Fix cpu types and names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There was confusion here about abstract classes and naming cpus.
We had registered a concrete class named "-rxcpu".  This was put
into the default cpu fields, and matched, so basic tests worked.
However, no value for -cpu could ever match in rx_cpu_class_by_name.

Rename the base class to "rx-cpu" and make it abstract.  This
matches what we do for most other targets.  Create a new concrete
cpu with the name "rx62n-rx-cpu".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.h | 12 ++++++------
 hw/rx/rx-virt.c |  2 +-
 hw/rx/rx62n.c   |  2 +-
 target/rx/cpu.c | 43 ++++++++++++++++++++++++++-----------------
 4 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 8c1a4e448d..a0b6975963 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,14 +24,14 @@
 #include "hw/registerfields.h"
 #include "qom/cpu.h"
 
-#define TYPE_RXCPU "rxcpu"
+#define TYPE_RX_CPU "rx-cpu"
 
 #define RXCPU_CLASS(klass)                                     \
-    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RXCPU)
+    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
 #define RXCPU(obj) \
-    OBJECT_CHECK(RXCPU, (obj), TYPE_RXCPU)
+    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
 #define RXCPU_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RXCPU)
+    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
 
 /*
  * RXCPUClass:
@@ -164,9 +164,9 @@ static inline RXCPU *rx_env_get_cpu(CPURXState *env)
 
 #define ENV_OFFSET offsetof(RXCPU, env)
 
-#define RX_CPU_TYPE_SUFFIX "-" TYPE_RXCPU
+#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
 #define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
-#define CPU_RESOLVING_TYPE TYPE_RXCPU
+#define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 extern const char rx_crname[][6];
 
diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
index 3deb7cb335..72a2989fcf 100644
--- a/hw/rx/rx-virt.c
+++ b/hw/rx/rx-virt.c
@@ -88,7 +88,7 @@ static void rxvirt_class_init(ObjectClass *oc, void *data)
     mc->desc = "RX QEMU Virtual Target";
     mc->init = rxvirt_init;
     mc->is_default = 1;
-    mc->default_cpu_type = TYPE_RXCPU;
+    mc->default_cpu_type = RX_CPU_TYPE_NAME("rx62n");
 }
 
 static const TypeInfo rxvirt_type = {
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index c6660b75b4..3a8fe7b0bf 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -195,7 +195,7 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     }
 
     object_initialize_child(OBJECT(s), "cpu", &s->cpu,
-                            sizeof(RXCPU), TYPE_RXCPU,
+                            sizeof(RXCPU), RX_CPU_TYPE_NAME("rx62n"),
                             errp, NULL);
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 3268077d08..41fe1de4bb 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -74,13 +74,14 @@ static void rx_cpu_list_entry(gpointer data, gpointer user_data)
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
     int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
 
-    qemu_printf("%.*s\n", len, typename);
+    qemu_printf("  %.*s\n", len, typename);
 }
 
 void rx_cpu_list(void)
 {
-    GSList *list;
-    list = object_class_get_list_sorted(TYPE_RXCPU, false);
+    GSList *list = object_class_get_list_sorted(TYPE_RX_CPU, false);
+
+    qemu_printf("Available CPUs:\n");
     g_slist_foreach(list, rx_cpu_list_entry, NULL);
     g_slist_free(list);
 }
@@ -88,15 +89,17 @@ void rx_cpu_list(void)
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    char *typename = NULL;
+    char *typename;
 
-    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
+    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
-        oc = NULL;
-    }
-
     g_free(typename);
+
+    if (oc == NULL ||
+        object_class_is_abstract(oc) ||
+        !object_class_dynamic_cast(oc, TYPE_RX_CPU)) {
+        return NULL;
+    }
     return oc;
 }
 
@@ -166,7 +169,7 @@ static void rx_cpu_init(Object *obj)
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
-static void rxcpu_class_init(ObjectClass *klass, void *data)
+static void rx_cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CPUClass *cc = CPU_CLASS(klass);
@@ -195,22 +198,28 @@ static void rxcpu_class_init(ObjectClass *klass, void *data)
     cc->gdb_num_core_regs = 26;
 }
 
-static const TypeInfo rxcpu_info = {
-    .name = TYPE_RXCPU,
+static const TypeInfo rx_cpu_info = {
+    .name = TYPE_RX_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(RXCPU),
     .instance_init = rx_cpu_init,
-    .abstract = false,
+    .abstract = true,
     .class_size = sizeof(RXCPUClass),
-    .class_init = rxcpu_class_init,
+    .class_init = rx_cpu_class_init,
 };
 
-static void rxcpu_register_types(void)
+static const TypeInfo rx62n_rx_cpu_info = {
+    .name = RX_CPU_TYPE_NAME("rx62n"),
+    .parent = TYPE_RX_CPU,
+};
+
+static void rx_cpu_register_types(void)
 {
-    type_register_static(&rxcpu_info);
+    type_register_static(&rx_cpu_info);
+    type_register_static(&rx62n_rx_cpu_info);
 }
 
-type_init(rxcpu_register_types)
+type_init(rx_cpu_register_types)
 
 static uint32_t extable[32];
 
-- 
2.17.1


