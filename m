Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BFC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267762064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267762064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKCD-00008j-8B
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2N-0008Qn-FY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2L-0001jV-7G
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2L-0001h8-20
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67BAD83F3C;
 Thu, 15 Aug 2019 17:59:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8854C17ADA;
 Thu, 15 Aug 2019 17:59:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:19 +0200
Message-Id: <20190815175922.3475-7-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 15 Aug 2019 17:59:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/9] tests/libqtest: Remove unused function hmp()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No test is using hmp() anymore, and since this function uses the disliked
global_qtest variable, we should also make sure that nobody adds new code
with this function again. qtest_hmp() should be used instead.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190813093047.27948-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 11 -----------
 tests/libqtest.h | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3c5c3f49d8..3e9245d4c9 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1130,17 +1130,6 @@ void qmp_assert_success(const char *fmt, ...)
     qobject_unref(response);
 }
 
-char *hmp(const char *fmt, ...)
-{
-    va_list ap;
-    char *ret;
-
-    va_start(ap, fmt);
-    ret = qtest_vhmp(global_qtest, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 bool qtest_big_endian(QTestState *s)
 {
     return s->big_endian;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index cadf1d4a03..0009b65791 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -687,16 +687,6 @@ static inline void qmp_eventwait(const char *event)
     return qtest_qmp_eventwait(global_qtest, event);
 }
 
-/**
- * hmp:
- * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
- *
- * Send HMP command to QEMU via QMP's human-monitor-command.
- *
- * Returns: the command's output.  The caller should g_free() it.
- */
-char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-
 /**
  * get_irq:
  * @num: Interrupt to observe.
-- 
2.18.1


