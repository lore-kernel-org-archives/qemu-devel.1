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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C2C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E685208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULG82S0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E685208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbqH-0004wk-DI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpB-0003MZ-Ex
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbp8-0005fA-Ql
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id c18so833999wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GGrLy3IbvYhI9UUc6EFtGpu2pNno9f5HSPArLmtNmFM=;
 b=ULG82S0L3kCib5VT4GaouqmZivM+bay/mzr4qks3za+D7dtBqR++RqUjn5NKpkuVLE
 /3WjJcnTTdwSFiaGo8qwVLUJahcQ7YdGddB3xqtaldRO0TWnk8RyT7Cau2kciF5uc7V7
 Nk/GzfRznwhn6IjcEL5I8C3h1O59R/HBQrVnu7SUJ3+UrmTDzW1TF7XsuaY1bR65VcNx
 sZ3AFsVXCOcMZP1jtQhLb8qc/1cQPTORJ/AxlxH/uybNPNQO95i10kyWpJ8XPe87hLJA
 AQLF6MfAcC6rwAgym1SY74AMz2zNBol60n2pAN+xDpkD9mAz2NmUuitE7eVfTahJz+cX
 4BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GGrLy3IbvYhI9UUc6EFtGpu2pNno9f5HSPArLmtNmFM=;
 b=edhvkGgaW9FNDljG3BIyWtLg3vd0nXEB+/VdohZOpFWeWNs3yQU+HeWPI6aFOXHqip
 w9iA0fpMObgbfEg/q9ms4kU1Td1b/+f5x4Ujjxb4tbeSLEfHVuBXTCrmeu+dzRBVRdOd
 KTaTcdGN+h854DLMezFJJJE+lqYJyY7gep7kYzCj5BzIqTS9cqSIIVPBBcFB1hC+3U4d
 7RX1jMrvlxe7E5Qh1aZIcQ2ntgdnxUDhsbZhfIezgHAVJt9rbhqI/58mbqcy9rwhmJLr
 FXKvpSlFTuI4+ereHs7Wv3rBgAizzUm+s/azfzQAc6n7LkmlymlVZCZkfCZ4KHaN585s
 GQig==
X-Gm-Message-State: AOAM532cer+BEXV1Y4xxukMb6m+oXF80a4vYTa7iq27DCeVULpPw8SUI
 B7Snuz/ED3TY/vhWtxrk80YWy3tKpaP0UA==
X-Google-Smtp-Source: ABdhPJy+UxZw0jQnURExU+I0JXJh37Lpqu5CD/VUPQVnG0uk7ICLiSSbKv/D/w+rB/FxGK0ERvMoDA==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr954931wrv.185.1598611292937; 
 Fri, 28 Aug 2020 03:41:32 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:32 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 1/9] scripts/performance: Refactor topN_perf.py
Date: Fri, 28 Aug 2020 12:40:54 +0200
Message-Id: <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
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

- Apply pylint and flake8 formatting rules to the script.
- Use 'tempfile' instead of '/tmp' for creating temporary files.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/topN_perf.py | 174 +++++++++++++++----------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
index 07be195fc8..56b100da87 100755
--- a/scripts/performance/topN_perf.py
+++ b/scripts/performance/topN_perf.py
@@ -1,72 +1,77 @@
 #!/usr/bin/env python3
 
