Received: from eggs.gnu.org ([2001:4830:134:3::10]:35611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtT-0003s2-CJ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benyux.xu@intel.com>) id 1dRJtR-0003sN-K9
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benyux.xu@intel.com>) id 1dRJtR-0003rM-AT
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:01:05 -0400
From: Benyu Xu <benyux.xu@intel.com>
Date: Sat,  1 Jul 2017 22:57:10 +0800
Message-Id: <1498921030-23255-4-git-send-email-benyux.xu@intel.com>
In-Reply-To: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
References: <1498921030-23255-1-git-send-email-benyux.xu@intel.com>
Subject: [Qemu-devel] [PATCH 3/3] add option -vcpupin into qemu-options.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, gordon.jin@intel.com, eddie.dong@intel.com, kevin.tian@intel.com, haozhong.zhang@intel.com, hongbo.wang@intel.com, hao.l.li@intel.com, xudong.hao@intel.com, tianyu.lan@intel.com, binx.wu@intel.com, benyux.xu@intel.com, benjamin_xby@163.com

Signed-off-by: Benyu Xu <benyux.xu@intel.com>
---
 qemu-options.hx | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..0c2cec3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -141,6 +141,25 @@ given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
 specifies the maximum number of hotpluggable CPUs.
 ETEXI
 
+DEF("vcpupin", HAS_ARG, QEMU_OPTION_vcpupin,
+    "-vcpupin [pcpu_id_list]\n"
+    "                use the host's physical or logical processor(pcpu) id\n"
+    "                to made a pcpu id list to set cpu affinity.\n"
+    "                here use ',' to seperate the single id or id sequence,\n"
+    "                use '-' as a id sequence's connector,\n"
+    "                eg.  qemu ... -smp 8 -vcpupin 0,2,4,6-10 ... \n"
+    "                this means qemu will pin 8 vcpus one by one and 1:1 to\n"
+    "                pcpu 0,2,4,6,7,8,9,10\n"
+    "                if pcpu_id_list=\"auto\", it means the pcpu id list is\n"
+    "                0,1,...,[smp_cpu_num-1]\n", QEMU_ARCH_ALL)
+STEXI
+@item -vcpupin @var{pcpu_id_list}
+@findex -vcpupin
+Pin the vcpus to pcpus(set CPU affinity). Use pcpus' id 0,1,2,3...etc. to
+make a valid pcpu id list, the vcpus will sequentially pin to the pcpus of
+this list 1:1 , this means we should use the @option{-smp} to allocate vcpus.
+ETEXI
+
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
-- 
1.8.3.1
