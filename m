Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ84-0001vx-Pj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gNZ81-00060q-I5
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3107 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gNZ80-0005ul-Pc
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:05:25 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Fri, 16 Nov 2018 15:59:35 +0800
Message-ID: <a4bc041444fd76d5da1d8e5321007f416df4ab84.1542384802.git.xiezhide@huawei.com>
In-Reply-To: <cover.1542384802.git.xiezhide@huawei.com>
References: <cover.1542384802.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 2/6] fsdev-throttle-qmp: Rename the
 ThrottleLimits member names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

Rename the ThrottleLimits member names and modify related code

Signed-off-by: xiezhide <xiezhide@huawei.com>
---
 qapi/block-core.json |  70 +++++++++++-----------
 util/throttle.c      | 163 +++++++++++++++++++++++++--------------------------
 2 files changed, 116 insertions(+), 117 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710..4ffaaea 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2240,45 +2240,45 @@
 # transaction. All fields are optional. When setting limits, if a field is
 # missing the current value is not changed.
 #
-# @iops-total:             limit total I/O operations per second
-# @iops-total-max:         I/O operations burst
-# @iops-total-max-length:  length of the iops-total-max burst period, in seconds
-#                          It must only be set if @iops-total-max is set as well.
-# @iops-read:              limit read operations per second
-# @iops-read-max:          I/O operations read burst
-# @iops-read-max-length:   length of the iops-read-max burst period, in seconds
-#                          It must only be set if @iops-read-max is set as well.
-# @iops-write:             limit write operations per second
-# @iops-write-max:         I/O operations write burst
-# @iops-write-max-length:  length of the iops-write-max burst period, in seconds
-#                          It must only be set if @iops-write-max is set as well.
-# @bps-total:              limit total bytes per second
-# @bps-total-max:          total bytes burst
-# @bps-total-max-length:   length of the bps-total-max burst period, in seconds.
-#                          It must only be set if @bps-total-max is set as well.
-# @bps-read:               limit read bytes per second
-# @bps-read-max:           total bytes read burst
-# @bps-read-max-length:    length of the bps-read-max burst period, in seconds
-#                          It must only be set if @bps-read-max is set as well.
-# @bps-write:              limit write bytes per second
-# @bps-write-max:          total bytes write burst
-# @bps-write-max-length:   length of the bps-write-max burst period, in seconds
-#                          It must only be set if @bps-write-max is set as well.
-# @iops-size:              when limiting by iops max size of an I/O in bytes
+# @iops:             limit total I/O operations per second
+# @iops_max:         I/O operations burst
+# @iops_max_length:  length of the iops_total_max burst period, in seconds
+#                          It must only be set if @iops_total_max is set as well.
+# @iops_rd:              limit read operations per second
+# @iops_rd_max:          I/O operations read burst
+# @iops_rd_max_length:   length of the iops_read_max burst period, in seconds
+#                          It must only be set if @iops_read_max is set as well.
+# @iops_wr:             limit write operations per second
+# @iops_wr_max:         I/O operations write burst
+# @iops_wr_max_length:  length of the iops_write_max burst period, in seconds
+#                          It must only be set if @iops_write_max is set as well.
+# @bps:              limit total bytes per second
+# @bps_max:          total bytes burst
+# @bps_max_length:   length of the bps_total_max burst period, in seconds.
+#                          It must only be set if @bps_total_max is set as well.
+# @bps_rd:               limit read bytes per second
+# @bps_rd_max:           total bytes read burst
+# @bps_rd_max_length:    length of the bps_read_max burst period, in seconds
+#                          It must only be set if @bps_read_max is set as well.
+# @bps_wr:              limit write bytes per second
+# @bps_wr_max:          total bytes write burst
+# @bps_wr_max_length:   length of the bps_write_max burst period, in seconds
+#                          It must only be set if @bps_write_max is set as well.
+# @iops_size:              when limiting by iops max size of an I/O in bytes
 #
 # Since: 2.11
 ##
 { 'struct': 'ThrottleLimits',
-  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
-            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
-            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
-            '*iops-write' : 'int', '*iops-write-max' : 'int',
-            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
-            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
-            '*bps-read' : 'int', '*bps-read-max' : 'int',
-            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
-            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
-            '*iops-size' : 'int' } }
+  'data': { '*iops' : 'int', '*iops_max' : 'int',
+            '*iops_max_length' : 'int', '*iops_rd' : 'int',
+            '*iops_rd_max' : 'int', '*iops_rd_max_length' : 'int',
+            '*iops_wr' : 'int', '*iops_wr_max' : 'int',
+            '*iops_wr_max_length' : 'int', '*bps' : 'int',
+            '*bps_max' : 'int', '*bps_max_length' : 'int',
+            '*bps_rd' : 'int', '*bps_rd_max' : 'int',
+            '*bps_rd_max_length' : 'int', '*bps_wr' : 'int',
+            '*bps_wr_max' : 'int', '*bps_wr_max_length' : 'int',
+            '*iops_size' : 'int' } }
 
 ##
 # @block-stream:
