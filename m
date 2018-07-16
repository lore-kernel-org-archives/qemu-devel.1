Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexzk-0006ji-0D
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexzg-0002ll-M8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fexzg-0002le-IX
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 267F7402178A
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:32:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 09:32:26 +0200
Message-Id: <20180716073226.21127-3-armbru@redhat.com>
In-Reply-To: <20180716073226.21127-1-armbru@redhat.com>
References: <20180716073226.21127-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] MAINTAINERS: New section "Incompatible
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
Cc: libvir-list@redhat.com, thuth@redhat.com, cohuck@redhat.com, pkrempa@redhat.com, berrange@redhat.com

Libvirt developers would like to be copied on patches to qemu-doc
appendix "Deprecated features".  Do them the favor.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
 
+Incompatible changes
+R: libvir-list@redhat.com
+F: qemu-deprecated.texi
+
 Build System
 ------------
 GIT submodules
-- 
2.17.1
