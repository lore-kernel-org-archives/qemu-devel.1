Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57958205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrbNTW8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57958205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgqS-0000bx-EN
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyB-00084g-8C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy9-000103-9l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfy9-0000ze-2E
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id t16so21672585wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1ppvb5bxHlUarLcdtxXV3E1gkwxQBUxp+2P7V8J9BmA=;
 b=FrbNTW8kPH2/+8FuqoRH5jHzrzyhFI36zkldr5BkVH52m+hv9r9/Li3pHgXIijtc3t
 MOIrzLegS9liLAZPGpMlAWleXVAd5b1wTqO1SiIAwUQ1EgrERRnHEPzkqDjkeN4r8nVo
 cp1r7GZyYuTHfvEpk7iIKAUgohFmFMyRJYvcOLa8YMgKQcAqP1Eul72P9tXnvBQQEVFr
 +Wiqp4V3S9EiSgsbVWWtzVQdzlFLfC4mx7bINPk5A+EvO2BUVRG+Bne7EkHMmeORRwAM
 XvL32Kp0i+u8LRPpql3zbJzHaxH19PBhteHZG937ClHm6eivDTmSEQHmVtxjoCI33OxW
 S2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ppvb5bxHlUarLcdtxXV3E1gkwxQBUxp+2P7V8J9BmA=;
 b=RNse6/aoCHwpulfliJ3ydHPxJRmPb57jxN4fa2tDqSxIOwMNB8x120BU4JbGh4TiBV
 7W+ic0gir3CltXPn30BCS5df4aT+IT4ARFRUgMu5WAf1m5EIwTHvyRmQAeggUP9A4zw5
 eCv0rpmTrxYSvmy2DQyzGnbkGmgPNWr8RuaxK44Y0c4eD3TU0SsoeIuvfYhi/1VirUJ6
 BA05wgKH3eKk427Bq7Ehcm07vIVEfVhn/5WuVCNjPCI+5lKNmj4N6vJxmDVkx0UKOm1G
 BL5Y69yGMLzW5qsmMYxud9mbTH+yyrszdBPPKhxpNat/uYe7V8ZHf8R4YJxq+VxRDqY2
 6mRg==
X-Gm-Message-State: APjAAAXJFtyeNTTsAAnXl6EExEX9m6EZVgOP/+YAjge1u/0fZQXR+AOu
 USpnPitzaguafKLqDanaPudmn5aP15w=
X-Google-Smtp-Source: APXvYqxAbeRZ8WMdYcCthF1CDavoKNw1sRkdCXJ+dovoGHNbR4OPkNL6H7qrMkwq/E9AgcVNcicgKg==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr4595384wrn.261.1571934491718; 
 Thu, 24 Oct 2019 09:28:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/51] tests: arm: Introduce cpu feature tests
Date: Thu, 24 Oct 2019 17:27:09 +0100
Message-Id: <20191024162724.31675-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Now that Arm CPUs have advertised features lets add tests to ensure
we maintain their expected availability with and without KVM.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20191024121808.9612-3-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/Makefile.include   |   5 +-
 tests/arm-cpu-features.c | 240 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 tests/arm-cpu-features.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 09e5b410dca..d71188f251b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -262,6 +262,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
+check-qtest-arm-y += tests/arm-cpu-features$(EXESUF)
 check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
@@ -269,7 +270,8 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
 
