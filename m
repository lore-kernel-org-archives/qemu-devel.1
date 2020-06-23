Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE5920738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE5920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhdt-0001bp-So
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIw-0006Q4-7a
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIt-0004kK-B7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NBWeU9045464; Tue, 23 Jun 2020 07:41:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05tfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:26 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NBWkoe045685;
 Tue, 23 Jun 2020 07:41:25 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05tfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBQCS1028311;
 Tue, 23 Jun 2020 11:41:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02wdc.us.ibm.com with ESMTP id 31sa38xtsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:41:24 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBfOp840567250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:41:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C5BC6059;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ED6CC6057;
 Tue, 23 Jun 2020 11:41:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:41:23 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 10/12] hw/tpm: Move DEFINE_PROP_TPMBE() macro to
 'tmp_prop.h' local header
Date: Tue, 23 Jun 2020 07:41:12 -0400
Message-Id: <20200623114114.1375104-11-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
References: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-23_06:2020-06-23,
 2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=1
 cotscore=-2147483648 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230092
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:41:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We are going to make "tpm_util.h" publicly accessible by
moving it to the include/ directory in the next commit.
The DEFINE_PROP_TPMBE() macro is only meaningful for the
TPM hardware files (in hw/tpm/), so keep this macro in a
local header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200612085444.8362-11-philmd@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c        |  1 +
 hw/tpm/tpm_prop.h       | 31 +++++++++++++++++++++++++++++++
 hw/tpm/tpm_spapr.c      |  1 +
 hw/tpm/tpm_tis_isa.c    |  2 +-
 hw/tpm/tpm_tis_sysbus.c |  2 +-
 hw/tpm/tpm_util.h       |  3 ---
 6 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 hw/tpm/tpm_prop.h

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 664ff70ef9..1cac4d671d 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -25,6 +25,7 @@
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/reset.h"
+#include "tpm_prop.h"
 #include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
new file mode 100644
index 0000000000..85e1ae5718
--- /dev/null
+++ b/hw/tpm/tpm_prop.h
@@ -0,0 +1,31 @@
+/*
+ * TPM utility functions
+ *
+ *  Copyright (c) 2010 - 2015 IBM Corporation
+ *  Authors:
+ *    Stefan Berger <stefanb@us.ibm.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef HW_TPM_PROP_H
+#define HW_TPM_PROP_H
+
+#include "sysemu/tpm_backend.h"
+#include "hw/qdev-properties.h"
+
+#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
+
+#endif /* HW_TPM_PROP_H */
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index ab1a86ad6e..65672048c7 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -21,6 +21,7 @@
 
 #include "sysemu/tpm_backend.h"
 #include "tpm_util.h"
+#include "tpm_prop.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 42f909ff1e..5faf6231c0 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -27,7 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
-#include "tpm_util.h"
+#include "tpm_prop.h"
 #include "tpm_tis.h"
 
 typedef struct TPMStateISA {
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index edca1dae0d..4a3bc70625 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -26,7 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/tpm.h"
-#include "tpm_util.h"
+#include "tpm_prop.h"
 #include "hw/sysbus.h"
 #include "tpm_tis.h"
 
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index d524935576..cf61d830d7 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -66,9 +66,6 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
     stl_be_p(b + 6, error);
 }
 
-#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
-
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
-- 
2.24.1


