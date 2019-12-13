Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90024C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D32424671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D32424671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifpCI-0004Ak-JC
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 12:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifp85-0007dQ-4f
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1ifp82-0005oO-U0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:53:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53786
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1ifp82-0005na-OK; Fri, 13 Dec 2019 12:53:26 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDHr6LF145301; Fri, 13 Dec 2019 12:53:09 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wusmm1cra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 12:53:09 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBDHr86J145547;
 Fri, 13 Dec 2019 12:53:08 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wusmm1cmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 12:53:08 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBDHmok4027567;
 Fri, 13 Dec 2019 17:52:58 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04wdc.us.ibm.com with ESMTP id 2wuqrbt89x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2019 17:52:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDHqvrJ53543418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 17:52:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD510C6055;
 Fri, 13 Dec 2019 17:52:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 279F5C605B;
 Fri, 13 Dec 2019 17:52:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 17:52:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH v6 1/4] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Date: Fri, 13 Dec 2019 12:52:12 -0500
Message-Id: <20191213175215.1234660-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191213175215.1234660-1-stefanb@linux.vnet.ibm.com>
References: <20191213175215.1234660-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=4
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement support for TPM on ppc64 by implementing the vTPM CRQ interface
as a frontend. It can use the tpm_emulator driver backend with the external
swtpm.

The Linux vTPM driver for ppc64 works with this emulation.

This TPM emulator also handles the TPM 2 case.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/tpm/Kconfig       |   6 +
 hw/tpm/Makefile.objs |   1 +
 hw/tpm/tpm_spapr.c   | 405 +++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/trace-events  |  12 ++
 include/sysemu/tpm.h |   3 +
 qapi/tpm.json        |   6 +-
 6 files changed, 430 insertions(+), 3 deletions(-)
 create mode 100644 hw/tpm/tpm_spapr.c

diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 4c8ee87d67..66a570aac1 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -22,3 +22,9 @@ config TPM_EMULATOR
     bool
     default y
     depends on TPMDEV
+
+config TPM_SPAPR
+    bool
+    default n
+    select TPMDEV
+    depends on PSERIES
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index de0b85d02a..85eb99ae05 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
 common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
 common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
+obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
new file mode 100644
index 0000000000..a5f19b9ca3
--- /dev/null
+++ b/hw/tpm/tpm_spapr.c
@@ -0,0 +1,405 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
+ *
+ * PAPR Virtual TPM
+ *
+ * Copyright (c) 2015, 2017, 2019 IBM Corporation.
+ *
+ * Authors:
+ *    Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#include "sysemu/tpm_backend.h"
+#include "tpm_int.h"
+#include "tpm_util.h"
+
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_vio.h"
+#include "trace.h"
+
+#define DEBUG_SPAPR 0
+
+#define VIO_SPAPR_VTPM(obj) \
+     OBJECT_CHECK(SpaprTpmState, (obj), TYPE_TPM_SPAPR)
+
+typedef struct TpmCrq {
+    uint8_t valid;  /* 0x80: cmd; 0xc0: init crq */
+                    /* 0x81-0x83: CRQ message response */
+    uint8_t msg;    /* see below */
+    uint16_t len;   /* len of TPM request; len of TPM response */
+    uint32_t data;  /* rtce_dma_handle when sending TPM request */
+    uint64_t reserved;
+} TpmCrq;
+
+#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND  0xC0
+#define SPAPR_VTPM_VALID_COMMAND           0x80
+#define SPAPR_VTPM_MSG_RESULT              0x80
+
+/* msg types for valid = SPAPR_VTPM_VALID_INIT_CRQ */
+#define SPAPR_VTPM_INIT_CRQ_RESULT           0x1
+#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT  0x2
+
+/* msg types for valid = SPAPR_VTPM_VALID_CMD */
+#define SPAPR_VTPM_GET_VERSION               0x1
+#define SPAPR_VTPM_TPM_COMMAND               0x2
+#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE      0x3
+#define SPAPR_VTPM_PREPARE_TO_SUSPEND        0x4
+
+/* response error messages */
+#define SPAPR_VTPM_VTPM_ERROR                0xff
+
+/* error codes */
+#define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
+#define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
+
+#define TPM_SPAPR_BUFFER_MAX		4096
+
+typedef struct {
+    SpaprVioDevice vdev;
+
+    TpmCrq crq; /* track single TPM command */
+
+    uint8_t state;
+#define SPAPR_VTPM_STATE_NONE         0
+#define SPAPR_VTPM_STATE_EXECUTION    1
+#define SPAPR_VTPM_STATE_COMPLETION   2
+
+    unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
+
+    TPMBackendCmd cmd;
+
+    TPMBackend *be_driver;
+    TPMVersion be_tpm_version;
+
+    size_t be_buffer_size;
+} SpaprTpmState;
+
+static void tpm_spapr_show_buffer(const unsigned char *buffer,
+                                  size_t buffer_size, const char *string)
+{
+    size_t len, i;
+    char *line_buffer, *p;
+
+    len = MIN(tpm_cmd_get_size(buffer), buffer_size);
+
+    /*
+     * allocate enough room for 3 chars per buffer entry plus a
+     * newline after every 16 chars and a final null terminator.
+     */
+    line_buffer = g_malloc(len * 3 + (len / 16) + 1);
+
+    for (i = 0, p = line_buffer; i < len; i++) {
+        if (i && !(i % 16)) {
+            p += sprintf(p, "\n");
+        }
+        p += sprintf(p, "%.2X ", buffer[i]);
+    }
+    trace_tpm_spapr_show_buffer(string, len, line_buffer);
+
+    g_free(line_buffer);
+}
+
+/*
+ * Send a request to the TPM.
+ */
+static void tpm_spapr_tpm_send(SpaprTpmState *s)
+{
+    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
+        tpm_spapr_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
+    }
+
+    s->state = SPAPR_VTPM_STATE_EXECUTION;
+    s->cmd = (TPMBackendCmd) {
+        .locty = 0,
+        .in = s->buffer,
+        .in_len = MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size),
+        .out = s->buffer,
+        .out_len = s->be_buffer_size,
+    };
+
+    tpm_backend_deliver_request(s->be_driver, &s->cmd);
+}
+
+static int tpm_spapr_process_cmd(SpaprTpmState *s, uint64_t dataptr)
+{
+    long rc;
+
+    /* a max. of be_buffer_size bytes can be transported */
+    rc = spapr_vio_dma_read(&s->vdev, dataptr,
+                            s->buffer, s->be_buffer_size);
+    if (rc) {
+        error_report("tpm_spapr_got_payload: DMA read failure");
+    }
+    /* let vTPM handle any malformed request */
+    tpm_spapr_tpm_send(s);
+
+    return rc;
+}
+
+static inline int spapr_tpm_send_crq(struct SpaprVioDevice *dev, TpmCrq *crq)
+{
+    return spapr_vio_send_crq(dev, (uint8_t *)crq);
+}
+
+static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    TpmCrq local_crq;
+    TpmCrq *crq = &s->crq; /* requests only */
+    int rc;
+
+    trace_tpm_spapr_do_crq(crq_data[0], crq_data[1]);
+
+    switch (crq_data[0] /* valid */) {
+    case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init command/response */
+
+        /* Respond to initialization request */
+        switch (crq_data[1] /* msg */) {
+        case SPAPR_VTPM_INIT_CRQ_RESULT:
+            trace_tpm_spapr_do_crq_crq_result();
+            memset(&local_crq, 0, sizeof(local_crq));
+            local_crq.valid = SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
+            local_crq.msg = SPAPR_VTPM_INIT_CRQ_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT:
+            trace_tpm_spapr_do_crq_crq_complete_result();
+            memset(&local_crq, 0, sizeof(local_crq));
+            local_crq.valid = SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
+            local_crq.msg = SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+        }
+
+        break;
+    case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
+        switch (crq_data[1] /* msg */) {
+        case SPAPR_VTPM_TPM_COMMAND:
+            trace_tpm_spapr_do_crq_tpm_command();
+            if (s->state == SPAPR_VTPM_STATE_EXECUTION) {
+                return H_BUSY;
+            }
+            memcpy(crq, crq_data, sizeof(*crq));
+
+            rc = tpm_spapr_process_cmd(s, be32_to_cpu(crq->data));
+
+            if (rc == H_SUCCESS) {
+                crq->valid = be16_to_cpu(0);
+            } else {
+                local_crq.valid = SPAPR_VTPM_MSG_RESULT;
+                local_crq.msg = SPAPR_VTPM_VTPM_ERROR;
+                local_crq.len = cpu_to_be16(0);
+                local_crq.data = cpu_to_be32(SPAPR_VTPM_ERR_COPY_IN_FAILED);
+                spapr_tpm_send_crq(dev, &local_crq);
+            }
+            break;
+
+        case SPAPR_VTPM_GET_RTCE_BUFFER_SIZE:
+            trace_tpm_spapr_do_crq_tpm_get_rtce_buffer_size(s->be_buffer_size);
+            local_crq.valid = SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg = SPAPR_VTPM_GET_RTCE_BUFFER_SIZE |
+                            SPAPR_VTPM_MSG_RESULT;
+            local_crq.len = cpu_to_be16(s->be_buffer_size);
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_GET_VERSION:
+            local_crq.valid = SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg = SPAPR_VTPM_GET_VERSION | SPAPR_VTPM_MSG_RESULT;
+            local_crq.len = cpu_to_be16(0);
+            switch (s->be_tpm_version) {
+            case TPM_VERSION_1_2:
+                local_crq.data = cpu_to_be32(1);
+                break;
+            case TPM_VERSION_2_0:
+                local_crq.data = cpu_to_be32(2);
+                break;
+            default:
+                g_assert_not_reached();
+                break;
+            }
+            trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq.data));
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_PREPARE_TO_SUSPEND:
+            trace_tpm_spapr_do_crq_prepare_to_suspend();
+            local_crq.valid = SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg = SPAPR_VTPM_PREPARE_TO_SUSPEND |
+                            SPAPR_VTPM_MSG_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        default:
+            trace_tpm_spapr_do_crq_unknown_msg_type(crq->msg);
+        }
+        break;
+    default:
+        trace_tpm_spapr_do_crq_unknown_crq(crq_data[0], crq_data[1]);
+    };
+
+    return H_SUCCESS;
+}
+
+static void tpm_spapr_request_completed(TPMIf *ti, int ret)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
+    TpmCrq *crq = &s->crq;
+    uint32_t len;
+    int rc;
+
+    s->state = SPAPR_VTPM_STATE_COMPLETION;
+
+    /* a max. of be_buffer_size bytes can be transported */
+    len = MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
+    rc = spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
+                             s->buffer, len);
+
+    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
+        tpm_spapr_show_buffer(s->buffer, len, "From TPM");
+    }
+
+    crq->valid = SPAPR_VTPM_MSG_RESULT;
+    if (rc == H_SUCCESS) {
+        crq->msg = SPAPR_VTPM_TPM_COMMAND | SPAPR_VTPM_MSG_RESULT;
+        crq->len = cpu_to_be16(len);
+    } else {
+        error_report("%s: DMA write failure", __func__);
+        crq->msg = SPAPR_VTPM_VTPM_ERROR;
+        crq->len = cpu_to_be16(0);
+        crq->data = cpu_to_be32(SPAPR_VTPM_ERR_COPY_OUT_FAILED);
+    }
+
+    rc = spapr_tpm_send_crq(&s->vdev, crq);
+    if (rc) {
+        error_report("%s: Error sending response", __func__);
+    }
+}
+
+static int tpm_spapr_do_startup_tpm(SpaprTpmState *s, size_t buffersize)
+{
+    return tpm_backend_startup_tpm(s->be_driver, buffersize);
+}
+
+static void tpm_spapr_update_deviceclass(SpaprVioDevice *dev)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_GET_CLASS(dev);
+
+    switch (s->be_tpm_version) {
+    case TPM_VERSION_1_2:
+        k->dt_compatible = "IBM,vtpm";
+        break;
+    case TPM_VERSION_2_0:
+        k->dt_compatible = "IBM,vtpm20";
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void tpm_spapr_reset(SpaprVioDevice *dev)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+
+    s->state = SPAPR_VTPM_STATE_NONE;
+
+    s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
+    tpm_spapr_update_deviceclass(dev);
+
+    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
+                            TPM_SPAPR_BUFFER_MAX);
+
+    tpm_backend_reset(s->be_driver);
+    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
+}
+
+static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(ti);
+
+    if (tpm_backend_had_startup_error(s->be_driver)) {
+        return TPM_VERSION_UNSPEC;
+    }
+
+    return tpm_backend_get_tpm_version(s->be_driver);
+}
+
+static const VMStateDescription vmstate_spapr_vtpm = {
+    .name = "tpm-spapr",
+    .unmigratable = 1,
+};
+
+static Property tpm_spapr_properties[] = {
+    DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
+    DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
+{
+    SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+
+    dev->crq.SendFunc = tpm_spapr_do_crq;
+
+    if (!s->be_driver) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+}
+
+static void tpm_spapr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k = VIO_SPAPR_DEVICE_CLASS(klass);
+    TPMIfClass *tc = TPM_IF_CLASS(klass);
+
+    k->realize = tpm_spapr_realizefn;
+    k->reset = tpm_spapr_reset;
+    k->dt_name = "vtpm";
+    k->dt_type = "IBM,vtpm";
+    k->signal_mask = 0x00000001;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props = tpm_spapr_properties;
+    k->rtce_window_size = 0x10000000;
+    dc->vmsd = &vmstate_spapr_vtpm;
+
+    tc->model = TPM_MODEL_TPM_SPAPR;
+    tc->get_version = tpm_spapr_get_version;
+    tc->request_completed = tpm_spapr_request_completed;
+}
+
+static const TypeInfo tpm_spapr_info = {
+    .name          = TYPE_TPM_SPAPR,
+    .parent        = TYPE_VIO_SPAPR_DEVICE,
+    .instance_size = sizeof(SpaprTpmState),
+    .class_init    = tpm_spapr_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
+};
+
+static void tpm_spapr_register_types(void)
+{
+    type_register_static(&tpm_spapr_info);
+}
+
+type_init(tpm_spapr_register_types)
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 89804bcd64..6278a39618 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -55,3 +55,15 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
 
 # tpm_ppi.c
 tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
