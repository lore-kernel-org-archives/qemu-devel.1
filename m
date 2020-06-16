Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C73C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E67C207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7/89ryh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E67C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKnZ-00064x-Ny
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 19:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKla-000341-Qd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:13:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlZ-0006wn-1C
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:13:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id b6so329103wrs.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t3VP6WWaLEUXrw5hSPEQzC1W88S05EoRcbRI+Zf7OEE=;
 b=G7/89ryh/FU+6PVotPSJOhs8ymD5/zqFU4jby/um/RijMhiuoZcw0/4j0CZItTCvP3
 c8KILQH6c9jnHEqv32p1qWxWqrT8OnFJGXzHSE4wqwLmGK5j6lELr5rgA/z+RbLEKddB
 m8A6xQ7IzAjHeGjF+TjMPIIL3bwC91w1d/FHSVYOzSmP0UetmwcuSZdCsSwVYr4bC54a
 i5htcySduGVxeWZ1TStXWE25GNT0MUreAh0mTOQ6rTalFjFqHL42KRRopqvQQX33TX72
 IYfa0Ka6mipyyxa4+DCA01tuHOgfqZLpkTRugG42daD5sKZ32ssnUNvgJRlT75UOb9ro
 84uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t3VP6WWaLEUXrw5hSPEQzC1W88S05EoRcbRI+Zf7OEE=;
 b=dODol49pr31OeUeKt2ej88DFSANoHF+mfBHTXwG90Ec7WVtTaYzXRGSpZU2hRRvaLe
 2cWNl+IAFrJYmsmsHCYQ4UpkJqM0SCAkg5A9NXGKeTz5qqXgoaFN2uk2xeEMyj5AqHQu
 XykfZhDQcreefpHQ0xHTNvSACTcsmg3Nkk/ianpzMnM2fh9MZiLX22inacWCxZPVUGHP
 fw/Boh13sKQLrBs+AjiJwR627Fz2aSMhHojy25QfbYWUNQhsIO0ca8igOf9zfALOZ0u5
 cA+12q5wbw382o22gVuX9HjeRJYTWjZ9FZeVswGSaFRJ4tcFQXuDpeLh8ML5dSadgZDC
 C8Bg==
X-Gm-Message-State: AOAM531XSLt3zIMagT/sUsWKle4c1FvEimu3F1dGBa+Ff/pyTt6ItbWw
 vtNNlPpTjJrXOHpITJHkV5S1GPYhNcQ=
X-Google-Smtp-Source: ABdhPJxC3RU2gkoYY68FJZnGIBh8uw/Zo+OEXUUD3FlTTmOCpVklYCF4YC1gdTBHQ/WKUsIqtfnSBw==
X-Received: by 2002:a05:6000:1185:: with SMTP id
 g5mr5715494wrx.39.1592349195486; 
 Tue, 16 Jun 2020 16:13:15 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.89.86])
 by smtp.gmail.com with ESMTPSA id o9sm2384226wrs.1.2020.06.16.16.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 16:13:15 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, rth@twiddle.net, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
Date: Wed, 17 Jun 2020 01:12:04 +0200
Message-Id: <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x434.google.com
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

Python script that prints the top 25 most executed functions in QEMU
using perf.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/perf_top_25.py | 82 ++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 scripts/performance/perf_top_25.py

diff --git a/scripts/performance/perf_top_25.py b/scripts/performance/perf_top_25.py
new file mode 100644
index 0000000000..eaa8cce3c3
--- /dev/null
+++ b/scripts/performance/perf_top_25.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python3
+
+#  Print the top 25 most executed functions in QEMU using perf.
+#  Example Usage:
+#  perf_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64 executable
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
+import os
+import sys
+
+# Ensure sufficient arguments
+if len(sys.argv) < 3:
+    print('Insufficient Script Arguments!')
+    sys.exit(1)
+
+# Get the qemu path and the executable + its arguments
+(qemu_path, executable) = (sys.argv[1], ' '.join(sys.argv[2:]))
+
+# Run perf repcord and report
+os.system('sudo perf record {} {} 2> /dev/null \
+            && sudo perf report --stdio > tmp.perf.data'
+          .format(qemu_path, executable))
+
+# Line number with the top function
+first_func_line = 11
+
+# Perf report output
+perf_data = []
+
+# Open perf report output and store it in perf_data
+with open('tmp.perf.data', 'r') as data:
+    perf_data = data.readlines()
+
+# Number of functions recorded by perf
+number_of_functions = len(perf_data) - first_func_line
+
+# Limit the number of top functions to 25
+number_of_top_functions = (25 if number_of_functions >
+                           25 else number_of_functions)
+
+# Store the data of the top functions in top_functions[]
+top_functions = perf_data[first_func_line:first_func_line
+                          + number_of_top_functions]
+
+# Print information headers
+print('{:>4}  {:>10}  {:<25}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Name',
+                                                         'Caller',
+                                                         '-' * 4,
+                                                         '-' * 10,
+                                                         '-' * 25,
+                                                         '-' * 25,
+                                                         ))
+
+# Print top 25 functions
+for (index, function) in enumerate(top_functions, start=1):
+    function_data = function.split()
+    print('{:>4}  {:>10}  {:<25}  {}'.format(index,
+                                             function_data[0],
+                                             function_data[-1],
+                                             ' '.join(function_data[2:-2])))
+
+# Remove intermediate files
+os.system('sudo rm perf.data tmp.perf.data')
-- 
2.17.1


