Received: from eggs.gnu.org ([2001:4830:134:3::10]:39734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSs-0001xo-Dd
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSo-0000m3-8E
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgzSn-0000lJ-VZ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F93A5145A
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1NJs4TJ020790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:54:05 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 20:53:41 +0100
Message-Id: <1487879642-16139-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487879642-16139-1-git-send-email-armbru@redhat.com>
References: <1487879642-16139-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/24] test-cutils: Add missing qemu_strtol()...
 endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1487708048-2131-4-git-send-email-armbru@redhat.com>
---
 tests/test-cutils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 20b0f59..71681dc 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -262,6 +262,7 @@ static void test_qemu_strtol_empty(void)
     err =3D qemu_strtol(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtol_whitespace(void)
@@ -275,6 +276,7 @@ static void test_qemu_strtol_whitespace(void)
     err =3D qemu_strtol(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtol_invalid(void)
@@ -288,6 +290,7 @@ static void test_qemu_strtol_invalid(void)
     err =3D qemu_strtol(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtol_trailing(void)
@@ -548,6 +551,7 @@ static void test_qemu_strtoul_empty(void)
     err =3D qemu_strtoul(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoul_whitespace(void)
@@ -561,6 +565,7 @@ static void test_qemu_strtoul_whitespace(void)
     err =3D qemu_strtoul(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoul_invalid(void)
@@ -574,6 +579,7 @@ static void test_qemu_strtoul_invalid(void)
     err =3D qemu_strtoul(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoul_trailing(void)
@@ -829,6 +835,7 @@ static void test_qemu_strtoll_empty(void)
     err =3D qemu_strtoll(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoll_whitespace(void)
@@ -842,6 +849,7 @@ static void test_qemu_strtoll_whitespace(void)
     err =3D qemu_strtoll(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoll_invalid(void)
@@ -855,6 +863,7 @@ static void test_qemu_strtoll_invalid(void)
     err =3D qemu_strtoll(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoll_trailing(void)
@@ -1113,6 +1122,7 @@ static void test_qemu_strtoull_empty(void)
     err =3D qemu_strtoull(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoull_whitespace(void)
@@ -1126,6 +1136,7 @@ static void test_qemu_strtoull_whitespace(void)
     err =3D qemu_strtoull(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoull_invalid(void)
@@ -1139,6 +1150,7 @@ static void test_qemu_strtoull_invalid(void)
     err =3D qemu_strtoull(str, &endptr, 0, &res);
=20
     g_assert_cmpint(err, =3D=3D, -EINVAL);
+    g_assert(endptr =3D=3D str);
 }
=20
 static void test_qemu_strtoull_trailing(void)
--=20
2.7.4
