Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3FC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6427921479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6427921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lOZ-0001I7-FC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i7lLm-0008Pr-Tp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i7lLl-0006Bo-VK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i7lLl-0006BB-Pa
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBF8630872C5;
 Tue, 10 Sep 2019 18:58:48 +0000 (UTC)
Received: from thuth.com (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79AA8196AE;
 Tue, 10 Sep 2019 18:58:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 20:58:34 +0200
Message-Id: <20190910185839.19682-3-thuth@redhat.com>
In-Reply-To: <20190910185839.19682-1-thuth@redhat.com>
References: <20190910185839.19682-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 18:58:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/7] tests/ptimer: Remove unnecessary inclusion
 of libqtest.h
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ptimer-test is a unit test, not a qtest, so libqtest.h is not
required here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ptimer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index 5b20e91599..927c9ce48f 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -14,7 +14,6 @@
 #include "qemu/main-loop.h"
 #include "hw/ptimer.h"
 
-#include "libqtest.h"
 #include "ptimer-test.h"
 
 static bool triggered;
-- 
2.18.1


