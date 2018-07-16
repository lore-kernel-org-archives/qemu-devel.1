Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexzk-0006jl-Vo
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fexzj-0002mm-W5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fexzj-0002mf-QX
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:32:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 760DA402315B
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:32:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 09:32:24 +0200
Message-Id: <20180716073226.21127-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Make it easier to track feature deprecation
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

Markus Armbruster (2):
  qemu-doc: Move appendix "Deprecated features" to its own file
  MAINTAINERS: New section "Incompatible changes", copy libvir-list

 MAINTAINERS          |   4 +
 qemu-deprecated.texi | 234 ++++++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi        | 235 +------------------------------------------
 3 files changed, 239 insertions(+), 234 deletions(-)
 create mode 100644 qemu-deprecated.texi

-- 
2.17.1