diff --git a/util/throttle.c b/util/throttle.c
index e7db2ad..b421e33 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -496,98 +496,97 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
 void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
                                Error **errp)
 {
-    if (arg->has_bps_total) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps_total;
+    if (arg->has_bps) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
     }
-    if (arg->has_bps_read) {
-        cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_read;
+    if (arg->has_bps_rd) {
+        cfg->buckets[THROTTLE_BPS_READ].avg  = arg->bps_rd;
     }
-    if (arg->has_bps_write) {
-        cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_write;
+    if (arg->has_bps_wr) {
+        cfg->buckets[THROTTLE_BPS_WRITE].avg = arg->bps_wr;
     }
 
-    if (arg->has_iops_total) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops_total;
+    if (arg->has_iops) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].avg = arg->iops;
     }
-    if (arg->has_iops_read) {
-        cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_read;
+    if (arg->has_iops_rd) {
+        cfg->buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
     }
-    if (arg->has_iops_write) {
-        cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_write;
+    if (arg->has_iops_wr) {
+        cfg->buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
     }
 
-    if (arg->has_bps_total_max) {
-        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_total_max;
+    if (arg->has_bps_max) {
+        cfg->buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
     }
-    if (arg->has_bps_read_max) {
-        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_read_max;
+    if (arg->has_bps_rd_max) {
+        cfg->buckets[THROTTLE_BPS_READ].max = arg->bps_rd_max;
     }
-    if (arg->has_bps_write_max) {
-        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_write_max;
+    if (arg->has_bps_wr_max) {
+        cfg->buckets[THROTTLE_BPS_WRITE].max = arg->bps_wr_max;
     }
-    if (arg->has_iops_total_max) {
-        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_total_max;
+    if (arg->has_iops_max) {
+        cfg->buckets[THROTTLE_OPS_TOTAL].max = arg->iops_max;
     }
-    if (arg->has_iops_read_max) {
-        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_read_max;
+    if (arg->has_iops_rd_max) {
+        cfg->buckets[THROTTLE_OPS_READ].max = arg->iops_rd_max;
     }
-    if (arg->has_iops_write_max) {
-        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_write_max;
+    if (arg->has_iops_wr_max) {
+        cfg->buckets[THROTTLE_OPS_WRITE].max = arg->iops_wr_max;
     }
 
-    if (arg->has_bps_total_max_length) {
-        if (arg->bps_total_max_length > UINT_MAX) {
+    if (arg->has_bps_max_length) {
+        if (arg->bps_max_length > UINT_MAX) {
             error_setg(errp, "bps-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_total_max_length;
+        cfg->buckets[THROTTLE_BPS_TOTAL].burst_length = arg->bps_max_length;
     }
-    if (arg->has_bps_read_max_length) {
-        if (arg->bps_read_max_length > UINT_MAX) {
+    if (arg->has_bps_rd_max_length) {
+        if (arg->bps_rd_max_length > UINT_MAX) {
             error_setg(errp, "bps-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_read_max_length;
+        cfg->buckets[THROTTLE_BPS_READ].burst_length = arg->bps_rd_max_length;
     }
-    if (arg->has_bps_write_max_length) {
-        if (arg->bps_write_max_length > UINT_MAX) {
+    if (arg->has_bps_wr_max_length) {
+        if (arg->bps_wr_max_length > UINT_MAX) {
             error_setg(errp, "bps-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_write_max_length;
+        cfg->buckets[THROTTLE_BPS_WRITE].burst_length = arg->bps_wr_max_length;
     }
-    if (arg->has_iops_total_max_length) {
-        if (arg->iops_total_max_length > UINT_MAX) {
+    if (arg->has_iops_max_length) {
+        if (arg->iops_max_length > UINT_MAX) {
             error_setg(errp, "iops-total-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_total_max_length;
+        cfg->buckets[THROTTLE_OPS_TOTAL].burst_length = arg->iops_max_length;
     }
-    if (arg->has_iops_read_max_length) {
-        if (arg->iops_read_max_length > UINT_MAX) {
+    if (arg->has_iops_rd_max_length) {
+        if (arg->iops_rd_max_length > UINT_MAX) {
             error_setg(errp, "iops-read-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_read_max_length;
+        cfg->buckets[THROTTLE_OPS_READ].burst_length = arg->iops_rd_max_length;
     }
-    if (arg->has_iops_write_max_length) {
-        if (arg->iops_write_max_length > UINT_MAX) {
+    if (arg->has_iops_wr_max_length) {
+        if (arg->iops_wr_max_length > UINT_MAX) {
             error_setg(errp, "iops-write-max-length value must be in"
                              " the range [0, %u]", UINT_MAX);
             return;
         }
-        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_write_max_length;
+        cfg->buckets[THROTTLE_OPS_WRITE].burst_length = arg->iops_wr_max_length;
     }
 
     if (arg->has_iops_size) {
         cfg->op_size = arg->iops_size;
     }
-
     throttle_is_valid(cfg, errp);
 }
 
@@ -598,45 +597,45 @@ void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
  */
 void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var)
 {
-    var->bps_total               = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
-    var->bps_read                = cfg->buckets[THROTTLE_BPS_READ].avg;
-    var->bps_write               = cfg->buckets[THROTTLE_BPS_WRITE].avg;
-    var->iops_total              = cfg->buckets[THROTTLE_OPS_TOTAL].avg;
-    var->iops_read               = cfg->buckets[THROTTLE_OPS_READ].avg;
-    var->iops_write              = cfg->buckets[THROTTLE_OPS_WRITE].avg;
-    var->bps_total_max           = cfg->buckets[THROTTLE_BPS_TOTAL].max;
-    var->bps_read_max            = cfg->buckets[THROTTLE_BPS_READ].max;
-    var->bps_write_max           = cfg->buckets[THROTTLE_BPS_WRITE].max;
-    var->iops_total_max          = cfg->buckets[THROTTLE_OPS_TOTAL].max;
-    var->iops_read_max           = cfg->buckets[THROTTLE_OPS_READ].max;
-    var->iops_write_max          = cfg->buckets[THROTTLE_OPS_WRITE].max;
-    var->bps_total_max_length    = cfg->buckets[THROTTLE_BPS_TOTAL].burst_length;
-    var->bps_read_max_length     = cfg->buckets[THROTTLE_BPS_READ].burst_length;
-    var->bps_write_max_length    = cfg->buckets[THROTTLE_BPS_WRITE].burst_length;
-    var->iops_total_max_length   = cfg->buckets[THROTTLE_OPS_TOTAL].burst_length;
-    var->iops_read_max_length    = cfg->buckets[THROTTLE_OPS_READ].burst_length;
-    var->iops_write_max_length   = cfg->buckets[THROTTLE_OPS_WRITE].burst_length;
-    var->iops_size               = cfg->op_size;
-
-    var->has_bps_total = true;
-    var->has_bps_read = true;
-    var->has_bps_write = true;
-    var->has_iops_total = true;
-    var->has_iops_read = true;
-    var->has_iops_write = true;
-    var->has_bps_total_max = true;
-    var->has_bps_read_max = true;
-    var->has_bps_write_max = true;
-    var->has_iops_total_max = true;
-    var->has_iops_read_max = true;
-    var->has_iops_write_max = true;
-    var->has_bps_read_max_length = true;
-    var->has_bps_total_max_length = true;
-    var->has_bps_write_max_length = true;
-    var->has_iops_total_max_length = true;
-    var->has_iops_read_max_length = true;
-    var->has_iops_write_max_length = true;
-    var->has_iops_size = true;
+    var->bps                    = cfg->buckets[THROTTLE_BPS_TOTAL].avg;
+    var->bps_rd                 = cfg->buckets[THROTTLE_BPS_READ].avg;
+    var->bps_wr                 = cfg->buckets[THROTTLE_BPS_WRITE].avg;
+    var->iops                   = cfg->buckets[THROTTLE_OPS_TOTAL].avg;
+    var->iops_rd                = cfg->buckets[THROTTLE_OPS_READ].avg;
+    var->iops_wr                = cfg->buckets[THROTTLE_OPS_WRITE].avg;
+    var->bps_max                = cfg->buckets[THROTTLE_BPS_TOTAL].max;
+    var->bps_rd_max             = cfg->buckets[THROTTLE_BPS_READ].max;
+    var->bps_wr_max             = cfg->buckets[THROTTLE_BPS_WRITE].max;
+    var->iops_max               = cfg->buckets[THROTTLE_OPS_TOTAL].max;
+    var->iops_rd_max            = cfg->buckets[THROTTLE_OPS_READ].max;
+    var->iops_wr_max            = cfg->buckets[THROTTLE_OPS_WRITE].max;
+    var->bps_max_length         = cfg->buckets[THROTTLE_BPS_TOTAL].burst_length;
+    var->bps_rd_max_length      = cfg->buckets[THROTTLE_BPS_READ].burst_length;
+    var->bps_wr_max_length      = cfg->buckets[THROTTLE_BPS_WRITE].burst_length;
+    var->iops_max_length        = cfg->buckets[THROTTLE_OPS_TOTAL].burst_length;
+    var->iops_rd_max_length     = cfg->buckets[THROTTLE_OPS_READ].burst_length;
+    var->iops_wr_max_length     = cfg->buckets[THROTTLE_OPS_WRITE].burst_length;
+    var->iops_size              = cfg->op_size;
+
+    var->has_bps                = true;
+    var->has_bps_rd             = true;
+    var->has_bps_wr             = true;
+    var->has_iops               = true;
+    var->has_iops_rd            = true;
+    var->has_iops_wr            = true;
+    var->has_bps_max            = true;
+    var->has_bps_rd_max         = true;
+    var->has_bps_wr_max         = true;
+    var->has_iops_max           = true;
+    var->has_iops_rd_max        = true;
+    var->has_iops_wr_max        = true;
+    var->has_bps_rd_max_length  = true;
+    var->has_bps_max_length     = true;
+    var->has_bps_wr_max_length  = true;
+    var->has_iops_max_length    = true;
+    var->has_iops_rd_max_length = true;
+    var->has_iops_wr_max_length = true;
+    var->has_iops_size          = true;
 }
 
 /* parse the throttle options
-- 
1.8.3.1
