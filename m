Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaAX-0006XM-W8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gRaAS-0006nL-SJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:00:37 -0500
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Nov 2018 02:00:12 -0800
Message-Id: <1543312812-2929-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target: hax: fix errors in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, alex.bennee@linaro.org, philmd@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 target/i386/hax-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 502ce6f0af..b978a9b821 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
     }
 
     /*
-     * 1. The hax_tunnel is also destroied when vcpu destroy
+     * 1. The hax_tunnel is also destroyed when vcpu is destroyed
      * 2. close fd will cause hax module vcpu be cleaned
      */
     hax_close_fd(vcpu->fd);
-- 
2.11.0
