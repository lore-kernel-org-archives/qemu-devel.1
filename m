Received: from eggs.gnu.org ([2001:4830:134:3::10]:37401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotXA-0004FM-Cy
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotX5-0000sK-LO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotX5-0000rw-F1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:42:59 +0200
Message-Id: <20170904154316.4148-3-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/19] cpu: drop old comments describing
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

These comments are obviously stale.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qom/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index b7ac9491c8..386ab0af40 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -378,10 +378,10 @@ struct CPUState {
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
