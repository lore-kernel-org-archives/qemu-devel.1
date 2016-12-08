Received: from eggs.gnu.org ([2001:4830:134:3::10]:45099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTr-0004Qw-6S
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTn-0001ED-7V
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:51 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:9028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cEqTm-00018u-Jr
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 23:38:47 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 8 Dec 2016 12:37:08 +0800
Message-ID: <1481171829-116496-2-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
References: <1481171829-116496-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 1/2] sparc: fix a building error reported by
 kbuild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
Cc: luonengjun@huawei.com, mst@redhat.com, stefanha@redhat.com, weidong.huang@huawei.com, wu.wubin@huawei.com, xin.zeng@intel.com, claudio.fontana@huawei.com, herbert@gondor.apana.org.au, pasic@linux.vnet.ibm.com, davem@davemloft.net, jianjay.zhou@huawei.com, hanweidong@huawei.com, arei.gonglei@hotmail.com, cornelia.huck@de.ibm.com, xuquan8@huawei.com, longpeng2@huawei.com, wanzongshun@huawei.com, Gonglei <arei.gonglei@huawei.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

>> arch/sparc/include/asm/topology_64.h:44:44:
error: implicit declaration of function 'cpu_data'
[-Werror=implicit-function-declaration]

 #define topology_physical_package_id(cpu) (cpu_data(cpu).proc_id)
                                               ^
Let's include cpudata.h in topology_64.h.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 arch/sparc/include/asm/topology_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
index 7b4898a..2255430 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_NUMA
 
 #include <asm/mmzone.h>
+#include <asm/cpudata.h>
 
 static inline int cpu_to_node(int cpu)
 {
-- 
1.8.3.1
