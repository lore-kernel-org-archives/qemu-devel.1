Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvIU0-00036F-UJ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvIU0-0001wO-4a
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dvITz-0001ve-VQ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:44 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 22 Sep 2017 09:34:32 +0200
Message-Id: <20170922073432.2811-2-cohuck@redhat.com>
In-Reply-To: <20170922073432.2811-1-cohuck@redhat.com>
References: <20170922073432.2811-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] s390x/ais: for 2.10 stable: disable ais
 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, mdroth@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The migration interface for ais was introduced with kernel 4.13
but the capability itself had been active since 4.12. As migration
support is considered necessary lets disable ais in the 2.10
stable version. A proper fix and re-enablement will be done
for qemu 2.11.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20170921140834.14233-2-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 720cb1d833..ebb75cafaa 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -311,8 +311,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    /* Try to enable AIS facility */
-    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    /*
+     * The migration interface for ais was introduced with kernel 4.13
+     * but the capability itself had been active since 4.12. As migration
+     * support is considered necessary let's disable ais in the 2.10
+     * machine.
+     */
+    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
 
     qemu_mutex_init(&qemu_sigp_mutex);
 
-- 
2.13.5
