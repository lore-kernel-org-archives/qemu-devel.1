Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D40C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 00:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74F4206E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 00:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74F4206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz7zZ-0003Kl-4N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 20:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jz7xa-0000ss-DD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 20:22:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1jz7xY-0007rg-9c
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 20:22:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06P02jJi102997; Fri, 24 Jul 2020 20:22:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32faj4ttpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 20:22:36 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06P05NeW112688;
 Fri, 24 Jul 2020 20:22:36 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32faj4ttpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 20:22:36 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06P0KKUf009049;
 Sat, 25 Jul 2020 00:22:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 32brqaeaus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 25 Jul 2020 00:22:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06P0MYWP53150152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 25 Jul 2020 00:22:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 990A4B2067;
 Sat, 25 Jul 2020 00:22:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AF50B2066;
 Sat, 25 Jul 2020 00:22:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat, 25 Jul 2020 00:22:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 1/3] Revert "tpm: Clean up error reporting in
 tpm_init_tpmdev()"
Date: Fri, 24 Jul 2020 20:22:26 -0400
Message-Id: <20200725002228.2629410-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200725002228.2629410-1-stefanb@linux.vnet.ibm.com>
References: <20200725002228.2629410-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_10:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240164
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 20:22:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

This reverts commit d10e05f15d5c3dd5e5cc59c5dfff460d89d48580.

We report some -tpmdev failures, but then continue as if all was fine.
Reproducer:

    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chardev null,id=tpm0 -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
    qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: tpm chardev 'chrtpm' not found.
    qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory
    QEMU 5.0.90 monitor - type 'help' for more information
    (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=tpm0: Property 'tpm-tis.tpmdev' can't find value 'tpm0'
    $ echo $?
    1

This is a regression caused by commit d10e05f15d "tpm: Clean up error
reporting in tpm_init_tpmdev()".  It's incomplete: be->create(opts)
continues to use error_report(), and we don't set an error when it
fails.

I figure converting the create() methods to Error would make some
sense, but I'm not sure it's worth the effort right now.  Revert the
broken commit instead, and add a comment to tpm_init_tpmdev().

Straightforward conflict in tpm.c resolved.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/sysemu/tpm.h |  2 +-
 softmmu/vl.c         |  4 +++-
 stubs/tpm.c          |  3 ++-
 tpm.c                | 30 +++++++++++++++++++++---------
 4 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 03fb25941c..730c61ac97 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -16,7 +16,7 @@
 #include "qom/object.h"
 
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
-void tpm_init(void);
+int tpm_init(void);
 void tpm_cleanup(void);
 
 typedef enum TPMVersion {
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3416241557..660537a709 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4258,7 +4258,9 @@ void qemu_init(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_delayed, &error_fatal);
 
-    tpm_init();
+    if (tpm_init() < 0) {
+        exit(1);
+    }
 
     blk_mig_init();
     ram_mig_init();
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 66c99d667d..9bded191d9 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -10,8 +10,9 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 
-void tpm_init(void)
+int tpm_init(void)
 {
+    return 0;
 }
 
 void tpm_cleanup(void)
diff --git a/tpm.c b/tpm.c
index fe03b24858..f6045bb6da 100644
--- a/tpm.c
+++ b/tpm.c
@@ -81,26 +81,33 @@ TPMBackend *qemu_find_tpm_be(const char *id)
 
 static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 {
+    /*
+     * Use of error_report() in a function with an Error ** parameter
+     * is suspicious.  It is okay here.  The parameter only exists to
+     * make the function usable with qemu_opts_foreach().  It is not
+     * actually used.
+     */
     const char *value;
     const char *id;
     const TPMBackendClass *be;
     TPMBackend *drv;
+    Error *local_err = NULL;
     int i;
 
     if (!QLIST_EMPTY(&tpm_backends)) {
-        error_setg(errp, "Only one TPM is allowed.");
+        error_report("Only one TPM is allowed.");
         return 1;
     }
 
     id = qemu_opts_id(opts);
     if (id == NULL) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        error_report(QERR_MISSING_PARAMETER, "id");
         return 1;
     }
 
     value = qemu_opt_get(opts, "type");
     if (!value) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "type");
+        error_report(QERR_MISSING_PARAMETER, "type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -108,14 +115,15 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
     be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
     if (be == NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
-                   "a TPM backend type");
+        error_report(QERR_INVALID_PARAMETER_VALUE,
+                     "type", "a TPM backend type");
         tpm_display_backend_drivers();
         return 1;
     }
 
     /* validate backend specific opts */
-    if (!qemu_opts_validate(opts, be->opts, errp)) {
+    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
+        error_report_err(local_err);
         return 1;
     }
 
@@ -148,10 +156,14 @@ void tpm_cleanup(void)
  * Initialize the TPM. Process the tpmdev command line options describing the
  * TPM backend.
  */
-void tpm_init(void)
+int tpm_init(void)
 {
-    qemu_opts_foreach(qemu_find_opts("tpmdev"),
-                      tpm_init_tpmdev, NULL, &error_fatal);
+    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
+                          tpm_init_tpmdev, NULL, NULL)) {
+        return -1;
+    }
+
+    return 0;
 }
 
 /*
-- 
2.24.1


