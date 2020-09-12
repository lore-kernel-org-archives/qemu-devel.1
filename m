Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E5C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEC920796
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 07:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wjhywkw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEC920796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0IR-0006vp-Jp
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH0Ht-0006VE-Nb
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH0Hs-0005WS-40
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599896970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=NkJiG16OzLTaD6cPmwsXlW26VUs9Ffokt3j38KhG0nc=;
 b=Wjhywkw6rNwx9iCZZZLNqaddtIjyGAbtr+PAuSIxEi6jRswTuOs+C2zOtDObuIhwwADP2m
 FNePEK/9kIK4aO92HTfEhT7z1yWE++UjaNNJX64eaOwKoyLnqYT11g6hn2EZunKlhCeMHR
 jy+CZqXTGzBcnEU0SHTMaXpkDxyYe/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-f4DnhwEnPri13FLEw8TEhg-1; Sat, 12 Sep 2020 03:49:29 -0400
X-MC-Unique: f4DnhwEnPri13FLEw8TEhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302971005E66
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 07:49:28 +0000 (UTC)
Received: from thuth.com (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B53B07B7A8;
 Sat, 12 Sep 2020 07:49:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/qmp-cmd-test: Use inclusive language
Date: Sat, 12 Sep 2020 09:49:22 +0200
Message-Id: <20200912074922.26103-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:04:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We simply want to ignore certain queries here, so let's rather
use the term 'ignore' to express this intention.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/qmp-cmd-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 3109a9fe96..18069a82fa 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -82,9 +82,9 @@ static void test_query(const void *data)
     qtest_quit(qts);
 }
 
-static bool query_is_blacklisted(const char *cmd)
+static bool ignore_query(const char *cmd)
 {
-    const char *blacklist[] = {
+    const char *ignorelist[] = {
         /* Not actually queries: */
         "add-fd",
         /* Success depends on target arch: */
@@ -101,8 +101,8 @@ static bool query_is_blacklisted(const char *cmd)
     };
     int i;
 
-    for (i = 0; blacklist[i]; i++) {
-        if (!strcmp(cmd, blacklist[i])) {
+    for (i = 0; ignorelist[i]; i++) {
+        if (!strcmp(cmd, ignorelist[i])) {
             return true;
         }
     }
@@ -179,7 +179,7 @@ static void add_query_tests(QmpSchema *schema)
             continue;
         }
 
-        if (query_is_blacklisted(si->name)) {
+        if (ignore_query(si->name)) {
             continue;
         }
 
-- 
2.18.2


