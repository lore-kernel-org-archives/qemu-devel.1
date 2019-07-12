Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80758C742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 03:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3DA20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 03:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSUKTdqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3DA20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hllsj-00044K-CO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 23:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <flukshun@gmail.com>) id 1hllsW-0003eX-Ve
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 23:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1hllsV-0000uZ-E2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 23:05:44 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1hllsV-0000tA-4p; Thu, 11 Jul 2019 23:05:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id v186so6201361oie.5;
 Thu, 11 Jul 2019 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W3PKTKhpaZggFaOpSOqzN4HAqva9kd9uG35eHVd/1PA=;
 b=nSUKTdqTOIw5ijqTpGmTzW5kfm/OdCsWC1xK5aHwQgj6zg6lBOtlGOVGNMbYKtPsEA
 KXccLH1O7DKXoPT7pjVGJVfjoJKFGv4GFKweUZ05pAf8SIqkhCqC6eiWXiVnFE4wtnzq
 39ABAIgRea03JBJ+08AF9/bgVWRQIMKAE1/zvylKAEcIfGBIQDG+W/cSyIFF0SqrHu8X
 sP8sUq8PSMxYM8SD7CxaoxUjFfzo8wekWSH/wXcCb4fLDhiuQhFKoNQupbg/dTuGrhkS
 f8CzF7wi5+O/bwpJMUAJAGbfpxIA5te7dRH4cPmOMeLGU0mPhoYgTcZNKW8L/yWDshsC
 Fmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=W3PKTKhpaZggFaOpSOqzN4HAqva9kd9uG35eHVd/1PA=;
 b=cR5rsyrr8juN0ilEJa11ykU09pxnJokFagiZs+sf14DfYYKdROrCU45s8S92gTX7wC
 xhO8DZ3KoFksgCOolF4yhn0nmdUwFZAOaK/qX0rMO/lXtklfgV837Fdx2cwX4nnrOXWH
 wWI08lF7d+epJvxDk9gQwPkjx8AR3qDw/QyYyfk55Y0uDfRJdaomam+wIr1CCebtxZsv
 KnNd8u2ETMZ6nH2dbrqNNp57aEoG5s1FZjla+B7K29xk3/xpqfmR9C1WrPR6MsguM3uv
 zvipzLuvy0Wxg76ispNaoXZFBOQ919iHJeJOFUZBmY4jX5oZTkOKlrzwJNjZ6V0xPoAW
 HrVw==
X-Gm-Message-State: APjAAAU7EuoLODI+kVyiHgxQFDt56OYWIU9OvLy69r8d9B11C+tSWXZ2
 SZTZF/nQVSc6S8yrF0Jf9dWhfSws
X-Google-Smtp-Source: APXvYqy27834pDllQ5cvfBe9OgWSrb+/SeFPOoLLBWaXjwuw8d3bBs6ayQrRAKP8oWNaAJuvtDv5XA==
X-Received: by 2002:aca:c695:: with SMTP id w143mr4119938oif.11.1562900740875; 
 Thu, 11 Jul 2019 20:05:40 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id k18sm2725715oib.56.2019.07.11.20.05.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Jul 2019 20:05:39 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 20:19:34 -0500
Message-Id: <20190712011934.29863-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH 2/2] spapr: initial implementation for
 H_TPM_COMM hcall
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the H_TPM_COMM hypercall, which is used by an
Ultravisor to pass TPM commands directly to the host's TPM device, or
a TPM Resource Manager associated with the device.

This also introduces a new pseries machine option which is used to
configure what TPM device to pass commands to, for example:

  -machine pseries,...,tpm-device-file=/dev/tmprm0

By default, no tpm-device-file is defined and hcalls will return
H_RESOURCE.

The full specification for this hypercall can be found in
docs/specs/ppc-spapr-uv-hcalls.txt

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
---
 hw/ppc/Makefile.objs     |   1 +
 hw/ppc/spapr.c           |  27 ++++++++
 hw/ppc/spapr_hcall_tpm.c | 135 +++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events      |   4 ++
 include/hw/ppc/spapr.h   |   7 +-
 5 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_hcall_tpm.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 9da93af905..5aa120cae6 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -5,6 +5,7 @@ obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
+obj-$(CONFIG_PSERIES) += spapr_hcall_tpm.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..eb3421673b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1776,6 +1776,10 @@ static void spapr_machine_reset(MachineState *machine)
      */
     object_child_foreach_recursive(object_get_root(), spapr_reset_drcs, NULL);
 
