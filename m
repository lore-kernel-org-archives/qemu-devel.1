Received: from eggs.gnu.org ([2001:4830:134:3::10]:34463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12X-00045A-9R
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12T-0002c4-9R
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz12T-0002a2-3e
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25C245F7B9
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 13:45:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 15:45:37 +0200
Message-Id: <20171002134538.23332-3-armbru@redhat.com>
In-Reply-To: <20171002134538.23332-1-armbru@redhat.com>
References: <20171002134538.23332-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] hmp-commands-info: Move Texinfo stanzas to
 conventional place
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

A command's STEXI..ETEXI stanza follows the command's initializer.
Two commands got them backwards.  Correct that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 574db7d24e..d27d3b1227 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -837,12 +837,6 @@ STEXI
 Show information about hotpluggable CPUs
 ETEXI
 
-STEXI
-@item info vm-generation-id
-@findex vm-generation-id
-Show Virtual Machine Generation ID
-ETEXI
-
     {
         .name       = "vm-generation-id",
         .args_type  = "",
@@ -852,10 +846,9 @@ ETEXI
     },
 
 STEXI
-@item info memory_size_summary
-@findex memory_size_summary
-Display the amount of initially allocated and present hotpluggable (if
-enabled) memory in bytes.
+@item info vm-generation-id
+@findex vm-generation-id
+Show Virtual Machine Generation ID
 ETEXI
 
     {
@@ -868,6 +861,13 @@ ETEXI
     },
 
 STEXI
+@item info memory_size_summary
+@findex memory_size_summary
+Display the amount of initially allocated and present hotpluggable (if
+enabled) memory in bytes.
+ETEXI
+
+STEXI
 @end table
 ETEXI
 
-- 
2.13.6
