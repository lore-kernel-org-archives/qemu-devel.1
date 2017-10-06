Received: from eggs.gnu.org ([2001:4830:134:3::10]:59037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRY-0006Qb-21
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRT-0008A3-GH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRT-00089T-AP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:43 +0200
Message-Id: <20171006095956.27534-21-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 20/33] MAINTAINERS: use KVM s390x maintainers
 for kvm-stubs.c and kvm_s390x.h
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

Forgot it when factoring code out into these files. This is 100% s390x
KVM material.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170928134609.16985-2-david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 932443df41..772ac209e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,6 +299,8 @@ M: Cornelia Huck <cohuck@redhat.com>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
 F: target/s390x/kvm.c
+F: target/s390x/kvm_s390x.h
+F: target/s390x/kvm-stub.c
 F: target/s390x/ioinst.[ch]
 F: target/s390x/machine.c
 F: hw/intc/s390_flic.c
-- 
2.13.6
