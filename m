Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8214FC35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 11:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545862080D
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 11:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545862080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyD1s-0005wn-D5
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 06:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iyD1C-0005Ua-TR
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iyD1B-00078x-HW
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:02:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2745 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1iyD1B-00076x-5k
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 06:02:21 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6DD382F2B32D55B41980;
 Sun,  2 Feb 2020 19:02:10 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sun, 2 Feb 2020 19:02:03 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] tests/qtest: update comments about
 bios-tables-test-allowed-diff.h
Date: Sun, 2 Feb 2020 19:00:09 +0800
Message-ID: <20200202110009.51479-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update comments in tests/qtest/bios-tables-test.c to reflect the
current path of bios-tables-test-allowed-diff.h, which is now under
tests/qtest/ as well.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>

---

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/bios-tables-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
index 3ab4872bd7..b4752c644c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -14,14 +14,14 @@
  * How to add or update the tests:
  * Contributor:
  * 1. add empty files for new tables, if any, under tests/data/acpi
- * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
+ * 2. list any changed files in tests/qtest/bios-tables-test-allowed-dif=
f.h
  * 3. commit the above *before* making changes that affect the tables
  *
  * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolv=
e conflicts
  * in binary commit created in step 6):
  *
  * After 1-3 above tests will pass but ignore differences with the expec=
ted files.
- * You will also notice that tests/bios-tables-test-allowed-diff.h lists
+ * You will also notice that tests/qtest/bios-tables-test-allowed-diff.h=
 lists
  * a bunch of files. This is your hint that you need to do the below:
  * 4. Run
  *      make check V=3D1
@@ -40,14 +40,14 @@
  *    in commit log.
  * 7. Before sending patches to the list (Contributor)
  *    or before doing a pull request (Maintainer), make sure
- *    tests/bios-tables-test-allowed-diff.h is empty - this will ensure
+ *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will e=
nsure
  *    following changes to ACPI tables will be noticed.
  *
  * The resulting patchset/pull request then looks like this:
- * - patch 1: list changed files in tests/bios-tables-test-allowed-diff.=
h.
+ * - patch 1: list changed files in tests/qtest/bios-tables-test-allowed=
-diff.h.
  * - patches 2 - n: real changes, may contain multiple patches.
  * - patch n + 1: update golden master binaries and empty
- *   tests/bios-tables-test-allowed-diff.h
+ *   tests/qtest/bios-tables-test-allowed-diff.h
  */
=20
 #include "qemu/osdep.h"
--=20
2.19.1


