Received: from eggs.gnu.org ([2001:4830:134:3::10]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpweN-0004nh-Rw
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpweK-0007UA-IG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpweJ-0007Rk-UA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:19:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 404DA8197001
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 14:19:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Aug 2018 16:19:44 +0200
Message-Id: <20180815141945.10457-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] libqtest: Improve error reporting for bad
 read from QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com

Eric Blake's "[PATCH v4] tests/libqtest: Improve kill_qemu()" improves
how we report how QEMU terminated.  Sadly, we bypass kill_qemu() in
certain failure modes.  Fix that.

Based-on: <20180810132800.38549-1-eblake@redhat.com>

Markus Armbruster (1):
  libqtest: Improve error reporting for bad read from QEMU

 tests/libqtest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1
