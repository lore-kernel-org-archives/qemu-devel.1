Received: from eggs.gnu.org ([2001:4830:134:3::10]:43923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORe-0004pE-0k
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eOORd-00083d-CL
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:48:34 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Dec 2017 14:47:39 +0100
Message-Id: <20171211134740.8235-15-david@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2-12 14/15] s390x/tcg: remove SMP warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We should be pretty good in shape now. Floating interrupts are working
and atomic instructions should be atomic.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c1f96418fa..6e286711e3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -78,10 +78,6 @@ static void s390_init_cpus(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
 
-    if (tcg_enabled() && max_cpus > 1) {
-        error_report("WARNING: SMP support on s390x is experimental!");
-    }
-
     /* initialize possible_cpus */
     mc->possible_cpu_arch_ids(machine);
 
-- 
2.14.3
