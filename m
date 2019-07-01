Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A789C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A2621479
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 06:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmKUUcnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpgR-000660-7E
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 02:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hhpfU-0005Pf-1v
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hhpfT-0000ac-03
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 02:19:59 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hhpfQ-0000YO-FK; Mon, 01 Jul 2019 02:19:56 -0400
Received: by mail-pl1-x641.google.com with SMTP id c14so6779063plo.0;
 Sun, 30 Jun 2019 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CPCt4ap55kJWMYFEEuGUSXfENIIqmZAQJDkEOlJni18=;
 b=MmKUUcnpBuehyYP8twWZ2PbA+dyejxTsjcE13WBC1DTcYQCUq3G5bP1X4WjNVY+S8Z
 rUx3h+ysJrqF9T2gTf4nWRFhP8vvnQMFUHncEouDkY0xfBkX9CipNN0htLWhg2dF65qn
 sAfvlOFJUuLbKnKIBLG1tUUrtN8TCteR/HFSVSXKgo5rTs21d/oUyXqGOX8pLLxGduIl
 SysDfu2ps0LBNQE3xNjpox4z8y5B4LDIf5FW/ldtyh1hSCeuUSNTF2xxK5AQ6tBbaLBl
 ZL5lsIBh039jRw/FnJQQfJGWnq/XpCbrdnOmNwemzOp5leEsRNRgJc6jZHe/h9ebS1kP
 WZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CPCt4ap55kJWMYFEEuGUSXfENIIqmZAQJDkEOlJni18=;
 b=GtipC2MJvzz671TlhCEV4e8XUbFGvkWN7lgFJahd3moKDWWhgqRyFu6D6acTt+iYTd
 ywgNPuXERhBtIUvZIc1CqCVxFWZ8uQs/v3YLv57RoQBHJH+rFOrT6qodpnhMUn2frhq+
 M93Cbs2DsZ1jXQ8DDyKSkR+mVd7PBfYfpXOjFe1N26ejB27Ct4eTYBsuGyjENuqpKmWP
 n+QtIsnsWaUzH6aivtdC3KUO1wOdSKnV7HkHg6akHxq9AzW6PhuW/K7ATc2i6yDcZZd8
 R84VUHhH3Q/NkOEDG1WdiParmdDfs8l5XSxwKx/Bfdj8Qwb+YQne9VkfeRp29COfHNWU
 1Y4w==
X-Gm-Message-State: APjAAAXNu8g/vZTNFEIiWGSCAhHta8sOxiYZBZ6mhkyHPZRyw9or6Gjs
 SW5zSmYGqwdUezX0OVGtsPI64jC5
X-Google-Smtp-Source: APXvYqwL73Rp2IdWgLy2lxX1X08QdlEa+ZdinrVS4TWY3OpEsmMaidOGhW2XdpPbLfFlKIBlvyszUw==
X-Received: by 2002:a17:902:e2:: with SMTP id
 a89mr27271273pla.210.1561961995165; 
 Sun, 30 Jun 2019 23:19:55 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v22sm4981227pgk.69.2019.06.30.23.19.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 30 Jun 2019 23:19:54 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Mon,  1 Jul 2019 16:19:46 +1000
Message-Id: <20190701061946.32636-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [QEMU-PPC] [PATCH v3] powerpc/spapr: Add host threads
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
V2 -> V3:
- Add curly braces for single line if statements
---
 hw/ppc/spapr_rtas.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 5bc1a93271..1bab71c90c 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
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
+    if (!kvm_enabled()) {
+        return 1;
+    }
+
+    /* Read interrupt servers to determine number of threads per core */
+    dir = g_dir_open(CPUS_PATH, 0, NULL);
+    if (!dir) {
+        return -1;
+    }
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
+        if (subcores) {
+            num_threads /= subcores;
+        }
+        g_free(buf);
+    }
+
+    return num_threads;
+}
+
 static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs,
@@ -250,6 +302,16 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
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


