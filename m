Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A097C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9413208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMCr0lg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9413208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbq6-0004q0-SI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbp9-0003KZ-56
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbp7-0005f2-8P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:41:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id w2so493412wmi.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cy/WqkrNRUK4XmSuZBJquGLXj6V7XsLXcPLIrlLQ8yc=;
 b=kMCr0lg5r/nYDxirPld430hQQvgX6S5gc6ZlZyCw8N+1TM3DwiJRua3BgiJy/jsd4E
 N9nqhWSx698K+79Se4c+zDsD+dwnF4bvJiW0/whm+uyYMmdfiblDtG/ymmwkAcZA7E8i
 SLJJHnpzhHCMJDN12KaY5zlcwd2Ej9FlPBW5R9g15iHk4Rl7+RGk+xt+/a/GDux0ReGH
 vc67Z/QXGa6EgRaSIqJrA7aTUEGEAdSw2PYr+1TvL7DCNOwPr7NAESebRvgQtzKjbXBw
 lkaNSIKQLqh4CVZQOV4xe0/dsJSxUEDkSSg361VbJmuXTD+Gy30yX4iQo2ytxO2jGT9A
 OY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cy/WqkrNRUK4XmSuZBJquGLXj6V7XsLXcPLIrlLQ8yc=;
 b=Ytuv8ieSC4DXt8cdIwyGrv+jvf+GhBOQHOQV5sC5nzKzn6ZCvJrNYq6ySxk1CiZx4T
 Pnq70OauxExDW4gLjKfIeYDehoAhui/yFMwoZk50k/Tq6OT7Yj3wVLvOQQksJDOHCJ+s
 NVzUjYZIfcAX4je0EhEtDNFT+RBTRLKHT5dDiuEz8nvtxc24Dnp6FqaOx1OBhlmTuCPr
 ncV+cgQ6STSxW/HYhyqsK2iqL5PziP7jq9wUtohcbgmDHjByxv8HLl1/Z+wDqkgbQqDs
 ZE2CLc0ue0qqDFjYY99NeTmkQ8x6Fsmq5JZk18LzuJrNEfx0hg1CNNXslvZ2FL/h2wo8
 WI8g==
X-Gm-Message-State: AOAM530n5WYR0c5JFG5N61INFu+zr3E6kUi8mmpmVSMjb6mLNVq/cp0v
 ljsuaGRkibqK+rYMVLbIztIFr7o5BdrgoA==
X-Google-Smtp-Source: ABdhPJyznJ9U452etSUi56ESwBzuBN8XPyqLoqjKhC0ML4/UXMzboYNGVKKg3r5ERJYQOQbCT3tsYw==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr972497wmn.27.1598611290769; 
 Fri, 28 Aug 2020 03:41:30 -0700 (PDT)
Received: from localhost.localdomain ([197.58.77.158])
 by smtp.gmail.com with ESMTPSA id e18sm1307453wrx.50.2020.08.28.03.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:41:30 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, philmd@redhat.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 0/9] GSoC 2020 - TCG Continuous Benchmarking scripts and tools
Date: Fri, 28 Aug 2020 12:40:53 +0200
Message-Id: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x344.google.com
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

Greetings,

This series includes all of the scripts, tools, and benchmarks
developed in the TCG Continuous Benchmarking GSoC project for 2020.

The series includes one patch for updating the MAINTAINERS file and
eight patches each with a separate script or tool.

All scripts and tools were thoroughly introduced, explained, and
utilized in the project weekly reports which were posted here on the
list each Monday at 12:30PM for the last three months.

Reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg714853.html
Introduced tools:
topN_perf.py and topN_callgrind.py

Report 2 - Dissecting QEMU Into Three Main Parts:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg717592.html
Introduced tools:
dissect.py

Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720321.html

Report 4 - Listing QEMU Helpers and Function Callees:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg722559.html
Introduced tools:
list_fn_callees.py and list_helpers.py

Report 5 - Finding Commits Affecting QEMU Performance:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg724080.html
Introduced tools:
bisect.py

Report 6 - Performance Comparison of Two QEMU Builds:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg725700.html

Report 7 - Measuring QEMU Emulation Efficiency:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg727147.html

Report 8 - QEMU Nightly Performance Tests:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg730444.html
Introduced tools:
nightly-tests/

Report 9 - Measuring QEMU Performance in System Mode:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg732729.html
Introduced tools:
topN_system.py

Report 10 - Measuring QEMU Performance in System Mode - Part Two:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734485.html


Best regards,
Ahmed Karaman

Ahmed Karaman (9):
  scripts/performance: Refactor topN_perf.py
  scripts/performance: Refactor topN_callgrind.py
  scripts/performance: Refactor dissect.py
  scripts/performance: Add list_fn_callees.py script
  scripts/performance: Add list_helpers.py script
  scripts/performance: Add bisect.py script
  tests/performance: Add nightly tests
  MAINTAINERS: Add 'tests/performance' to 'Performance Tools and Tests'
    subsection
  scripts/performance: Add topN_system.py script

 MAINTAINERS                                   |  32 +-
 scripts/performance/bisect.py                 | 425 ++++++++
 scripts/performance/dissect.py                | 123 +--
 scripts/performance/list_fn_callees.py        | 245 +++++
 scripts/performance/list_helpers.py           | 221 +++++
 scripts/performance/topN_callgrind.py         | 169 ++--
 scripts/performance/topN_perf.py              | 174 ++--
 scripts/performance/topN_system.py            | 158 +++
 tests/performance/nightly-tests/README.md     | 243 +++++
 .../source/dijkstra_double/dijkstra_double.c  | 194 ++++
 .../source/dijkstra_int32/dijkstra_int32.c    | 192 ++++
 .../source/matmult_double/matmult_double.c    | 123 +++
 .../source/matmult_int32/matmult_int32.c      | 121 +++
 .../source/qsort_double/qsort_double.c        | 104 ++
 .../source/qsort_int32/qsort_int32.c          | 103 ++
 .../source/qsort_string/qsort_string.c        | 122 +++
 .../source/search_string/search_string.c      | 110 +++
 .../scripts/nightly_tests_core.py             | 920 ++++++++++++++++++
 .../scripts/run_nightly_tests.py              | 135 +++
 .../nightly-tests/scripts/send_email.py       |  56 ++
 20 files changed, 3744 insertions(+), 226 deletions(-)
 create mode 100755 scripts/performance/bisect.py
 create mode 100755 scripts/performance/list_fn_callees.py
 create mode 100755 scripts/performance/list_helpers.py
 create mode 100755 scripts/performance/topN_system.py
 create mode 100644 tests/performance/nightly-tests/README.md
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/dijkstra_double/dijkstra_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/dijkstra_int32/dijkstra_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/matmult_double/matmult_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/matmult_int32/matmult_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_double/qsort_double.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_int32/qsort_int32.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/qsort_string/qsort_string.c
 create mode 100644 tests/performance/nightly-tests/benchmarks/source/search_string/search_string.c
 create mode 100755 tests/performance/nightly-tests/scripts/nightly_tests_core.py
 create mode 100755 tests/performance/nightly-tests/scripts/run_nightly_tests.py
 create mode 100644 tests/performance/nightly-tests/scripts/send_email.py

-- 
2.17.1


