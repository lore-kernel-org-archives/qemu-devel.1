Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9J-0006sU-2S
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZ9G-0002Mu-0g
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZ9F-0002L9-Qf
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:46:41 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 15:46:05 +0200
Message-Id: <20170928134609.16985-2-david@redhat.com>
In-Reply-To: <20170928134609.16985-1-david@redhat.com>
References: <20170928134609.16985-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/5] MAINTAINERS: use KVM s390x maintainers
 for kvm-stubs.c and kvm_s390x.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>

Forgot it when factoring code out into these files. This is 100% s390x
KVM material.

Signed-off-by: David Hildenbrand <david@redhat.com>
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
2.13.5
