Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C8F22521
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GA8J27ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C8F22521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPxB-0002oX-PA
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yanminhui163@163.com>) id 1iXLBP-0001ni-3b
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yanminhui163@163.com>) id 1iXLBM-0000Gi-PS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:17:49 -0500
Received: from m13-80.163.com ([220.181.13.80]:56631)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <yanminhui163@163.com>) id 1iXLBL-0000Ca-7n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uzUCK
 Mo9EWfKmC0LZGLcAD1ImneJPcij28/GZWN7EIk=; b=GA8J27ue8AaxkNb5/aJaO
 0NqFtsbSWvcn2oSfnZ26bUIP4+QmXQSHTXEMskahN5DSvSWdelrlsMSUDiDdlYUv
 EctAW3G3E1reFY6VFWMtqpjhP0TvGFsHVywRH0ZbNgu4MqF3aQAVs3YewfkvdQJa
 SxGHCl1arFdoG+41TcfeAg=
Received: from yanminhuideMacBook-Air.local (unknown [113.18.255.205])
 by mx38 (Coremail) with SMTP id WMCowAA3hJCwaM9dgur7Hw--.14009S2;
 Sat, 16 Nov 2019 11:10:40 +0800 (CST)
Received: by yanminhuideMacBook-Air.local (Postfix, from userid 501)
 id 0C2C0200AF873B; Sat, 16 Nov 2019 11:10:39 +0800 (CST)
From: yanminhui <yanminhui163@163.com>
To: 565101222@qq.com
Subject: [PATCH] ui/gtk: fix gettext message's charset.
Date: Sat, 16 Nov 2019 11:10:37 +0800
Message-Id: <20191116031037.1207-1-yanminhui163@163.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: mx38; spf=none smtp.mail=yanminhui@yanminhuide
 macbook-air.local;
Resent-From: yanminhui163@163.com
Resent-Date: Wed, 20 Nov 2019 16:02:34 +0800 (CST)
X-CM-TRANSID: UMGowABXytAb89Rd4CaOAQ--.4971W
X-CM-SenderInfo: 51dqzx5qkxxiiwt6il2tof0z/
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Resent-Message-Id: <5DD4F6A4.740104.08046@m13-80.163.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.13.80
X-Mailman-Approved-At: Wed, 20 Nov 2019 08:22:50 -0500
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
Cc: yanminhui <yanminhui163@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: yanminhui <yanminhui163@163.com>
---
 po/zh_CN.po | 2 +-
 ui/gtk.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/po/zh_CN.po b/po/zh_CN.po
index b25e8e3c02..38de6a4f2a 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -66,7 +66,7 @@ msgid "Detach Tab"
 msgstr "分离标签页"
 
 msgid "Show Menubar"
-msgstr ""
+msgstr "显示菜单栏"
 
 msgid "_Machine"
 msgstr "虚拟机(_M)"
diff --git a/ui/gtk.c b/ui/gtk.c
index 2f23922afc..692ccc7bbb 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2215,6 +2215,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     setlocale(LC_MESSAGES, "");
     setlocale(LC_CTYPE, "C.UTF-8");
     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
+    bind_textdomain_codeset("qemu", "UTF-8");
     textdomain("qemu");
 
     window_display = gtk_widget_get_display(s->window);
-- 
2.22.0


