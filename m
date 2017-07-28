Received: from eggs.gnu.org ([2001:4830:134:3::10]:41338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5gJ-0000qI-Rq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5gF-0007fW-5l
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db5gF-0007eb-04
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0E2A3E2A4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:45:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 28 Jul 2017 15:45:52 +0200
Message-Id: <1501249552-788-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1501249552-788-1-git-send-email-armbru@redhat.com>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] block: Remove unused BlockDeviceMapEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

BlockDeviceMapEntry has never been used.  It was added in commit
facd6e2 "so that it is published through the introspection mechanism."
What exactly introspecting types that aren't used for anything could
accomplish isn't clear.  What "introspection mechanism" to use is also
nebulous.  To the best of my knowledge, there has never been one that
covered this type.  Certainly not query-qmp-schema, which includes
only types that are actually used in QMP.

Not being able to introspect BlockDeviceMapEntry hasn't bothered
anyone enough to complain in almost four years.  Get rid of it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602..27790f3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -383,35 +383,6 @@
 { 'enum': 'BlockDeviceIoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
 
 ##
-# @BlockDeviceMapEntry:
-#
-# Entry in the metadata map of the device (returned by "qemu-img map")
-#
-# @start: Offset in the image of the first byte described by this entry
-#         (in bytes)
-#
-# @length: Length of the range described by this entry (in bytes)
-#
-# @depth: Number of layers (0 = top image, 1 = top image's backing file, etc.)
-#         before reaching one for which the range is allocated.  The value is
-#         in the range 0 to the depth of the image chain - 1.
-#
-# @zero: the sectors in this range read as zeros
-#
-# @data: reading the image will actually read data from a file (in particular,
-#        if @offset is present this means that the sectors are not simply
-#        preallocated, but contain actual data in raw format)
-#
-# @offset: if present, the image file stores the data for this range in
-#          raw format at the given offset.
-#
-# Since: 1.7
-##
-{ 'struct': 'BlockDeviceMapEntry',
-  'data': { 'start': 'int', 'length': 'int', 'depth': 'int', 'zero': 'bool',
-            'data': 'bool', '*offset': 'int' } }
-
-##
 # @DirtyBitmapStatus:
 #
 # An enumeration of possible states that a dirty bitmap can report to the user.
-- 
2.7.5
