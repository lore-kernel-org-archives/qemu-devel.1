Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B4EC48BE4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774BB22CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 01:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl5HU9Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774BB22CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfDyD-0007DW-5s
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 21:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfDxf-0006Sn-TU
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 21:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfDxe-0003nQ-Pg
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 21:39:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:32996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hfDxY-0003ER-VZ; Sun, 23 Jun 2019 21:39:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id m4so5597886pgk.0;
 Sun, 23 Jun 2019 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=A7KAWEKUMNrndfGHBvS4f2aODZGCXViLo82IWAShxPA=;
 b=Fl5HU9Vtx1MOuszJnVLnVrQNZMnww0fjYwbXHayxk9YVXOftLNbI3mErewvy2dWYxn
 c8gRebcl7nGsoHUHg/32pOOFUq0moAxTcMEbuJalYmEO9GTOpBTHLId1HUAtbsv0oQF9
 wjrJst5AVje4ZVmjzovQRo9pf2k7IFh1V1uo4ATydkLfF1ZJ8+hZREDfg1OGnJNA/DPL
 sE+OTrNWbpzhCQjzNR2xMf1At18An5s9vuJ8pyFiMYb5W/QKGZgB+Rqo2Nd+sI/c5ANv
 vHTtG9S3wsIqvDraEAta/v0XXZclH6NAutEMtK34gm+0xY1I56VkjP6S9NHWUxgxAlAG
 2l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=A7KAWEKUMNrndfGHBvS4f2aODZGCXViLo82IWAShxPA=;
 b=t9Vpp/g5gTeYv1SVxKnz3Th3c1LAEE8syNfsnr28GtrtWf7Xsv6Ny6dW9Il7jz/vru
 LSM7qV4h+jY1ns5T70lvFsA9W/WDFYH/bhR21IN1b+VOskfr58VqkCOiEKfF95okQ/N0
 vhtuB5+UYYUvYG8WvG7gD914vg7LdHY6LnFglipzmXEAKvyO5OKcCZmHNQcaDIFjF6Jl
 D6wMqlHZcS6ZkEUaibfQ/6VDfO+Jj43gdfiMUHR9fzMVLTPq6dtCZwDjYwrrdLwu34u/
 hGYG6UYbE43RMsSeSi0c40i49zxYvRmyQ7ay+aDCfvUPTa4FAWkI8XXtlzsy1goIVru/
 qGIQ==
X-Gm-Message-State: APjAAAWfhz3xqkTJgYh7+dK8zLtUlYMtziGcWmA/9ZxQkUo11wWA7zD+
 7jbwXYj9jueSzAPfXNsNct8wHCeF
X-Google-Smtp-Source: APXvYqxlRm36N5nyA8Vd3sq8RQLLn3gbCHge7oxOL0AxPNrjCgp+laRVWnHokpKbOceu4h5T/zab9w==
X-Received: by 2002:a63:455c:: with SMTP id u28mr31342893pgk.416.1561340389652; 
 Sun, 23 Jun 2019 18:39:49 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id k22sm9025036pfk.157.2019.06.23.18.39.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 23 Jun 2019 18:39:48 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-ppc@nongnu.org
Date: Mon, 24 Jun 2019 11:39:21 +1000
Message-Id: <20190624013921.11944-1-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [QEMU-PPC] [PATCH] powerpc/spapr: Add host threads
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
Cc: qemu-devel@nongnu.org, sjitindarsingh@gmail.com,
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
 hw/ppc/spapr_rtas.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 5bc1a93271..a33d87794c 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -229,6 +229,40 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
     return RTAS_OUT_SUCCESS;
 }
 
+static int rtas_get_num_host_threads(void)
+{
+    const char *entry, *name = "/proc/device-tree/cpus/";
+    int num_threads = -1;
+    GDir *dir;
+
+    if (!kvm_enabled())
+        return 1;
+
+    dir = g_dir_open(name, 0, NULL);
+    if (!dir)
+        return -1;
+
+    while ((entry = g_dir_read_name(dir))) {
+        if (!strncmp(entry, "PowerPC,POWER", strlen("PowerPC,POWER"))) {
+            unsigned long len;
+            char *path, *buf;
+
+            path = g_strconcat(name, entry, "/ibm,ppc-interrupt-server#s",
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
+    return num_threads;
+}
+
 static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
                                           SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs,
@@ -250,6 +284,16 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
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


