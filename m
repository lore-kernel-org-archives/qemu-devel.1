Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7B720707
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhmj-0006Qi-Jy
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIy-0006V0-98
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jnhIv-0004l6-OC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:41:31 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NBWh0F045555; Tue, 23 Jun 2020 07:41:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05thb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:28 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NBWmOo045856;
 Tue, 23 Jun 2020 07:41:28 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uds05tg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:41:27 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBQ7CX015003;
 Tue, 23 Jun 2020 11:41:26 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 31sa38pvwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:41:26 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBfOBJ11338160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:41:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 629EAC6055;
 Tue, 23 Jun 2020 11:41:25 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD84DC6059;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:41:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 12/12] tpm: Move backend code under the 'backends/' directory
Date: Tue, 23 Jun 2020 07:41:14 -0400
Message-Id: <20200623114114.1375104-13-stefanb@linux.vnet.ibm.com>
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
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

TPM subsytem is split into backends (see commit f4ede81eed2)
and frontends (see i.e. 3676bc69b35). Keep the emulated
hardware 'frontends' under hw/tpm/, but move the backends
in the backends/tpm/ directory.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200612085444.8362-13-philmd@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 Makefile                               |  2 +-
 Makefile.objs                          |  1 +
 backends/Kconfig                       |  1 +
 backends/tpm/Kconfig                   | 14 +++++++++++
 backends/tpm/Makefile.objs             |  3 +++
 {hw => backends}/tpm/tpm_emulator.c    |  0
 {hw => backends}/tpm/tpm_int.h         |  6 ++---
 {hw => backends}/tpm/tpm_ioctl.h       |  0
 {hw => backends}/tpm/tpm_passthrough.c |  0
 {hw => backends}/tpm/tpm_util.c        |  0
 backends/tpm/trace-events              | 33 +++++++++++++++++++++++++
 docs/specs/tpm.rst                     |  8 +++---
 hw/tpm/Kconfig                         | 15 ------------
 hw/tpm/Makefile.objs                   |  3 ---
 hw/tpm/trace-events                    | 34 +-------------------------
 tests/qtest/tpm-emu.c                  |  2 +-
 16 files changed, 62 insertions(+), 60 deletions(-)
 create mode 100644 backends/Kconfig
 create mode 100644 backends/tpm/Kconfig
 rename {hw => backends}/tpm/tpm_emulator.c (100%)
 rename {hw => backends}/tpm/tpm_int.h (96%)
 rename {hw => backends}/tpm/tpm_ioctl.h (100%)
 rename {hw => backends}/tpm/tpm_passthrough.c (100%)
 rename {hw => backends}/tpm/tpm_util.c (100%)
 create mode 100644 backends/tpm/trace-events

diff --git a/Makefile b/Makefile
index 48f23aa978..a0092153af 100644
--- a/Makefile
+++ b/Makefile
@@ -418,7 +418,7 @@ MINIKCONF_ARGS = \
     CONFIG_LINUX=$(CONFIG_LINUX) \
     CONFIG_PVRDMA=$(CONFIG_PVRDMA)
 
-MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
+MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/backends/Kconfig $(SRC_PATH)/hw/Kconfig
 MINIKCONF_DEPS = $(MINIKCONF_INPUTS) $(wildcard $(SRC_PATH)/hw/*/Kconfig)
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
 
diff --git a/Makefile.objs b/Makefile.objs
index 7ce2588b89..98383972ee 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,6 +125,7 @@ trace-events-subdirs =
 trace-events-subdirs += accel/kvm
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += backends
+trace-events-subdirs += backends/tpm
 trace-events-subdirs += crypto
 trace-events-subdirs += monitor
 ifeq ($(CONFIG_USER_ONLY),y)
diff --git a/backends/Kconfig b/backends/Kconfig
new file mode 100644
index 0000000000..f35abc1609
--- /dev/null
+++ b/backends/Kconfig
@@ -0,0 +1 @@
+source tpm/Kconfig
diff --git a/backends/tpm/Kconfig b/backends/tpm/Kconfig
new file mode 100644
index 0000000000..5d91eb89c2
--- /dev/null
+++ b/backends/tpm/Kconfig
@@ -0,0 +1,14 @@
+config TPM_BACKEND
+    bool
+    depends on TPM
+
+config TPM_PASSTHROUGH
+    bool
+    default y
+    # FIXME: should check for x86 host as well
+    depends on TPM_BACKEND && LINUX
+
+config TPM_EMULATOR
+    bool
+    default y
+    depends on TPM_BACKEND
diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
index 8cf5772824..db2731f634 100644
--- a/backends/tpm/Makefile.objs
+++ b/backends/tpm/Makefile.objs
@@ -1 +1,4 @@
 common-obj-y += tpm_backend.o
+common-obj-y += tpm_util.o
+common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
+common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/hw/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
similarity index 100%
rename from hw/tpm/tpm_emulator.c
rename to backends/tpm/tpm_emulator.c
diff --git a/hw/tpm/tpm_int.h b/backends/tpm/tpm_int.h
similarity index 96%
rename from hw/tpm/tpm_int.h
rename to backends/tpm/tpm_int.h
index 9f72879d89..ba6109306e 100644
--- a/hw/tpm/tpm_int.h
+++ b/backends/tpm/tpm_int.h
@@ -9,8 +9,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#ifndef TPM_TPM_INT_H
-#define TPM_TPM_INT_H
+#ifndef BACKENDS_TPM_INT_H
+#define BACKENDS_TPM_INT_H
 
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
@@ -85,4 +85,4 @@ typedef struct TPMSizedBuffer {
 
 void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
 
-#endif /* TPM_TPM_INT_H */
+#endif /* BACKENDS_TPM_INT_H */
diff --git a/hw/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
similarity index 100%
rename from hw/tpm/tpm_ioctl.h
rename to backends/tpm/tpm_ioctl.h
diff --git a/hw/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
similarity index 100%
rename from hw/tpm/tpm_passthrough.c
rename to backends/tpm/tpm_passthrough.c
diff --git a/hw/tpm/tpm_util.c b/backends/tpm/tpm_util.c
similarity index 100%
rename from hw/tpm/tpm_util.c
rename to backends/tpm/tpm_util.c
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
new file mode 100644
index 0000000000..0a2591fb2d
--- /dev/null
+++ b/backends/tpm/trace-events
@@ -0,0 +1,33 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# tpm_passthrough.c
+tpm_passthrough_handle_request(void *cmd) "processing command %p"
+tpm_passthrough_reset(void) "reset"
+
+# tpm_util.c
+tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
+tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
+tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
+tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
+
+# tpm_emulator.c
+tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
+tpm_emulator_handle_request(void) "processing TPM command"
+tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
+tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
+tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
+tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
+tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_TPM_CMD"
+tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
+tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
+tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
+tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
+tpm_emulator_get_state_blob(uint8_t type, uint32_t size, uint32_t flags) "got state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blob(uint8_t type, uint32_t size, uint32_t flags) "set state blob type %d, %u bytes, flags 0x%08x"
+tpm_emulator_set_state_blobs(void) "setting state blobs"
+tpm_emulator_set_state_blobs_error(const char *msg) "error while setting state blobs: %s"
+tpm_emulator_set_state_blobs_done(void) "Done setting state blobs"
+tpm_emulator_pre_save(void) ""
+tpm_emulator_inst_init(void) ""
diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 0200fdac68..ed6c0d785d 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -232,8 +232,8 @@ Integrity Measurement Architecture (IMA), are not expecting to share
 PCRs.
 
 QEMU files related to the TPM passthrough device:
- - ``hw/tpm/tpm_passthrough.c``
- - ``hw/tpm/tpm_util.c``
+ - ``backends/tpm/tpm_passthrough.c``
+ - ``backends/tpm/tpm_util.c``
  - ``include/sysemu/tpm_util.h``
 
 
@@ -292,8 +292,8 @@ instrumented to initialize a TPM 1.2 or TPM 2 device using this
 command.
 
 QEMU files related to the TPM emulator device:
- - ``hw/tpm/tpm_emulator.c``
- - ``hw/tpm/tpm_util.c``
+ - ``backends/tpm/tpm_emulator.c``
+ - ``backends/tpm/tpm_util.c``
  - ``include/sysemu/tpm_util.h``
 
 The following commands start the swtpm with a UnixIO control channel over
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 5028fd8880..29e82f3c92 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -1,7 +1,3 @@
-config TPM_BACKEND
-    bool
-    depends on TPM
-
 config TPM_TIS_ISA
     bool
     depends on TPM && ISA_BUS
@@ -22,17 +18,6 @@ config TPM_CRB
     depends on TPM && PC
     select TPM_BACKEND
 
-config TPM_PASSTHROUGH
-    bool
-    default y
-    # FIXME: should check for x86 host as well
-    depends on TPM_BACKEND && LINUX
-
-config TPM_EMULATOR
-    bool
-    default y
-    depends on TPM_BACKEND
-
 config TPM_SPAPR
     bool
     default y
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index f1ec4beb95..6fc05be67c 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,9 +1,6 @@
-common-obj-$(CONFIG_TPM) += tpm_util.o
 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
 common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
 common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
 common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
-common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
-common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
 obj-$(CONFIG_TPM_SPAPR) += tpm_spapr.o
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 439e514787..de9bf1e01b 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -4,38 +4,6 @@
 tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
 
-# tpm_passthrough.c
-tpm_passthrough_handle_request(void *cmd) "processing command %p"
-tpm_passthrough_reset(void) "reset"
-
-# tpm_util.c
-tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_resp->hdr.len = %u, expected = %zu"
-tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u, expected = %zu"
-tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
-tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
-tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
-tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
-
-# tpm_emulator.c
-tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
-tpm_emulator_handle_request(void) "processing TPM command"
-tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
-tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
-tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
-tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
-tpm_emulator_cancel_cmd_not_supt(void) "Backend does not support CANCEL_TPM_CMD"
-tpm_emulator_handle_device_opts_tpm12(void) "TPM Version 1.2"
-tpm_emulator_handle_device_opts_tpm2(void) "TPM Version 2"
-tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
-tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
-tpm_emulator_get_state_blob(uint8_t type, uint32_t size, uint32_t flags) "got state blob type %d, %u bytes, flags 0x%08x"
-tpm_emulator_set_state_blob(uint8_t type, uint32_t size, uint32_t flags) "set state blob type %d, %u bytes, flags 0x%08x"
-tpm_emulator_set_state_blobs(void) "setting state blobs"
-tpm_emulator_set_state_blobs_error(const char *msg) "error while setting state blobs: %s"
-tpm_emulator_set_state_blobs_done(void) "Done setting state blobs"
-tpm_emulator_pre_save(void) ""
-tpm_emulator_inst_init(void) ""
-
 # tpm_tis.c
 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
 tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
@@ -56,7 +24,7 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
 # tpm_ppi.c
 tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
 
-# hw/tpm/tpm_spapr.c
+# tpm_spapr.c
 tpm_spapr_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
 tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x%02x 0x%02x"
 tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index 298d0eec74..2e8eb7b94f 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
-#include "hw/tpm/tpm_ioctl.h"
+#include "backends/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
 #include "tpm-emu.h"
-- 
2.24.1


