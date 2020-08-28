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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6192098B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+XmnZCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6192098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbqb-00058c-3h
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpE-0003Re-M4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbpC-0005gg-Fx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r15so828425wrp.13
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EJjPWrg0i8aqjuW0NGnomyE8WzQ7HVuoMsi3T2ewGf0=;
 b=O+XmnZCn19gSQ9LhKKOi5ptnw7DICMn0z17F4uo1VVTkzXwb2ScJWwleT9vSnBgGuj
 wTh3Zc+jwzHhwmOcdb3U7pjhZdoamRmOZ/jSFUzcvbsk8eweunRayngHIL7rjoa+/eVK
 JPVI2q09eKw7LJI4qwfB3JT32NfIjKFoVj9IlbeoO2PpiA3p0v/DxmEgN49zvbDOjZ4/
 U82KeCfn4VYTbhe7HBaxx0E41dnyqI1Z8piJ0fVdLyuDy7IR0BtHs0XyS/LrAaAxyeYL
 ZIFudBPRpRM5aH7hyqB4Fg+pLfQUbmwhKdiQLNvIUOiPYI2hU/rRrIUvZLYejCck3JeX
 3EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EJjPWrg0i8aqjuW0NGnomyE8WzQ7HVuoMsi3T2ewGf0=;
 b=hEyCFR39ji16AXv7G3xOMFY/PE6FDpY4nCkffrNxVPkdR3W1JtI5lgBougtjiWjkU5
 9zrFm02UubIOpHxxjZVSDZxSDneZ/rlyfHuiI1Tdv/ESKBEu5kcfTBk/QBd4ez9+D4eR
 gcjRAO5DTxsNgskFPXcgFRIsO+OPuqAAgm9I3zdSn4QqRxfBQra625WqRQQUbb7i7mB6
 5FN1Y9sp78xF19UVdfTzXZj+T0BaE/cP+m8pCM1QET3Vtb7eQ1FwM4ih4tpt29MwCbmT
 VaKjXajHzsQVTs8Kz6LKwJiB83qj1Akmf7T7E+MLjGBvHFAZeSi0jdQdA25Z0n1Z0Z4V
 J8hg==
X-Gm-Message-State: AOAM533VW2tu8hEUDUoLsrG35SbLapUUjYIKfvp2tXhnkPLyfsUtIh0g
 h/WfOSOk5W/mmec4o5yD5lGPjvsBqXvPBw==
X-Google-Smtp-Source: ABdhPJwYHcBmyWUqISf1+MDWEgjeN49KGbx78XbWEICTBGoADTQXsb4aYsE666vllJTQwD7y/kKXvw==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr904644wrm.113.1598611296846; 
 Fri, 28 Aug 2020 03:41:36 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:36 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 3/9] scripts/performance: Refactor dissect.py
Date: Fri, 28 Aug 2020 12:40:56 +0200
Message-Id: <20200828104102.4490-4-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x42a.google.com
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

- Apply pylint and flake8 formatting rules to the script.
- Move syntax and usage exmaple to main() docstring.
- Update get_jit_line() to only detect the main jit call.
- Use mypy for specifying parameters and return types in functions.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/dissect.py | 123 ++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 55 deletions(-)

diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
index bf24f50922..d4df884b75 100755
--- a/scripts/performance/dissect.py
+++ b/scripts/performance/dissect.py
@@ -1,34 +1,27 @@
 #!/usr/bin/env python3
 
-#  Print the percentage of instructions spent in each phase of QEMU
-#  execution.
-#
-#  Syntax:
-#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
-#                   <target executable> [<target executable options>]
-#
-#  [-h] - Print the script arguments help message.
-#
-#  Example of usage:
-#  dissect.py -- qemu-arm coulomb_double-arm
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
+Print the percentage of instructions spent in each phase of QEMU
+execution.
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
@@ -36,23 +29,26 @@ import subprocess
 import sys
 import tempfile
 
+from typing import List
+
 
-def get_JIT_line(callgrind_data):
+def get_jit_line(callgrind_data: List[str]) -> int:
     """
     Search for the first instance of the JIT call in
     the callgrind_annotate output when ran using --tree=caller
     This is equivalent to the self number of instructions of JIT.
 
     Parameters:
-    callgrind_data (list): callgrind_annotate output
+    callgrind_data (List[str]): callgrind_annotate output
 
     Returns:
     (int): Line number
     """
     line = -1
-    for i in range(len(callgrind_data)):
-        if callgrind_data[i].strip('\n') and \
-                callgrind_data[i].split()[-1] == "[???]":
+    for (i, callgrind_datum) in enumerate(callgrind_data):
+        if callgrind_datum.strip('\n') and \
+                callgrind_datum.split()[-1] == "[???]" and \
+                callgrind_datum.split()[1] == "*":
             line = i
             break
     if line == -1:
