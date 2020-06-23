Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C61D2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C61D2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhjz-0001Dh-8l
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIx-0006Rl-1w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIu-0004kd-8L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:30 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NBWeUC045464; Tue, 23 Jun 2020 07:41:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05tgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:27 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NBY3dF048905;
 Tue, 23 Jun 2020 07:41:26 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05tfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:26 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBQBHZ015236;
 Tue, 23 Jun 2020 11:41:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 31sa38pvw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:41:25 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBfOLb61669860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:41:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCB56C6055;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 435E8C605A;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 11/12] hw/tpm: Make 'tpm_util.h' publicly accessible as
 "sysemu/tpm_util.h"
Date: Tue, 23 Jun 2020 07:41:13 -0400
Message-Id: <20200623114114.1375104-12-stefanb@linux.vnet.ibm.com>
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

We are going to split the TPM backends from the TPM emulated
hardware in the next commit. Make the TPM util helpers accessible
by moving local "tpm_util.h" to global "sysemu/tpm_util.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-id: 20200612085444.8362-12-philmd@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 docs/specs/tpm.rst                    | 4 ++--
 hw/tpm/tpm_crb.c                      | 2 +-
 hw/tpm/tpm_emulator.c                 | 2 +-
 hw/tpm/tpm_passthrough.c              | 2 +-
 hw/tpm/tpm_spapr.c                    | 2 +-
 hw/tpm/tpm_tis_common.c               | 2 +-
 hw/tpm/tpm_util.c                     | 2 +-
 {hw/tpm => include/sysemu}/tpm_util.h | 6 +++---
 8 files changed, 11 insertions(+), 11 deletions(-)
 rename {hw/tpm => include/sysemu}/tpm_util.h (95%)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 9e48e3b981..0200fdac68 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -234,7 +234,7 @@ PCRs.
 QEMU files related to the TPM passthrough device:
  - ``hw/tpm/tpm_passthrough.c``
  - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``include/sysemu/tpm_util.h``
 
 
 Command line to start QEMU with the TPM passthrough device using the host's
@@ -294,7 +294,7 @@ command.
 QEMU files related to the TPM emulator device:
  - ``hw/tpm/tpm_emulator.c``
  - ``hw/tpm/tpm_util.c``
- - ``hw/tpm/tpm_util.h``
+ - ``include/sysemu/tpm_util.h``
 
 The following commands start the swtpm with a UnixIO control channel over
 a socket interface. They do not need to be run as root.
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 1cac4d671d..60247295d4 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -24,9 +24,9 @@
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "sysemu/reset.h"
 #include "tpm_prop.h"
-#include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 3a0fc442f3..9605339f93 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -32,8 +32,8 @@
 #include "qemu/sockets.h"
 #include "io/channel-socket.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_int.h"
-#include "tpm_util.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f67244b5d4..7403807ec4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -28,10 +28,10 @@
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_int.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-tpm.h"
-#include "tpm_util.h"
 #include "trace.h"
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 65672048c7..cb4dfd1e6a 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -20,7 +20,7 @@
 #include "migration/vmstate.h"
 
 #include "sysemu/tpm_backend.h"
-#include "tpm_util.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_prop.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 1779b4fc1e..e700d82181 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -33,7 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
-#include "tpm_util.h"
+#include "sysemu/tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
 
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 12f19465c5..cfc7572a61 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -23,11 +23,11 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "tpm_util.h"
 #include "tpm_int.h"
 #include "exec/memory.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/tpm_util.h"
 #include "trace.h"
 
 /* tpm backend property */
diff --git a/hw/tpm/tpm_util.h b/include/sysemu/tpm_util.h
similarity index 95%
rename from hw/tpm/tpm_util.h
rename to include/sysemu/tpm_util.h
index cf61d830d7..63e872c3b2 100644
--- a/hw/tpm/tpm_util.h
+++ b/include/sysemu/tpm_util.h
@@ -19,8 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#ifndef TPM_TPM_UTIL_H
-#define TPM_TPM_UTIL_H
+#ifndef SYSEMU_TPM_UTIL_H
+#define SYSEMU_TPM_UTIL_H
 
 #include "sysemu/tpm.h"
 #include "qemu/bswap.h"
@@ -69,4 +69,4 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
 void tpm_util_show_buffer(const unsigned char *buffer,
                           size_t buffer_size, const char *string);
 
-#endif /* TPM_TPM_UTIL_H */
+#endif /* SYSEMU_TPM_UTIL_H */
-- 
2.24.1


