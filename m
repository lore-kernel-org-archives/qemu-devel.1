Received: from eggs.gnu.org ([2001:4830:134:3::10]:51346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESm-0004wp-Ng
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESh-0002cH-7a
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYESh-0002bs-1x
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD75C806BA
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:34 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:12 +0200
Message-Id: <20170720162815.19802-9-ldoktor@redhat.com>
In-Reply-To: <20170720162815.19802-1-ldoktor@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/11] qmp.py: Avoid "has_key" usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

The "has_key" is deprecated in favor of "__in__" operator.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 scripts/qmp/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 68f3420..a14b001 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -197,7 +197,7 @@ class QEMUMonitorProtocol(object):
         Build and send a QMP command to the monitor, report errors when =
any
         """
         ret =3D self.cmd(cmd, kwds)
-        if ret.has_key('error'):
+        if "error" in ret:
             raise Exception(ret['error']['desc'])
         return ret['return']
=20
--=20
2.9.4
