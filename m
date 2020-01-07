Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E70C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71950214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/tblJuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71950214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouFM-0006if-8x
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iouDb-0005As-M1
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iouDa-00083O-Og
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iouDa-00082k-L6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKeH0PA6nH2CxhSqObaoGZsGXfna2CbbXugw4LIiFac=;
 b=f/tblJuKzD/QH47iY/cRyqwuA7qKvrFQXhzxEewrexqs+XbeMWkpsjkOpx509l+2zyfTO7
 C45EE/aVJ1ZuXQaPw+PEAfS07MvEBMK8x1dduuYYnFdT9xN0IdqW/ieNh9DI/4pkbOwWZN
 LxnEa8BMpdKeqGhfKr+Vxsi/i3f0cWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-duuWIKkLP4aVImYROIwnPQ-1; Tue, 07 Jan 2020 14:08:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 609B71902B2B;
 Tue,  7 Jan 2020 19:08:37 +0000 (UTC)
Received: from thuth.com (ovpn-116-83.ams2.redhat.com [10.36.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F8B360E1C;
 Tue,  7 Jan 2020 19:08:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/8] tests/ptimer: Remove unnecessary inclusion of libqtest.h
Date: Tue,  7 Jan 2020 20:07:56 +0100
Message-Id: <20200107190802.2257-3-thuth@redhat.com>
In-Reply-To: <20200107190802.2257-1-thuth@redhat.com>
References: <20200107190802.2257-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: duuWIKkLP4aVImYROIwnPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ptimer-test is a unit test, not a qtest, so libqtest.h is not
required here.

Message-Id: <20191218103059.11729-3-thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ptimer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index e16c30ce57..9176b96c1c 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -14,7 +14,6 @@
 #include "qemu/main-loop.h"
 #include "hw/ptimer.h"
=20
-#include "libqtest.h"
 #include "ptimer-test.h"
=20
 static bool triggered;
--=20
2.18.1


