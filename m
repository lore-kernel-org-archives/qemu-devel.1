Received: from eggs.gnu.org ([2001:4830:134:3::10]:57319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GT-0002r1-GU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6GS-0005bA-Om
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6GS-0005aj-IS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:33 +0200
Message-Id: <20170830165252.13421-26-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 25/44] target/s390x: simplify ri_allowed()
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

Only used in KVM and there is no reason why it shouldn't be allowed for
tcg - it is simply not available.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-4-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8331c0a275..cdf7fa042b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -278,9 +278,6 @@ static S390CcwMachineClass *get_machine_class(void)
 
 bool ri_allowed(void)
 {
-    if (!kvm_enabled()) {
-        return false;
-    }
     /* for "none" machine this results in true */
     return get_machine_class()->ri_allowed;
 }
-- 
2.13.5
