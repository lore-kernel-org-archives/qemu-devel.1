Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb0L2-00040w-22
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fb0Ky-0001Lo-RR
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:14:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fb0Ky-0001L6-NG
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:14:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DA30407049A
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 09:14:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  5 Jul 2018 11:14:00 +0200
Message-Id: <20180705091402.26244-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Let's not chisel --preconfig in stone
 without a user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

Please refer to PATCH 1 for rationale.

Markus Armbruster (2):
  qapi: Do not expose "allow-preconfig" in query-qmp-schema
  cli qmp: Mark --preconfig, exit-preconfig experimental

 hmp.c                      |  2 +-
 qapi/introspect.json       |  5 +----
 qapi/misc.json             |  6 +++---
 qemu-options.hx            |  9 +++++----
 qemu-tech.texi             | 11 ++++-------
 qmp.c                      |  2 +-
 scripts/qapi/introspect.py |  3 +--
 tests/numa-test.c          |  2 +-
 tests/qmp-test.c           |  6 +++---
 9 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.17.1
