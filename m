Received: from eggs.gnu.org ([2001:4830:134:3::10]:48488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIh-0006uh-Kk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIY-0003eY-4o
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:35 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:09 +0200
Message-Id: <1502117160-24655-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 05/56] char: Make ringbuf size unsigned in
 QAPI
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

Sizes should use QAPI type 'size' (uint64_t).  ChardevRingbuf member
@size is 'int' (int64_t).  Doesn't really matter, as its users
chardev-add and chardev-change manually reject sizes that aren't
powers of two.

Change the ChardevRingbuf member to 'size' anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 18ec301..f4a71df 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5106,7 +5106,7 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'int' },
+{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'size' },
   'base': 'ChardevCommon' }
 
 ##
-- 
2.7.5
