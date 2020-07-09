Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8A320658
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd9LyL3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8A320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtP1n-0000Za-T3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOzx-0007hW-6W
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:21:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtOzv-0001EI-3h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:21:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id f2so893438wrp.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DbRARhFFgtYTtm8gDZEexYv5UYd7NuiLak/1TdEVmuI=;
 b=gd9LyL3A+ol1XXC5gDVnwDonPeHw+gKntJ8xuHZHokVVJkJ7o2pjHthK9cZnq9HQcL
 OaLsQ0hr64LUARZ5f9nGhR3F9ec7/Gwm26C1qPcxQEj3+bwckf1AN3U9xsbdkaSahomv
 4GoiL/FPYmN1kIzGEJpWXEuyRaw7vXi6OAcWBmBHBPFRQNJAtGX6TFlRgUHuP6raVQmB
 Q9npwNdgnlLlQ0pfUfyZ+GQE1Y0z0FykLwxLlFW21JzLuVaEaNkw1ulaGOS8N9ETxjcI
 fd0CK+f4etiZyOq+hc4PE0amjnNilWX7QXy+8R6Ni3pItDBZQN/yRGaZipqDWoJMgXeu
 IEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DbRARhFFgtYTtm8gDZEexYv5UYd7NuiLak/1TdEVmuI=;
 b=C1Xe9R68J+FJjBLt7yvOpwn662yD+/jJqVzQ+AJKBn5fdP5hAIESjz+oogz/WAK1uB
 MDIpzP+93ZwKc4yM1fu5UcWaumae7tQzOm09y+u6wh9DV0zvlu3VgLZF+OUs4lStPTTO
 hJJm9/eWyXecYF74+IQVEfpI+HoA9uSna4JDr6/EGNYLGd/PjLShUyMLinSVUcVTx3k1
 5xv3WVYB3dcqhRBNTc7P/BvOXv+Ls7s4VUiDhMKeeGUMmc0oYkyxNZ/hOWEhEC1JVxE6
 4buvK68oyKQSlRKk13tDRvZ6bzbvYr9qGnHeYteFLgrosk464gVVi4Sz4qsd2BqWwT0p
 bX2Q==
X-Gm-Message-State: AOAM530+DXXMkGf6ure+RgohxXJj1uuANx/RvbAk17H9RZwcAaKaQGaE
 JTsdTHxpEYaDyAGPxnW+sg9Hc7KC
X-Google-Smtp-Source: ABdhPJziCWaa/2PtJ8+3zg39hIWgvJpQdQNkwUbgxrAkxpkjbgdMa5fKLKxbSHIJPSwYcnekpLTg3A==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr60080011wrq.215.1594272085627; 
 Wed, 08 Jul 2020 22:21:25 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.193.80])
 by smtp.gmail.com with ESMTPSA id j6sm3717551wro.25.2020.07.08.22.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 22:21:25 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v3 1/1] scripts/performance: Add dissect.py script
Date: Thu,  9 Jul 2020 07:20:55 +0200
Message-Id: <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709052055.2650-1-ahmedkhaledkaraman@gmail.com>
References: <20200709052055.2650-1-ahmedkhaledkaraman@gmail.com>
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

Python script that dissects QEMU execution into three main phases:
code generation, JIT execution and helpers execution.

Syntax:
dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
                 <target executable> [<target executable options>]

[-h] - Print the script arguments help message.

Example of usage:
dissect.py -- qemu-arm coulomb_double-arm

Example output:
Total Instructions:        4,702,865,362

Code Generation:             115,819,309	 2.463%
JIT Execution:             1,081,980,528	23.007%
Helpers:                   3,505,065,525	74.530%

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 scripts/performance/dissect.py | 166 +++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 scripts/performance/dissect.py

diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
new file mode 100755
index 0000000000..bf24f50922
--- /dev/null
+++ b/scripts/performance/dissect.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env python3
+
+#  Print the percentage of instructions spent in each phase of QEMU
+#  execution.
+#
+#  Syntax:
+#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
+#                   <target executable> [<target executable options>]
+#
+#  [-h] - Print the script arguments help message.
+#
+#  Example of usage:
+#  dissect.py -- qemu-arm coulomb_double-arm
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
+def get_JIT_line(callgrind_data):
+    """
+    Search for the first instance of the JIT call in
+    the callgrind_annotate output when ran using --tree=caller
+    This is equivalent to the self number of instructions of JIT.
+
+    Parameters:
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (int): Line number
+    """
+    line = -1
+    for i in range(len(callgrind_data)):
+        if callgrind_data[i].strip('\n') and \
+                callgrind_data[i].split()[-1] == "[???]":
+            line = i
+            break
+    if line == -1:
+        sys.exit("Couldn't locate the JIT call ... Exiting.")
+    return line
+
+
+def main():
+    # Parse the command line arguments
+    parser = argparse.ArgumentParser(
+        usage='dissect.py [-h] -- '
+        '<qemu executable> [<qemu executable options>] '
+        '<target executable> [<target executable options>]')
+
+    parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
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
+                ["callgrind_annotate", data_path, "--tree=caller"],
+                stdout=output,
+                stderr=subprocess.PIPE)
+            if callgrind_annotate.returncode:
+                sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+        # Read the callgrind_annotate output to callgrind_data[]
+        callgrind_data = []
+        with open(annotate_out_path, 'r') as data:
+            callgrind_data = data.readlines()
+
+        # Line number with the total number of instructions
+        total_instructions_line_number = 20
+        # Get the total number of instructions
+        total_instructions_line_data = \
+            callgrind_data[total_instructions_line_number]
+        total_instructions = total_instructions_line_data.split()[0]
+        total_instructions = int(total_instructions.replace(',', ''))
+
+        # Line number with the JIT self number of instructions
+        JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
+        # Get the JIT self number of instructions
+        JIT_self_instructions_line_data = \
+            callgrind_data[JIT_self_instructions_line_number]
+        JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
+        JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
+
+        # Line number with the JIT self + inclusive number of instructions
+        # It's the line above the first JIT call when running with --tree=caller
+        JIT_total_instructions_line_number = JIT_self_instructions_line_number-1
+        # Get the JIT self + inclusive number of instructions
+        JIT_total_instructions_line_data = \
+            callgrind_data[JIT_total_instructions_line_number]
+        JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
+        JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
+
+        # Calculate number of instructions in helpers and code generation
+        helpers_instructions = JIT_total_instructions-JIT_self_instructions
+        code_generation_instructions = total_instructions-JIT_total_instructions
+
+        # Print results (Insert commas in large numbers)
+        # Print total number of instructions
+        print('{:<20}{:>20}\n'.
+              format("Total Instructions:",
+                     format(total_instructions, ',')))
+        # Print code generation instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("Code Generation:",
+                     format(code_generation_instructions, ","),
+                     (code_generation_instructions / total_instructions) * 100))
+        # Print JIT instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("JIT Execution:",
+                     format(JIT_self_instructions, ","),
+                     (JIT_self_instructions / total_instructions) * 100))
+        # Print helpers instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("Helpers:",
+                     format(helpers_instructions, ","),
+                     (helpers_instructions/total_instructions)*100))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1


