Received: from eggs.gnu.org ([2001:4830:134:3::10]:51118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYES8-0004S8-8S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYES4-0002I1-Vk
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:37:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYERs-0002CW-0N
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:37:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A6B68553D
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:43 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:15 +0200
Message-Id: <20170720162815.19802-12-ldoktor@redhat.com>
In-Reply-To: <20170720162815.19802-1-ldoktor@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/11] qtest.py: Avoid using mutable list as
 default argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

The list is a mutable object and is dangerous to use it. Recently the
QEMUMachine was adjusted to allow None as default, let's use it here as
well.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 scripts/qtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index e4b5788..ba3233c 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -76,7 +76,7 @@ class QEMUQtestProtocol(object):
 class QEMUQtestMachine(qemu.QEMUMachine):
     '''A QEMU VM'''
=20
-    def __init__(self, binary, args=3D[], name=3DNone, test_dir=3D"/var/=
tmp",
+    def __init__(self, binary, args=3DNone, name=3DNone, test_dir=3D"/va=
r/tmp",
                  socket_scm_helper=3DNone):
         if name is None:
             name =3D "qemu-%d" % os.getpid()
--=20
2.9.4
