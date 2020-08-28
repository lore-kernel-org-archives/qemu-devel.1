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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45DA208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK/+cklW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45DA208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbrw-0008Gm-5K
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpD-0003Pe-Ia
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpA-0005gS-RI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so830654wrt.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6VnUOaw47q1sBFWEPDkKi8Rl+L6HJXn0J6GhoPyLYWM=;
 b=HK/+cklW0orMXNl4Is5lsX4XkmBhx776gGavdwJf8IBs89t4vZJzXPAaCtxc6yKIvc
 RzQB1Qus6S9Bn6Mzp/bHtBKVuU99Vcl4/E54OUhOshOmMFSRImyfLeEu3yKgjaZNuKZr
 Q/R91V2p8iDPXFPeLzOrwTJzcHoK+Rwdtb5Izj+iATpzclxbu7oMxWbdaKr5AbmjWolH
 WQEPE/DkQ7BvxFwG2cz0hL0+6qnx3otbnGYt7t0mxUeUiEXYIxZeDOGK0qs9WxCdaBSo
 ZNaz31UqFtszJ4YvYS+YHjq3NuI1ipWTa24bHx8MYl6pALyPRYiokQMv3shLjDT4F9bH
 NkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6VnUOaw47q1sBFWEPDkKi8Rl+L6HJXn0J6GhoPyLYWM=;
 b=NriiN+nz4yZkfD74HZulD9tIomLmngDWDA8gazf8+8/WJHHvFU5zcT5gGhzY5GBOQQ
 E+WlbiNH+y2SDEIjCdO7wq/KE26t8X/PZaUepCvMWKRVxyxifYmXvJrfQMn89RuDPkIJ
 sYzFCFV+adVzh8kg4R26iZWSpisLfzwYbeoiBsUvP3DdYwcYKzywaia/4Tu+yLTK7a+/
 11BbMJiuu9+c8iIjVEX4LUBEhEg8bL/fSEfxWtOJtIVqfld2ausPS8moJRsmx93PLtNC
 n7liJJuATdjssXl9WRFwM+zup86OT3AXSAmeKCOe59p1sI5+ACWWMErExjyzkKAKXZRY
 iTdA==
X-Gm-Message-State: AOAM533QXLo3R0Uz/AxpcfakWt4+/QsIVEYutCI00pdz4sFd8rW4P2Rl
 rZ3xit9u9SaskK8XOYJn6gdLKIUiLPu4/A==
X-Google-Smtp-Source: ABdhPJzJsAjybpcBhmfxWDs+uG3yuDlTJWs5Nnd98OPlyvZdKNUSixe42FeYCDweCVGzHmXJt3aKPA==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr864841wre.99.1598611294899;
 Fri, 28 Aug 2020 03:41:34 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:34 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 2/9] scripts/performance: Refactor topN_callgrind.py
Date: Fri, 28 Aug 2020 12:40:55 +0200
Message-Id: <20200828104102.4490-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x443.google.com
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
 scripts/performance/topN_callgrind.py | 169 +++++++++++++-------------
 1 file changed, 87 insertions(+), 82 deletions(-)

diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
index 67c59197af..f8a554f393 100755
--- a/scripts/performance/topN_callgrind.py
+++ b/scripts/performance/topN_callgrind.py
@@ -1,113 +1,122 @@
 #!/usr/bin/env python3
 
