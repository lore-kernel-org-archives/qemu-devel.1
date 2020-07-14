Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3727C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBA02242C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx3UfNHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBA02242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO3w-0005Hv-Mo
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jvO1D-0000vf-Qy
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jvO1B-0006nN-Og
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:42:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so22943775wrw.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lKksvSCiqLKHcqzqty/UoqhoSvwtg2ek2FI9kzKQiBs=;
 b=mx3UfNHNZQCALD+Q+bHNzksi6GaptMlMStkat7j3Js4FEAhGIRCiEzJbAB0+7BMwPT
 4XiOcoASZEggyV3O7b4aZr6bsVzvzFWbFwHoFh8VY9lrby0CR9rud9YgXifDcYk/uoup
 2BXS/Zmntb0L3LmJYwXWQBJ8+UUeLeXs360c9m5LgDakuzBEgeVUzRRO0btrmJMHXgfn
 Xv4WnLo7g2DsiaAcXbA8P2uJongqU9TNu1oAMy/98bNsAI2V894KcbgU82NZ6x63FJ08
 pznVx9jhEK76tMF67y5aDwju971Z/4Fo7JiLKvKxQV9rHD/i4hs19SgIFht2iiEqqU6b
 f3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lKksvSCiqLKHcqzqty/UoqhoSvwtg2ek2FI9kzKQiBs=;
 b=T8BwMFOJE9RS/hf11lhBhyX6FOinTXg1s+vbu2yEitjAei5sKgIxKi+WaZ3AHGuw5W
 sRmzlRaXHmFVKHVvv3hVp06Gp1nn2ArCy0sUo8nrf7nv1hbCkPI6v5K7wasbBzz6IyNr
 UzO6uMNqAHOHKk8UpdQNhHANXOLKwbrUL57JhYgafaP0LYNSsiuK7t5QhA86Q38MGN74
 dYrbtrGzJJ1vmIU915yoHOZtqPcpV89ldCP+HZMyidwJ36O3SoZLFvQwcxdfWFR6txum
 XEpWjYxJfXaZZuRewpJH8+CAwAz12aGpOEXlSHECJ9W0JVEqY4BGZChTQM3nqdgrOpCc
 14wg==
X-Gm-Message-State: AOAM531G0kUVjKIRf1psx3zAdC9w/SaNlkyDp2yK9DG0BakVQfUf1TNB
 JxO8cenDpHx9FwyGA6uapVQ7JtUe
X-Google-Smtp-Source: ABdhPJyAbplOI2gFGZyNcKGlFFghEeCDLuhgGmNQ5OEN8oltKWT7O2FJ+XZN3z8YzEOdua8/oIIktg==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr6494531wrt.97.1594744975583;
 Tue, 14 Jul 2020 09:42:55 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.245.220])
 by smtp.gmail.com with ESMTPSA id l1sm30779380wrb.12.2020.07.14.09.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:42:55 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 1/2] scripts/performance: Add list_fn_callees.py script
Date: Tue, 14 Jul 2020 18:41:55 +0200
Message-Id: <20200714164156.9353-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714164156.9353-1-ahmedkhaledkaraman@gmail.com>
References: <20200714164156.9353-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x441.google.com
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
 scripts/performance/list_fn_callees.py | 228 +++++++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100755 scripts/performance/list_fn_callees.py

diff --git a/scripts/performance/list_fn_callees.py b/scripts/performance/list_fn_callees.py
new file mode 100755
index 0000000000..f0ec5c8e81
--- /dev/null
+++ b/scripts/performance/list_fn_callees.py
@@ -0,0 +1,228 @@
+#!/usr/bin/env python3
+
+#  Print the callees of a given list of QEMU functions.
+#
+#  Syntax:
+#  list_fn_callees.py [-h] -f FUNCTION [FUNCTION ...] -- \
+#                 <qemu executable> [<qemu executable options>] \
+#                 <target executable> [<target executable options>]
+#
+#  [-h] - Print the script arguments help message.
+#  -f FUNCTION [FUNCTION ...] - List of function names
+#
+#  Example of usage:
+#  list_fn_callees.py -f helper_float_sub_d helper_float_mul_d -- \
+#                        qemu-mips coulomb_double-mips
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
+def find_function_lines(function_name, callgrind_data):
+    """
+    Search for the line with the function name in the
+    callgrind_annotate output when ran using --tre=calling.
+    All the function callees should be listed after that line.
+
+    Parameters:
+    function_name (string): The desired function name to print its callees
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (list): List of function line numbers
+    """
+    lines = []
+    for i in range(len(callgrind_data)):
+        split_line = callgrind_data[i].split()
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
+def get_function_calles(function_lines, callgrind_data):
+    """
+    Get all callees data for a function given its list of line numbers in
+    callgrind_annotate output.
+
+    Parameters:
+    function_lines (list): Line numbers of the function to get its callees
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (list):[[number_of_instructions(int), callee_name(str),
+             number_of_calls(int), source_file(str)]]
+    """
+    callees = []
+    for function_line in function_lines:
+        next_callee = function_line + 1
+        while (callgrind_data[next_callee] != "\n"):
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


