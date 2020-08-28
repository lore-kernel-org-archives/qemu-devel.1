Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D6BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3199B208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Lp06PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3199B208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbru-0008Cb-E1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpT-0003pL-V1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpQ-0005kD-Jh
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so834510wrn.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NKjrR/1jJBl3PMLAgxGFOGP+xi3KNmymEVWR9lFRmRk=;
 b=b7Lp06PIVaYJOGD/iWKmSUt1QjjX41g5c9VeXHZhk3l7qeTyJropoduGwPmAMNJ0RC
 smQxmVX7ivvXTDaMNzWBiWCiIGajG5y1jonWPU/YKLQrwB20wBvHWUFYlM1nDdf6CFWQ
 zph5CvKoUrduoVOz2a4hk4BnRW2Is0uABwxVPA/rNsRGAeVQ3QlKQSO1N0z5Q15EDFVY
 M4YWJRHHYTQs+yVy1Ipyf+ObGU5d0UL0D4BVqw2I9t4jITTLakphE5OVbHZja7km9GsB
 /kHtzlJlRWExC9iPT7/DmO9A2oNZApQi2TB1Q/Olw8kK53bwhuf8LFVDdvnCoP39Q7P9
 t51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NKjrR/1jJBl3PMLAgxGFOGP+xi3KNmymEVWR9lFRmRk=;
 b=JFw0lDw6e2fU7+ukZcqxus70HcXSlGlRRSdkTjJQHQXESD1FkbQ6A73ZAx5vd9Ag3v
 oNRwYFDRje0Rrin+c3fRPoOf5N94x2lHfs2PV89kuX7hKlvtvNTLT1b64CVyJsB9wTBm
 BcH2po1J4gsFYsVO5pRqBOoSVnujgNHN84nWwzZ4hsbjDbbYjuEPvPwJfu8KxYRfLICE
 7walVArnLs5iSWo74WBC1H0vvTWO0J6mt//f+gs1RiUdO6yMx3dvoRqrWxIjqVr6giZW
 EzqPPzxK2QXdAumDunKQ6f2x/qWshrJX5U6dZqjoLtzAB0/bSaTnxc4dS7mMf/3iEbXN
 tbXg==
X-Gm-Message-State: AOAM530pseFF1o4KXG7up1h2MihWyrvstAz3IF76meNuFzRmtjluOPW7
 968P62rRIM98xbrircy8sCNwydAr/BXfKg==
X-Google-Smtp-Source: ABdhPJwsM0EBllpTnbeUyiaGJcaEEvoElZtbRzP6mYUFKdp3uqyWztCdJ+EosrbuJFcOdtYbGs7lKg==
X-Received: by 2002:adf:828e:: with SMTP id 14mr984753wrc.217.1598611310859;
 Fri, 28 Aug 2020 03:41:50 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:50 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 9/9] scripts/performance: Add topN_system.py script
Date: Fri, 28 Aug 2020 12:41:02 +0200
Message-Id: <20200828104102.4490-10-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python script for listing the topN executed QEMU functions in
system mode.

Syntax:
topN_system.py [-h] [-n <number of displayed top functions>] -- \
    <qemu system executable> <qemu system options>

[-h] - Print the script arguments help message.
[-n] - Specify the number of top functions to print.
     - If this flag is not specified, the tool defaults to 25.

Example of usage:
topN_system.py -n 20 -- qemu-system-x86_64 -m 1024 -kernel <kernel> \
    -initrd <initrd>

Example output:
Number of instructions: 150,991,381,071

 No.  Percentage  Name
 ---  ----------  ------------------------------
   1      11.30%  helper_lookup_tb_ptr
   2       7.01%  liveness_pass_1
   3       4.48%  tcg_gen_code
   4       3.41%  tcg_optimize
   5       1.84%  tcg_out_opc.isra.13
   6       1.78%  helper_pcmpeqb_xmm
   7       1.20%  object_dynamic_cast_assert
   8       1.00%  cpu_exec
   9       0.99%  tcg_temp_new_internal
  10       0.88%  tb_htable_lookup
  11       0.84%  object_class_dynamic_cast_assert
  12       0.81%  init_ts_info
  13       0.80%  tlb_set_page_with_attrs
  14       0.77%  victim_tlb_hit
  15       0.75%  tcg_out_sib_offset
  16       0.62%  tcg_op_alloc
  17       0.61%  helper_pmovmskb_xmm
  18       0.58%  disas_insn.isra.50
  19       0.56%  helper_pcmpgtb_xmm
  20       0.56%  address_space_ldq

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/topN_system.py | 158 +++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 scripts/performance/topN_system.py

