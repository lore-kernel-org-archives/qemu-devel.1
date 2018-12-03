Received: from eggs.gnu.org ([2001:4830:134:3::10]:46413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTsT2-00039k-4w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTsSz-0002Rs-1p
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTsSy-0002Qw-Ss
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:57:08 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Dec 2018 11:57:02 -0600
Message-Id: <20181203175702.128701-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] docs: Update references to JSON RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

RFC8259 obsoletes RFC7159. Fix a couple of URLs to point to the
newer version.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 2 +-
 docs/interop/qmp-spec.txt    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 53eaf01f340..2c8b392b20f 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -26,7 +26,7 @@ how the schemas, scripts, and resulting code are used.
 == QMP/Guest agent schema ==

 A QAPI schema file is designed to be loosely based on JSON
-(http://www.ietf.org/rfc/rfc7159.txt) with changes for quoting style
+(http://www.ietf.org/rfc/rfc8259.txt) with changes for quoting style
 and the use of comments; a QAPI schema file is then parsed by a python
 code generation program.  A valid QAPI schema consists of a series of
 top-level expressions, with no commas between them.  Where
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 8f7da0245d5..dea3369bb0c 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -32,7 +32,7 @@ following format:
 Where DATA-STRUCTURE-NAME is any valid JSON data structure, as defined
 by the JSON standard:

-http://www.ietf.org/rfc/rfc7159.txt
+http://www.ietf.org/rfc/rfc8259.txt

 The server expects its input to be encoded in UTF-8, and sends its
 output encoded in ASCII.
-- 
2.17.2
