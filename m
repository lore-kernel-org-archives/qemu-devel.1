Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA920639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gc37PFcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AA920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9jk-00086a-Gr
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kA9jD-0007he-TM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kA9jB-0001vP-Dc
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598264963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pZ4zoYIFlMzOdASWPX0EpuxffjPyPb6y3vMX7m2LbG0=;
 b=Gc37PFcPqNzAsyVQ+mPY1RQ9m5eEPLxC1DZu09pdK8NJ+yC9dHNzlDDKJ/pm73jdaHiHPi
 PrPtWzVyW8e2DjXUUXipxFjfYxqnQRBK6H5yNySUjjaLcI8hRhJoF8SiD/AxhBHBehBlXH
 SY5OWTDppW+yk3v+VoGXLLpestMOrAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Wm5gAuIDMJGBobzg6YOBdw-1; Mon, 24 Aug 2020 06:29:18 -0400
X-MC-Unique: Wm5gAuIDMJGBobzg6YOBdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 778E81007462;
 Mon, 24 Aug 2020 10:29:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-59.ams2.redhat.com
 [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75A18197E5;
 Mon, 24 Aug 2020 10:29:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	philmd@redhat.com
Subject: [PATCH] qemu-io-cmds: Simplify help_oneline
Date: Mon, 24 Aug 2020 11:29:14 +0100
Message-Id: <20200824102914.105619-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

help_oneline is declared and starts as:

  static void help_oneline(const char *cmd, const cmdinfo_t *ct)
  {
      if (cmd) {
          printf("%s ", cmd);
      } else {
          printf("%s ", ct->name);
          if (ct->altname) {
              printf("(or %s) ", ct->altname);
          }
      }

However, there are only two routes to help_oneline being called:

   help_f -> help_all -> help_oneline(ct->name, ct)

   help_f -> help_onecmd(argv[1], ct)

In the first case, 'cmd' and 'ct->name' are the same thing,
so it's impossible for the if (cmd) to be false and then validly
print ct->name - this is upsetting gcc
( https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96739 )

In the second case, cmd is argv[1] and we know we've got argv[1]
so again (cmd) is non-NULL.

Simplify help_oneline by just printing cmd.
(Also strengthen argc check just to be pedantic)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qemu-io-cmds.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index baeae86d8c..4153f1c0b0 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2383,14 +2383,7 @@ static const cmdinfo_t sleep_cmd = {
 
 static void help_oneline(const char *cmd, const cmdinfo_t *ct)
 {
-    if (cmd) {
-        printf("%s ", cmd);
-    } else {
-        printf("%s ", ct->name);
-        if (ct->altname) {
-            printf("(or %s) ", ct->altname);
-        }
-    }
+    printf("%s ", cmd);
 
     if (ct->args) {
         printf("%s ", ct->args);
@@ -2420,7 +2413,7 @@ static int help_f(BlockBackend *blk, int argc, char **argv)
 {
     const cmdinfo_t *ct;
 
-    if (argc == 1) {
+    if (argc < 2) {
         help_all();
         return 0;
     }
-- 
2.26.2


