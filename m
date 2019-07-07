Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8FC48BE1
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA21F2082F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA21F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8I0-00051n-51
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8E3-0008G4-A3
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8E0-0003TU-To
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:31571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8Dz-00038w-Up
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497853"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:32:57 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:54 +0800
Message-Id: <20190707142958.31316-11-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190707142958.31316-1-tao3.xu@intel.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 10/14] numa: Extend the CLI to provide
 memory side cache information
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-cache option to provide Memory Side Cache Information.
These memory attributes help to build Memory Side Cache Information
Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - Add add reference to ACPI 6.3 spec (Igor)
---
 numa.c          | 68 +++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json  | 81 +++++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx | 16 ++++++++--
 3 files changed, 161 insertions(+), 4 deletions(-)

diff --git a/numa.c b/numa.c
index db5fe8c12f..1cbfb8ab4e 100644
--- a/numa.c
+++ b/numa.c
@@ -307,6 +307,68 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
     }
 }
 
+static
+void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
+                            Error **errp)
+{
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    HMAT_Cache_Info *hmat_cache = NULL;
+
+    if (node->node_id >= nb_numa_nodes) {
+        error_setg(errp, "Invalid node-id=%" PRIu32
+                   ", it should be less than %d.",
+                   node->node_id, nb_numa_nodes);
+        return;
+    }
+
+    if (node->total > MAX_HMAT_CACHE_LEVEL) {
+        error_setg(errp, "Invalid total=%" PRIu8
+                   ", it should be less than or equal to %d.",
+                   node->total, MAX_HMAT_CACHE_LEVEL);
+        return;
+    }
+    if (node->level > node->total) {
+        error_setg(errp, "Invalid level=%" PRIu8
+                   ", it should be less than or equal to"
+                   " total=%" PRIu8 ".",
+                   node->level, node->total);
+        return;
+    }
+    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
+        error_setg(errp, "Duplicate configuration of the side cache for "
+                   "node-id=%" PRIu32 " and level=%" PRIu8 ".",
+                   node->node_id, node->level);
+        return;
+    }
+
+    if ((node->level > 1) &&
+        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
+        (node->size >=
+            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
+        error_setg(errp, "Invalid size=0x%" PRIx64
+                   ", the size of level=%" PRIu8
+                   " should be less than the size(0x%" PRIx64
+                   ") of level=%" PRIu8 ".",
+                   node->size, node->level,
+                   ms->numa_state->hmat_cache[node->node_id]
+                                             [node->level - 1]->size,
+                   node->level - 1);
+        return;
+    }
+
+    hmat_cache = g_malloc0(sizeof(*hmat_cache));
+
+    hmat_cache->mem_proximity = node->node_id;
+    hmat_cache->size = node->size;
+    hmat_cache->total_levels = node->total;
+    hmat_cache->level = node->level;
+    hmat_cache->associativity = node->assoc;
+    hmat_cache->write_policy = node->policy;
+    hmat_cache->line_size = node->line;
+
+    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
+}
+
 static
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
@@ -352,6 +414,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             goto end;
         }
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
+        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c7a356fa8..00d5ffabe8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2537,10 +2537,12 @@
 #
 # @hmat-lb: memory latency and bandwidth information (Since: 4.1)
 #
+# @hmat-cache: memory side cache information (Since: 4.1)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
 ##
 # @NumaOptions:
@@ -2556,7 +2558,8 @@
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
     'cpu': 'NumaCpuOptions',
-    'hmat-lb': 'NumaHmatLBOptions' }}
+    'hmat-lb': 'NumaHmatLBOptions',
+    'hmat-cache': 'NumaHmatCacheOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2719,6 +2722,80 @@
     '*latency': 'uint16',
     '*bandwidth': 'uint16' }}
 
