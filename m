Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egCfO-0001hN-GE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egCfN-0006Rn-Ee
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:52:22 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 29 Jan 2018 17:52:10 +0100
Message-Id: <20180129165210.21086-3-cohuck@redhat.com>
In-Reply-To: <20180129165210.21086-1-cohuck@redhat.com>
References: <20180129165210.21086-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/2] s390x/cpumodel: allow zpci features in
 qemu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

AEN can be provided unconditionally, ZPCI has to be turned on
manually (it should really depend on CONFIG_PCI).

With -cpu qemu,zpci=on, a 4.15 guest kernel can now successfully
detect virtio-pci devices under tcg.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/gen-features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0570f597ec..db7ac965a0 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -574,6 +574,7 @@ static uint16_t qemu_LATEST[] = {
     S390_FEAT_INTERLOCKED_ACCESS_2,
     S390_FEAT_MSA_EXT_4,
     S390_FEAT_MSA_EXT_3,
+    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
 };
 
 /* add all new definitions before this point */
@@ -582,6 +583,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_STFLE_53,
     /* generates a dependency warning, leave it out for now */
     S390_FEAT_MSA_EXT_5,
+    /* should be conditional on CONFIG_PCI */
+    S390_FEAT_ZPCI,
 };
 
 /****** END FEATURE DEFS ******/
-- 
2.13.6
