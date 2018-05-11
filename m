Received: from eggs.gnu.org ([2001:4830:134:3::10]:49368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zz-0000aQ-DY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zv-0000fa-FR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:59 -0400
Received: from mail-he1eur01on0724.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::724]:32813
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fH3zv-0000WI-4j
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:55 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 11 May 2018 12:05:34 +0300
Message-Id: <1526029534-35771-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] qapi: avoid empty CpuInfoOther type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

the patch provides an example of a previously introduced data-partial
qapi union tag

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/misc.json | 48 ++++--------------------------------------------
 cpus.c         |  2 --
 2 files changed, 4 insertions(+), 46 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc..2059852 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -387,14 +387,14 @@
            'qom_path': 'str', 'thread_id': 'int',
            '*props': 'CpuInstanceProperties', 'arch': 'CpuInfoArch' },
   'discriminator': 'arch',
+  'data-partial': true,
   'data': { 'x86': 'CpuInfoX86',
             'sparc': 'CpuInfoSPARC',
             'ppc': 'CpuInfoPPC',
             'mips': 'CpuInfoMIPS',
             'tricore': 'CpuInfoTricore',
             's390': 'CpuInfoS390',
-            'riscv': 'CpuInfoRISCV',
-            'other': 'CpuInfoOther' } }
+            'riscv': 'CpuInfoRISCV' } }
 
 ##
 # @CpuInfoX86:
@@ -465,16 +465,6 @@
 { 'struct': 'CpuInfoRISCV', 'data': { 'pc': 'int' } }
 
 ##
-# @CpuInfoOther:
-#
-# No additional information is available about the virtual CPU
-#
-# Since: 2.6
-#
-##
-{ 'struct': 'CpuInfoOther', 'data': { } }
-
-##
 # @CpuS390State:
 #
 # An enumeration of cpu states that can be assumed by a virtual
@@ -575,38 +565,8 @@
                       'arch'         : 'CpuInfoArch',
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
-  'data'          : { 'aarch64'      : 'CpuInfoOther',
-                      'alpha'        : 'CpuInfoOther',
-                      'arm'          : 'CpuInfoOther',
-                      'cris'         : 'CpuInfoOther',
-                      'hppa'         : 'CpuInfoOther',
-                      'i386'         : 'CpuInfoOther',
-                      'lm32'         : 'CpuInfoOther',
-                      'm68k'         : 'CpuInfoOther',
-                      'microblaze'   : 'CpuInfoOther',
-                      'microblazeel' : 'CpuInfoOther',
-                      'mips'         : 'CpuInfoOther',
-                      'mips64'       : 'CpuInfoOther',
-                      'mips64el'     : 'CpuInfoOther',
-                      'mipsel'       : 'CpuInfoOther',
-                      'moxie'        : 'CpuInfoOther',
-                      'nios2'        : 'CpuInfoOther',
-                      'or1k'         : 'CpuInfoOther',
-                      'ppc'          : 'CpuInfoOther',
-                      'ppc64'        : 'CpuInfoOther',
-                      'ppcemb'       : 'CpuInfoOther',
-                      'riscv32'      : 'CpuInfoOther',
-                      'riscv64'      : 'CpuInfoOther',
-                      's390x'        : 'CpuInfoS390',
-                      'sh4'          : 'CpuInfoOther',
-                      'sh4eb'        : 'CpuInfoOther',
-                      'sparc'        : 'CpuInfoOther',
-                      'sparc64'      : 'CpuInfoOther',
-                      'tricore'      : 'CpuInfoOther',
-                      'unicore32'    : 'CpuInfoOther',
-                      'x86_64'       : 'CpuInfoOther',
-                      'xtensa'       : 'CpuInfoOther',
-                      'xtensaeb'     : 'CpuInfoOther' } }
+  'data-partial'  : true,
+  'data'          : { 's390x'        : 'CpuInfoS390' } }
 
 ##
 # @query-cpus-fast:
diff --git a/cpus.c b/cpus.c
index 5bcd3ec..bd0de44 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2273,8 +2273,6 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
         info->value->target = target;
         if (target == SYS_EMU_TARGET_S390X) {
             cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
-        } else {
-            /* do nothing for @CpuInfoOther */
         }
 
         if (!cur_item) {
-- 
2.7.4
