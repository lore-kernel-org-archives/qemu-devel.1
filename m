Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E1EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACA420760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVIxF69w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACA420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1L0-0008NQ-Bk
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jw1Jt-0007LC-64
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:40:53 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jw1Jp-0003iu-B7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:40:52 -0400
Received: by mail-ed1-x543.google.com with SMTP id a8so4423495edy.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CkBQjPpokRRSOD3d3LoQgCJvGglsJwGJes84iBBLdZI=;
 b=iVIxF69wwyaDb3mTXmEE9mxKCjNe2ATDQQxGGXFWeZXDdZMzGpC6LsH9PneEGcGbv4
 6jqQcqXXuY7PhY9nE5z4TbnXzvZxjucgdfEsE4001IVivKrzhigBDKjwoMUrRG0KIvSH
 a0cO46KvvinfL8395nGmp0PNg4IT/km6SV3F0SoYhP2yFJqMxxVPFiTdxbFGs7PjZQpE
 84OcyKvzldXIvKpwHzunCXFS+WObM6XTl975xE9nfDb0YM+rKWe5lqls6U9tvJQjUgDS
 VkC+d74iKQ++BwDQijUE6MrWJRoV0BRmryJyfMbyAj3ukkUrr1G1gx88gRfVUtnlSrhT
 sYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CkBQjPpokRRSOD3d3LoQgCJvGglsJwGJes84iBBLdZI=;
 b=lfeyooA7LVWfK5b1qpRSKiv0axVV5mSmHCvb+LiCcOXwqQaVQrs+UGR1iEQikV/Q4d
 OJ7/r7NqswzgtdK7jwcRMjNl6SdXCKpmy062kSa1bQ0ikJri6szWOk3X9omtBh9NUqSM
 C5tt09RBQOQCOrnP4ULUcauDvtluCtbTNTaesn5iNfNJhFx3aYwv5qrYFOKdVn9PzFAk
 0cEdxCaqe2OvSJqXoBbsleCdp8R1zqqv2Ag3/OYQM62W1HySuQMoYoBRcK56rg6ii5Px
 jgQefuk6ewM713i9RMef2/sMK5K2DqlFCunu5T+oxSwonclCMlzBwvKplVcyYOj89ZVE
 I9Ng==
X-Gm-Message-State: AOAM531utR/QCtrm9PnRzO+OrO94TLJXs9T71Y+B/g2xyu1CvxuTrbCA
 rLn98CNY/OxZUJkhy56hLuPH8qM7
X-Google-Smtp-Source: ABdhPJw4GKx0xDZ1St+uhszMmzdarSVT4/s4CF7Zf52qSkOK87I5KVcoJwXRwaAMsuR70uKnGc4iwg==
X-Received: by 2002:a50:e801:: with SMTP id e1mr3736751edn.251.1594896047535; 
 Thu, 16 Jul 2020 03:40:47 -0700 (PDT)
Received: from localhost.localdomain ([197.58.201.14])
 by smtp.gmail.com with ESMTPSA id w8sm4707892ejb.10.2020.07.16.03.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 03:40:47 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 2/2] scripts/performance: Add list_helpers.py script
Date: Thu, 16 Jul 2020 12:39:21 +0200
Message-Id: <20200716103921.6605-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716103921.6605-1-ahmedkhaledkaraman@gmail.com>
References: <20200716103921.6605-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Python script that prints executed helpers of a QEMU invocation.

Syntax:
list_helpers.py [-h] -- \
               <qemu executable> [<qemu executable options>] \
               <target executable> [<target executable options>]

[-h] - Print the script arguments help message.

Example of usage:
list_helpers.py -- qemu-mips coulomb_double-mips -n10

