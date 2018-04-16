Received: from eggs.gnu.org ([2001:4830:134:3::10]:33573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f888O-0004R3-8r
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f888J-0003WF-Dj
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:41:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f888J-0003UV-9p
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B2EAEBFFD
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 17:41:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Apr 2018 19:41:29 +0200
Message-Id: <1523900489-25950-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/device-crash-test: Removed fixed CAN
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The CAN device crashes have been fixed with the commit
089eac81e1d34d202471c0a023284f47f4c5f00e already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 5d17dc6..b3ce720 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -218,9 +218,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
1.8.3.1
