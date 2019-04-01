Received: from eggs.gnu.org ([209.51.188.92]:58833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyRf-0007tw-U4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAyRe-0007gG-6q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAyRd-0007fh-Th
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CF46307D911
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 15:01:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 17:01:40 +0200
Message-Id: <20190401150140.29151-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] qdev: Delete unused LostTickPolicy "merge"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Commit 4e4fa398db6 "qdev: Introduce lost tick policy property"
(v1.1.0) created PropertyType PROP_TYPE_LOSTTICKPOLICY with values
"discard", "delay", "merge", and "slew".  Value "merge" has never been
used.  Delete it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..dc4cf9da20 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -172,17 +172,13 @@
 # @delay: continue to deliver ticks at the normal rate.  Guest time will be
 #         delayed due to the late tick
 #
-# @merge: merge the missed tick(s) into one tick and inject.  Guest time
-#         may be delayed, depending on how the OS reacts to the merging
-#         of ticks
-#
 # @slew: deliver ticks at a higher rate to catch up with the missed tick. The
 #        guest time should not be delayed once catchup is complete.
 #
 # Since: 2.0
 ##
 { 'enum': 'LostTickPolicy',
-  'data': ['discard', 'delay', 'merge', 'slew' ] }
+  'data': ['discard', 'delay', 'slew' ] }
 
 ##
 # @add_client:
-- 
2.17.2
