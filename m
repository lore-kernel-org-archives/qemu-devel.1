Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8FC3A59C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720802083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720802083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyK40-0001PP-0w
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2B-00087S-HQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK29-0001BP-B4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK29-00019J-5j
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74C0181DF7;
 Thu, 15 Aug 2019 17:59:32 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A63F217CF8;
 Thu, 15 Aug 2019 17:59:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:14 +0200
Message-Id: <20190815175922.3475-2-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 17:59:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/9] qtest: Rename qtest.c:qtest_init()
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

From: "Oleinik, Alexander" <alxndr@bu.edu>

Both the qtest client, libqtest.c, and server, qtest.c, used the same
name for initialization functions which can cause confusion.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
Message-Id: <20190805031240.6024-1-alxndr@bu.edu>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/qtest.h | 2 +-
 qtest.c                | 3 +--
 vl.c                   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index cd114b8d80..5ed09c80b1 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -24,6 +24,6 @@ static inline bool qtest_enabled(void)
 
 bool qtest_driver(void);
 
-void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
 
 #endif
diff --git a/qtest.c b/qtest.c
index 15e27e911f..c9681dbdf3 100644
--- a/qtest.c
+++ b/qtest.c
@@ -748,8 +748,7 @@ static void qtest_event(void *opaque, int event)
         break;
     }
 }
-
-void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
 {
     Chardev *chr;
 
diff --git a/vl.c b/vl.c
index b426b32134..130a389712 100644
--- a/vl.c
+++ b/vl.c
@@ -4197,7 +4197,7 @@ int main(int argc, char **argv, char **envp)
     migration_object_init();
 
     if (qtest_chrdev) {
-        qtest_init(qtest_chrdev, qtest_log, &error_fatal);
+        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
     }
 
     machine_opts = qemu_get_machine_opts();
-- 
2.18.1


