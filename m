Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F1320786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRW/rG2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F1320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJ5b-0007lK-QM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4f-00063E-Gf
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4d-00053j-Mj
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so10134161wrc.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y99cTXU0hssEqSMOSYo4duv+RSopidjYwaHbc5SXG4E=;
 b=aRW/rG2d4CBTk06l+CgNS93zMsol4o+g9e+jOCBencBbTjzxbW7UXR0xtU9ceveAag
 FOAKjdlHimltqOoEQ/bJ/6dCISrtIg0TgHsAvdyDNhweRXczaqFQ7NjLQimXVjTIQnmG
 R3/doFoZjw0ojnzATBBO6fRpJt5WPsywoepl512Jw3/RF6gizU4K87Fvxk7jRhzi1/WN
 smKuetya6Y7kBte5krsjbDNKkMBKzfzdkxbaxE6+u9r/Z85eWWnHAytTlHGpsTEtg4mr
 mqHcTd/7P0quUtAkkDDJYINvsqY4p79mi03kNN50Lpg08FrTFbo5PAtpxK/xGRekUa+q
 mrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y99cTXU0hssEqSMOSYo4duv+RSopidjYwaHbc5SXG4E=;
 b=FiCXc4VHfRKS+xMGSSkGmeymjFU2kvcAyeKdiF/OPl5jf64AVIAU43FrycMdUdl+E5
 VvRbNKaH3guEV4IEpb6Zd9qd7mayZvcf4eL6f8y5iryoNj6QQFFh+JKtj/+ILC8OSxrI
 3xzlCWZz+3qSr7eCpjIRRNo28e1dFgxPAyKz48BDThMB3a84sfwvRqtkNjOIoQFNkgnZ
 qLYXum7RJQVz7BbMTJXGSDfTkn714B+Qw5Pp9adljNq0SmFYPrCzti5sYet2yQOyfpuq
 p2rsnyz/CuiGb6Q8V0rZ/rIrekchvzDZwAkCnThflt3Bl3FjcER0buzHmoiriD1LBFeo
 G9Ww==
X-Gm-Message-State: AOAM532SAlCXFSnedrqZ+bKWBNDIYpCT7iJtCWTaBxdjgw2W9totTVjO
 rgz0dzGsgtytEjkR+UFwx28mqLGe
X-Google-Smtp-Source: ABdhPJxT2ZLsMnDjCGJBrI4HvHzEsXSRUSEI+11rF95BC/V1Ap+9432PDkZonds1Gbp9AkrBekWZ2A==
X-Received: by 2002:adf:a111:: with SMTP id o17mr4630462wro.257.1592581017618; 
 Fri, 19 Jun 2020 08:36:57 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.120.95])
 by smtp.gmail.com with ESMTPSA id x186sm7341354wmg.8.2020.06.19.08.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:36:57 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 1/3] scripts/performance: Add topN_perf.py script
Date: Fri, 19 Jun 2020 17:36:30 +0200
Message-Id: <20200619153632.1365-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x441.google.com
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
using perf.

Example Usage:
topN_perf.py -n 20 -- /path/to/qemu program -program -flags

If '-n' is not specified, the default is 25.

Example Output:
 No.  Percentage  Name                       Caller
----  ----------  -------------------------  -------------------------
   1      16.25%  float64_mul                qemu-x86_64
   2      12.01%  float64_sub                qemu-x86_64
   3      11.99%  float64_add                qemu-x86_64
   4       5.69%  helper_mulsd               qemu-x86_64
   5       4.68%  helper_addsd               qemu-x86_64
   6       4.43%  helper_lookup_tb_ptr       qemu-x86_64
   7       4.28%  helper_subsd               qemu-x86_64
   8       2.71%  f64_compare                qemu-x86_64
   9       2.71%  helper_ucomisd             qemu-x86_64
  10       1.04%  helper_pand_xmm            qemu-x86_64
  11       0.71%  float64_div                qemu-x86_64
  12       0.63%  helper_pxor_xmm            qemu-x86_64
  13       0.50%  0x00007f7b7004ef95         [JIT] tid 491
  14       0.50%  0x00007f7b70044e83         [JIT] tid 491
  15       0.36%  helper_por_xmm             qemu-x86_64
  16       0.32%  helper_cc_compute_all      qemu-x86_64
  17       0.30%  0x00007f7b700433f0         [JIT] tid 491
  18       0.30%  float64_compare_quiet      qemu-x86_64
  19       0.27%  soft_f64_addsub            qemu-x86_64
  20       0.26%  round_to_int               qemu-x86_64

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/topN_perf.py | 115 +++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 scripts/performance/topN_perf.py

diff --git a/scripts/performance/topN_perf.py b/scripts/performance/topN_perf.py
new file mode 100755
index 0000000000..53fa503d8a
--- /dev/null
+++ b/scripts/performance/topN_perf.py
@@ -0,0 +1,115 @@
+#!/usr/bin/env python3
+
+#  Print the top N most executed functions in QEMU using perf.
+#  Example Usage:
+#  topN_perf.py -n 20 -- /path/to/qemu program -program -flags
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
+parser = argparse.ArgumentParser(usage='topN_perf.py [-h] [-n TOP_FUNCTIONS] --'
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
+# Insure that perf is installed
+check_perf = subprocess.run(["which", "perf"], stdout=subprocess.DEVNULL)
+if check_perf.returncode:
+    sys.exit("Please install perf before running the script!")
+
+# Insure user has previllage to run perf
+check_previlage = subprocess.run(["perf", "stat", "ls", "/"],
+                              stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
+if check_previlage.returncode:
+    sys.exit(check_previlage.stderr.decode("utf-8") +
+             "\nOr alternatively, you can run the script with sudo privileges!")
+
+# Run perf record
+perf_record = subprocess.run((["perf", "record"] + command),
+                             stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
+if perf_record.returncode:
+    os.unlink('perf.data')
+    sys.exit(perf_record.stderr.decode("utf-8"))
+
+# Save perf report output to tmp.perf.data
+with open("tmp.perf.data", "w") as output:
+    perf_report = subprocess.run(
+        ["perf", "report", "--stdio"], stdout=output, stderr=subprocess.PIPE)
+    if perf_report.returncode:
+        os.unlink('perf.data')
+        output.close()
+        os.unlink('tmp.perf.data')
+        sys.exit(perf_report.stderr.decode("utf-8"))
+
+# Read the reported data to functions[]
+functions = []
+with open("tmp.perf.data", "r") as data:
+    # Only read lines that are not comments (comments start with #)
+    # Only read lines that are not empty
+    functions = [line for line in data.readlines() if line and line[0]
+                 != '#' and line[0] != "\n"]
+
+# Limit the number of top functions to "top"
+number_of_top_functions = top if len(functions) > top else len(functions)
+
+# Store the data of the top functions in top_functions[]
+top_functions = functions[:number_of_top_functions]
+
+# Print information headers
+print('{:>4}  {:>10}  {:<30}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Name',
+                                                         'Caller',
+                                                         '-' * 4,
+                                                         '-' * 10,
+                                                         '-' * 30,
+                                                         '-' * 25))
+
+
+# Print top N functions
+for (index, function) in enumerate(top_functions, start=1):
+    function_data = function.split()
+    function_percentage = function_data[0]
+    function_name = function_data[-1]
+    function_caller = ' '.join(function_data[2:-2])
+    print('{:>4}  {:>10}  {:<30}  {}'.format(index,
+                                             function_percentage,
+                                             function_name,
+                                             function_caller))
+
+# Remove intermediate files
+os.unlink('perf.data')
+os.unlink('tmp.perf.data')
-- 
2.17.1


