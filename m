Received: from eggs.gnu.org ([2001:4830:134:3::10]:39662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPoXw-0005rv-Ta
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPoXs-0007nx-Ro
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:57:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gPoXs-0007nK-Mv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 07:57:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 22 Nov 2018 13:57:18 +0100
Message-Id: <1542891438-13329-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing entries related
 to accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Add some files from accel/stubs/, include/hw/kvm/ and scripts/kvm/
to the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63c88e1..6522621 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -117,6 +117,7 @@ S: Maintained
 F: cpus.c
 F: exec.c
 F: accel/tcg/
+F: accel/stubs/tcg-stub.c
 F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/helper*.h
@@ -332,7 +333,10 @@ L: kvm@vger.kernel.org
 S: Supported
 F: */kvm.*
 F: accel/kvm/
+F: accel/stubs/kvm-stub.c
+F: include/hw/kvm/
 F: include/sysemu/kvm*.h
+F: scripts/kvm/kvm_flightrecorder
 
 ARM
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -375,6 +379,7 @@ M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
 F: target/i386/kvm.c
+F: scripts/kvm/vmxcap
 
 Guest CPU Cores (Xen):
 ----------------------
-- 
1.8.3.1
