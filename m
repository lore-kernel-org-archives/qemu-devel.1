Received: from eggs.gnu.org ([2001:4830:134:3::10]:53264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxr-0005l6-KL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxn-0002RU-Qx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxl-0001P6-Vz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2FB5307D844
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:18 +0100
Message-Id: <20181213184340.24037-11-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/32] docs: Update references to JSON RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

RFC8259 obsoletes RFC7159. Fix a couple of URLs to point to the
newer version.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181203175702.128701-1-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 2 +-
 docs/interop/qmp-spec.txt    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 53eaf01f34..2c8b392b20 100644
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
index 67e44a8120..adcf86754d 100644
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
