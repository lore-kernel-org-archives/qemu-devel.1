Received: from eggs.gnu.org ([2001:4830:134:3::10]:49661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXljX-0006nv-0v
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXljW-0005So-A4
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dXljW-0005Sc-47
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:57:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 19 Jul 2017 11:50:32 +0200
Message-Id: <20170719095033.20482-5-david@redhat.com>
In-Reply-To: <20170719095033.20482-1-david@redhat.com>
References: <20170719095033.20482-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/5] s390x/kvm: better comment regarding
 zPCI feature availability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index fe02315..3d0b7b3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2661,7 +2661,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         clear_bit(S390_FEAT_CMM_NT, model->features);
     }
 
-    /* set zpci and aen facilities */
+    /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
     set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
 
-- 
2.9.4
