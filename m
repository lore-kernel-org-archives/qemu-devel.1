Received: from eggs.gnu.org ([2001:4830:134:3::10]:49241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhC-0001sw-JG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhB-00079C-UU
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhB-00078s-OE
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:38 +0200
Message-Id: <20170818114353.13455-4-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 03/18] target/s390x: simplify
 ri_allowed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Only used in KVM and there is no reason why it shouldn't be allowed for
tcg - it is simply not available.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c7af39..3a674f5 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -276,9 +276,6 @@ static S390CcwMachineClass *get_machine_class(void)
 
 bool ri_allowed(void)
 {
-    if (!kvm_enabled()) {
-        return false;
-    }
     /* for "none" machine this results in true */
     return get_machine_class()->ri_allowed;
 }
-- 
2.9.4
