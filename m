Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBC0206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCn193/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBC0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorhn-0001VY-Ux
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUh-0003Zo-Gc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:27 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jorUf-0007x8-NN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:46:27 -0400
Received: by mail-ej1-x642.google.com with SMTP id mb16so10019050ejb.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PbfzS0czgvrzfNYUDwbovVaLiZXJYJoWggoXPaTM6Ew=;
 b=pCn193/CdT40jI8dX5Mn65yWUxQKrXiKShFayRxn4TcRXETbAMVWN0bIJnMSa0D3xY
 GFIeQSlhObthaWqDYNGmfAcPjkDUi/L2WWXKSqz5DZbpvvhKq9/E1EynR2f2dSR59quH
 lg10jszU2Oj+5qr1j+7Pa52vgHUKN7OhltCM0XNUOwGarJGqvKVkFbHCW23096oP9GPV
 K4inVN7twM8IwMHDmj8cl38g1MfHCoZ0Pw2Y96wDy3rxg6N6GdXHRL3nGN5YQwKKFP7j
 DjeZWA2hwcNUIHKtPFQ2BSh4N0JNDuTD82ODqejQwLZLOMdflvcFQyHYT1sMCa9UMU1s
 g+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PbfzS0czgvrzfNYUDwbovVaLiZXJYJoWggoXPaTM6Ew=;
 b=rr1C4tNImqr2CkgoojjD4FCyETZjtKKG/euLfPgPXjWvkrcWbIaM16Hmxk9YaKL1RJ
 6CMkmPgg8Ui27S2FesP0kiFADyMZCHKBLhgrBbScWYJXaR33EPD1rizAHOLwH/qJ7eQC
 WhoGDBlRYtXh2wS2odeAj5bk9POj+EFDasLCWHl2y/P64c2H8IgSOXout3hYRLxiLG5f
 XWTkFBcnqIP9/5Ld2plrdvvsDBeRnOLwhHX4rv99mrmLqw58JmvefEk54USyMJxkcUaS
 2chaKrSoPAjBvt5Kise3xjjhMLuA5jabI1lLcyqKOok/JulBKpoS9Yqsym76u5nfsiIb
 MbFw==
X-Gm-Message-State: AOAM531BE2kJABLFCdRV8x9wyKRZaSsQH5Kifp06dH6BogXsqgxsoUoK
 3gjCmG0WlWf5XL8wjAJQLW5PXiTR
X-Google-Smtp-Source: ABdhPJxWHVT5CnZD+/wo7Ka1b0YNWiPtDnSAIW/6lnAe4bf21umD40B4w+AK5PuubzMDKXGvwLesqQ==
X-Received: by 2002:a17:906:c451:: with SMTP id
 ck17mr3497900ejb.80.1593189983947; 
 Fri, 26 Jun 2020 09:46:23 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.224.183])
 by smtp.gmail.com with ESMTPSA id rv16sm10894889ejb.60.2020.06.26.09.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:46:23 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, rth@twiddle.net, eblake@redhat.com,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v4 2/3] scripts/performance: Add topN_callgrind.py script
Date: Fri, 26 Jun 2020 18:45:45 +0200
Message-Id: <20200626164546.22102-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
References: <20200626164546.22102-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 scripts/performance/topN_callgrind.py | 140 ++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py

diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
new file mode 100755
index 0000000000..67c59197af
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
2.17.1


