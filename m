Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3952BC4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6FA2077B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6FA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsNh-0005Zd-DY
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5q-0005dG-Kj
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5p-0004Y2-E7
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5p-0004XL-55
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:01 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AFB6C057EC6
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:59 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m6so10854367qtk.23
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Amj4PpRLJKQT0ZPCZm5InuKFsg1DBINwnumBQfGWOYY=;
 b=id8pnXKa3a1aBr+hRaLU3q/OpnseJgtYED9+yBoNvbYQO4z3UZEHYpHSpIrZ9X2yL4
 D0fRV5JUjaddcrs+chxOvmVNfYzMUUCupmgrgLkDPbFTC/XQDzRzKaW0ORsNdjv7vtfR
 f36kQHyQqu983rxmj0fv/qnZDAyOm3TWn6yuxefuSJ4qOx2A/0V5wHn4GHRD03Dkjb5w
 n4QVXojDiFJyK/rMCkt0dIYQI4ss70udvCIcph+HeiR7EVGvgujC++ZY9km1oSNLK4pX
 bF++/52Pa6m9eleO0sBl1mvRIjjaTCJkQoe1HC2SjrmH0bJwXSdkOg+XkAWWKzaTlldT
 KPOQ==
X-Gm-Message-State: APjAAAWnF208RtRENmiJzZA0HXLuzvD74sWhuy0t3QajCyLpgW6mv1uX
 OkoEyzI/vCHRECQ/apErckt9s0ExrK64Uo9XVzoo1+AEVsyV23mL25K9qLcRT3mDUBCFa5xNZ+S
 pvR6BLoeEkKa6E0A=
X-Received: by 2002:ad4:4431:: with SMTP id e17mr20474611qvt.76.1570312798101; 
 Sat, 05 Oct 2019 14:59:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznhscbK+t07LgkmxMYHVGNvutoiIrofBzFziOHCOY3vhz5tL2SGvb6q5Yta24LjBlJS6fzPg==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr20474597qvt.76.1570312797841; 
 Sat, 05 Oct 2019 14:59:57 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v13sm4374649qtp.61.2019.10.05.14.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:57 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] tests: document how to update acpi tables
Message-ID: <20191005215508.28754-16-mst@redhat.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like no one understands how to do it.
Document the process.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 652a78773f..0b33fb265f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -10,6 +10,33 @@
  * See the COPYING file in the top-level directory.
  */
 
+/*
+ * How to add or update the tests:
+ * Contributor:
+ * 1. add empty files for new tables, if any, under tests/data/acpi
+ * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
+ * 3. commit the above *before* making changes that affect the tables
+ * Maintainer:
+ * After 1-3 above tests will pass but ignore differences with the expected files.
+ * You will also notice that tests/bios-tables-test-allowed-diff.h lists
+ * a bunch of files. This is your hint that you need to do the below:
+ * 4. Run
+ *      make check V=1
+ * this will produce a bunch of warnings about differences
+ * beween actual and expected ACPI tables. If you have IASL installed,
+ * they will also be disassembled so you can look at the disassembled
+ * output. If not - disassemble them yourself in any way you like.
+ * Look at the differences - make sure they make sense and match what the
+ * changes you are merging are supposed to do.
+ *
+ * 5. From build directory, run:
+ *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
+ * 6. Now commit any changes.
+ * 7. Before doing a pull request, make sure tests/bios-tables-test-allowed-diff.h
+ *    is empty - this will ensure following changes to ACPI tables will
+ *    be noticed.
+ */
+
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
-- 
MST


