Received: from eggs.gnu.org ([2001:4830:134:3::10]:46357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPs-0001Oz-6i
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadPr-0005vx-Bg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadPr-0005v8-5p
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B73B14075E3C
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 08:45:34 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 16:45:04 +0800
Message-Id: <20180704084507.14560-7-peterx@redhat.com>
In-Reply-To: <20180704084507.14560-1-peterx@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 6/9] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Now it was not used any more.  Drop it, especially if we can do that
before we release QEMU 3.0.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/misc.json | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index f1860418e8..ceda21746b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3432,46 +3432,6 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
-##
-# @CommandDropReason:
-#
-# Reasons that caused one command to be dropped.
-#
-# @queue-full: the command queue is full. This can only occur when
-#              the client sends a new non-oob command before the
-#              response to the previous non-oob command has been
-#              received.
-#
-# Since: 2.12
-##
-{ 'enum': 'CommandDropReason',
-  'data': [ 'queue-full' ] }
-
-##
-# @COMMAND_DROPPED:
-#
-# Emitted when a command is dropped due to some reason.  Commands can
-# only be dropped when the oob capability is enabled.
-#
-# @id: The dropped command's "id" field.
-# FIXME Broken by design.  Events are broadcast to all monitors.  If
-# another monitor's client has a command with the same ID in flight,
-# the event will incorrectly claim that command was dropped.
-#
-# @reason: The reason why the command is dropped.
-#
-# Since: 2.12
-#
-# Example:
-#
-# { "event": "COMMAND_DROPPED",
-#   "data": {"result": {"id": "libvirt-102",
-#                       "reason": "queue-full" } } }
-#
-##
-{ 'event': 'COMMAND_DROPPED' ,
-  'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
-
 ##
 # @set-numa-node:
 #
-- 
2.17.1
