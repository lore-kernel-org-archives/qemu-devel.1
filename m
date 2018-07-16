Received: from eggs.gnu.org ([2001:4830:134:3::10]:33995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47r-0001pw-Qm
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47o-0007vu-Oa
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47o-0007vT-D1
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F25FE81663CE
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD612156893
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:13 +0200
Message-Id: <20180716140514.1490-5-armbru@redhat.com>
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] MAINTAINERS: New section "Incompatible
 changes", copy libvir-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Libvirt developers would like to be copied on patches to qemu-doc
appendix "Deprecated features".  Do them the favor.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180716073226.21127-3-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20eef3cb61..666e936812 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2194,6 +2194,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: docs/devel/build-system.txt
=20
+Incompatible changes
+R: libvir-list@redhat.com
+F: qemu-deprecated.texi
+
 Build System
 ------------
 GIT submodules
--=20
2.17.1
