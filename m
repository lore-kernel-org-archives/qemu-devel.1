Received: from eggs.gnu.org ([2001:4830:134:3::10]:49480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyRf-0007WO-KS
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUyRc-0004sd-KP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUyRc-0004rq-Fk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:00:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 19:59:56 +0200
Message-Id: <20180618175958.29073-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Fix compilation with python-3 if
 en_US.UTF-8 is unavailable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tamiko@43-1.org, arfrever.fta@gmail.com

v4:
 - Rewrite PATCH 1.

v3:
 - reverse order of patches
 - rename second patch to "Revert commit ..."
 - drop "UTF-8" argument in decode()/encode(); bot functions default to
   utf-8 already.

v2:
 - ensure compatibility with python2 by only calling encode()/decode() if
   script is run with a python3 interpreter

Markus Armbruster (1):
  qapi: Open files with encoding='utf-8'

Matthias Maier (1):
  Revert commit d4e5ec877ca

 Makefile               |  6 ++----
 scripts/qapi/common.py | 17 ++++++++++++++---
 tests/Makefile.include |  6 +++---
 3 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.17.1
