Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D3C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23F921955
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FSDJINYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23F921955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpv4i-0002uK-UB
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpv40-0008M0-5o
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hpv3y-0003w5-M4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:44 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hpv3y-0003vH-Av
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:42:42 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 06CB72E14FF;
 Tue, 23 Jul 2019 16:42:40 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 bUF0FMhxxG-gdNCXqIH; Tue, 23 Jul 2019 16:42:39 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563889359; bh=+Sg2s8EViammw1Q6KCDgexNkoAD5O7PCpMnjCmLWR9Q=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=FSDJINYbJBsLg9NnBG7zmyOFyytj33EhnomZupig03gtF+Qywesg0JE54pkD0H4bL
 PfQDv+YSqyxKPEhVdgQpq+vF9eUJxaY5LeGLNsdT7myhLDzhbRXDTII72Lme5pyj2Q
 hRiWvtV/BlHctZI4V0yWQLBUA2s6cGrrSYQn/0dI=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:1a])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 cJSCJL4WEY-gdAmPsSq; Tue, 23 Jul 2019 16:42:39 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Date: Tue, 23 Jul 2019 16:42:14 +0300
Message-Id: <20190723134215.25095-4-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
References: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: [Qemu-devel] [PATCH v4 3/3] tests/migration: Add a test for auto
 converge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/migration-test.c | 103 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index a4feb9545d..b783ae47b3 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -241,6 +241,17 @@ static int64_t read_ram_property_int(QTestState *who=
, const char *property)
     return result;
 }
=20
+static int64_t read_migrate_property_int(QTestState *who, const char *pr=
operty)
+{
+    QDict *rsp_return;
+    int64_t result;
+
+    rsp_return =3D migrate_query(who);
+    result =3D qdict_get_try_int(rsp_return, property, 0);
+    qobject_unref(rsp_return);
+    return result;
+}
+
 static uint64_t get_migration_pass(QTestState *who)
 {
     return read_ram_property_int(who, "dirty-sync-count");
@@ -255,20 +266,22 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
=20
+static bool check_migration_status(QTestState *who, const char *status)
+{
+    bool completed;
+    char *current_status;
+
+    current_status =3D migrate_query_status(who);
+    completed =3D strcmp(current_status, status) =3D=3D 0;
+    g_assert_cmpstr(current_status, !=3D, "failed");
+    g_free(current_status);
+    return completed;
+}
+
 static void wait_for_migration_status(QTestState *who,
                                       const char *goal)
 {
-    while (true) {
-        bool completed;
-        char *status;
-
-        status =3D migrate_query_status(who);
-        completed =3D strcmp(status, goal) =3D=3D 0;
-        g_assert_cmpstr(status, !=3D,  "failed");
-        g_free(status);
-        if (completed) {
-            return;
-        }
+    while (!check_migration_status(who, goal)) {
         usleep(1000);
     }
 }
@@ -1121,6 +1134,73 @@ static void test_migrate_fd_proto(void)
     test_migrate_end(from, to, true);
 }
=20
+static void test_migrate_auto_converge(void)
+{
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining, percentage;
+
+    /*
+     * We want the test to be fast enough, but stable.
+     * Throttle percentages are chosen to cover all cases (init, increme=
nt, max)
+     */
+    static const int64_t expected_pcts[] =3D { 0, 1, 51, 98 };
+    const int64_t max_bandwidth =3D 200000000; /* ~200Mb/s */
+    const int64_t downtime_limit =3D 50; /* 50ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold =3D max_bandwidth * downtime_limit =
/ 1000;
+
+    if (test_migrate_start(&from, &to, uri, false, false)) {
+        return;
+    }
+
+    migrate_set_capability(from, "auto-converge", true);
+    migrate_set_parameter_int(from, "cpu-throttle-initial", expected_pct=
s[1]);
+    migrate_set_parameter_int(from, "cpu-throttle-increment",
+                              expected_pcts[2] - expected_pcts[1]);
+    migrate_set_parameter_int(from, "max-cpu-throttle", expected_pcts[3]=
);
+
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+
+    /* To check remaining size after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    /*
+     * Wait for pre-switchover status to check last throttle percentage
+     * and remaining. These values will be zeroed later
+     */
+    wait_for_migration_status(from, "pre-switchover");
+
+    /* We expect that migration can't converge without throttling */
+    percentage =3D read_migrate_property_int(from, "cpu-throttle-percent=
age");
+    g_assert_cmpint(percentage, >, 0);
+
+    remaining =3D read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <, expected_threshold);
+
+    wait_command(from, "{ 'execute': 'migrate-continue' , 'arguments':"
+                       "  { 'state': 'pre-switchover' } }");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    g_free(uri);
+
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1176,6 +1256,7 @@ int main(int argc, char **argv)
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
     qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
+    qtest_add_func("/migration/auto_converge", test_migrate_auto_converg=
e);
=20
     ret =3D g_test_run();
=20
--=20
2.22.0


