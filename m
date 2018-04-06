Received: from eggs.gnu.org ([2001:4830:134:3::10]:36456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utw-00084R-UB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utw-0007wO-1t
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:48 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:52478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utv-0007ue-QO
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:47 -0400
Received: by mail-wm0-x231.google.com with SMTP id g8so4834567wmd.2
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:18 +0200
Message-Id: <1523034681-33787-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/20] device-crash-test: Remove fixed isa-fdc
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Fixed by commit b3da551 ("fdc: Exit if ISA controller does not support DMA", 2018-03-16).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/device-crash-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 24c7bf5..5d17dc6 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -217,7 +217,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-- 
1.8.3.1
