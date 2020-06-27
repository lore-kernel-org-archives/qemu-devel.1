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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C78EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C63F2071A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXzxAkOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C63F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpGse-00041h-Eu
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 15:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrf-0002PQ-MG
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:51 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:47023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrd-0003vH-EQ
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:51 -0400
Received: by mail-ed1-x541.google.com with SMTP id dm19so3218979edb.13
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YU0Awk4ZM0qzu5ZQ6OYVIlPFF2Q2vnGOu2wQJzJ+hiU=;
 b=dXzxAkOHciUqGn6ZPzEilCrQxHg5Ri3ldJJArxKfvr9wTnHBW1L2X0cC1WY50K18X7
 hih+JdyfiJBJcbVLdoTNFF2UEpEofY6fwiVHDAAonCGsCACBK7fT4ZNSJLXPjGPecH/0
 DLkxtAEX/dbC9K8MieUbXd61di95O4PzpulH87E1idpgyAnV1ZOuJW0Gg9ab0vXCVSYh
 /GzAB174tkNj4lcvwKCVFT9sKhrp5PNyXUiwg6pbQ2D/T/oJvO+3uH0XhXhbbeJ2Rpm8
 7J5yN4zuBm2blkx2q7bk/8nX0CMPnnRWNc1+Kkzo9pNh3kruSkUiFfhK+zCtaLHyTNFR
 QBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YU0Awk4ZM0qzu5ZQ6OYVIlPFF2Q2vnGOu2wQJzJ+hiU=;
 b=S2SlwcEUAm42HPv4EbvIZWQ6hATFcRr19T7gwFT7Wm1xoaaZfb/go9wNVij8B91XKZ
 y7dQ3+VUIx+N5MbMmpEHd66RHgLlRbESYZAde2++4qWjw564clfQTBGsnw1qVtcpEKN6
 kocpA/B+47hPQ4m9VCYjYYq7AzvEAmDQ0/T7djgfRJZ/u/b1e+Nc1E3thLLJmqs2m8qX
 S/KgIYWsfgDyaUEzDoqkFkXCDeQBkpla920cb+TroFbHpgpCYY45114dMin4xUq6cB4S
 6ZDNkUyofq925gj/5oyYvxqvOVSYXpBsaQ9GlJbSs2NdWuYgeGAxf22igZSrqa9Ey1FH
 742A==
X-Gm-Message-State: AOAM532M6POcyo+o7/KSvlhpq4xLzwT/ZO7Eo7txCcLg848njUs12Zn8
 4oAYzFJ4SrOccY9FYlsm/B1hyQHl
X-Google-Smtp-Source: ABdhPJzIJwouQ7MvfJ86uUSXb91n1pOhMuVYtLqZ/4DZBaCIm01BSy/+rbq4tKB1jAgb3QozM/FkeA==
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr9462176edv.243.1593287507972; 
 Sat, 27 Jun 2020 12:51:47 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y11sm5298734ejw.63.2020.06.27.12.51.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jun 2020 12:51:47 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 5/6] scripts/performance: Add topN_callgrind.py script
Date: Sat, 27 Jun 2020 21:51:42 +0200
Message-Id: <1593287503-25197-6-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x541.google.com
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

Python script that prints the top N most executed functions in QEMU
using callgrind.

Syntax:
topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
                      <qemu executable> [<qemu executable options>] \
                      <target executable> [<target execurable options>]

[-h] - Print the script arguments help message.
[-n] - Specify the number of top functions to print.
     - If this flag is not specified, the tool defaults to 25.

Example of usage:
topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm

Example Output:
No.  Percentage Function Name         Source File
----  --------- ------------------    ------------------------------
   1    24.577% 0x00000000082db000    ???
   2    20.467% float64_mul           <qemu>/fpu/softfloat.c
   3    14.720% float64_sub           <qemu>/fpu/softfloat.c
   4    13.864% float64_add           <qemu>/fpu/softfloat.c
   5     4.876% helper_mulsd          <qemu>/target/i386/ops_sse.h
   6     3.767% helper_subsd          <qemu>/target/i386/ops_sse.h
   7     3.549% helper_addsd          <qemu>/target/i386/ops_sse.h
   8     2.185% helper_ucomisd        <qemu>/target/i386/ops_sse.h
   9     1.667% helper_lookup_tb_ptr  <qemu>/include/exec/tb-lookup.h
  10     1.662% f64_compare           <qemu>/fpu/softfloat.c
  11     1.509% helper_lookup_tb_ptr  <qemu>/accel/tcg/tcg-runtime.c
  12     0.635% helper_lookup_tb_ptr  <qemu>/include/exec/exec-all.h
  13     0.616% float64_div           <qemu>/fpu/softfloat.c
  14     0.502% helper_pand_xmm       <qemu>/target/i386/ops_sse.h
  15     0.502% float64_mul           <qemu>/include/fpu/softfloat.h
  16     0.476% helper_lookup_tb_ptr  <qemu>/target/i386/cpu.h
  17     0.437% float64_compare_quiet <qemu>/fpu/softfloat.c
  18     0.414% helper_pxor_xmm       <qemu>/target/i386/ops_sse.h
  19     0.353% round_to_int          <qemu>/fpu/softfloat.c
  20     0.347% helper_cc_compute_all <qemu>/target/i386/cc_helper.c

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200626164546.22102-3-ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/topN_callgrind.py | 140 ++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py

diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
new file mode 100755
index 0000000..67c5919
--- /dev/null
+++ b/scripts/performance/topN_callgrind.py
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+
+#  Print the top N most executed functions in QEMU using callgrind.
+#  Syntax:
+#  topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- \
+#           <qemu executable> [<qemu executable options>] \
+#           <target executable> [<target execurable options>]
+#
+#  [-h] - Print the script arguments help message.
+#  [-n] - Specify the number of top functions to print.
+#       - If this flag is not specified, the tool defaults to 25.
+#
+#  Example of usage:
+#  topN_callgrind.py -n 20 -- qemu-arm coulomb_double-arm
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
+    usage='topN_callgrind.py [-h] [-n] <number of displayed top functions>  -- '
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
+# Insure that valgrind is installed
+check_valgrind_presence = subprocess.run(["which", "valgrind"],
+                                         stdout=subprocess.DEVNULL)
+if check_valgrind_presence.returncode:
+    sys.exit("Please install valgrind before running the script!")
+
+# Run callgrind
+callgrind = subprocess.run((
+    ["valgrind", "--tool=callgrind", "--callgrind-out-file=/tmp/callgrind.data"]
+    + command),
+    stdout=subprocess.DEVNULL,
+    stderr=subprocess.PIPE)
+if callgrind.returncode:
+    sys.exit(callgrind.stderr.decode("utf-8"))
+
+# Save callgrind_annotate output to /tmp/callgrind_annotate.out
+with open("/tmp/callgrind_annotate.out", "w") as output:
+    callgrind_annotate = subprocess.run(["callgrind_annotate",
+                                         "/tmp/callgrind.data"],
+                                        stdout=output,
+                                        stderr=subprocess.PIPE)
+    if callgrind_annotate.returncode:
+        os.unlink('/tmp/callgrind.data')
+        output.close()
+        os.unlink('/tmp/callgrind_annotate.out')
+        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+# Read the callgrind_annotate output to callgrind_data[]
+callgrind_data = []
+with open('/tmp/callgrind_annotate.out', 'r') as data:
+    callgrind_data = data.readlines()
+
+# Line number with the total number of instructions
+total_instructions_line_number = 20
+
+# Get the total number of instructions
+total_instructions_line_data = callgrind_data[total_instructions_line_number]
+total_number_of_instructions = total_instructions_line_data.split(' ')[0]
+total_number_of_instructions = int(
+    total_number_of_instructions.replace(',', ''))
+
+# Line number with the top function
+first_func_line = 25
+
+# Number of functions recorded by callgrind, last two lines are always empty
+number_of_functions = len(callgrind_data) - first_func_line - 2
+
+# Limit the number of top functions to "top"
+number_of_top_functions = (top if number_of_functions >
+                           top else number_of_functions)
+
+# Store the data of the top functions in top_functions[]
+top_functions = callgrind_data[first_func_line:
+                               first_func_line + number_of_top_functions]
+
+# Print table header
+print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Function Name',
+                                                         'Source File',
+                                                         '-' * 4,
+                                                         '-' * 10,
+                                                         '-' * 30,
+                                                         '-' * 30,
+                                                         ))
+
+# Print top N functions
+for (index, function) in enumerate(top_functions, start=1):
+    function_data = function.split()
+    # Calculate function percentage
+    function_instructions = float(function_data[0].replace(',', ''))
+    function_percentage = (function_instructions /
+                           total_number_of_instructions)*100
+    # Get function name and source files path
+    function_source_file, function_name = function_data[1].split(':')
+    # Print extracted data
+    print('{:>4}  {:>9.3f}%  {:<30}  {}'.format(index,
+                                                round(function_percentage, 3),
+                                                function_name,
+                                                function_source_file))
+
+# Remove intermediate files
+os.unlink('/tmp/callgrind.data')
+os.unlink('/tmp/callgrind_annotate.out')
-- 
2.7.4


