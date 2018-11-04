Received: from eggs.gnu.org ([2001:4830:134:3::10]:41876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGi2-0007eT-BP
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGi0-0002pa-6S
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJGhz-0002js-6a
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun,  4 Nov 2018 11:24:22 +0000
Message-Id: <20181104112424.18663-7-stefanha@redhat.com>
In-Reply-To: <20181104112424.18663-1-stefanha@redhat.com>
References: <20181104112424.18663-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] pc-testdev: use HTTPS git URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/misc/pc-testdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 697eb88c97..0aee04f231 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -32,7 +32,7 @@
  * -kernel /home/lmr/Code/virt-test.git/kvm/unittests/msr.flat
  *
  * Where msr.flat is one of the KVM unittests, present on a separate repo,
- * git://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
+ * https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
 */
 
 #include "qemu/osdep.h"
-- 
2.17.2
