Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F29220786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8kW1+xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F29220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJ7e-0004Kl-AD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4l-0006GG-Cx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4j-00054W-DI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id t194so9497993wmt.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3pe+cy1PMrcgZWmsymw2ifZ/LH88Xw0rfLGCjMAL5zA=;
 b=F8kW1+xA0FKovqqOOFwa1dxzijR9fQrxezJZbLg+m2j50uLWZnvtX92FRbsrLTpaCj
 RPgUw+/V45DaWGMn9GDJbWyybmsTahVhhWEe4bJwi6hAKXyOVzZy8MZWAnEt/keqSk8q
 KRC+ARApuKtUHYLOP5wtsOd2A3U0CI4kMKuhGhqrnNhPchFy6GRZYeEMYVsljyfxy05Z
 baHusll4uXvVGAQnzS7fgTm55D3rE3m1B7Az1cKGye7i+rijY7wxPVjMFgDf4c3A6UsC
 MCpMeBQP4clfLpldFrmFVzlZIZCIlCcb4Yt+IkUgd6WtS6nUTlejwzsGSOm8n+3ezU44
 62+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3pe+cy1PMrcgZWmsymw2ifZ/LH88Xw0rfLGCjMAL5zA=;
 b=RWbhaeJsVzBliQDysWN66AQKp4nPhBjHUgVVu+ByzJJKEub6dDcZ7QUxvWMT04A1y6
 wiayu8YA2RZDq7cXFoipDCjGcs2cIwK54Zo9PtHfnWCkPrnobqNbO/DmfvJX7r7oO0H3
 ljGGeE6SR2tenE0sG9HqWr2xivIIqX6/+9/9DevJh5c+Yd5Nv88SSzwgGQfOiYPI6+TR
 yph3i7Xio73gKfBqroPbwz1lEgs3BpXDnci2LBj7VEXAIo9KRmAzLQYidhYI/u/Tgjkh
 8PS+o/mQGUMNZR2hONmY7kClUYqU/9GyB8yjYZI1VfycaworN4t4EUgI054g6KBnjNhd
 Yz8A==
X-Gm-Message-State: AOAM532hOzMw3LYQB9aRAd7/XyKSH2R2WKjbXZG7KjkQKla47nSFTwil
 6FbQE3thgc5LKESlCFbfip9yAzGD
X-Google-Smtp-Source: ABdhPJxuB5+Vydm8g5UOpN2zeuYgtVj+r/nXBXBsewaVbgOaojsviV4tuAhQQpaiODI2FY4EZv2bWA==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr4299768wmj.186.1592581023645; 
 Fri, 19 Jun 2020 08:37:03 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.120.95])
 by smtp.gmail.com with ESMTPSA id x186sm7341354wmg.8.2020.06.19.08.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:37:03 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 2/3] scripts/performance: Add topN_callgrind.py script
Date: Fri, 19 Jun 2020 17:36:31 +0200
Message-Id: <20200619153632.1365-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x343.google.com
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

Example Usage:
topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags

If '-n' is not specified, the default is 25.

Example Output:
No.  Percentage Name                  Source File
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
 scripts/performance/topN_callgrind.py | 131 ++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100755 scripts/performance/topN_callgrind.py

diff --git a/scripts/performance/topN_callgrind.py b/scripts/performance/topN_callgrind.py
new file mode 100755
index 0000000000..2cfff54c98
--- /dev/null
+++ b/scripts/performance/topN_callgrind.py
@@ -0,0 +1,131 @@
+#!/usr/bin/env python3
+
+#  Print the top N most executed functions in QEMU using callgrind.
+#  Example Usage:
+#  topN_callgrind.py -n 20 -- /path/to/qemu program -program -flags
+#
+#   If '-n' is not specified, the default is 25.
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
+parser = argparse.ArgumentParser(usage=\
+                                'topN_callgrind.py [-h] [-n TOP_FUNCTIONS] --'
+                                ' /path/to/qemu program -[flags PROGRAM_FLAGS]')
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
+check_valgrind = subprocess.run(
+    ["which", "valgrind"], stdout=subprocess.DEVNULL)
+if check_valgrind.returncode:
+    sys.exit("Please install valgrind before running the script!")
+
+# Run callgrind
+callgrind = subprocess.run((["valgrind", "--tool=callgrind",
+                             "--callgrind-out-file=callgrind.data"] + command),
+                           stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
+if callgrind.returncode:
+    sys.exit(callgrind.stderr.decode("utf-8"))
+
+# Save callgrind_annotate output to tmp.callgrind.data
+with open("tmp.callgrind.data", "w") as output:
+    callgrind_annotate = subprocess.run(
+        ["callgrind_annotate", "callgrind.data"],
+        stdout=output,
+        stderr=subprocess.PIPE)
+    if callgrind_annotate.returncode:
+        os.unlink('callgrind.data')
+        output.close()
+        os.unlink('tmp.callgrind.data')
+        sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+
+# Read the callgrind_annotate output to callgrind_data[]
+callgrind_data = []
+with open('tmp.callgrind.data', 'r') as data:
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
+# Print information headers
+print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Name',
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
+    function_source_path, function_name = function_data[1].split(':')
+    # Print extracted data
+    print('{:>4}  {:>9.3f}%  {:<30}  {}'.format(index,
+                                                round(function_percentage, 3),
+                                                function_name,
+                                                function_source_path))
+
+# Remove intermediate files
+os.unlink('callgrind.data')
+os.unlink('tmp.callgrind.data')
-- 
2.17.1


