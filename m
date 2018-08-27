Received: from eggs.gnu.org ([2001:4830:134:3::10]:57810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVv-0005tj-5e
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVs-00067y-GO
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuBVs-00067g-9d
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 09:00:15 +0200
Message-Id: <20180827070021.11931-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] json: More fixes,
 error reporting improvements, cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Just a few patches to follow up on "json: Fixes, error reporting
improvements, cleanups".

Markus Armbruster (6):
  json: Fix lexer for lookahead character beyond '\x7F'
  json: Clean up how lexer consumes "end of input"
  json: Make lexer's "character consumed" logic less confusing
  json: Nicer recovery from lexical errors
  json: Eliminate lexer state IN_ERROR
  json: Eliminate lexer state IN_WHITESPACE, pseudo-token JSON_SKIP

 qobject/json-lexer.c      | 108 +++++++++++++++++++++-----------------
 qobject/json-parser-int.h |  10 ++--
 tests/qmp-test.c          |   6 +--
 3 files changed, 65 insertions(+), 59 deletions(-)

-- 
2.17.1
