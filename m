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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201AC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A68208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee1yLB37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A68208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbqb-00058u-9I
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpH-0003To-FF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpE-0005gz-JQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id b79so461882wmb.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BLJGQzaC58i7Jzawy2mcPTfB5Z7zUVTcLSsOZpQQw9o=;
 b=Ee1yLB37j//pyLubHmHwGE8x2jNKvKKRnrZaLj1/xd5pSgwuowx6nfn0DOwOpSopLR
 lGrY3IzEbRA9n29sUMWiAFi5Nj2kl0YaJ/mhdAW/uodYb0B7NNvBctZw+DZXFQ3yidzC
 EP9i1sM/0hQ2O7xlHkMT6RC679fmLATZv4VoQMCxTWt+zhdBTs6I14b7TXYDDG/KkRCZ
 86si0/dF9yibzmS08RLtZXmlOAvo88BSy/Ly0dVn0/ALObIPfXIAO08mTXce39zOOXZf
 kv9JgEYhlYyp+y5XTcjCCx0XcGHyghgbGVBw4WAQTtaQYY+5HAiIs0lfR5QrPs6MPB7N
 CXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BLJGQzaC58i7Jzawy2mcPTfB5Z7zUVTcLSsOZpQQw9o=;
 b=A7mJaKGoZVAedVWUOv2sMnSRbe+WRYr5r+gHJs3hCyDC0+PItsbn+MH7zYaac3qPgU
 oXzUp0EByUSSp383wDWES+vsiNquyZMwj0qQBErrwFtHis8nKRZYZOg6VplliMw+rey8
 1v8zDcljO6rTiM10nM2HomWd2ry3rSz6hVcMbj5B9LoUQDaYIT9yHbzPJknThkaoSjuN
 CezMwJ3yhn2icmsk54U0xDTLCx2zXMnIff2WNrfSTxSEklbr8D8it5TrXi2O9GdckmS1
 muKWR3W4ToEFsnOhLcpQyVO+E8Yk1MooiftFUKQVwo5U+YgZBt4UOSE7eIKtR55iZ7cV
 yu1Q==
X-Gm-Message-State: AOAM5333ZetjEBn2uL10Mll/K7q/nQzpX04uhpuT9XH4KXcjM0STbCF0
 gsvUkaXDkT+NMIoPkYA2qeJoP0JO5oQqHg==
X-Google-Smtp-Source: ABdhPJxzVzFgK/pQN+NIm9cfQdPnRVmfEJwuo9hH0KmgVb+A2Odn35Uv2iFuBuHTUbF0FlSOjwCBsQ==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr953381wmc.123.1598611298903; 
 Fri, 28 Aug 2020 03:41:38 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:38 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 4/9] scripts/performance: Add list_fn_callees.py script
Date: Fri, 28 Aug 2020 12:40:57 +0200
Message-Id: <20200828104102.4490-5-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x329.google.com
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

Python script that prints the callees of a given list of QEMU
functions.

Syntax:
list_fn_callees.py [-h] -f FUNCTION [FUNCTION ...] -- \
               <qemu executable> [<qemu executable options>] \
               <target executable> [<target executable options>]

[-h] - Print the script arguments help message.
-f FUNCTION [FUNCTION ...] - List of function names

Example of usage:
list_fn_callees.py -f helper_float_sub_d helper_float_mul_d -- \
                      qemu-mips coulomb_double-mips -n10

Example output:
 Total number of instructions: 108,952,851

 Callees of helper_float_sub_d:

 No. Instructions Percentage  Calls Ins/Call Function Name Source File
 --- ------------ ---------- ------ -------- ------------- ---------------
   1      153,160     0.141%  1,305     117  float64_sub   <qemu>/fpu/softfloat.c

 Callees of helper_float_mul_d:

 No. Instructions Percentage  Calls Ins/Call Function Name Source File
 --- ------------ ---------- ------ -------- ------------- ---------------
   1      131,137     0.120%  1,014      129 float64_mul   <qemu>/fpu/softfloat.c

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/list_fn_callees.py | 245 +++++++++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100755 scripts/performance/list_fn_callees.py

