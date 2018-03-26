Received: from eggs.gnu.org ([2001:4830:134:3::10]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ0-0006YU-KZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIz-0006xt-RL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:58 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIz-0006x8-LJ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:57 -0400
Received: by mail-wr0-x22d.google.com with SMTP id d10so18957035wrf.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:35 +0200
Message-Id: <1522071403-52486-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/16] scripts/device-crash-test: Remove fixed
 isapc-with-iommu entry
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

Fixed in a0c167a18470831e359f0538c3cf67907808f13e ("x86_iommu: check
if machine has PCI bus").

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1521193892-15552-5-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/device-crash-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index c1b2c78..24c7bf5 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -219,7 +219,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
-- 
1.8.3.1
