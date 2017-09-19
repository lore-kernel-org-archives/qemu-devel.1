Received: from eggs.gnu.org ([2001:4830:134:3::10]:39017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdZ-00069x-4t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdY-0002wo-BH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdY-0002w5-6J
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:11 +0200
Message-Id: <20170919164337.18555-13-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 12/38] cpu: drop old comments describing
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

These comments are obviously stale.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/qom/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 995a7beeb5..0dc767a753 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -388,10 +388,10 @@ struct CPUState {
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
 
     /* TODO Move common fields from CPUArchState here. */
-    int cpu_index; /* used by alpha TCG */
-    uint32_t halted; /* used by alpha, cris, ppc TCG */
+    int cpu_index;
+    uint32_t halted;
     uint32_t can_do_io;
-    int32_t exception_index; /* used by m68k TCG */
+    int32_t exception_index;
 
     /* shared by kvm, hax and hvf */
     bool vcpu_dirty;
-- 
2.13.5
