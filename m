Received: from eggs.gnu.org ([2001:4830:134:3::10]:35314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU3-0003tx-A3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReU2-0001pO-GY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReU2-0001oC-7u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id j10so22939362wru.4
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:37:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:33 +0100
Message-Id: <1543329397-48407-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] MAINTAINERS: Add some missing entries
 related to accelerators
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

Add some files from accel/stubs/, include/hw/kvm/ and scripts/kvm/
to the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1542891438-13329-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9410bbb..c7acb55 100644
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
@@ -341,7 +342,10 @@ L: kvm@vger.kernel.org
 S: Supported
 F: */kvm.*
 F: accel/kvm/
+F: accel/stubs/kvm-stub.c
+F: include/hw/kvm/
 F: include/sysemu/kvm*.h
+F: scripts/kvm/kvm_flightrecorder
 
 ARM
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -384,6 +388,7 @@ M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
 F: target/i386/kvm.c
+F: scripts/kvm/vmxcap
 
 Guest CPU Cores (Xen):
 ----------------------
-- 
1.8.3.1
