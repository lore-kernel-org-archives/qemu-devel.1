Received: from eggs.gnu.org ([2001:4830:134:3::10]:59555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUuj-0004Qn-GD
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUuf-0008UR-IL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:45 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:52725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsUuf-0008Th-BS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:41 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 45F4DAC1E1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 16:14:39 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 16:14:33 +0200
Message-ID: <150539847337.21523.1659017394355445790.stgit@bahia>
In-Reply-To: <150539846159.21523.16161730500010192093.stgit@bahia>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] checkpatch: add hwaddr to @typeList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

The script doesn't know about all possible types and learn them as
it parses the code. If it reaches a line with a type cast but the
type isn't known yet, it is misinterpreted as an identifier.

For example the following line:

    foo = (hwaddr) -1;

results in the following false-positive to be reported:

ERROR: spaces required around that '-' (ctx:VxV)

Let's add this standard QEMU type to the list of pre-known types.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 scripts/checkpatch.pl |    1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fa478074b88d..def5bc1cc0e1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -213,6 +213,7 @@ our @typeList = (
 	qr{${Ident}_handler},
 	qr{${Ident}_handler_fn},
 	qr{target_(?:u)?long},
+	qr{hwaddr},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