-check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/arm-cpu-features$(EXESUF)
+check-qtest-aarch64-y += tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
@@ -835,6 +837,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
+tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
new file mode 100644
index 00000000000..c59fcf409c8
--- /dev/null
+++ b/tests/arm-cpu-features.c
@@ -0,0 +1,240 @@
+/*
+ * Arm CPU feature test cases
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ * Authors:
+ *  Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+
+#define MACHINE    "-machine virt,gic-version=max "
+#define QUERY_HEAD "{ 'execute': 'query-cpu-model-expansion', " \
+                     "'arguments': { 'type': 'full', "
+#define QUERY_TAIL "}}"
+
+static QDict *do_query_no_props(QTestState *qts, const char *cpu_type)
+{
+    return qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s }"
+                          QUERY_TAIL, cpu_type);
+}
+
+static QDict *do_query(QTestState *qts, const char *cpu_type,
+                       const char *fmt, ...)
+{
+    QDict *resp;
+
+    if (fmt) {
+        QDict *args;
+        va_list ap;
+
+        va_start(ap, fmt);
+        args = qdict_from_vjsonf_nofail(fmt, ap);
+        va_end(ap);
+
+        resp = qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s, "
+                                                    "'props': %p }"
+                              QUERY_TAIL, cpu_type, args);
+    } else {
+        resp = do_query_no_props(qts, cpu_type);
+    }
+
+    return resp;
+}
+
+static const char *resp_get_error(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+
+    qdict = qdict_get_qdict(resp, "error");
+    if (qdict) {
+        return qdict_get_str(qdict, "desc");
+    }
+    return NULL;
+}
+
+#define assert_error(qts, cpu_type, expected_error, fmt, ...)          \
+({                                                                     \
+    QDict *_resp;                                                      \
+    const char *_error;                                                \
+                                                                       \
+    _resp = do_query(qts, cpu_type, fmt, ##__VA_ARGS__);               \
+    g_assert(_resp);                                                   \
+    _error = resp_get_error(_resp);                                    \
+    g_assert(_error);                                                  \
+    g_assert(g_str_equal(_error, expected_error));                     \
+    qobject_unref(_resp);                                              \
+})
+
+static bool resp_has_props(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+
+    if (!qdict_haskey(resp, "return")) {
+        return false;
+    }
+    qdict = qdict_get_qdict(resp, "return");
+
+    if (!qdict_haskey(qdict, "model")) {
+        return false;
+    }
+    qdict = qdict_get_qdict(qdict, "model");
+
+    return qdict_haskey(qdict, "props");
+}
+
+static QDict *resp_get_props(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+    g_assert(resp_has_props(resp));
+
+    qdict = qdict_get_qdict(resp, "return");
+    qdict = qdict_get_qdict(qdict, "model");
+    qdict = qdict_get_qdict(qdict, "props");
+    return qdict;
+}
+
+#define assert_has_feature(qts, cpu_type, feature)                     \
+({                                                                     \
+    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    g_assert(qdict_get(resp_get_props(_resp), feature));               \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_has_not_feature(qts, cpu_type, feature)                 \
+({                                                                     \
+    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
+    g_assert(_resp);                                                   \
+    g_assert(!resp_has_props(_resp) ||                                 \
+             !qdict_get(resp_get_props(_resp), feature));              \
+    qobject_unref(_resp);                                              \
+})
+
+static void assert_type_full(QTestState *qts)
+{
+    const char *error;
+    QDict *resp;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
+                            "'arguments': { 'type': 'static', "
+                                           "'model': { 'name': 'foo' }}}");
+    g_assert(resp);
+    error = resp_get_error(resp);
+    g_assert(error);
+    g_assert(g_str_equal(error,
+                         "The requested expansion type is not supported"));
+    qobject_unref(resp);
+}
+
+static void assert_bad_props(QTestState *qts, const char *cpu_type)
+{
+    const char *error;
+    QDict *resp;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
+                            "'arguments': { 'type': 'full', "
+                                           "'model': { 'name': %s, "
+                                                      "'props': false }}}",
+                     cpu_type);
+    g_assert(resp);
+    error = resp_get_error(resp);
+    g_assert(error);
+    g_assert(g_str_equal(error,
+                         "Invalid parameter type for 'props', expected: dict"));
+    qobject_unref(resp);
+}
+
+static void test_query_cpu_model_expansion(const void *data)
+{
+    QTestState *qts;
+
+    qts = qtest_init(MACHINE "-cpu max");
+
+    /* Test common query-cpu-model-expansion input validation */
+    assert_type_full(qts);
+    assert_bad_props(qts, "max");
+    assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
+                 "ARM CPU type", NULL);
+    assert_error(qts, "max", "Parameter 'not-a-prop' is unexpected",
+                 "{ 'not-a-prop': false }");
+    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
+
+    /* Test expected feature presence/absence for some cpu types */
+    assert_has_feature(qts, "max", "pmu");
+    assert_has_feature(qts, "cortex-a15", "pmu");
+    assert_has_not_feature(qts, "cortex-a15", "aarch64");
+
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        assert_has_feature(qts, "max", "aarch64");
+        assert_has_feature(qts, "cortex-a57", "pmu");
+        assert_has_feature(qts, "cortex-a57", "aarch64");
+
+        /* Test that features that depend on KVM generate errors without. */
+        assert_error(qts, "max",
+                     "'aarch64' feature cannot be disabled "
+                     "unless KVM is enabled and 32-bit EL1 "
+                     "is supported",
+                     "{ 'aarch64': false }");
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_query_cpu_model_expansion_kvm(const void *data)
+{
+    QTestState *qts;
+
+    qts = qtest_init(MACHINE "-accel kvm -cpu host");
+
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        assert_has_feature(qts, "host", "aarch64");
+        assert_has_feature(qts, "host", "pmu");
+
+        assert_error(qts, "cortex-a15",
+            "We cannot guarantee the CPU type 'cortex-a15' works "
+            "with KVM on this host", NULL);
+    } else {
+        assert_has_not_feature(qts, "host", "aarch64");
+        assert_has_not_feature(qts, "host", "pmu");
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    bool kvm_available = false;
+
+    if (!access("/dev/kvm",  R_OK | W_OK)) {
+#if defined(HOST_AARCH64)
+        kvm_available = g_str_equal(qtest_get_arch(), "aarch64");
+#elif defined(HOST_ARM)
+        kvm_available = g_str_equal(qtest_get_arch(), "arm");
+#endif
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/arm/query-cpu-model-expansion",
+                        NULL, test_query_cpu_model_expansion);
+
+    if (kvm_available) {
+        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
+                            NULL, test_query_cpu_model_expansion_kvm);
+    }
+
+    return g_test_run();
+}
-- 
2.20.1


