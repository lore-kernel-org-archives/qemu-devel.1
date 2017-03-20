Received: from eggs.gnu.org ([2001:4830:134:3::10]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cpskB-0008JN-KQ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cpsk8-0000l9-IO
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:32:47 -0400
Received: from mbob.nabble.com ([162.253.133.15]:51270)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cpsk8-0000kJ-Cw
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:32:44 -0400
Received: from mtom.nabble.com (unknown [162.253.133.81])
	by mbob.nabble.com (Postfix) with ESMTP id 6F06D3F301BC
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 01:07:53 -0700 (PDT)
Date: Mon, 20 Mar 2017 01:32:41 -0700 (MST)
From: wangguang <wang.guang55@zte.com.cn>
Message-ID: <1489998761089-474098.post@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3]Fix Colo doc secondeary should be secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Subject: [PATCH] Fix Colo doc secondeary should be secondary
This is an error in COLO-FT.txt.
secondeary-disk0 should be secondary-disk0.

Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
---
 docs/COLO-FT.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index e289be2..bec7547 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -139,7 +139,7 @@ Secondary:
 { 'execute': 'nbd-server-start',
   'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx',
'port': '8889'} } }
 }
-{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0',
'writable': true } }
+{'execute': 'nbd-server-add', 'arguments': {'device': 'Secondary-disk0',
'writable': true } }
 
 Note:
   a. The qmp command nbd-server-start and nbd-server-add must be run
-- 
2.9.3





--
View this message in context: http://qemu.11.n7.nabble.com/PATCH-v3-Fix-Colo-doc-secondeary-should-be-secondary-tp474098.html
Sent from the Developer mailing list archive at Nabble.com.
