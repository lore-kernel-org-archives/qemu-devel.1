Received: from eggs.gnu.org ([2001:4830:134:3::10]:58930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFc-0004eY-44
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFZ-00035a-NQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFY-0002nk-V2
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:54 -0400
Message-Id: <20181019010625.25294-26-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 25/56] exec: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 4fd831ef06..6006902975 100644
--- a/exec.c
+++ b/exec.c
@@ -776,7 +776,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
 
     /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
        version_id is increased. */
-    cpu->interrupt_request &= ~0x01;
+    cpu_reset_interrupt(cpu, ~0x01);
     tlb_flush(cpu);
 
     /* loadvm has just updated the content of RAM, bypassing the
-- 
2.17.1