-#  Print the top N most executed functions in QEMU using callgrind.
-#  Syntax:
-#  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
-#           <qemu executable> [<qemu executable options>] \
-#           <target executable> [<target execurable options>]
-#
-#  [-h] - Print the script arguments help message.
-#  [-n] - Specify the number of top functions to print.
-#       - If this flag is not specified, the tool defaults to 25.
-#
-#  Example of usage:
-#  topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
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
+Print the top N most executed functions in QEMU using callgrind.
+
+Syntax:
+topN_callgrind.py [-h] [-n <number of displayed top functions>] -- \
+         <qemu executable> [<qemu executable options>] \
+         <target executable> [<target execurable options>]
+
+[-h] - Print the script arguments help message.
+[-n] - Specify the number of top functions to print.
+     - If this flag is not specified, the tool defaults to 25.
+
+Example of usage:
+topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
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
-    usage='topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- '
+PARSER = argparse.ArgumentParser(
+    usage='topN_callgrind.py [-h] [-n] <number of displayed top functions> -- '
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
 
 # Insure that valgrind is installed
-check_valgrind_presence = subprocess.run(["which", "valgrind"],
-                                         stdout=subprocess.DEVNULL)
-if check_valgrind_presence.returncode:
+CHECK_VALGRIND_PRESENCE = subprocess.run(["which", "valgrind"],
+                                         stdout=subprocess.DEVNULL,
+                                         check=False)
+if CHECK_VALGRIND_PRESENCE.returncode:
     sys.exit("Please install valgrind before running the script!")
 
-# Run callgrind
-callgrind = subprocess.run((
-    ["valgrind", "--tool=callgrind", "--callgrind-out-file=/tmp/callgrind.data"]
-    + command),
-    stdout=subprocess.DEVNULL,
-    stderr=subprocess.PIPE)
-if callgrind.returncode:
-    sys.exit(callgrind.stderr.decode("utf-8"))
-
-# Save callgrind_annotate output to /tmp/callgrind_annotate.out
-with open("/tmp/callgrind_annotate.out", "w") as output:
-    callgrind_annotate = subprocess.run(["callgrind_annotate",
-                                         "/tmp/callgrind.data"],
-                                        stdout=output,
-                                        stderr=subprocess.PIPE)
-    if callgrind_annotate.returncode:
-        os.unlink('/tmp/callgrind.data')
-        output.close()
-        os.unlink('/tmp/callgrind_annotate.out')
-        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
-
-# Read the callgrind_annotate output to callgrind_data[]
-callgrind_data = []
-with open('/tmp/callgrind_annotate.out', 'r') as data:
-    callgrind_data = data.readlines()
+# Run callgrind and save all intermediate files in a temporary directory
+with tempfile.TemporaryDirectory() as tmpdir:
+    CALLGRIND_DATA_PATH = os.path.join(tmpdir, "callgrind.data")
+    ANNOTATE_OUT_PATH = os.path.join(tmpdir, "callgrind_annotate.out")
+
+    # Run callgrind
+    CALLGRIND = subprocess.run((["valgrind",
+                                 "--tool=callgrind",
+                                 "--callgrind-out-file="+CALLGRIND_DATA_PATH]
+                                + COMMAND),
+                               stdout=subprocess.DEVNULL,
+                               stderr=subprocess.PIPE,
+                               check=False)
+    if CALLGRIND.returncode:
+        sys.exit(CALLGRIND.stderr.decode("utf-8"))
+
+    with open(ANNOTATE_OUT_PATH, "w") as output:
+        CALLGRIND_ANNOTATE = subprocess.run(["callgrind_annotate",
+                                             CALLGRIND_DATA_PATH],
+                                            stdout=output,
+                                            stderr=subprocess.PIPE,
+                                            check=False)
+        if CALLGRIND_ANNOTATE.returncode:
+            sys.exit(CALLGRIND_ANNOTATE.stderr.decode("utf-8"))
+
+    # Read the callgrind_annotate output to CALLGRIND_DATA[]
+    CALLGRIND_DATA = []
+    with open(ANNOTATE_OUT_PATH, 'r') as data:
+        CALLGRIND_DATA = data.readlines()
 
 # Line number with the total number of instructions
-total_instructions_line_number = 20
+TOTAL_INSTRUCTIONS_LINE_NO = 20
 
 # Get the total number of instructions
-total_instructions_line_data = callgrind_data[total_instructions_line_number]
-total_number_of_instructions = total_instructions_line_data.split(' ')[0]
-total_number_of_instructions = int(
-    total_number_of_instructions.replace(',', ''))
+TOTAL_INSTRUCTIONS_LINE_DATA = CALLGRIND_DATA[TOTAL_INSTRUCTIONS_LINE_NO]
+TOTAL_NUMBER_OF_INSTRUCTIONS = TOTAL_INSTRUCTIONS_LINE_DATA.split(' ')[0]
+TOTAL_NUMBER_OF_INSTRUCTIONS = int(
+    TOTAL_NUMBER_OF_INSTRUCTIONS.replace(',', ''))
 
 # Line number with the top function
-first_func_line = 25
+FIRST_FUNC_LINE = 25
 
 # Number of functions recorded by callgrind, last two lines are always empty
-number_of_functions = len(callgrind_data) - first_func_line - 2
+NUMBER_OF_FUNCTIONS = len(CALLGRIND_DATA) - FIRST_FUNC_LINE - 2
 
 # Limit the number of top functions to "top"
-number_of_top_functions = (top if number_of_functions >
-                           top else number_of_functions)
+NUMBER_OF_TOP_FUNCTIONS = (TOP if NUMBER_OF_FUNCTIONS >
+                           TOP else NUMBER_OF_FUNCTIONS)
 
 # Store the data of the top functions in top_functions[]
-top_functions = callgrind_data[first_func_line:
-                               first_func_line + number_of_top_functions]
+TOP_FUNCTIONS = CALLGRIND_DATA[FIRST_FUNC_LINE:
+                               FIRST_FUNC_LINE + NUMBER_OF_TOP_FUNCTIONS]
 
 # Print table header
 print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
@@ -121,12 +130,12 @@ print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
                                                          ))
 
 # Print top N functions
-for (index, function) in enumerate(top_functions, start=1):
+for (index, function) in enumerate(TOP_FUNCTIONS, start=1):
     function_data = function.split()
     # Calculate function percentage
     function_instructions = float(function_data[0].replace(',', ''))
     function_percentage = (function_instructions /
-                           total_number_of_instructions)*100
+                           TOTAL_NUMBER_OF_INSTRUCTIONS)*100
     # Get function name and source files path
     function_source_file, function_name = function_data[1].split(':')
     # Print extracted data
@@ -134,7 +143,3 @@ for (index, function) in enumerate(top_functions, start=1):
                                                 round(function_percentage, 3),
                                                 function_name,
                                                 function_source_file))
-
-# Remove intermediate files
-os.unlink('/tmp/callgrind.data')
-os.unlink('/tmp/callgrind_annotate.out')
-- 
2.17.1


