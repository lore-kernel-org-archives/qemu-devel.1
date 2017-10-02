Received: from eggs.gnu.org ([2001:4830:134:3::10]:40321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JR-0005fG-Fg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1JP-0004je-OA
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1JP-0004j6-IN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95B8D80477
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-91.ams2.redhat.com
	[10.36.116.91])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FB699DDA
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:03:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:07 +0200
Message-Id: <20171002140307.5292-9-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] qemu-options: Belatedly document
 --watchdog-action inject-nmi
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Missed in commit 795dc6e46d, v2.4.0.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index b792c65149..32afc11296 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3596,7 +3596,7 @@ A virtual watchdog for s390x backed by the diagnose 288 hypercall
 ETEXI
 
 DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
-    "-watchdog-action reset|shutdown|poweroff|pause|debug|none\n" \
+    "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|none\n" \
     "                action when watchdog fires [default=reset]\n",
     QEMU_ARCH_ALL)
 STEXI
@@ -3610,6 +3610,7 @@ The default is
 Other possible actions are:
 @code{shutdown} (attempt to gracefully shutdown the guest),
 @code{poweroff} (forcefully poweroff the guest),
+@code{inject-nmi} (inject a NMI into the guest),
 @code{pause} (pause the guest),
 @code{debug} (print a debug message and continue), or
 @code{none} (do nothing).
-- 
2.13.6
