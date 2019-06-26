Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154BC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D314208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlgQeGvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D314208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg0Lw-00086e-EV
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 01:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hg0LC-0007Zs-3R
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hg0LB-0007dS-3T
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:19:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hg0L8-0007ad-6k; Wed, 26 Jun 2019 01:19:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id m4so624323pgk.0;
 Tue, 25 Jun 2019 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=XwpxBVl70guybapI8XVHMxeo9/0ZLkhofCzAVm65pUM=;
 b=TlgQeGvMtBE8Dexm1PbxuU0DaYM1WO3KFf+g5Cq73NkA9xGgE6aW24yAFREUe2aSwe
 U2iNg46XOs1Dian79E0xrdnVizNgUksKsxnURBbdMpyC5i0raBAS+c7Q4tFWDBxrnQRu
 tWf7qfWXlBhqQ1lXWT6NtGOrchVV+tUfnyYb0JAxc0zIEbRyqbmsXoZQ6ajd3aDwosEt
 UYkCJQra741yf89NZ7ntOv3eWzDkrRNeZNe2Kmn65kRzDmAh+VWROT3XBfhvi/NqUd4W
 pt7SFH7K6ad2ZGlXQXsxVHSbhA9NuK5OKheqc86T7CnD3iQp/pyAh+FJTxSJmY/Zk2PO
 b/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XwpxBVl70guybapI8XVHMxeo9/0ZLkhofCzAVm65pUM=;
 b=g+RMtz67bq0+i3p5kF5JDKsZYapRVFTc7dFwaKalli10/uI250fUoK4zdBwaCfOuEd
 Z8PkRXc9qDlbR6aNUtPx5SVMK7DIJVOcaLQYyfZZ0e5QDOuDqGdIVzdwtnPUpKp3ELHE
 KLfAyLKwkqYnN2T1UhbhGR/Rj68PmV+2Faqehv00vdJV67Js90QJqzJ/A5SduxJzseV4
 ai89ewKKQaXqHrMXLjoryFp3MXYN/Sf28O9MWVFWWWSDkP056uddGlxA8xwZCG+RafMw
 SGvwh6D8CfP51beVghoh3+RyYJgSqaiqsXqiXR9MuAxtpUr2CnfjdQdy5pytUfF68/bB
 iAmQ==
X-Gm-Message-State: APjAAAVlxUy2r8gw8ffVauhJh4FHcXum/p6dM7Ef+KNyP7VMRglqySi3
 TdtoPV928qxnkhyYAA3f11nEs4EM
X-Google-Smtp-Source: APXvYqygcWm8qmZ1LPbbUqfSXcCQfIcPsju6+f1eoMB+zXm/kSwMfIJVN1S2Zszr2Y5OqqVBjIDHNQ==
X-Received: by 2002:a63:6011:: with SMTP id u17mr975907pgb.117.1561526364671; 
 Tue, 25 Jun 2019 22:19:24 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e188sm10037746pfh.99.2019.06.25.22.19.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 22:19:23 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Wed, 26 Jun 2019 15:19:03 +1000
Message-Id: <20190626051903.26829-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [QEMU-PPC] [PATCH v2] powerpc/spapr: Add host threads
 parameter to ibm, get_system_parameter
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
Cc: groug@kaod.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ibm,get_system_parameter rtas call is used by the guest to retrieve
data relating to certain parameters of the system. The SPLPAR
characteristics option (token 20) is used to determin characteristics of
the environment in which the lpar will run.

It may be useful for a guest to know the number of physical host threads
present on the underlying system where it is being run. Add the
characteristic "HostThrs" to the SPLPAR Characteristics
ibm,get_system_parameter rtas call to expose this information to a
guest and provide an implementation which determines this information
based on the number of interrupt servers present in the device tree.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V1 -> V2:
- Take into account that the core may be operating in split core mode
  meaning a single core may be split into multiple subcores.
---
 hw/ppc/spapr_rtas.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 5bc1a93271..9b15e7606b 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -229,6 +229,55 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
     return RTAS_OUT_SUCCESS;
 }
 
+#define CPUS_PATH       "/proc/device-tree/cpus/"
+#define SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
+
+static int rtas_get_num_host_threads(void)
+{
+    int num_threads = -1;
+    unsigned long len;
+    const char *entry;
+    char *buf;
+    GDir *dir;
+
+    if (!kvm_enabled())
+        return 1;
+
+    /* Read interrupt servers to determine number of threads per core */
+    dir = g_dir_open(CPUS_PATH, 0, NULL);
+    if (!dir)
+        return -1;
+
+    while ((entry = g_dir_read_name(dir))) {
+        if (!strncmp(entry, "PowerPC,POWER", strlen("PowerPC,POWER"))) {
+            char *path;
+
+            path = g_strconcat(CPUS_PATH, entry, "/ibm,ppc-interrupt-server#s",
+                               NULL);
+            if (g_file_get_contents(path, &buf, &len, NULL)) {
+                num_threads = len / sizeof(int);
+                g_free(buf);
+            }
+
+            g_free(path);
+            break;
+        }
+    }
+
+    g_dir_close(dir);
+
+    /* Check if split core mode in use */
+    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
+        int subcores = g_ascii_strtoll(buf, NULL, 10);
+
+        if (subcores)
+            num_threads /= subcores;
+        g_free(buf);
+    }
+
+    return num_threads;
+}
+
 static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs,
@@ -250,6 +299,16 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           current_machine->ram_size / MiB,
                                           smp_cpus,
                                           max_cpus);
+        int num_host_threads = rtas_get_num_host_threads();
+
+        if (num_host_threads > 0) {
+            char *hostthr_val, *old = param_val;
+
+            hostthr_val = g_strdup_printf(",HostThrs=%d", num_host_threads);
+            param_val = g_strconcat(param_val, hostthr_val, NULL);
+            g_free(hostthr_val);
+            g_free(old);
+        }
         ret = sysparm_st(buffer, length, param_val, strlen(param_val) + 1);
         g_free(param_val);
         break;
-- 
2.13.6


