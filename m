Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F4C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E262071A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfna7c7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E262071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpGvl-0008TK-F5
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 15:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGre-0002OH-PY
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:50 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrc-0003uz-QK
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id s28so9446172edw.11
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GP6FfKUQQ7/PDaeGu/ePS+hzQJumHWPaJpKy6/KoXmU=;
 b=Yfna7c7v8w1bOkBY9yVBj3ZVpdW+a/5pZktXOrWf/UJ6S1P9aQO9oHyh9IKJDbhVpO
 0nacSqCTm0a3+FgNHJR6sduf7B1V/c6cEM6SZ/clI0m78+4GqPFJBScSn5CWZyOMim8p
 7OHuTDEocz/BnTf9Vlms5T5vZ153H2E3G7I/UQA7AftpfI23keIkGI6r0muIKD8DoDq4
 aOuWEWyy/DmTGLf7eodBqmvzC7WK2DMK5N4Dsc1lRIbkfJZfHLfgzW45JqaAVdWLgK7i
 lff17XgAp0iWRJzcTfrhCFJ4Hp0bKjkwjC3DT6Y84gCihIat81DoVebwjXn6Yk/eE4If
 WYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GP6FfKUQQ7/PDaeGu/ePS+hzQJumHWPaJpKy6/KoXmU=;
 b=IPRWqAI7wwRkfTiFE90k21r0uU2v5vr77bCGLM4E2KcM6fBgJ9XE15tTe1GHloPfyj
 rHlAsxBtW0k+Ul1zTTce8DbYHEag7G/549+gItjcPUD5tCAJQqBMger+09i4kwNpsfOI
 IFYhCSeJohc3N+KlQVOfTRRV0bJ0wqO+JSFdIQ5GIeZ4fg59RBxCelbgbH39rcd6cMC/
 efOVy4fjzvK1D2t9y+bpeB2sCWcY6fE8gumvWi4tVIIQ5yWGo+EuDxMH4ynqa9KUG9vm
 i90XCKE4yqnDoAdHQRyKJBi2rab+5GvEmaxH4YqC4FRuFprPypQcy1gOxuGW4wI8U9ak
 mhxQ==
X-Gm-Message-State: AOAM531wRxm4h2MygeGyhojviM4B3efBryCkVdc5DuimL3JwGy9fkamY
 Fy06DDaMvdMCeCkYZ3RlGixcTszn
X-Google-Smtp-Source: ABdhPJy2Zy+UAKz0riGAjzUMs4vqvjazCYZHzgwdHfw/6ePneD3KRSqn5xN0DqqR6X+G2CVT9dTWfg==
X-Received: by 2002:a50:9e02:: with SMTP id z2mr9507208ede.87.1593287507295;
 Sat, 27 Jun 2020 12:51:47 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y11sm5298734ejw.63.2020.06.27.12.51.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jun 2020 12:51:46 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 4/6] scripts/performance: Add topN_perf.py script
Date: Sat, 27 Jun 2020 21:51:41 +0200
Message-Id: <1593287503-25197-5-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>

Syntax:
topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
                 <qemu executable> [<qemu executable options>] \
                 <target executable> [<target execurable options>]

[-h] - Print the script arguments help message.
[-n] - Specify the number of top functions to print.
     - If this flag is not specified, the tool defaults to 25.

Example of usage:
topN_perf.py -n 20 -- qemu-arm coulomb_double-arm

Example Output:
 No.  Percentage  Name                       Invoked by
----  ----------  -------------------------  -------------------------
   1      16.25%  float64_mul                qemu-x86_64
   2      12.01%  float64_sub                qemu-x86_64
   3      11.99%  float64_add                qemu-x86_64
   4       5.69%  helper_mulsd               qemu-x86_64
   5       4.68%  helper_addsd               qemu-x86_64
   6       4.43%  helper_lookup_tb_ptr       qemu-x86_64
   7       4.28%  helper_subsd               qemu-x86_64
   8       2.71%  f64_compare                qemu-x86_64
   9       2.71%  helper_ucomisd             qemu-x86_64
  10       1.04%  helper_pand_xmm            qemu-x86_64
  11       0.71%  float64_div                qemu-x86_64
  12       0.63%  helper_pxor_xmm            qemu-x86_64
  13       0.50%  0x00007f7b7004ef95         [JIT] tid 491
  14       0.50%  0x00007f7b70044e83         [JIT] tid 491
  15       0.36%  helper_por_xmm             qemu-x86_64
  16       0.32%  helper_cc_compute_all      qemu-x86_64
  17       0.30%  0x00007f7b700433f0         [JIT] tid 491
  18       0.30%  float64_compare_quiet      qemu-x86_64
  19       0.27%  soft_f64_addsub            qemu-x86_64
  20       0.26%  round_to_int               qemu-x86_64

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200626164546.22102-2-ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/topN_perf.py | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100755 scripts/performance/topN_perf.py

diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
new file mode 100755
index 0000000..07be195
--- /dev/null
+++ b/scripts/performance/topN_perf.py
@@ -0,0 +1,149 @@
+#!/usr/bin/env python3
+
+#  Print the top N most executed functions in QEMU using perf.
+#  Syntax:
+#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
+#           <qemu executable> [<qemu executable options>] \
+#           <target executable> [<target execurable options>]
+#
+#  [-h] - Print the script arguments help message.
+#  [-n] - Specify the number of top functions to print.
+#       - If this flag is not specified, the tool defaults to 25.
+#
+#  Example of usage:
+#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
+#
+#  This file is a part of the project "TCG Continuous Benchmarking".
+#
+#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+#
+#  This program is free software: you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation, either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program. If not, see <https://www.gnu.org/licenses/>.
+
+import argparse
+import os
+import subprocess
+import sys
+
+
+# Parse the command line arguments
+parser = argparse.ArgumentParser(
+    usage='topN_perf.py [-h] [-n] <number of displayed top functions >  -- '
+          '<qemu executable> [<qemu executable options>] '
+          '<target executable> [<target executable options>]')
+
+parser.add_argument('-n', dest='top', type=int, default=25,
+                    help='Specify the number of top functions to print.')
+
+parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
+
+args = parser.parse_args()
+
+# Extract the needed variables from the args
+command = args.command
+top = args.top
+
+# Insure that perf is installed
+check_perf_presence = subprocess.run(["which", "perf"],
+                                     stdout=subprocess.DEVNULL)
+if check_perf_presence.returncode:
+    sys.exit("Please install perf before running the script!")
+
+# Insure user has previllage to run perf
+check_perf_executability = subprocess.run(["perf", "stat", "ls", "/"],
+                                          stdout=subprocess.DEVNULL,
+                                          stderr=subprocess.DEVNULL)
+if check_perf_executability.returncode:
+    sys.exit(
+"""
+Error:
+You may not have permission to collect stats.
+
+Consider tweaking /proc/sys/kernel/perf_event_paranoid,
+which controls use of the performance events system by
+unprivileged users (without CAP_SYS_ADMIN).
+
+  -1: Allow use of (almost) all events by all users
+      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
+   0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN
+      Disallow raw tracepoint access by users without CAP_SYS_ADMIN
+   1: Disallow CPU event access by users without CAP_SYS_ADMIN
+   2: Disallow kernel profiling by users without CAP_SYS_ADMIN
+
+To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
+   kernel.perf_event_paranoid = -1
+
+* Alternatively, you can run this script under sudo privileges.
+"""
+)
+
+# Run perf record
+perf_record = subprocess.run((["perf", "record", "--output=/tmp/perf.data"] +
+                              command),
+                             stdout=subprocess.DEVNULL,
+                             stderr=subprocess.PIPE)
+if perf_record.returncode:
+    os.unlink('/tmp/perf.data')
+    sys.exit(perf_record.stderr.decode("utf-8"))
+
+# Save perf report output to /tmp/perf_report.out
+with open("/tmp/perf_report.out", "w") as output:
+    perf_report = subprocess.run(
+        ["perf", "report", "--input=/tmp/perf.data", "--stdio"],
+        stdout=output,
+        stderr=subprocess.PIPE)
+    if perf_report.returncode:
+        os.unlink('/tmp/perf.data')
+        output.close()
+        os.unlink('/tmp/perf_report.out')
+        sys.exit(perf_report.stderr.decode("utf-8"))
+
+# Read the reported data to functions[]
+functions = []
+with open("/tmp/perf_report.out", "r") as data:
+    # Only read lines that are not comments (comments start with #)
+    # Only read lines that are not empty
+    functions = [line for line in data.readlines() if line and line[0]
+                 != '#' and line[0] != "\n"]
+
+# Limit the number of top functions to "top"
+number_of_top_functions = top if len(functions) > top else len(functions)
+
+# Store the data of the top functions in top_functions[]
+top_functions = functions[:number_of_top_functions]
+
+# Print table header
+print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Name',
+                                                         'Invoked by',
+                                                         '-' * 4,
+                                                         '-' * 10,
+                                                         '-' * 30,
+                                                         '-' * 25))
+
+# Print top N functions
+for (index, function) in enumerate(top_functions, start=1):
+    function_data = function.split()
+    function_percentage = function_data[0]
+    function_name = function_data[-1]
+    function_invoker = ' '.join(function_data[2:-2])
+    print('{:>4}  {:>10}  {:<30}  {}'.format(index,
+                                             function_percentage,
+                                             function_name,
+                                             function_invoker))
+
+# Remove intermediate files
+os.unlink('/tmp/perf.data')
+os.unlink('/tmp/perf_report.out')
-- 
2.7.4