+    if (spapr->tpm_device_file) {
+        spapr_hcall_tpm_reset();
+    }
+
     spapr_clear_pending_events(spapr);
 
     /*
@@ -3340,6 +3344,21 @@ static void spapr_set_host_serial(Object *obj, const char *value, Error **errp)
     spapr->host_serial = g_strdup(value);
 }
 
+static char *spapr_get_tpm_device_file(Object *obj, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return g_strdup(spapr->tpm_device_file);
+}
+
+static void spapr_set_tpm_device_file(Object *obj, const char *value, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(obj);
+
+    g_free(spapr->tpm_device_file);
+    spapr->tpm_device_file = g_strdup(value);
+}
+
 static void spapr_instance_init(Object *obj)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
@@ -3396,6 +3415,14 @@ static void spapr_instance_init(Object *obj)
         &error_abort);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree", &error_abort);
+    object_property_add_str(obj, "tpm-device-file",
+                            spapr_get_tpm_device_file,
+                            spapr_set_tpm_device_file, &error_abort);
+    object_property_set_description(obj, "tpm-device-file",
+                 "Specifies the path to the TPM character device file to use"
+                 " for TPM communication via hypercalls (usually a TPM"
+                 " resource manager)",
+                 &error_abort);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_hcall_tpm.c b/hw/ppc/spapr_hcall_tpm.c
new file mode 100644
index 0000000000..75e2b6d594
--- /dev/null
+++ b/hw/ppc/spapr_hcall_tpm.c
@@ -0,0 +1,135 @@
+/*
+ * SPAPR TPM Hypercall
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Authors:
+ *  Michael Roth      <mdroth@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "hw/ppc/spapr.h"
+#include "trace.h"
+
+#define TPM_SPAPR_BUFSIZE 4096
+
+enum {
+    TPM_COMM_OP_EXECUTE = 1,
+    TPM_COMM_OP_CLOSE_SESSION = 2,
+};
+
+static int tpm_devfd = -1;
+
+static ssize_t tpm_execute(SpaprMachineState *spapr, target_ulong *args)
+{
+    uint64_t data_in = ppc64_phys_to_real(args[1]);
+    target_ulong data_in_size = args[2];
+    uint64_t data_out = ppc64_phys_to_real(args[3]);
+    target_ulong data_out_size = args[4];
+    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
+    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
+    ssize_t ret;
+
+    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_size);
+
+    if (data_in_size > TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM input buffer size: " TARGET_FMT_lu "\n",
+                     data_in_size);
+        return H_P3;
+    }
+
+    if (data_out_size < TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM output buffer size: " TARGET_FMT_lu "\n",
+                     data_out_size);
+        return H_P5;
+    }
+
+    if (tpm_devfd == -1) {
+        tpm_devfd = open(spapr->tpm_device_file, O_RDWR);
+        if (tpm_devfd == -1) {
+            error_report("failed to open TPM device %s: %d",
+                         spapr->tpm_device_file, errno);
+            return H_RESOURCE;
+        }
+    }
+
+    cpu_physical_memory_read(data_in, buf_in, data_in_size);
+
+    do {
+        ret = write(tpm_devfd, buf_in, data_in_size);
+        if (ret > 0) {
+            data_in_size -= ret;
+        }
+    } while ((ret >= 0 && data_in_size > 0) || (ret == -1 && errno == EINTR));
+
+    if (ret == -1) {
+        error_report("failed to write to TPM device %s: %d",
+                     spapr->tpm_device_file, errno);
+        return H_RESOURCE;
+    }
+
+    do {
+        ret = read(tpm_devfd, buf_out, data_out_size);
+    } while (ret == 0 || (ret == -1 && errno == EINTR));
+
+    if (ret == -1) {
+        error_report("failed to read from TPM device %s: %d",
+                     spapr->tpm_device_file, errno);
+        return H_RESOURCE;
+    }
+
+    cpu_physical_memory_write(data_out, buf_out, ret);
+    args[0] = ret;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_tpm_comm(PowerPCCPU *cpu,
+                               SpaprMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    target_ulong op = args[0];
+
+    trace_spapr_h_tpm_comm(spapr->tpm_device_file ?: "null", op);
+
+    if (!spapr->tpm_device_file) {
+        error_report("TPM device not specified");
+        return H_RESOURCE;
+    }
+
+    switch (op) {
+        case TPM_COMM_OP_EXECUTE:
+            return tpm_execute(spapr, args);
+        case TPM_COMM_OP_CLOSE_SESSION:
+            if (tpm_devfd != -1) {
+                close(tpm_devfd);
+                tpm_devfd = -1;
+            }
+            return H_SUCCESS;
+        default:
+            return H_PARAMETER;
+    }
+}
+
+void spapr_hcall_tpm_reset(void)
+{
+    if (tpm_devfd != -1) {
+        close(tpm_devfd);
+        tpm_devfd = -1;
+    }
+}
+
+static void hypercall_register_types(void)
+{
+    spapr_register_hypercall(H_TPM_COMM, h_tpm_comm);
+}
+
+type_init(hypercall_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f76448f532..96dad767a1 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -25,6 +25,10 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 
+# spapr_hcall_tpm.c
+spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_device_path=%s operation=0x%"PRIu64
+spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_out, uint64_t data_out_sz) "data_in=0x%"PRIx64", data_in_sz=%"PRIu64", data_out=0x%"PRIx64", data_out_sz=%"PRIu64
+
 # spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64
 spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tce) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" ret=%"PRId64" tce=0x%"PRIx64
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4..7bd47575d7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -198,6 +198,7 @@ struct SpaprMachineState {
     SpaprXive  *xive;
     SpaprIrq *irq;
     qemu_irq *qirqs;
+    char *tpm_device_file;
 
     bool cmd_line_caps[SPAPR_CAP_NUM];
     SpaprCapabilities def, eff, mig;
@@ -490,8 +491,9 @@ struct SpaprMachineState {
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
+#define H_TPM_COMM              0xEF10
 
-#define MAX_HCALL_OPCODE        H_INT_RESET
+#define MAX_HCALL_OPCODE        H_TPM_COMM
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
@@ -864,6 +866,9 @@ int spapr_caps_post_migration(SpaprMachineState *spapr);
 
 void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp);
+
+void spapr_hcall_tpm_reset(void);
+
 /*
  * XIVE definitions
  */
-- 
2.17.1


