Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40912C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057A9207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcTBWhbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057A9207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKmZ-0004ga-8E
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 19:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlV-0002uA-Fo
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:13:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlT-0006vB-In
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:13:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j10so341533wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ClO0YbMLxFK4IoNk8Xcwu72VrPPnrLf9XqnoMALXakg=;
 b=FcTBWhbiAuTS3aQck2Rv1xN71br3x/y5lDhn4fbGPXEORqgMmS1ap1uN/S5ORNJqcM
 OS4qYTxbb/bbBO+wzMJgZU8B48Q17ilULwaSRsyimXzOO3um+Vs7kk7WrdzTxtkuObwo
 dwhk2GkXuUbH13mfbp5EpUR0pIygR5l272BHCxXbtmO5WYno1lme5V7blaP/yq7c3in3
 COPKmusuWOUN1vz+KxsdfdW9aDoV5+CqlTtvV4+AkERBT6Lz+p8KLKMMeWGQ3a1SrNdi
 m+TpzdF5b//B93hSyqnaOr/JVuDt4/+GSw5EOoQFlA79KcKyNcmmeuWSAkzKs2UHw0D2
 OnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ClO0YbMLxFK4IoNk8Xcwu72VrPPnrLf9XqnoMALXakg=;
 b=kV233tpgXDnWvv0IW36LH2fhEaJJ7vX8gZhV9fqMzDtDoVRWaC/IXJXCfDnMsKwc18
 hhzhaAhf+DgDxB4ciub9MIfVrl6DzuEvUnBs2wXxQv8LK2QlnGiqC5UZt5nIvoWX9UNl
 FVcTqQouDbLofyW5hqwO81OyM6MeVYv6hNStW9S73OTP9kamVOKjV5AKnblB/GNc0QWN
 140+L4biyhujI5jq5MZoCeFs38c/CL7ycdyhTaKKVLk36umiMZTmT6ehDhOZ/WcJubw7
 oEJkSjTFYOETcvF1U4ufufClugzNRVjKymlIvrC0ybyLuvyZqZSfXEWZK5dY9ZElR/eE
 l7Mw==
X-Gm-Message-State: AOAM533hhxFH+q30YLkRZ0K47zoESGCcMqfOBAAu5sxa7JTx0nL4q5ve
 SNaEMoUfjSRgLaqE9N+G+qkNiI1YmzI=
X-Google-Smtp-Source: ABdhPJx9UNcwQD+tNZkvtiw+L/LLheQd0grcNIZ+SaN65caeEM43IjtSAQQcmG75WBtGmeKdvKMuKA==
X-Received: by 2002:a5d:468d:: with SMTP id u13mr5659423wrq.73.1592349189716; 
 Tue, 16 Jun 2020 16:13:09 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.89.86])
 by smtp.gmail.com with ESMTPSA id o9sm2384226wrs.1.2020.06.16.16.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 16:13:09 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, rth@twiddle.net, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 2/3] scripts/performance: Add callgrind_top_25.py script
Date: Wed, 17 Jun 2020 01:12:03 +0200
Message-Id: <20200616231204.8850-3-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x42f.google.com
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
using callgrind.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 scripts/performance/callgrind_top_25.py

diff --git a/scripts/performance/callgrind_top_25.py b/scripts/performance/callgrind_top_25.py
new file mode 100644
index 0000000000..03b089a96d
--- /dev/null
+++ b/scripts/performance/callgrind_top_25.py
@@ -0,0 +1,95 @@
+#!/usr/bin/env python3
+
+#  Print the top 25 most executed functions in QEMU using callgrind.
+#  Example Usage:
+#  callgrind_top_25.py <qemu-build>/x86_64-linux-user/qemu-x86_64 executable
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
+(qemu, executable) = (sys.argv[1], ' '.join(sys.argv[2:]))
+
+# Run callgrind and callgrind_annotate
+os.system('valgrind --tool=callgrind --callgrind-out-file=callgrind.data {} {} \
+            2 > / dev / null & & callgrind_annotate callgrind.data \
+            > tmp.callgrind.data'.
+          format(qemu, executable))
+
+# Line number with the total number of instructions
+number_of_instructions_line = 20
+
+# Line number with the top function
+first_func_line = 25
+
+# callgrind_annotate output
+callgrind_data = []
+
+# Open callgrind_annotate output and store it in callgrind_data
+with open('tmp.callgrind.data', 'r') as data:
+    callgrind_data = data.readlines()
+
+# Get the total number of instructions
+total_number_of_instructions = int(
+    callgrind_data[number_of_instructions_line].split(' ')[0].replace(',', ''))
+
+# Number of functions recorded by callgrind
+number_of_functions = len(callgrind_data) - first_func_line
+
+# Limit the number of top functions to 25
+number_of_top_functions = (25 if number_of_functions >
+                           25 else number_of_instructions_line)
+
+# Store the data of the top functions in top_functions[]
+top_functions = callgrind_data[first_func_line:
+                               first_func_line + number_of_top_functions]
+# Print information headers
+print('{:>4}  {:>10}  {:<25}  {}\n{}  {}  {}  {}'.format('No.',
+                                                         'Percentage',
+                                                         'Name',
+                                                         'Source File',
+                                                         '-' * 4,
+                                                         '-' * 10,
+                                                         '-' * 25,
+                                                         '-' * 30,
+                                                         ))
+
+# Print top 25 functions
+for (index, function) in enumerate(top_functions, start=1):
+    function_data = function.split()
+    # Calculate function percentage
+    percentage = (float(function_data[0].replace(
+        ',', '')) / total_number_of_instructions) * 100
+    # Get function source path and name
+    path, name = function_data[1].split(':')
+    # Print extracted data
+    print('{:>4}  {:>9.3f}%  {:<25}  {}'.format(index,
+                                                round(percentage, 3),
+                                                name,
+                                                path))
+
+# Remove intermediate files
+os.system('rm callgrind.data tmp.callgrind.data')
-- 
2.17.1