diff --git a/scripts/performance/list_fn_callees.py b/scripts/performance/list_fn_callees.py
new file mode 100755
index 0000000000..6aa8f6b6ca
--- /dev/null
+++ b/scripts/performance/list_fn_callees.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+
+"""
+Print the callees of a given list of QEMU functions.
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
+def find_function_lines(function_name: str,
+                        callgrind_data: List[str]) -> List[int]:
+    """
+    Search for the line with the function name in the
+    callgrind_annotate output when ran using --tre=calling.
+    All the function callees should be listed after that line.
+
+    Parameters:
+    function_name (string): The desired function name to print its callees
+    callgrind_data (List[str]): callgrind_annotate output
+
+    Returns:
+    (List[int]): List of function line numbers
+    """
+    lines = []
+    for (i, callgrind_datum) in enumerate(callgrind_data):
+        split_line = callgrind_datum.split()
+        if len(split_line) > 2 and \
+                split_line[1] == "*" and \
+                split_line[2].split(":")[-1] == function_name:
+            # Function might be in the callgrind_annotate output more than
+            # once, so don't break after finding an instance
+            if callgrind_data[i + 1] != "\n":
+                # Only append the line number if the found instance has
+                # callees
+                lines.append(i)
+    return lines
+
+
+def get_function_calles(
+        function_lines: List[int],
+        callgrind_data: List[str]) -> List[List[Union[str, int]]]:
+    """
+    Get all callees data for a function given its list of line numbers in
+    callgrind_annotate output.
+
+    Parameters:
+    function_lines (List[int]): Line numbers of the function to get its callees
+    callgrind_data (List[str]): callgrind_annotate output
+
+    Returns:
+    (List[List[Union[str, int]]]):[[number_of_instructions(int),
+                                    callee_name(str),
+                                    number_of_calls(int),
+                                    source_file(str)],
+                                    ...]
+    """
+    callees: List[List[Union[str, int]]] = []
+    for function_line in function_lines:
+        next_callee = function_line + 1
+        while callgrind_data[next_callee] != "\n":
+            split_line = callgrind_data[next_callee].split()
+            number_of_instructions = int(split_line[0].replace(",", ""))
+            source_file = split_line[2].split(":")[0]
+            callee_name = split_line[2].split(":")[1]
+            number_of_calls = int(split_line[3][1:-2])
+            callees.append([number_of_instructions, callee_name,
+                            number_of_calls, source_file])
+            next_callee += 1
+    return sorted(callees, reverse=True)
+
+
+def main():
+    """
+    Parse the command line arguments then start execution.
+
+    Syntax:
+    list_fn_callees.py [-h] -f FUNCTION [FUNCTION ...] -- \
+               <qemu executable> [<qemu executable options>] \
+               <target executable> [<target executable options>]
+
+    [-h] - Print the script arguments help message.
+    -f FUNCTION [FUNCTION ...] - List of function names
+
+    Example of usage:
+    list_fn_callees.py -f helper_float_sub_d helper_float_mul_d -- \
+                      qemu-mips coulomb_double-mips
+    """
+
+    # Parse the command line arguments
+    parser = argparse.ArgumentParser(
+        usage="list_fn_callees.py [-h] -f FUNCTION [FUNCTION ...] -- "
+        "<qemu executable> [<qemu executable options>] "
+        "<target executable> [<target executable options>]")
+
+    parser.add_argument("-f", dest="function", type=str,
+                        nargs="+", required=True,
+                        help="list of function names to print their callees")
+
+    parser.add_argument("command", type=str, nargs="+", help=argparse.SUPPRESS)
+
+    args = parser.parse_args()
+
+    # Extract the needed variables from the args
+    command = args.command
+    function_names = args.function
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
+        for function_name in function_names:
+            # Line numbers with the desired function
+            function_lines = find_function_lines(function_name, callgrind_data)
+
+            if len(function_lines) == 0:
+                print("Couldn't locate function: {}.\n".format(
+                    function_name))
+                continue
+
+            # Get function callees
+            function_callees = get_function_calles(
+                function_lines, callgrind_data)
+
+            print("Callees of {}:\n".format(function_name))
+
+            # Print table header
+            print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
+                  format(
+                      "No.",
+                      "Instructions",
+                      "Percentage",
+                      "Calls",
+                      "Ins/Call",
+                      "Function Name",
+                      "Source File")
+                  )
+
+            print("{:>4}  {:>15}  {:>10}  {:>15}  {:>10}  {:<25}  {}".
+                  format(
+                      "-" * 4,
+                      "-" * 15,
+                      "-" * 10,
+                      "-" * 15,
+                      "-" * 10,
+                      "-" * 25,
+                      "-" * 30)
+                  )
+
+            for (index, callee) in enumerate(function_callees, start=1):
+                instructions = callee[0]
+                percentage = (callee[0] / total_instructions) * 100
+                calls = callee[2]
+                instruction_per_call = int(callee[0] / callee[2])
+                function_name = callee[1]
+                source_file = callee[3]
+                # Print extracted data
+                print("{:>4}  {:>15}  {:>9.3f}%  {:>15}  {:>10}  {:<25}  {}".
+                      format(
+                          index,
+                          format(instructions, ","),
+                          round(percentage, 3),
+                          format(calls, ","),
+                          format(instruction_per_call, ","),
+                          function_name,
+                          source_file)
+                      )
+
+            print("\n")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1