-#  Print the top N most executed functions in QEMU using perf.
-#  Syntax:
-#  topN_perf.py [-h] [-n] <number of displayed top functions>  -- \
-#           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
-#
-#  [-h] - Print the script arguments help message.
-#  [-n] - Specify the number of top functions to print.
-#       - If this flag is not specified, the tool defaults to 25.
-#
-#  Example of usage:
-#  topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
-#
-#  This file is a part of the project "TCG Continuous Benchmarking".
-#
-#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
-#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <https://www.gnu.org/licenses/>.
+"""
+Print the top N most executed functions in QEMU using perf.
+
+Syntax:
+topN_perf.py [-h] [-n <number of displayed top functions>] -- \
+         <qemu executable> [<qemu executable options>] \
+         <target executable> [<target execurable options>]
+
+[-h] - Print the script arguments help message.
+[-n] - Specify the number of top functions to print.
+     - If this flag is not specified, the tool defaults to 25.
+
+Example of usage:
+topN_perf.py -n 20 -- qemu-arm coulomb_double-arm
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
 
 import argparse
 import os
 import subprocess
 import sys
+import tempfile
 
 
 # Parse the command line arguments
-parser = argparse.ArgumentParser(
-    usage='topN_perf.py [-h] [-n] <number of displayed top functions >  -- '
+PARSER = argparse.ArgumentParser(
+    usage='topN_perf.py [-h] [-n <number of displayed top functions>] -- '
           '<qemu executable> [<qemu executable options>] '
           '<target executable> [<target executable options>]')
 
-parser.add_argument('-n', dest='top', type=int, default=25,
+PARSER.add_argument('-n', dest='top', type=int, default=25,
                     help='Specify the number of top functions to print.')
 
-parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
+PARSER.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
 
-args = parser.parse_args()
+ARGS = PARSER.parse_args()
 
 # Extract the needed variables from the args
-command = args.command
-top = args.top
+COMMAND = ARGS.command
+TOP = ARGS.top
 
 # Insure that perf is installed
-check_perf_presence = subprocess.run(["which", "perf"],
-                                     stdout=subprocess.DEVNULL)
-if check_perf_presence.returncode:
+CHECK_PERF_PRESENCE = subprocess.run(["which", "perf"],
+                                     stdout=subprocess.DEVNULL,
+                                     check=False)
+if CHECK_PERF_PRESENCE.returncode:
     sys.exit("Please install perf before running the script!")
 
 # Insure user has previllage to run perf
-check_perf_executability = subprocess.run(["perf", "stat", "ls", "/"],
+CHECK_PERF_EXECUTABILITY = subprocess.run(["perf", "stat", "ls", "/"],
                                           stdout=subprocess.DEVNULL,
-                                          stderr=subprocess.DEVNULL)
-if check_perf_executability.returncode:
-    sys.exit(
-"""
+                                          stderr=subprocess.DEVNULL,
+                                          check=False)
+if CHECK_PERF_EXECUTABILITY.returncode:
+    sys.exit("""
 Error:
 You may not have permission to collect stats.
 
@@ -85,43 +90,42 @@ To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
    kernel.perf_event_paranoid = -1
 
 * Alternatively, you can run this script under sudo privileges.
-"""
-)
-
-# Run perf record
-perf_record = subprocess.run((["perf", "record", "--output=/tmp/perf.data"] +
-                              command),
-                             stdout=subprocess.DEVNULL,
-                             stderr=subprocess.PIPE)
-if perf_record.returncode:
-    os.unlink('/tmp/perf.data')
-    sys.exit(perf_record.stderr.decode("utf-8"))
-
-# Save perf report output to /tmp/perf_report.out
-with open("/tmp/perf_report.out", "w") as output:
-    perf_report = subprocess.run(
-        ["perf", "report", "--input=/tmp/perf.data", "--stdio"],
-        stdout=output,
-        stderr=subprocess.PIPE)
-    if perf_report.returncode:
-        os.unlink('/tmp/perf.data')
-        output.close()
-        os.unlink('/tmp/perf_report.out')
-        sys.exit(perf_report.stderr.decode("utf-8"))
-
-# Read the reported data to functions[]
-functions = []
-with open("/tmp/perf_report.out", "r") as data:
-    # Only read lines that are not comments (comments start with #)
-    # Only read lines that are not empty
-    functions = [line for line in data.readlines() if line and line[0]
-                 != '#' and line[0] != "\n"]
-
-# Limit the number of top functions to "top"
-number_of_top_functions = top if len(functions) > top else len(functions)
-
-# Store the data of the top functions in top_functions[]
-top_functions = functions[:number_of_top_functions]
+""")
+
+# Run perf and save all intermediate files in a temporary directory
+with tempfile.TemporaryDirectory() as tmpdir:
+    RECORD_PATH = os.path.join(tmpdir, "record.data")
+    REPORT_PATH = os.path.join(tmpdir, "report.txt")
+
+    PERF_RECORD = subprocess.run((["perf", "record", "--output="+RECORD_PATH] +
+                                  COMMAND),
+                                 stdout=subprocess.DEVNULL,
+                                 stderr=subprocess.PIPE,
+                                 check=False)
+    if PERF_RECORD.returncode:
+        sys.exit(PERF_RECORD.stderr.decode("utf-8"))
+
+    with open(REPORT_PATH, "w") as output:
+        PERF_REPORT = subprocess.run(
+            ["perf", "report", "--input="+RECORD_PATH, "--stdio"],
+            stdout=output,
+            stderr=subprocess.PIPE,
+            check=False)
+        if PERF_REPORT.returncode:
+            sys.exit(PERF_REPORT.stderr.decode("utf-8"))
+
+    # Save the reported data to FUNCTIONS[]
+    with open(REPORT_PATH, "r") as data:
+        # Only read lines that are not comments (comments start with #)
+        # Only read lines that are not empty
+        FUNCTIONS = [line for line in data.readlines() if line and
+                     line[0] != '#' and line[0] != "\n"]
+
+# Limit the number of top functions to "TOP"
+NO_TOP_FUNCTIONS = TOP if len(FUNCTIONS) > TOP else len(FUNCTIONS)
+
+# Store the data of the top functions in TOP_FUNCTIONS[]
+TOP_FUNCTIONS = FUNCTIONS[:NO_TOP_FUNCTIONS]
 
 # Print table header
 print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
@@ -134,7 +138,7 @@ print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
                                                          '-' * 25))
 
 # Print top N functions
-for (index, function) in enumerate(top_functions, start=1):
+for (index, function) in enumerate(TOP_FUNCTIONS, start=1):
     function_data = function.split()
     function_percentage = function_data[0]
     function_name = function_data[-1]
@@ -143,7 +147,3 @@ for (index, function) in enumerate(top_functions, start=1):
                                              function_percentage,
                                              function_name,
                                              function_invoker))
-
-# Remove intermediate files
-os.unlink('/tmp/perf.data')
-os.unlink('/tmp/perf_report.out')
-- 
2.17.1