+
+# hw/tpm/tpm_spapr.c
+tpm_spapr_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
+tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x%02x 0x%02x"
+tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
+tpm_spapr_do_crq_crq_complete_result(void) "SPAPR_VTPM_INIT_CRQ_COMP_RESULT"
+tpm_spapr_do_crq_tpm_command(void) "got TPM command payload"
+tpm_spapr_do_crq_tpm_get_rtce_buffer_size(size_t buffersize) "response: buffer size is %zu"
+tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
+tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspend"
+tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x%02x"
+tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x%02x 0x%02x ..."
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 5b541a71c8..15979a3647 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -45,11 +45,14 @@ typedef struct TPMIfClass {
 
 #define TYPE_TPM_TIS                "tpm-tis"
 #define TYPE_TPM_CRB                "tpm-crb"
+#define TYPE_TPM_SPAPR              "tpm-spapr"
 
 #define TPM_IS_TIS(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
+#define TPM_IS_SPAPR(chr)                           \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
 
 /* returns NULL unless there is exactly one TPM device */
 static inline TPMIf *tpm_find(void)
diff --git a/qapi/tpm.json b/qapi/tpm.json
index b30323bb6b..63878aa0f4 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -12,11 +12,11 @@
 #
 # @tpm-tis: TPM TIS model
 # @tpm-crb: TPM CRB model (since 2.12)
+# @tpm-spapr: TPM SPAPR model (since 5.0)
 #
 # Since: 1.5
 ##
-{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
-
+{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb', 'tpm-spapr' ] }
 ##
 # @query-tpm-models:
 #
@@ -29,7 +29,7 @@
 # Example:
 #
 # -> { "execute": "query-tpm-models" }
-# <- { "return": [ "tpm-tis", "tpm-crb" ] }
+# <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
 #
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
-- 
2.21.0


