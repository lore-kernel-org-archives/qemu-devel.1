Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7306FC4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC25222CE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC25222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDjo-0003Wp-SG
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iBDaH-0001dM-0a
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iBDaE-0005Xz-QR
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:9868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iBDaE-0005VQ-Hs
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Sep 2019 00:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; d="scan'208";a="212495048"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2019 00:43:59 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH v12 04/11] tests: Add test for QAPI builtin type time
Date: Fri, 20 Sep 2019 15:43:42 +0800
Message-Id: <20190920074349.2616-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920074349.2616-1-tao3.xu@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add tests for time input such as zero, around limit of precision,
signed upper limit, actual upper limit, beyond limits, time suffixes,
and etc.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v11 and v12.

New patch in v10.
---
 tests/test-keyval.c                | 125 +++++++++++++++++++++++++++++
 tests/test-qobject-input-visitor.c |  29 +++++++
 2 files changed, 154 insertions(+)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 09b0ae3c68..b36914f0fc 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -490,6 +490,130 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 }
 
+static void test_keyval_visit_time(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    uint64_t time;
+
+    /* Lower limit zero */
+    qdict = keyval_parse("time1=0", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &error_abort);
+    g_assert_cmpuint(time, ==, 0);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Around limit of precision: 2^53-1, 2^53, 2^53+1 */
+    qdict = keyval_parse("time1=9007199254740991,"
+                         "time2=9007199254740992,"
+                         "time3=9007199254740993",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0x1fffffffffffff);
+    visit_type_time(v, "time2", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0x20000000000000);
+    visit_type_time(v, "time3", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0x20000000000000);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
+    qdict = keyval_parse("time1=9223372036854774784," /* 7ffffffffffffc00 */
+                         "time2=9223372036854775295", /* 7ffffffffffffdff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
+    visit_type_time(v, "time2", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0x7ffffffffffffc00);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
+    qdict = keyval_parse("time1=18446744073709549568," /* fffffffffffff800 */
+                         "time2=18446744073709550591", /* fffffffffffffbff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0xfffffffffffff800);
+    visit_type_time(v, "time2", &time, &error_abort);
+    g_assert_cmphex(time, ==, 0xfffffffffffff800);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limits */
+    qdict = keyval_parse("time1=-1,"
+                         "time2=18446744073709550592", /* fffffffffffffc00 */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &err);
+    error_free_or_abort(&err);
+    visit_type_time(v, "time2", &time, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Suffixes */
+    qdict = keyval_parse("time1=2ps,time2=3.4ns,time3=5us,"
+                         "time4=0.6ms,time5=700s",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &error_abort);
+    g_assert_cmpuint(time, ==, 2);
+    visit_type_time(v, "time2", &time, &error_abort);
+    g_assert_cmpuint(time, ==, 3400);
+    visit_type_time(v, "time3", &time, &error_abort);
+    g_assert_cmphex(time, ==, 5 * 1000 * 1000);
+    visit_type_time(v, "time4", &time, &error_abort);
+    g_assert_cmphex(time, ==, 600 * 1000 * 1000);
+    visit_type_time(v, "time5", &time, &error_abort);
+    g_assert_cmphex(time, ==, 700 * 1000000000000ULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limit with suffix */
+    qdict = keyval_parse("time1=18446745s", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Trailing crap */
+    qdict = keyval_parse("time1=89ks,time2=ns", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    qobject_unref(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_time(v, "time1", &time, &err);
+    error_free_or_abort(&err);
+    visit_type_time(v, "time2", &time, &err);;
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
 static void test_keyval_visit_dict(void)
 {
     Error *err = NULL;
@@ -678,6 +802,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/keyval/visit/bool", test_keyval_visit_bool);
     g_test_add_func("/keyval/visit/number", test_keyval_visit_number);
     g_test_add_func("/keyval/visit/size", test_keyval_visit_size);
+    g_test_add_func("/keyval/visit/time", test_keyval_visit_time);
     g_test_add_func("/keyval/visit/dict", test_keyval_visit_dict);
     g_test_add_func("/keyval/visit/list", test_keyval_visit_list);
     g_test_add_func("/keyval/visit/optional", test_keyval_visit_optional);
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 6bacabf063..4b5820b744 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -366,6 +366,31 @@ static void test_visitor_in_size_str_fail(TestInputVisitorData *data,
     error_free_or_abort(&err);
 }
 
+static void test_visitor_in_time_str_keyval(TestInputVisitorData *data,
+                                            const void *unused)
+{
+    uint64_t res, value = 265 * 1000 * 1000;
+    Visitor *v;
+
+    v = visitor_input_test_init_full(data, true, "\"265us\"");
+
+    visit_type_time(v, NULL, &res, &error_abort);
+    g_assert_cmpfloat(res, ==, value);
+}
+
+static void test_visitor_in_time_str_fail(TestInputVisitorData *data,
+                                          const void *unused)
+{
+    uint64_t res = 0;
+    Visitor *v;
+    Error *err = NULL;
+
+    v = visitor_input_test_init(data, "\"265us\"");
+
+    visit_type_time(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+}
+
 static void test_visitor_in_string(TestInputVisitorData *data,
                                    const void *unused)
 {
@@ -1311,6 +1336,10 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_size_str_keyval);
     input_visitor_test_add("/visitor/input/size_str_fail",
                            NULL, test_visitor_in_size_str_fail);
+    input_visitor_test_add("/visitor/input/time_str_keyval",
+                           NULL, test_visitor_in_time_str_keyval);
+    input_visitor_test_add("/visitor/input/time_str_fail",
+                           NULL, test_visitor_in_time_str_fail);
     input_visitor_test_add("/visitor/input/string",
                            NULL, test_visitor_in_string);
     input_visitor_test_add("/visitor/input/enum",
-- 
2.20.1


