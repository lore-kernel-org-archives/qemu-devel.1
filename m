Received: from eggs.gnu.org ([2001:4830:134:3::10]:56942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB8-00062W-BY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB5-0000XH-9l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYJB5-0000Wh-3X
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8CB876A00
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 21:40:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 20 Jul 2017 16:40:04 -0500
Message-Id: <20170720214008.28494-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10? v2 0/4] random qapi cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Doc and testsuite changes only, so safe for softfreeze if we like
it (but no real harm if it slips to 2.11).

Since v1:
- drop changes that conflict with Markus' work-in-progress on virtual
alternates
- tweak comments per review from Markus

Eric Blake (4):
  tests: Enhance qobject output to cover partial visit
  qapi: Visitor documentation tweak
  qtest: Avoid passing raw strings through hmp()
  qtest: Document calling conventions

 include/qapi/visitor.h              | 14 ++++++-------
 tests/libqtest.h                    | 22 ++++++++++++-------
 tests/test-hmp.c                    |  4 ++--
 tests/test-qobject-output-visitor.c | 42 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.13.3
