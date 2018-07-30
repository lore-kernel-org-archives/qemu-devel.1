Received: from eggs.gnu.org ([2001:4830:134:3::10]:51559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fkAE3-000736-Rq
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fkAE1-0003xZ-5T
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fkAE0-0003xK-Vo
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 812AF7C6A9
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 15:36:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jul 2018 17:36:39 +0200
Message-Id: <20180730153639.26466-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build-sys: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The check should be unnecessary since commit
e7b3af81597db1a6b55f2c15d030d703c6b2c6ac "glib: bump min required glib
library version to 2.40".

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c             | 4 ----
 tests/test-x86-cpuid-compat.c | 6 ------
 tests/vhost-user-test.c       | 4 ----
 configure                     | 3 ---
 tests/Makefile.include        | 2 +-
 5 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31441..2a2ff32904 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -56,7 +56,6 @@ static void fe_event(void *opaque, int event)
     }
 }
=20
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 #ifdef _WIN32
 static void char_console_test_subprocess(void)
 {
@@ -106,7 +105,6 @@ static void char_stdio_test(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stdout("buf");
 }
-#endif
=20
 static void char_ringbuf_test(void)
 {
@@ -807,14 +805,12 @@ int main(int argc, char **argv)
     g_test_add_func("/char/invalid", char_invalid_test);
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
     g_test_add_func("/char/mux", char_mux_test);
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 #ifdef _WIN32
     g_test_add_func("/char/console/subprocess", char_console_test_subpro=
cess);
     g_test_add_func("/char/console", char_console_test);
 #endif
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess=
);
     g_test_add_func("/char/stdio", char_stdio_test);
-#endif
 #ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.=
c
index 84ce9c71ae..e75b959950 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -35,7 +35,6 @@ static QObject *qom_get(const char *path, const char *p=
rop)
     return ret;
 }
=20
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static bool qom_get_bool(const char *path, const char *prop)
 {
     QBool *value =3D qobject_to(QBool, qom_get(path, prop));
@@ -44,7 +43,6 @@ static bool qom_get_bool(const char *path, const char *=
prop)
     qobject_unref(value);
     return b;
 }
-#endif
=20
 typedef struct CpuidTestArgs {
     const char *cmdline;
@@ -168,7 +166,6 @@ static FeatureTestArgs *add_feature_test(const char *=
name, const char *cmdline,
     return args;
 }
=20
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static void test_plus_minus_subprocess(void)
 {
     char *path;
@@ -210,17 +207,14 @@ static void test_plus_minus(void)
                               "Don't mix both \"+cx8\" and \"cx8=3Doff\"=
*");
     g_test_trap_assert_stdout("");
 }
-#endif
=20
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
     g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
                     test_plus_minus_subprocess);
     g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
-#endif
=20
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index fecc832d99..e4d1dd5f35 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -772,7 +772,6 @@ static void wait_for_rings_started(TestServer *s, siz=
e_t count)
     g_mutex_unlock(&s->data_mutex);
 }
=20
-#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
 static inline void test_server_connect(TestServer *server)
 {
     test_server_create_chr(server, ",reconnect=3D1");
@@ -897,7 +896,6 @@ static void test_flags_mismatch(void)
     g_free(path);
 }
=20
-#endif
=20
 static void test_multiqueue(void)
 {
@@ -979,7 +977,6 @@ int main(int argc, char **argv)
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
=20
-#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
     /* keeps failing on build-system since Aug 15 2017 */
     if (getenv("QTEST_VHOST_USER_FIXME")) {
         qtest_add_func("/vhost-user/reconnect/subprocess",
@@ -992,7 +989,6 @@ int main(int argc, char **argv)
                        test_flags_mismatch_subprocess);
         qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch=
);
     }
-#endif
=20
     ret =3D g_test_run();
=20
diff --git a/configure b/configure
index b874615e02..c5d2dbcac9 100755
--- a/configure
+++ b/configure
@@ -6329,9 +6329,6 @@ if test "$bluez" =3D "yes" ; then
   echo "CONFIG_BLUEZ=3Dy" >> $config_host_mak
   echo "BLUEZ_CFLAGS=3D$bluez_cflags" >> $config_host_mak
 fi
-if test "$glib_subprocess" =3D "yes" ; then
-  echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=3Dy" >> $config_host_mak
-fi
 if test "$gtk" =3D "yes" ; then
   echo "CONFIG_GTK=3Dm" >> $config_host_mak
   echo "CONFIG_GTKABI=3D$gtkabi" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a49282704e..e75acfc3ed 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -124,7 +124,7 @@ check-unit-y +=3D tests/test-qht-par$(EXESUF)
 gcov-files-test-qht-par-y =3D util/qht.c
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
-check-unit-$(CONFIG_HAS_GLIB_SUBPROCESS_TESTS) +=3D tests/test-qdev-glob=
al-props$(EXESUF)
+check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
 check-unit-y +=3D tests/check-qom-interface$(EXESUF)
 gcov-files-check-qom-interface-y =3D qom/object.c
 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
--=20
2.18.0.232.gb7bd9486b0
