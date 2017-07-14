Received: from eggs.gnu.org ([2001:4830:134:3::10]:54158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x3-0002Hj-Eh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x0-00020U-8n
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dW5x0-00020A-2G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0E293C33
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 19:08:28 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 14:08:22 -0500
Message-Id: <20170714190827.4083-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] random qapi cleanups
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

Trying to flush some of the random patches I have lying around
locally.  Some of these may have been posted to the list before,
perhaps as part of larger series, but I didn't bother to research
which parts came from where.

I'm not sure if this is in time for softfreeze; and if not, I'm
not sure how much is appropriate during freeze vs. being deferred
to 2.11.

Eric Blake (5):
  qapi: Further enhance visitor virtual walk doc example
  tests: Enhance qobject output to cover partial visit
  qapi: Visitor documentation tweak
  qtest: Avoid passing raw strings through hmp()
  qtest: Document calling conventions

 include/qapi/visitor.h              | 55 +++++++++++++++++++++++--------------
 tests/libqtest.h                    | 23 ++++++++++------
 tests/test-hmp.c                    |  4 +--
 tests/test-qobject-output-visitor.c | 46 ++++++++++++++++++++++++++++++-
 4 files changed, 96 insertions(+), 32 deletions(-)

-- 
2.9.4
