Received: from eggs.gnu.org ([2001:4830:134:3::10]:46203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gIXCd-0003P2-P4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gIXCQ-0004wX-5D
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:01:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gIXCP-0004wA-QU
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:01:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id p7-v6so862600plk.5
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 04:01:09 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Fri,  2 Nov 2018 04:01:03 -0700
Message-Id: <1541156463-2730-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] qapi: misc: change the 'pc' to unsinged 64 in
 CpuInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

When trigger a 'query-cpus' qmp, the pc is an signed value like
following:
{"arch": "x86", ...  "pc": -1732653994, "halted": true,...}
It is strange. Change it to uint64_t.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 qapi/misc.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 6c1c5c0a37..621ec6ce13 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -407,7 +407,7 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'CpuInfoX86', 'data': { 'pc': 'int' } }
+{ 'struct': 'CpuInfoX86', 'data': { 'pc': 'uint64' } }
 
 ##
 # @CpuInfoSPARC:
@@ -420,7 +420,7 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'CpuInfoSPARC', 'data': { 'pc': 'int', 'npc': 'int' } }
+{ 'struct': 'CpuInfoSPARC', 'data': { 'pc': 'uint64', 'npc': 'uint64' } }
 
 ##
 # @CpuInfoPPC:
@@ -431,7 +431,7 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'CpuInfoPPC', 'data': { 'nip': 'int' } }
+{ 'struct': 'CpuInfoPPC', 'data': { 'nip': 'uint64' } }
 
 ##
 # @CpuInfoMIPS:
@@ -442,7 +442,7 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'CpuInfoMIPS', 'data': { 'PC': 'int' } }
+{ 'struct': 'CpuInfoMIPS', 'data': { 'PC': 'uint64' } }
 
 ##
 # @CpuInfoTricore:
@@ -453,7 +453,7 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
+{ 'struct': 'CpuInfoTricore', 'data': { 'PC': 'uint64' } }
 
 ##
 # @CpuInfoRISCV:
@@ -464,7 +464,7 @@
 #
 # Since 2.12
 ##
-{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
+{ 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'uint64' } }
 
 ##
 # @CpuS390State:
-- 
2.11.0
