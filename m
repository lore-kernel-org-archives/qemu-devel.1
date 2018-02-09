Received: from eggs.gnu.org ([2001:4830:134:3::10]:43644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wZ-0002Hu-NM
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wU-00069S-6o
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:07 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:10 +0100
Message-Id: <20180209092524.31348-16-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] s390x/tcg: remove SMP warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We should be pretty good in shape now. Floating interrupts are working
and atomic instructions should be atomic.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-15-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3807dcb097..2af3b3d112 100644
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
2.13.6
