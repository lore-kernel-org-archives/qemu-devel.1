Received: from eggs.gnu.org ([2001:4830:134:3::10]:57395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GZ-0002y2-Df
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GX-0005dX-Qa
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GX-0005d4-K3
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:35 +0200
Message-Id: <20170830165252.13421-28-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 27/44] target/s390x: no need to pass kvm_state
 to savevm_gtod handlers
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

Let's avoid any KVM stuff in s390-virtio-ccw.c. This parameter is simply
ignored.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-6-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3a718953a2..42f0edac36 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -163,7 +163,7 @@ static void ccw_init(MachineState *machine)
     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
 
     /* Register savevm handler for guest TOD clock */
-    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, kvm_state);
+    register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
-- 
2.13.5
