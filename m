Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D00FCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F209222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F209222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUtK-0002CO-34
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLUpZ-0006cg-6T
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLUpY-00072k-56
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iLUpU-00070c-Te; Fri, 18 Oct 2019 12:10:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70F34811AB;
 Fri, 18 Oct 2019 16:10:15 +0000 (UTC)
Received: from thuth.com (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 222B460BF1;
 Fri, 18 Oct 2019 16:10:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH] iotests: Remove 130 from the "auto" group
Date: Fri, 18 Oct 2019 18:10:08 +0200
Message-Id: <20191018161008.17140-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 18 Oct 2019 16:10:15 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter hit a "Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared
'write' lock - Is another process using the image [TEST_DIR/t.IMGFMT]?"
error with 130 already twice. Looks like this test is a little bit
shaky, and currently nobody has a real clue what could be causing this
issue, so for the time being, let's disable it from the "auto" group so
that it does not gate the pull requests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7dac79a783..6aa4b8d098 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -151,7 +151,7 @@
 127 rw backing quick
 128 rw quick
 129 rw quick
-130 rw auto quick
+130 rw quick
 131 rw quick
 132 rw quick
 133 auto quick
-- 
2.18.1