diff --git a/scripts/performance/topN_system.py b/scripts/performance/topN_system.py
new file mode 100755
index 0000000000..9b1f1a66c7
--- /dev/null
+++ b/scripts/performance/topN_system.py
@@ -0,0 +1,158 @@
+#!/usr/bin/env python3
+
+"""
+Print the top N most executed functions in QEMU system mode emulation.
+
+Syntax:
+topN_system.py [-h] [-n <number of displayed top functions>] -- \
+    <qemu system executable> <qemu system options>
+
+[-h] - Print the script arguments help message.
+[-n] - Specify the number of top functions to print.
+     - If this flag is not specified, the tool defaults to 25.
+
+Example of usage:
+topN_system.py -n 20 -- qemu-system-x86_64 -m 1024 -kernel <kernel> \
+    -initrd <initrd>
+
+This file is a part of the project "TCG Continuous Benchmarking".
+
+Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+
+This program is free software: you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation, either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program. If not, see <https://www.gnu.org/licenses/>.
+"""
+
+import argparse
+import os
+import subprocess
+import sys
+import tempfile
+
+
+# Parse the command line arguments
+PARSER = argparse.ArgumentParser(
+    usage="usage: topN_system.py [-h] [-n <number of displayed top functions>]"
+          " -- <qemu system executable> <qemu system options>")
+
+PARSER.add_argument("-n", dest="top", type=int, default=25,
+                    help="Specify the number of top functions to print.")
+
+PARSER.add_argument("command", type=str, nargs="+", help=argparse.SUPPRESS)
+
+ARGS = PARSER.parse_args()
+
+# Extract the needed variables from the args
+COMMAND = ARGS.command
+TOP = ARGS.top
+
+# Ensure that perf is installed
+CHECK_PERF_PRESENCE = subprocess.run(["which", "perf"],
+                                     stdout=subprocess.DEVNULL,
+                                     check=False)
+if CHECK_PERF_PRESENCE.returncode:
+    sys.exit("Please install perf before running the script!")
+
+# Ensure user has previllage to run perf
+CHECK_PERF_EXECUTABILITY = subprocess.run(["perf", "stat", "ls", "/"],
+                                          stdout=subprocess.DEVNULL,
+                                          stderr=subprocess.DEVNULL,
+                                          check=False)
+if CHECK_PERF_EXECUTABILITY.returncode:
+    sys.exit("""
+Error:
+You may not have permission to collect stats.
+Consider tweaking /proc/sys/kernel/perf_event_paranoid,
+which controls use of the performance events system by
+unprivileged users (without CAP_SYS_ADMIN).
+  -1: Allow use of (almost) all events by all users
+      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
+   0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
+      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
+   1: Disallow CPU event access by users without CAP_SYS_ADMIN
+   2: Disallow kernel profiling by users without CAP_SYS_ADMIN
+To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
+   kernel.perf_event_paranoid = -1
+
+* Alternatively, you can run this script under sudo privileges.
+""")
+
+# Run perf and save all intermediate files in a temporary directory
+with tempfile.TemporaryDirectory() as tmpdir:
+    RECORD_PATH = os.path.join(tmpdir, "record.data")
+    REPORT_PATH = os.path.join(tmpdir, "report.txt")
+
+    PERF_RECORD = subprocess.run((["perf",
+                                   "record",
+                                   "-e",
+                                   "instructions",
+                                   "--output="+RECORD_PATH] +
+                                  COMMAND),
+                                 stdout=subprocess.DEVNULL,
+                                 stderr=subprocess.PIPE,
+                                 check=False)
+    if PERF_RECORD.returncode:
+        sys.exit(PERF_RECORD.stderr.decode("utf-8"))
+
+    with open(REPORT_PATH, "w") as output:
+        PERF_REPORT = subprocess.run(["perf",
+                                      "report",
+                                      "--input=" + RECORD_PATH,
+                                      "--stdio"],
+                                     stdout=output,
+                                     stderr=subprocess.PIPE,
+                                     check=False)
+        if PERF_REPORT.returncode:
+            sys.exit(PERF_REPORT.stderr.decode("utf-8"))
+
+    # Save the reported data to FUNCTIONS[] and INSTRUCTIONS
+    with open(REPORT_PATH, "r") as data:
+        LINES = data.readlines()
+        # Read the number of instructions
+        INSTRUCTIONS = int(LINES[6].split()[-1])
+        # Continue reading:
+        # Only read lines that are not empty
+        # Only read lines that are not comments (comments start with #)
+        # Only read functions executed by qemu-system
+        FUNCTIONS = [line for line in LINES if line
+                     and line[0] != "\n"
+                     and line[0] != "#"
+                     and "qemu-system" in line.split()[2]]
+
+
+# Limit the number of top functions to "TOP"
+NO_TOP_FUNCTIONS = TOP if len(FUNCTIONS) > TOP else len(FUNCTIONS)
+
+# Store the data of the top functions in TOP_FUNCTIONS[]
+TOP_FUNCTIONS = FUNCTIONS[:NO_TOP_FUNCTIONS]
+
+# Print total instructions
+print("\nNumber of instructions:", format(INSTRUCTIONS, ","))
+# Print table header
+print("\n{:>4}  {:>10}  {}\n{}  {}  {}".format("No.",
+                                               "Percentage",
+                                               "Name",
+                                               "-" * 4,
+                                               "-" * 10,
+                                               "-" * 30))
+
+# Print top N functions
+for (index, function) in enumerate(TOP_FUNCTIONS, start=1):
+    function_data = function.split()
+    function_percentage = function_data[0]
+    function_name = function_data[-1]
+    function_invoker = " ".join(function_data[2:-2])
+    print("{:>4}  {:>10}  {}".format(index,
+                                     function_percentage,
+                                     function_name))
-- 
2.17.1


