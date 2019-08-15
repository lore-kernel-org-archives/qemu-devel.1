Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68AC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253D82083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253D82083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyK7o-0004B8-Ni
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2R-00008w-8O
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2P-0001uj-1h
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2N-0001ov-He
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA2F3300BCE9;
 Thu, 15 Aug 2019 17:59:46 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 038D417CDF;
 Thu, 15 Aug 2019 17:59:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:20 +0200
Message-Id: <20190815175922.3475-8-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 17:59:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/9] tests/libqtest: Clean up
 qtest_cb_for_every_machine() wrt global_qtest
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

The generic libqtest library functions should not use functions that
require the global_qtest variable.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190813093047.27948-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3e9245d4c9..d1aead30ed 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1189,9 +1189,10 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     QObject *qobj;
     QString *qstr;
     const char *mname;
+    QTestState *qts;
 
-    qtest_start("-machine none");
-    response = qmp("{ 'execute': 'query-machines' }");
+    qts = qtest_init("-machine none");
+    response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
     g_assert(list);
@@ -1209,7 +1210,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         }
     }
 
-    qtest_end();
+    qtest_quit(qts);
     qobject_unref(response);
 }
 
-- 
2.18.1


