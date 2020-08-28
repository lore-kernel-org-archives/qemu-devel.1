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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E41EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323BA208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm/LCScj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323BA208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbs0-0008Qn-FH
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpJ-0003W3-Do
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpH-0005hF-45
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so834373wrm.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v7lvcz/T9X8UTSmvha1Vg7mQ7t6EJ96o/jbqvgFXbUM=;
 b=Zm/LCScjFpPa/OlSC90gjfzM/dO1Cbbd5MhzgHc9Av9kwuVbpJIujUhey643OVEB1d
 TT/D7HlKFQmnS9Q/4boVcHsch3eljfQZQHjoVG01OgX2Vdp2N5J1I5FawkA49Jm962DL
 MY2UmlBxSy2HvOFv7r8nQrmQZd/lYbDSYj0HpMra0uIMN6rxb5Srtyen7yRJUWmV3CXT
 SFpiLG2qgNMuX6st734EPDycMo0Rm3pYVC/MRiZjHBz7QeE84BnSfz9H+vUoxlO+OZ3y
 Gddeph3LBqzyWTF4LCmBxde3BbQjLQRmp/E0tmh44npvEsgrCxE8UL7qqEc+59O4mga8
 lgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v7lvcz/T9X8UTSmvha1Vg7mQ7t6EJ96o/jbqvgFXbUM=;
 b=Tv8P2f6ILztUAIY7DoyREs1wKjd4qaFtO+ybMAvqN/B/2obnhNhnjMwvF6uzXh/9Ok
 MvyR7/K4LLEkyJT9laJJNGByRPGqNyVhaEKNEizKIjIFCGyk6xJ93ollHM1GvxFD38uN
 hZSZozq9FwHdeABqYhST1vv1FOdTEqUBtlmevdIcxSxsR09ggmyuYTi3le4fbazzW8Om
 gRu7UUGFFEvdYTjHvxm/PwDziGi1zRk9cphZi6/WsGVjxqm00uJ7m4g1YPs6FkvVihxO
 K9nnjueyO6KixGE+XOawdCqFDvTYbYp+Er9/1kpMmcWXLmPic4X4TnYUKF7fnC+2dSEq
 aXLQ==
X-Gm-Message-State: AOAM531UJu/+YYBcpjhRLoVahiLfyT/9gTEV1omwSqS+J7MiGclnEIJG
 wyGiHz+6QWyYwHxPomP+uFk34gN9hKaU+g==
X-Google-Smtp-Source: ABdhPJyyk0V9ys0F1gVgrOARWvF6p8zAVaB4JNP7nTqmgazkjjzo1v0ik5fyIsGCLdQhEQDDkO3rdg==
X-Received: by 2002:a5d:4c90:: with SMTP id z16mr1016638wrs.170.1598611300883; 
 Fri, 28 Aug 2020 03:41:40 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:40 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 5/9] scripts/performance: Add list_helpers.py script
Date: Fri, 28 Aug 2020 12:40:58 +0200
Message-Id: <20200828104102.4490-6-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 scripts/performance/list_helpers.py | 221 ++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100755 scripts/performance/list_helpers.py

diff --git a/scripts/performance/list_helpers.py b/scripts/performance/list_helpers.py
new file mode 100755
index 0000000000..823b1cef66
--- /dev/null
+++ b/scripts/performance/list_helpers.py
@@ -0,0 +1,221 @@
+#!/usr/bin/env python3
+
+"""
+Print the executed helpers of a QEMU invocation.
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
+from typing import List, Union
+
+
+def find_jit_line(callgrind_data: List[str]) -> int:
+    """
+    Search for the line with the JIT call in the callgrind_annotate
+    output when ran using --tre=calling.
+    All the helpers should be listed after that line.
+
+    Parameters:
+    callgrind_data (List[str]): callgrind_annotate output
+
+    Returns:
+    (int): Line number of JIT call
+    """
+    line = -1
+    for (i, callgrind_datum) in enumerate(callgrind_data):
+        split_line = callgrind_datum.split()
+        if len(split_line) > 2 and \
+                split_line[1] == "*" and \
+                split_line[-1] == "[???]":
+            line = i
+            break
+    return line
+
+
+def get_helpers(jit_line: int,
+                callgrind_data: List[str]) -> List[List[Union[str, int]]]:
+    """
+    Get all helpers data given the line number of the JIT call.
+
+    Parameters:
+    jit_line (int): Line number of the JIT call
+    callgrind_data (List[str]): callgrind_annotate output
+
+    Returns:
+    (List[List[Union[str, int]]]):[[number_of_instructions(int),
+                                    helper_name(str),
+                                    number_of_calls(int),
+                                    source_file(str)],
+                                    ...]
+    """
+    helpers: List[List[Union[str, int]]] = []
+    next_helper = jit_line + 1
+    while callgrind_data[next_helper] != "\n":
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
+    """
+    Parse the command line arguments then start execution
+
+    Syntax:
+    list_helpers.py [-h] -- \
+               <qemu executable> [<qemu executable options>] \
+               <target executable> [<target executable options>]
+
+    [-h] - Print the script arguments help message.
+
+    Example of usage:
+    list_helpers.py -- qemu-mips coulomb_double-mips
+    """
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
+        ["which", "valgrind"], stdout=subprocess.DEVNULL, check=False)
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
+                                   stderr=subprocess.PIPE,
+                                   check=False)
+        if callgrind.returncode:
+            sys.exit(callgrind.stderr.decode("utf-8"))
+
+        # Save callgrind_annotate output
+        with open(annotate_out_path, "w") as output:
+            callgrind_annotate = subprocess.run(["callgrind_annotate",
+                                                 data_path,
+                                                 "--threshold=100",
+                                                 "--tree=calling"],
+                                                stdout=output,
+                                                stderr=subprocess.PIPE,
+                                                check=False)
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
+        jit_line = find_jit_line(callgrind_data)
+        if jit_line == -1:
+            sys.exit("Couldn't locate the JIT call ... Exiting")
+
+        # Get helpers
+        helpers = get_helpers(jit_line, callgrind_data)
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