+##
+# @HmatCacheAssociativity:
+#
+# Cache associativity in the Memory Side Cache
+# Information Structure of HMAT
+#
+# For more information of @HmatCacheAssociativity see
+# the chapter 5.2.27.5: Table 5-143 of ACPI 6.3 spec.
+#
+# @none: None
+#
+# @direct: Direct Mapped
+#
+# @complex: Complex Cache Indexing (implementation specific)
+#
+# Since: 4.1
+##
+{ 'enum': 'HmatCacheAssociativity',
+  'data': [ 'none', 'direct', 'complex' ] }
+
+##
+# @HmatCacheWritePolicy:
+#
+# Cache write policy in the Memory Side Cache
+# Information Structure of HMAT
+#
+# For more information of @HmatCacheWritePolicy see
+# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.3 spec.
+#
+# @none: None
+#
+# @write-back: Write Back (WB)
+#
+# @write-through: Write Through (WT)
+#
+# Since: 4.1
+##
+{ 'enum': 'HmatCacheWritePolicy',
+  'data': [ 'none', 'write-back', 'write-through' ] }
+
+##
+# @NumaHmatCacheOptions:
+#
+# Set the memory side cache information for a given memory domain.
+#
+# For more information of @NumaHmatCacheOptions see
+# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.3 spec.
+#
+# @node-id: the memory proximity domain to which the memory belongs.
+#
+# @size: the size of memory side cache in bytes.
+#
+# @total: the total cache levels for this memory proximity domain.
+#
+# @level: the cache level described in this structure.
+#
+# @assoc: the cache associativity, none/direct-mapped/complex(complex cache indexing).
+#
+# @policy: the write policy, none/write-back/write-through.
+#
+# @line: the cache Line size in bytes.
+#
+# Since: 4.1
+##
+{ 'struct': 'NumaHmatCacheOptions',
+  'data': {
+   'node-id': 'uint32',
+   'size': 'size',
+   'total': 'uint8',
+   'level': 'uint8',
+   'assoc': 'HmatCacheAssociativity',
+   'policy': 'HmatCacheWritePolicy',
+   'line': 'uint16' }}
+
 ##
 # @HostMemPolicy:
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 8dfbeb2941..d47a7db69e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -164,7 +164,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
-    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|last-level|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n",
+    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|last-level|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n"
+    "-numa hmat-cache,node-id=node,size=size,total=total,level=level[,assoc=none|direct|complex][,policy=none|write-back|write-through][,line=size]\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
@@ -172,6 +173,7 @@ STEXI
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
 @itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{str},data-type=@var{str}[,base-lat=@var{blat}][,base-bw=@var{bbw}][,latency=@var{lat}][,bandwidth=@var{bw}]
+@itemx -numa hmat-cache,node-id=@var{node},size=@var{size},total=@var{total},level=@var{level}[,assoc=@var{str}][,policy=@var{str}][,line=@var{size}]
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
@@ -274,11 +276,19 @@ Note: Due to the minimum matrix value entry value being 10, the base unit corres
 to a value of 10. And @var{blat} or @var{bbw} should be an integer. @var{lat} or
 @var{bw} is the latency/bandwidth value.
 
+In @samp{hmat-cache} option, @var{node-id} is the NUMA-id of the memory belongs.
+@var{size} is the size of memory side cache in bytes. @var{total} is the total cache levels.
+@var{level} is the cache level described in this structure. @var{assoc} is the cache associativity.
+"none/direct-mapped/complex(complex cache indexing). @var{policy} is the write policy.
+@var{line} is the cache Line size in bytes.
+
 For example, the following option assigns NUMA node 0 and 1. Node 0 has 2 cpus and
 a ram, node 1 has only a ram. The processors in node 0 access memory in node
 0 with access-latency 5 picoseconds(base latency is 10), access-bandwidth 5 MB/s(base latency is 20);
 The processors in NUMA node 0 access memory in NUMA node 1 with access-latency 10
-picoseconds(base latency is 10), access-bandwidth 10 MB/s(base latency is 20):
+picoseconds(base latency is 10), access-bandwidth 10 MB/s(base latency is 20).
+And for memory side cache information, NUMA node 0 and 1 both have 1 level memory
+cache, size is 0x20000 bytes, policy is write-back, the cache Line size is 8 bytes:
 @example
 -m 2G \
 -object memory-backend-ram,size=1024M,policy=bind,host-nodes=0,id=ram-node0 -numa node,nodeid=0,memdev=ram-node0 \
@@ -290,6 +300,8 @@ picoseconds(base latency is 10), access-bandwidth 10 MB/s(base latency is 20):
 -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=5 \
 -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,latency=10 \
 -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,base-bw=20,bandwidth=10 \
+-numa hmat-cache,node-id=0,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
+-numa hmat-cache,node-id=1,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
 @end example
 
 ETEXI
-- 
2.20.1