Example output:
 Total number of instructions: 108,933,695

 Executed QEMU Helpers:

 No. Ins     Percent  Calls Ins/Call Helper Name             Source File
 --- ------- ------- ------ -------- --------------------    ---------------
   1 183,021  0.168%  1,305      140 helper_float_sub_d      <qemu>/target/mips/fpu_helper.c
   2 177,111  0.163%    770      230 helper_float_madd_d     <qemu>/target/mips/fpu_helper.c
   3 171,537  0.157%  1,014      169 helper_float_mul_d      <qemu>/target/mips/fpu_helper.c
   4 157,298  0.144%  2,443       64 helper_lookup_tb_ptr    <qemu>/accel/tcg/tcg-runtime.c
   5 138,123  0.127%    897      153 helper_float_add_d      <qemu>/target/mips/fpu_helper.c
   6  47,083  0.043%    207      227 helper_float_msub_d     <qemu>/target/mips/fpu_helper.c
   7  24,062  0.022%    487       49 helper_cmp_d_lt         <qemu>/target/mips/fpu_helper.c
   8  22,910  0.021%    150      152 helper_float_div_d      <qemu>/target/mips/fpu_helper.c
   9  15,497  0.014%    321       48 helper_cmp_d_eq         <qemu>/target/mips/fpu_helper.c
  10   9,100  0.008%     52      175 helper_float_trunc_w_d  <qemu>/target/mips/fpu_helper.c
  11   7,059  0.006%     10      705 helper_float_sqrt_d     <qemu>/target/mips/fpu_helper.c
  12   3,000  0.003%     40       75 helper_cmp_d_ule        <qemu>/target/mips/fpu_helper.c
  13   2,720  0.002%     20      136 helper_float_cvtd_w     <qemu>/target/mips/fpu_helper.c
  14   2,477  0.002%     27       91 helper_swl              <qemu>/target/mips/op_helper.c
  15   2,000  0.002%     40       50 helper_cmp_d_le         <qemu>/target/mips/fpu_helper.c
  16   1,800  0.002%     40       45 helper_cmp_d_un         <qemu>/target/mips/fpu_helper.c
  17   1,164  0.001%     12       97 helper_raise_exception_ <qemu>/target/mips/op_helper.c
  18     720  0.001%     10       72 helper_cmp_d_ult        <qemu>/target/mips/fpu_helper.c
  19     560  0.001%    140        4 helper_cfc1             <qemu>/target/mips/fpu_helper.c

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/list_helpers.py | 207 ++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100755 scripts/performance/list_helpers.py

