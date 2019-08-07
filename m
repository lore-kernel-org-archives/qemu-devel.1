Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4455BC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126C82199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126C82199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGCf-0000JK-4d
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAh-0006yY-9M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAf-0001ZT-PJ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18192
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvGAf-0001Z8-JX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x777FBIq113586
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 03:15:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u7qk04y5g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:40 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 08:15:37 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 08:15:35 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x777FY0f26214868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 07:15:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A040A405B;
 Wed,  7 Aug 2019 07:15:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D033A406E;
 Wed,  7 Aug 2019 07:15:32 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.109.247.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 07:15:32 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:44:41 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080707-0020-0000-0000-0000035BD0CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080707-0021-0000-0000-000021AFF358
Message-Id: <20190807071445.4109-3-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=21 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [RFC PATCH 2/6] hw/ppc/pnv_xscom: extend xscom to use
 python interface
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
Cc: maddy@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Existing xscom access emulation for read/write can be
extended with the python interface to support feeding
data externally.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c      | 31 ++++++++++++++++++++++++++++---
 include/sysemu/sysemu.h |  4 ++++
 qemu-options.hx         | 14 ++++++++++++++
 vl.c                    | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 2b81c75f56..5d5b5e9884 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -17,11 +17,13 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "sysemu/python_api.h"
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
 
@@ -157,8 +159,20 @@ static uint64_t xscom_read(void *opaque, hwaddr addr, unsigned width)
     uint64_t val = 0;
     MemTxResult result;
 
-    /* Handle some SCOMs here before dispatch */
-    val = xscom_read_default(chip, pcba);
+    if (xscom_module && xscom_readp) {
+        char **args = g_malloc(2 * sizeof(uint64_t));
+        PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
+        python_args_init_cast_long(args, pcba, 0);
+        python_args_init_cast_int(args, pcc->chip_type, 1);
+        val = python_callback_int(module_path, xscom_module, xscom_readp,
+                                  args, 2);
+        python_args_clean(args, 2);
+        g_free(args);
+    }
+    else {
+        /* Handle some SCOMs here before dispatch */
+        val = xscom_read_default(chip, pcba);
+    }
     if (val != -1) {
         goto complete;
     }
@@ -184,8 +198,19 @@ static void xscom_write(void *opaque, hwaddr addr, uint64_t val,
     uint32_t pcba = pnv_xscom_pcba(chip, addr);
     MemTxResult result;
 
+    if (xscom_module && xscom_writep) {
+        char **args = g_malloc(sizeof(uint64_t));
+        bool xscom_success;
+        python_args_init_cast_long(args, pcba, 0);
+        xscom_success = python_callback_bool(module_path, xscom_module,
+                                             xscom_writep, args, 1);
+        python_args_clean(args, 1);
+        g_free(args);
+        if (xscom_success)
+            goto complete;
+    }
     /* Handle some SCOMs here before dispatch */
-    if (xscom_write_default(chip, pcba, val)) {
+    else if (xscom_write_default(chip, pcba, val)) {
         goto complete;
     }
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac9..9b8dc346d6 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -117,6 +117,10 @@ extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
+extern const char *module_path;
+extern const char *xscom_module;
+extern const char *xscom_readp;
+extern const char *xscom_writep;
 extern int mem_prealloc;
 
 #define MAX_NODES 128
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..06c9f34d99 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -385,6 +385,20 @@ STEXI
 Allocate guest RAM from a temporarily created file in @var{path}.
 ETEXI
 
+DEF("module-path", HAS_ARG, QEMU_OPTION_modulepath,
+    "-module-path FILE  provide absolute path where python modules"
+    "resides\n", QEMU_ARCH_ALL)
+STEXI
+@item -module-path [path=]@var{absolute path}[,homer_module=homer,homer_func=func1]
+@findex -module-path
+Provides information about where the python modules exist and the callback
+functions defined.
+
+@example
+qemu-system-ppc64 -module-path /home/modules/,homer_module=homer,homer_func=homer_read
+@end example
+ETEXI
+
 DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
     "-mem-prealloc   preallocate guest memory (use with -mem-path)\n",
     QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index b426b32134..28f0dc1c1b 100644
--- a/vl.c
+++ b/vl.c
@@ -140,6 +140,10 @@ int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
 const char *mem_path = NULL;
+const char *module_path = NULL;
+const char *xscom_module = NULL;
+const char *xscom_readp = NULL;
+const char *xscom_writep = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
 bool enable_mlock = false;
 bool enable_cpu_pm = false;
@@ -469,6 +473,32 @@ static QemuOptsList qemu_mem_opts = {
     },
 };
 
+static QemuOptsList qemu_module_opts = {
+    .name = "module_path",
+    .implied_opt_name = "module_path",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_module_opts.head),
+    .merge_lists = true,
+    .desc = {
+        {
+            .name = "module_path",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "xscom_module",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "xscom_read",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "xscom_write",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_icount_opts = {
     .name = "icount",
     .implied_opt_name = "shift",
@@ -2923,6 +2953,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
     qemu_add_opts(&qemu_mem_opts);
+    qemu_add_opts(&qemu_module_opts);
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
     qemu_add_opts(&qemu_add_fd_opts);
@@ -3190,6 +3221,17 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_mempath:
                 mem_path = optarg;
                 break;
+            case QEMU_OPTION_modulepath:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("module_path"),
+                                               optarg, true);
+                if (!opts) {
+                    exit(EXIT_FAILURE);
+                }
+                module_path = qemu_opt_get(opts, "module_path");
+                xscom_module = qemu_opt_get(opts, "xscom_module");
+                xscom_readp = qemu_opt_get(opts, "xscom_read");
+                xscom_writep = qemu_opt_get(opts, "xscom_write");
+                break;
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
                 break;
-- 
2.14.5


