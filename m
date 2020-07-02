Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3244C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C02920890
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgTSI09E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C02920890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0Eu-0000wS-S8
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr0Dx-00087l-D1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:30:01 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jr0Dv-0003Mn-7D
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:30:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so28723721wrv.9
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v76VNU0Dx2LFfNaSVKZRC0Op64JkZ2VPSoeeOvi7n0M=;
 b=IgTSI09EbJz9Mpe2umwKEHls5eqst9sAZu6ptUUC0ow1+tMRgbeuGN6y+luUBifH0g
 zl5MXgVsJwcvb++DiNQfhBayT0OsF7PuMXDLAou9i8dc0yrBtRWhhxQTroT5KZFu5Xfo
 lmyhOvRsjUKat0MSTGkvb6/HO3HJ6repXEhN1nd5+kDlneZjQVegYYmIUwlfUHL4hIR5
 NUc2HjTNi7Lsp/uJK8PrJOUVkuY34XLuoltLYLh26hY+GManqr4XMzsdYiLmayP+pMHg
 SopaOBYIm7eEqBQuYaDo6iXKInDbZKa8BiMBfajR5AZO/Rz1urfvB4UPi8kG5f75ahoB
 wwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v76VNU0Dx2LFfNaSVKZRC0Op64JkZ2VPSoeeOvi7n0M=;
 b=mQkd03KisyPMMOqZgg/VShmhQfOcfB6kQEEQu8gzRc2P0IHeWF2BKoMWiKxPPDK0iZ
 wMzHNHKqeyG8GLdxuhNZWkz3RkeaeF/Mp2RvVG+8woBl5lnnCdLiAK0CxWZ1j4cWLzlq
 bu58pQ+0vfGKpxcUc+ezIDumGRdHx9CizwRlfv71u6/pNG69eQLefxkkl2d+JcaIAH0V
 MS2d+qXCENK+QIzwX5LbgC2xAmX0vn+BS5QgCdwN8974Ll8SjKIleDk1LXxxdSb4lZ1p
 LQ9oXOAv8ui3gpePmHxEnSz+ssaHcUliUE1slFFS85hLN4TvGhrGsexpPOwcFv+GVdXh
 E/sQ==
X-Gm-Message-State: AOAM531SNWv3tGRwhcF0o/hlvdb27EXCUJJqqSnBfhSkJrv48X30lFg6
 ++MskGlg3zXG19RR/32kmw+9c7QA
X-Google-Smtp-Source: ABdhPJyRBnIqzCJHvDSm0IDGAYViaD/7DDa1P57rx0UHB76B19ioyLECd/Ch+GdVDvMGDoZ0++ESfw==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr31306465wrr.196.1593700196565; 
 Thu, 02 Jul 2020 07:29:56 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.210.158])
 by smtp.gmail.com with ESMTPSA id j14sm10818406wrs.75.2020.07.02.07.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 07:29:56 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, rth@twiddle.net, eblake@redhat.com,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 1/1] scripts/performance: Add dissect.py script
Date: Thu,  2 Jul 2020 16:29:42 +0200
Message-Id: <20200702142942.4887-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
References: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---
 scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100755 scripts/performance/dissect.py

diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
new file mode 100755
index 0000000000..8c2967d082
--- /dev/null
+++ b/scripts/performance/dissect.py
@@ -0,0 +1,165 @@
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
+   """
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
+    # Run callgrind
+    callgrind = subprocess.run((["valgrind",
+                                 "--tool=callgrind",
+                                 "--callgrind-out-file=/tmp/callgrind.data"]
+                                + command),
+                               stdout=subprocess.DEVNULL,
+                               stderr=subprocess.PIPE)
+    if callgrind.returncode:
+        sys.exit(callgrind.stderr.decode("utf-8"))
+
+    # Save callgrind_annotate output to /tmp/callgrind_annotate.out
+    with open("/tmp/callgrind_annotate.out", "w") as output:
+        callgrind_annotate = subprocess.run(
+            ["callgrind_annotate", "/tmp/callgrind.data", "--tree=caller"],
+            stdout=output,
+            stderr=subprocess.PIPE)
+        if callgrind_annotate.returncode:
+            os.unlink('/tmp/callgrind.data')
+            output.close()
+            os.unlink('/tmp/callgrind_annotate.out')
+            sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+    # Read the callgrind_annotate output to callgrind_data[]
+    callgrind_data = []
+    with open('/tmp/callgrind_annotate.out', 'r') as data:
+        callgrind_data = data.readlines()
+
+    # Line number with the total number of instructions
+    total_instructions_line_number = 20
+    # Get the total number of instructions
+    total_instructions_line_data = \
+        callgrind_data[total_instructions_line_number]
+    total_instructions = total_instructions_line_data.split()[0]
+    total_instructions = int(total_instructions.replace(',', ''))
+
+    # Line number with the JIT self number of instructions
+    JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
+    # Get the JIT self number of instructions
+    JIT_self_instructions_line_data = \
+        callgrind_data[JIT_self_instructions_line_number]
+    JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
+    JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
+
+    # Line number with the JIT self + inclusive number of instructions
+    # It's the line above the first JIT call when running with --tree=caller
+    JIT_total_instructions_line_number = JIT_self_instructions_line_number - 1
+    # Get the JIT self + inclusive number of instructions
+    JIT_total_instructions_line_data = \
+        callgrind_data[JIT_total_instructions_line_number]
+    JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
+    JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
+
+    # Calculate number of instructions in helpers and code generation
+    helpers_instructions = JIT_total_instructions - JIT_self_instructions
+    code_generation_instructions = total_instructions - JIT_total_instructions
+
+    # Print results (Insert commas in large numbers)
+    # Print total number of instructions
+    print('{:<20}{:>20}\n'.
+          format("Total Instructions:",
+                 format(total_instructions, ',')))
+    # Print code generation instructions and percentage
+    print('{:<20}{:>20}\t{:>6.3f}%'.
+          format("Code Generation:",
+                 format(code_generation_instructions, ","),
+                 (code_generation_instructions / total_instructions) * 100))
+    # Print JIT instructions and percentage
+    print('{:<20}{:>20}\t{:>6.3f}%'.
+          format("JIT Execution:",
+                 format(JIT_self_instructions, ","),
+                 (JIT_self_instructions / total_instructions) * 100))
+    # Print helpers instructions and percentage
+    print('{:<20}{:>20}\t{:>6.3f}%'.
+          format("Helpers:",
+                 format(helpers_instructions, ","),
+                 (helpers_instructions/total_instructions)*100))
+
+    # Remove intermediate files
+    os.unlink('/tmp/callgrind.data')
+    os.unlink('/tmp/callgrind_annotate.out')
+
+
+if __name__ == "__main__":
+    main()
-- 
2.17.1


