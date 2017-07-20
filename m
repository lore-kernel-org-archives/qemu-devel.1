Received: from eggs.gnu.org ([2001:4830:134:3::10]:60797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6bi-0003jM-5L
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6bh-0006QM-3B
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:14:50 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6bg-0006PZ-S9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:14:49 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:14:46 +0200
Message-Id: <1500538486-23453-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH] vmxcap: Fix output formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

From: Stefan Fritsch <stefan_fritsch@genua.de>

One string is longer than 40 chars. Set the field width to 50.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
---
 scripts/kvm/vmxcap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index d9a6db0bb7..19506f45bf 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -69,7 +69,7 @@ class Control(object):
                 s = 'forced'
             elif one and zero:
                 s = 'yes'
-            print('  %-40s %s' % (self.bits[bit], s))
+            print('  %-50s %s' % (self.bits[bit], s))
 
 class Misc(object):
     def __init__(self, name, bits, msr):
@@ -94,7 +94,7 @@ class Misc(object):
                 def fmt(x):
                     return { True: 'yes', False: 'no' }[x]
             v = (value >> lo) & ((1 << (hi - lo + 1)) - 1)
-            print('  %-40s %s' % (self.bits[bits], fmt(v)))
+            print('  %-50s %s' % (self.bits[bits], fmt(v)))
 
 controls = [
     Misc(
-- 
2.11.0