@@ -61,6 +57,18 @@ def get_JIT_line(callgrind_data):
 
 
 def main():
+    """
+    Parse the command line arguments then start the execution.
+    Syntax:
+    dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
+                 <target executable> [<target executable options>]
+
+    [-h] - Print the script arguments help message.
+
+    Example of usage:
+    dissect.py -- qemu-arm coulomb_double-arm
+    """
+
     # Parse the command line arguments
     parser = argparse.ArgumentParser(
         usage='dissect.py [-h] -- '
@@ -76,7 +84,7 @@ def main():
 
     # Insure that valgrind is installed
     check_valgrind = subprocess.run(
-        ["which", "valgrind"], stdout=subprocess.DEVNULL)
+        ["which", "valgrind"], stdout=subprocess.DEVNULL, check=False)
     if check_valgrind.returncode:
         sys.exit("Please install valgrind before running the script.")
 
@@ -93,7 +101,8 @@ def main():
                                      "--callgrind-out-file=" + data_path]
                                     + command),
                                    stdout=subprocess.DEVNULL,
-                                   stderr=subprocess.PIPE)
+                                   stderr=subprocess.PIPE,
+                                   check=False)
         if callgrind.returncode:
             sys.exit(callgrind.stderr.decode("utf-8"))
 
@@ -102,7 +111,8 @@ def main():
             callgrind_annotate = subprocess.run(
                 ["callgrind_annotate", data_path, "--tree=caller"],
                 stdout=output,
-                stderr=subprocess.PIPE)
+                stderr=subprocess.PIPE,
+                check=False)
             if callgrind_annotate.returncode:
                 sys.exit(callgrind_annotate.stderr.decode("utf-8"))
 
@@ -120,25 +130,28 @@ def main():
         total_instructions = int(total_instructions.replace(',', ''))
 
         # Line number with the JIT self number of instructions
-        JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
+        jit_self_instructions_line_number = get_jit_line(callgrind_data)
         # Get the JIT self number of instructions
-        JIT_self_instructions_line_data = \
-            callgrind_data[JIT_self_instructions_line_number]
-        JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
-        JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
+        jit_self_instructions_line_data = \
+            callgrind_data[jit_self_instructions_line_number]
+        jit_self_instructions = jit_self_instructions_line_data.split()[0]
+        jit_self_instructions = int(jit_self_instructions.replace(',', ''))
 
         # Line number with the JIT self + inclusive number of instructions
-        # It's the line above the first JIT call when running with --tree=caller
-        JIT_total_instructions_line_number = JIT_self_instructions_line_number-1
+        # It's the line above the first JIT call when running with
+        # --tree=caller
+        jit_total_instructions_line_number = \
+            jit_self_instructions_line_number-1
         # Get the JIT self + inclusive number of instructions
-        JIT_total_instructions_line_data = \
-            callgrind_data[JIT_total_instructions_line_number]
-        JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
-        JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
+        jit_total_instructions_line_data = \
+            callgrind_data[jit_total_instructions_line_number]
+        jit_total_instructions = jit_total_instructions_line_data.split()[0]
+        jit_total_instructions = int(jit_total_instructions.replace(',', ''))
 
         # Calculate number of instructions in helpers and code generation
-        helpers_instructions = JIT_total_instructions-JIT_self_instructions
-        code_generation_instructions = total_instructions-JIT_total_instructions
+        helpers_instructions = jit_total_instructions-jit_self_instructions
+        code_generation_instructions = \
+            total_instructions-jit_total_instructions
 
         # Print results (Insert commas in large numbers)
         # Print total number of instructions
@@ -149,12 +162,12 @@ def main():
         print('{:<20}{:>20}\t{:>6.3f}%'.
               format("Code Generation:",
                      format(code_generation_instructions, ","),
-                     (code_generation_instructions / total_instructions) * 100))
-        # Print JIT instructions and percentage
+                     (code_generation_instructions/total_instructions)*100))
+        # Print jit instructions and percentage
         print('{:<20}{:>20}\t{:>6.3f}%'.
-              format("JIT Execution:",
-                     format(JIT_self_instructions, ","),
-                     (JIT_self_instructions / total_instructions) * 100))
+              format("jit Execution:",
+                     format(jit_self_instructions, ","),
+                     (jit_self_instructions / total_instructions) * 100))
         # Print helpers instructions and percentage
         print('{:<20}{:>20}\t{:>6.3f}%'.
               format("Helpers:",
-- 
2.17.1


