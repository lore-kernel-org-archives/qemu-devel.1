Received: from eggs.gnu.org ([2001:4830:134:3::10]:49181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJD-0007Wl-I6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIw-000416-Sa
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:54 +0200
Message-Id: <1502117160-24655-51-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 50/56] block: Make BLOCK_IMAGE_CORRUPTED
 offset, size unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

File offsets should use QAPI type 'size' (uint64_t).
BLOCK_IMAGE_CORRUPTED parameters @offset and @size are 'int'
(int64_t).  qcow2_signal_corruption() passes non-negative int64_t
values.

Change the event parameters to 'size', for QAPI/QMP consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3c6d448..64b84a5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3520,8 +3520,8 @@
   'data': { 'device'     : 'str',
             '*node-name' : 'str',
             'msg'        : 'str',
-            '*offset'    : 'int',
-            '*size'      : 'int',
+            '*offset'    : 'size',
+            '*size'      : 'size',
             'fatal'      : 'bool' } }
 
 ##
-- 
2.7.5
