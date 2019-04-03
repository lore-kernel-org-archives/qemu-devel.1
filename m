Received: from eggs.gnu.org ([209.51.188.92]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeX7-0003jc-DX
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeWz-0002Fv-45
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeWx-0002EF-Pc
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:58:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 324BA3086204
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:53 +0200
Message-Id: <20190403114958.3705-4-quintela@redhat.com>
In-Reply-To: <20190403114958.3705-1-quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/8] migration-test: rename parameter to
 parameter_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

We would need _str ones on the next patch.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 49 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index bd3f5c3125..0b25aa3d6c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -392,7 +392,8 @@ static char *migrate_get_socket_address(QTestState *w=
ho, const char *parameter)
     return result;
 }
=20
-static long long migrate_get_parameter(QTestState *who, const char *para=
meter)
+static long long migrate_get_parameter_int(QTestState *who,
+                                           const char *parameter)
 {
     QDict *rsp;
     long long result;
@@ -403,17 +404,17 @@ static long long migrate_get_parameter(QTestState *=
who, const char *parameter)
     return result;
 }
=20
-static void migrate_check_parameter(QTestState *who, const char *paramet=
er,
-                                    long long value)
+static void migrate_check_parameter_int(QTestState *who, const char *par=
ameter,
+                                        long long value)
 {
     long long result;
=20
-    result =3D migrate_get_parameter(who, parameter);
+    result =3D migrate_get_parameter_int(who, parameter);
     g_assert_cmpint(result, =3D=3D, value);
 }
=20
-static void migrate_set_parameter(QTestState *who, const char *parameter=
,
-                                  long long value)
+static void migrate_set_parameter_int(QTestState *who, const char *param=
eter,
+                                      long long value)
 {
     QDict *rsp;
=20
@@ -423,7 +424,7 @@ static void migrate_set_parameter(QTestState *who, co=
nst char *parameter,
                     parameter, value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    migrate_check_parameter(who, parameter, value);
+    migrate_check_parameter_int(who, parameter, value);
 }
=20
 static void migrate_pause(QTestState *who)
@@ -672,7 +673,7 @@ static void deprecated_set_downtime(QTestState *who, =
const double value)
                     " 'arguments': { 'value': %f } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    migrate_check_parameter(who, "downtime-limit", value * 1000);
+    migrate_check_parameter_int(who, "downtime-limit", value * 1000);
 }
=20
 static void deprecated_set_speed(QTestState *who, long long value)
@@ -683,7 +684,7 @@ static void deprecated_set_speed(QTestState *who, lon=
g long value)
                           "'arguments': { 'value': %lld } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    migrate_check_parameter(who, "max-bandwidth", value);
+    migrate_check_parameter_int(who, "max-bandwidth", value);
 }
=20
 static void deprecated_set_cache_size(QTestState *who, long long value)
@@ -694,7 +695,7 @@ static void deprecated_set_cache_size(QTestState *who=
, long long value)
                          "'arguments': { 'value': %lld } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
-    migrate_check_parameter(who, "xbzrle-cache-size", value);
+    migrate_check_parameter_int(who, "xbzrle-cache-size", value);
 }
=20
 static void test_deprecated(void)
@@ -729,8 +730,8 @@ static int migrate_postcopy_prepare(QTestState **from=
_ptr,
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    migrate_set_parameter(from, "max-bandwidth", 100000000);
-    migrate_set_parameter(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
+    migrate_set_parameter_int(from, "downtime-limit", 1);
=20
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -781,7 +782,7 @@ static void test_postcopy_recovery(void)
     }
=20
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
-    migrate_set_parameter(from, "max-postcopy-bandwidth", 4096);
+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
=20
     /* Now we start the postcopy */
     migrate_postcopy_start(from, to);
@@ -822,7 +823,7 @@ static void test_postcopy_recovery(void)
     g_free(uri);
=20
     /* Restore the postcopy bandwidth to unlimited */
-    migrate_set_parameter(from, "max-postcopy-bandwidth", 0);
+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
=20
     migrate_postcopy_complete(from, to);
 }
@@ -868,9 +869,9 @@ static void test_precopy_unix(void)
      * machine, so also set the downtime.
      */
     /* 1 ms should make it not converge*/
-    migrate_set_parameter(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "downtime-limit", 1);
     /* 1GB/s */
-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
=20
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -880,7 +881,7 @@ static void test_precopy_unix(void)
     wait_for_migration_pass(from);
=20
     /* 300 ms should converge */
-    migrate_set_parameter(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", 300);
=20
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -947,11 +948,11 @@ static void test_xbzrle(const char *uri)
      * machine, so also set the downtime.
      */
     /* 1 ms should make it not converge*/
-    migrate_set_parameter(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "downtime-limit", 1);
     /* 1GB/s */
-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
=20
-    migrate_set_parameter(from, "xbzrle-cache-size", 33554432);
+    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
=20
     migrate_set_capability(from, "xbzrle", "true");
     migrate_set_capability(to, "xbzrle", "true");
@@ -963,7 +964,7 @@ static void test_xbzrle(const char *uri)
     wait_for_migration_pass(from);
=20
     /* 300ms should converge */
-    migrate_set_parameter(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", 300);
=20
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -999,9 +1000,9 @@ static void test_precopy_tcp(void)
      * machine, so also set the downtime.
      */
     /* 1 ms should make it not converge*/
-    migrate_set_parameter(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "downtime-limit", 1);
     /* 1GB/s */
-    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
=20
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -1013,7 +1014,7 @@ static void test_precopy_tcp(void)
     wait_for_migration_pass(from);
=20
     /* 300ms should converge */
-    migrate_set_parameter(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", 300);
=20
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
--=20
2.20.1
