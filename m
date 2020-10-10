Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF03C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFE6207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG4x1A+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE6207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRA2t-0004a2-Sp
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lP-0004L7-3s
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lM-0006if-Tz
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkBNPei9uMoqu12UG5Q0b8HB14/E7ipCviA8H8P7BJA=;
 b=OG4x1A+1FVZLpi/x4M1eukLGKkkGblkNcjU4lHqQfbFjksZU9Yv3usbzquKpOCYaj4xq5P
 UFLE8CSmj+Cu51Q24/JTJJirs5tl1Swr6/ft4G8oS6ryAu5Dy3LPyK38yrBfTPIJS2plsK
 hGBh1Ux4kWlexlxnyoFhcZHx4PY3V6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-l6CX1cT3PSOWFHBjXmM2rw-1; Sat, 10 Oct 2020 03:57:54 -0400
X-MC-Unique: l6CX1cT3PSOWFHBjXmM2rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42ACF8030CA
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F208D672C6;
 Sat, 10 Oct 2020 07:57:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/39] qtest: rename qtest_qmp_receive to qtest_qmp_receive_dict
Date: Sat, 10 Oct 2020 03:57:22 -0400
Message-Id: <20201010075739.951385-23-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

In the next patch a new version of qtest_qmp_receive will be
reintroduced that will buffer received qmp events for later
consumption in qtest_qmp_eventwait_ref

No functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/ahci-test.c        |  4 ++--
 tests/qtest/device-plug-test.c |  2 +-
 tests/qtest/drive_del-test.c   |  2 +-
 tests/qtest/libqos/libqtest.h  |  4 ++--
 tests/qtest/libqtest.c         | 16 ++++++++--------
 tests/qtest/pvpanic-test.c     |  2 +-
 tests/qtest/qmp-test.c         | 18 +++++++++---------
 7 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5e1954852e..d42ebaeb4c 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1590,7 +1590,7 @@ static void test_atapi_tray(void)
     qtest_qmp_send(ahci->parent->qts, "{'execute': 'blockdev-open-tray', "
                     "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(ahci, true);
-    rsp = qtest_qmp_receive(ahci->parent->qts);
+    rsp = qtest_qmp_receive_dict(ahci->parent->qts);
     qobject_unref(rsp);
 
     qmp_discard_response(ahci->parent->qts,
@@ -1620,7 +1620,7 @@ static void test_atapi_tray(void)
     qtest_qmp_send(ahci->parent->qts, "{'execute': 'blockdev-close-tray', "
                    "'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(ahci, false);
-    rsp = qtest_qmp_receive(ahci->parent->qts);
+    rsp = qtest_qmp_receive_dict(ahci->parent->qts);
     qobject_unref(rsp);
 
     /* Now, to convince ATAPI we understand the media has changed... */
diff --git a/tests/qtest/device-plug-test.c b/tests/qtest/device-plug-test.c
index 9214892741..a2247856be 100644
--- a/tests/qtest/device-plug-test.c
+++ b/tests/qtest/device-plug-test.c
@@ -23,7 +23,7 @@ static void device_del_start(QTestState *qtest, const char *id)
 
 static void device_del_finish(QTestState *qtest)
 {
-    QDict *resp = qtest_qmp_receive(qtest);
+    QDict *resp = qtest_qmp_receive_dict(qtest);
 
     g_assert(qdict_haskey(resp, "return"));
     qobject_unref(resp);
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 2d765865ce..ba0cd77445 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -41,7 +41,7 @@ static void device_del(QTestState *qts)
     /* Complication: ignore DEVICE_DELETED event */
     qmp_discard_response(qts, "{'execute': 'device_del',"
                          " 'arguments': { 'id': 'dev0' } }");
-    response = qtest_qmp_receive(qts);
+    response = qtest_qmp_receive_dict(qts);
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index 209fcf6973..9b3f99b322 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -191,12 +191,12 @@ void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 
 /**
- * qtest_receive:
+ * qtest_qmp_receive_dict:
  * @s: #QTestState instance to operate on.
  *
  * Reads a QMP message from QEMU and returns the response.
  */
-QDict *qtest_qmp_receive(QTestState *s);
+QDict *qtest_qmp_receive_dict(QTestState *s);
 
 /**
  * qtest_qmp_eventwait:
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 58f58e1ece..dadc465825 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -322,7 +322,7 @@ QTestState *qtest_init(const char *extra_args)
     QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
-    greeting = qtest_qmp_receive(s);
+    greeting = qtest_qmp_receive_dict(s);
     qobject_unref(greeting);
     qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
 
@@ -603,7 +603,7 @@ QDict *qmp_fd_receive(int fd)
     return qmp.response;
 }
 
-QDict *qtest_qmp_receive(QTestState *s)
+QDict *qtest_qmp_receive_dict(QTestState *s)
 {
     return qmp_fd_receive(s->qmp_fd);
 }
@@ -678,7 +678,7 @@ QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
     qtest_qmp_vsend_fds(s, fds, fds_num, fmt, ap);
 
     /* Receive reply */
-    return qtest_qmp_receive(s);
+    return qtest_qmp_receive_dict(s);
 }
 
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
@@ -686,7 +686,7 @@ QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
     qtest_qmp_vsend(s, fmt, ap);
 
     /* Receive reply */
-    return qtest_qmp_receive(s);
+    return qtest_qmp_receive_dict(s);
 }
 
 QDict *qmp_fd(int fd, const char *fmt, ...)
@@ -776,7 +776,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
     QDict *response;
 
     for (;;) {
-        response = qtest_qmp_receive(s);
+        response = qtest_qmp_receive_dict(s);
         if ((qdict_haskey(response, "event")) &&
             (strcmp(qdict_get_str(response, "event"), event) == 0)) {
             return response;
@@ -807,7 +807,7 @@ char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     while (ret == NULL && qdict_get_try_str(resp, "event")) {
         /* Ignore asynchronous QMP events */
         qobject_unref(resp);
-        resp = qtest_qmp_receive(s);
+        resp = qtest_qmp_receive_dict(s);
         ret = g_strdup(qdict_get_try_str(resp, "return"));
     }
     g_assert(ret);
@@ -1255,7 +1255,7 @@ QDict *qtest_qmp_receive_success(QTestState *s,
     const char *event;
 
     for (;;) {
-        response = qtest_qmp_receive(s);
+        response = qtest_qmp_receive_dict(s);
         g_assert(!qdict_haskey(response, "error"));
         ret = qdict_get_qdict(response, "return");
         if (ret) {
@@ -1345,7 +1345,7 @@ void qtest_qmp_device_del(QTestState *qts, const char *id)
     rsp = qtest_qmp_receive_success(qts, device_deleted_cb, &got_event);
     qobject_unref(rsp);
     if (!got_event) {
-        rsp = qtest_qmp_receive(qts);
+        rsp = qtest_qmp_receive_dict(qts);
         g_assert_cmpstr(qdict_get_try_str(rsp, "event"),
                         ==, "DEVICE_DELETED");
         qobject_unref(rsp);
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index e57639481e..b0b20ad340 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -24,7 +24,7 @@ static void test_panic(void)
 
     qtest_outb(qts, 0x505, 0x1);
 
-    response = qtest_qmp_receive(qts);
+    response = qtest_qmp_receive_dict(qts);
     g_assert(qdict_haskey(response, "event"));
     g_assert_cmpstr(qdict_get_str(response, "event"), ==, "GUEST_PANICKED");
     g_assert(qdict_haskey(response, "data"));
diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index e1032c5a21..eb1cd8abb8 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -47,37 +47,37 @@ static void test_malformed(QTestState *qts)
 
     /* syntax error */
     qtest_qmp_send_raw(qts, "{]\n");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
     /* lexical error: impossible byte outside string */
     qtest_qmp_send_raw(qts, "{\xFF");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
     /* lexical error: funny control character outside string */
     qtest_qmp_send_raw(qts, "{\x01");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
     /* lexical error: impossible byte in string */
     qtest_qmp_send_raw(qts, "{'bad \xFF");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
     /* lexical error: control character in string */
     qtest_qmp_send_raw(qts, "{'execute': 'nonexistent', 'id':'\n");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
     /* lexical error: interpolation */
     qtest_qmp_send_raw(qts, "%%p");
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     qmp_expect_error_and_unref(resp, "GenericError");
     assert_recovered(qts);
 
@@ -111,7 +111,7 @@ static void test_qmp_protocol(void)
     qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Test greeting */
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     q = qdict_get_qdict(resp, "QMP");
     g_assert(q);
     test_version(qdict_get(q, "version"));
@@ -205,7 +205,7 @@ static void send_oob_cmd_that_fails(QTestState *s, const char *id)
 
 static void recv_cmd_id(QTestState *s, const char *id)
 {
-    QDict *resp = qtest_qmp_receive(s);
+    QDict *resp = qtest_qmp_receive_dict(s);
 
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, id);
     qobject_unref(resp);
@@ -222,7 +222,7 @@ static void test_qmp_oob(void)
     qts = qtest_init_without_qmp_handshake(common_args);
 
     /* Check the greeting message. */
-    resp = qtest_qmp_receive(qts);
+    resp = qtest_qmp_receive_dict(qts);
     q = qdict_get_qdict(resp, "QMP");
     g_assert(q);
     capabilities = qdict_get_qlist(q, "capabilities");
-- 
2.26.2



