Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66662C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834B4206A4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834B4206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ruijie.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaxmt-00056Y-FS
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1kaxkn-0002Ly-Qz
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:09:53 -0500
Received: from [240e:678:8c0:5::c0a8:3a63] (port=61549
 helo=FZEX4.ruijie.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1kaxkk-00058N-45
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:09:52 -0500
Received: from centos.localdomain (172.20.101.108) by FZEX4.ruijie.com.cn
 (192.168.58.89) with Microsoft SMTP Server id 14.3.123.3; Fri, 6 Nov 2020
 17:03:46 +0800
From: lichun <lichun@ruijie.com.cn>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] console: avoid passing con=NULL to graphic_hw_update_done()
 In graphic_hw_update(), first select an existing console,
 a specific-console or active_console(if not specified),
 then updating the console.
Date: Sat, 7 Nov 2020 01:03:39 +0800
Message-ID: <1604682219-114389-1-git-send-email-lichun@ruijie.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.101.108]
X-Host-Lookup-Failed: Reverse DNS lookup failed for 240e:678:8c0:5::c0a8:3a63
 (failed)
Received-SPF: permerror client-ip=240e:678:8c0:5::c0a8:3a63;
 envelope-from=lichun@ruijie.com.cn; helo=FZEX4.ruijie.com.cn
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_40=-0.001, DATE_IN_FUTURE_06_12=1.947,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, lichun <lichun@ruijie.com.cn>, 706701795@qq.com,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: lichun <lichun@ruijie.com.cn>
---
 ui/console.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index e8e5970..e07d2c3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -270,10 +270,11 @@ void graphic_hw_update_done(QemuConsole *con)
 void graphic_hw_update(QemuConsole *con)
 {
     bool async = false;
+    con = con ? con : active_console;
     if (!con) {
-        con = active_console;
+        return;
     }
-    if (con && con->hw_ops->gfx_update) {
+    if (con->hw_ops->gfx_update) {
         con->hw_ops->gfx_update(con->hw);
         async = con->hw_ops->gfx_update_async;
     }
-- 
1.8.3.1


