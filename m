Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D92C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743D82199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743D82199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGFD-0003aF-P3
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGB5-0007WD-Hz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAz-0001l3-Nu
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:16:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvGAu-0001i7-1E
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x777E9wZ076510
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 03:15:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7see1hen-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:53 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 08:15:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 08:15:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x777Fl0R45875208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 07:15:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B7A3A4055;
 Wed,  7 Aug 2019 07:15:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E307A4065;
 Wed,  7 Aug 2019 07:15:45 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.109.247.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 07:15:45 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:44:45 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080707-0016-0000-0000-0000029B154D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080707-0017-0000-0000-000032FA25EF
Message-Id: <20190807071445.4109-7-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=21 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC PATCH 6/6] hw/ppc/pnv_homer: add python interface
 support for homer/occ common area
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

use python interface APIs in homer/occ common area emulation to
interact with scripts if provided else fallback to normal flow,
it shows how simple to use the interface to call python methods
with any number of arguments in any script placed in common
-module-path provided in qemu commandline.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_homer.c      | 20 ++++++++++++++++++++
 hw/ppc/pnv_xscom.c      |  9 +++++----
 include/sysemu/sysemu.h |  4 ++++
 vl.c                    | 24 ++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 73a94856d0..6ae5e74f19 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -16,7 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+#include "sysemu/python_api.h"
 #include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/cpus.h"
 #include "hw/ppc/pnv.h"
@@ -37,6 +39,15 @@ static bool core_max_array(hwaddr addr)
 
 static uint64_t homer_read(void *opaque, hwaddr addr, unsigned width)
 {
+    if (homer_module && homer) {
+        uint64_t homer_ret;
+        char **address = g_malloc(sizeof(uint64_t));
+        python_args_init_cast_long(address, addr, 0);
+        homer_ret = python_callback_int(module_path, homer_module, homer, address, 1);
+        python_args_clean(address, 1);
+        g_free(address);
+        return homer_ret;
+    }
     switch (addr) {
         case 0xe2006:  /* max pstate ultra turbo */
         case 0xe2018:  /* pstate id for 0 */
@@ -106,6 +117,15 @@ const MemoryRegionOps pnv_homer_ops = {
 
 static uint64_t occ_common_area_read(void *opaque, hwaddr addr, unsigned width)
 {
+    if (occ_module && occ) {
+        uint64_t occ_ret;
+        char **address = g_malloc(sizeof(uint64_t));
+        python_args_init_cast_long(address, addr, 0);
+        occ_ret = python_callback_int(module_path, occ_module, occ, address, 1);
+        python_args_clean(address, 1);
+        g_free(address);
+        return occ_ret;
+    }
     switch (addr) {
         /*
          * occ-sensor sanity check that asserts the sensor
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 18a780bcdf..5e41b7c953 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -179,13 +179,14 @@ static uint64_t xscom_read(void *opaque, hwaddr addr, unsigned width)
     MemTxResult result;
 
     if (xscom_module && xscom_readp) {
-        char **args = g_malloc(2 * sizeof(uint64_t));
+        char **args = g_malloc(3 * sizeof(uint64_t));
         PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
         python_args_init_cast_long(args, pcba, 0);
-        python_args_init_cast_int(args, pcc->chip_type, 1);
+        python_args_init_cast_int(args, chip->chip_num, 1);
+        python_args_init_cast_int(args, pcc->chip_type, 2);
         val = python_callback_int(module_path, xscom_module, xscom_readp,
-                                  args, 2);
-        python_args_clean(args, 2);
+                                  args, 3);
+        python_args_clean(args, 3);
         g_free(args);
     }
     else {
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 9b8dc346d6..3c8119e040 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -121,6 +121,10 @@ extern const char *module_path;
 extern const char *xscom_module;
 extern const char *xscom_readp;
 extern const char *xscom_writep;
+extern const char *homer_module;
+extern const char *homer;
+extern const char *occ_module;
+extern const char *occ;
 extern int mem_prealloc;
 
 #define MAX_NODES 128
diff --git a/vl.c b/vl.c
index 28f0dc1c1b..c96d35d907 100644
--- a/vl.c
+++ b/vl.c
@@ -144,6 +144,10 @@ const char *module_path = NULL;
 const char *xscom_module = NULL;
 const char *xscom_readp = NULL;
 const char *xscom_writep = NULL;
+const char *homer_module = NULL;
+const char *homer = NULL;
+const char *occ_module = NULL;
+const char *occ = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
 bool enable_mlock = false;
 bool enable_cpu_pm = false;
@@ -495,6 +499,22 @@ static QemuOptsList qemu_module_opts = {
             .name = "xscom_write",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "homer_module",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "homer",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "occ_module",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "occ",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -3231,6 +3251,10 @@ int main(int argc, char **argv, char **envp)
                 xscom_module = qemu_opt_get(opts, "xscom_module");
                 xscom_readp = qemu_opt_get(opts, "xscom_read");
                 xscom_writep = qemu_opt_get(opts, "xscom_write");
+                homer_module = qemu_opt_get(opts, "homer_module");
+                homer = qemu_opt_get(opts, "homer");
+                occ_module = qemu_opt_get(opts, "occ_module");
+                occ = qemu_opt_get(opts, "occ");
                 break;
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
-- 
2.14.5