diff --git a/scripts/performance/list_helpers.py b/scripts/performance/list_helpers.py
new file mode 100755
index 0000000000..a97c7ed4fe
--- /dev/null
+++ b/scripts/performance/list_helpers.py
@@ -0,0 +1,207 @@
+#!/usr/bin/env python3
+
+#  Print the executed helpers of a QEMU invocation.
+#
+#  Syntax:
+#  list_helpers.py [-h] -- \
+#                 <qemu executable> [<qemu executable options>] \
+#                 <target executable> [<target executable options>]
+#
+#  [-h] - Print the script arguments help message.
+#
+#  Example of usage:
+#  list_helpers.py -- qemu-mips coulomb_double-mips
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
+import tempfile
+
+
+def find_JIT_line(callgrind_data):
+    """
+    Search for the line with the JIT call in the callgrind_annotate
+    output when ran using --tre=calling.
+    All the helpers should be listed after that line.
+
+    Parameters:
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (int): Line number of JIT call
+    """
+    line = -1
+    for i in range(len(callgrind_data)):
+        split_line = callgrind_data[i].split()
+        if len(split_line) > 2 and \
+                split_line[1] == "*" and \
+                split_line[-1] == "[???]":
+            line = i
+            break
+    return line
+
+
+def get_helpers(JIT_line, callgrind_data):
+    """
+    Get all helpers data given the line number of the JIT call.
+
+    Parameters:
+    JIT_line (int): Line number of the JIT call
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (list):[[number_of_instructions(int), helper_name(str),
+             number_of_calls(int), source_file(str)]]
+    """
+    helpers = []
+    next_helper = JIT_line + 1
+    while (callgrind_data[next_helper] != "\n"):
+        split_line = callgrind_data[next_helper].split()
+        number_of_instructions = int(split_line[0].replace(",", ""))
+        source_file = split_line[2].split(":")[0]
+        callee_name = split_line[2].split(":")[1]
+        number_of_calls = int(split_line[3][1:-2])
+        helpers.append([number_of_instructions, callee_name,
+                        number_of_calls, source_file])
+        next_helper += 1
+    return sorted(helpers, reverse=True)
+
+
+def main():
+    # Parse the command line arguments
+    parser = argparse.ArgumentParser(
+        usage="list_helpers.py [-h] -- "
+        "<qemu executable> [<qemu executable options>] "
+        "<target executable> [<target executable options>]")
+
+    parser.add_argument("command", type=str, nargs="+", help=argparse.SUPPRESS)
+
+    args = parser.parse_args()
+
+    # Extract the needed variables from the args
+    command = args.command
+
+    # Insure that valgrind is installed
+    check_valgrind = subprocess.run(
+        ["which", "valgrind"], stdout=subprocess.DEVNULL)
+    if check_valgrind.returncode:
+        sys.exit("Please install valgrind before running the script.")
+
+    # Save all intermediate files in a temporary directory
+    with tempfile.TemporaryDirectory() as tmpdirname:
+        # callgrind output file path
+        data_path = os.path.join(tmpdirname, "callgrind.data")
+        # callgrind_annotate output file path
+        annotate_out_path = os.path.join(tmpdirname, "callgrind_annotate.out")
+
+        # Run callgrind
+        callgrind = subprocess.run((["valgrind",
+                                     "--tool=callgrind",
+                                     "--callgrind-out-file=" + data_path]
+                                    + command),
+                                   stdout=subprocess.DEVNULL,
+                                   stderr=subprocess.PIPE)
+        if callgrind.returncode:
+            sys.exit(callgrind.stderr.decode("utf-8"))
+
+        # Save callgrind_annotate output
+        with open(annotate_out_path, "w") as output:
+            callgrind_annotate = subprocess.run(
+                ["callgrind_annotate", data_path,
+                    "--threshold=100", "--tree=calling"],
+                stdout=output,
+                stderr=subprocess.PIPE)
+            if callgrind_annotate.returncode:
+                sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+        # Read the callgrind_annotate output to callgrind_data[]
+        callgrind_data = []
+        with open(annotate_out_path, "r") as data:
+            callgrind_data = data.readlines()
+
+        # Line number with the total number of instructions
+        total_instructions_line_number = 20
+        # Get the total number of instructions
+        total_instructions_line_data = \
+            callgrind_data[total_instructions_line_number]
+        total_instructions = total_instructions_line_data.split()[0]
+
+        print("Total number of instructions: {}\n".format(total_instructions))
+
+        # Remove commas and convert to int
+        total_instructions = int(total_instructions.replace(",", ""))
+
+        # Line number with the JIT call
+        JIT_line = find_JIT_line(callgrind_data)
+        if JIT_line == -1:
+            sys.exit("Couldn't locate the JIT call ... Exiting")
+
+        # Get helpers
+        helpers = get_helpers(JIT_line, callgrind_data)
+
+        print("Executed QEMU Helpers:\n")
+
+        # Print table header
+        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
+              format(
+                  "No.",
+                  "Instructions",
+                  "Percentage",
+                  "Calls",
+                  "Ins/Call",
+                  "Helper Name",
+                  "Source File")
+              )
+
+        print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
+              format(
+                  "-" * 4,
+                  "-" * 15,
+                  "-" * 10,
+                  "-" * 15,
+                  "-" * 10,
+                  "-" * 25,
+                  "-" * 30)
+              )
+
+        for (index, callee) in enumerate(helpers, start=1):
+            instructions = callee[0]
+            percentage = (callee[0] / total_instructions) * 100
+            calls = callee[2]
+            instruction_per_call = int(callee[0] / callee[2])
+            helper_name = callee[1]
+            source_file = callee[3]
+            # Print extracted data
+            print("{:>4}  {:>15}  {:>9.3f}%  {:>15}  {:>10}  {:<25}  {}".
+                  format(
+                      index,
+                      format(instructions, ","),
+                      round(percentage, 3),
+                      format(calls, ","),
+                      format(instruction_per_call, ","),
+                      helper_name,
+                      source_file)
+                  )
+
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1


