Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB32420663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB32420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNGvq-0000sH-R1
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 09:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iNGtk-00005d-0g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iNGti-0003HZ-Ti
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:41:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iNGti-0003HF-O8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 09:41:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so13405569wro.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 06:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WerShYvd+MuzMjIKlZy+iIQtN1e64KEyuQ83yIP2H/w=;
 b=oXUAd4BUX0PkbSZCan78+RbUEYk1e6y7fip9aWqYmeX7nmpDFWzXY8K0QBmGwaN8Sc
 A932iGAsQ8a7cme8QAEvr83XRPLhFCIrDTGFHfouAVnj4LTFFSMsYrRGTZQY87r62jKu
 81RIMtPRLFeQsZy1IrW1LM2yge9uqWLd1EWU0+o1IJUiNiNQ5j901bclEgSKSGiCZEvk
 L0UKQSpqXIicYbnx7o8S3eqlp++V/6YLkkrq89MTqgdL5fzVR9T6VGNMXbsydVA3VX0T
 N0QSyntXvwLPxge+hKhZZ65ikZeDz99zTKpvQCkUr/5PJtYj9Wmz8Q5UewOuTIpNNo/A
 iH6g==
X-Gm-Message-State: APjAAAUCpToIVWnsHwUZeYAvLlyoGOgi65AsIcf2iX89YCF1FT4YdcHb
 yprNsvjUThAJTrNFWvvOuOEmMgPW
X-Google-Smtp-Source: APXvYqzFRd4th1IxIPrg+WpcnJu4uJdY8A8kHHl8LKR8m85xFXeWoOSgMuSp+dGwCzTSfgWC5eg7Nw==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr5073638wro.27.1571838117350; 
 Wed, 23 Oct 2019 06:41:57 -0700 (PDT)
Received: from thl530.redhat.com (nat-pool-str-u.redhat.com. [149.14.88.107])
 by smtp.gmail.com with ESMTPSA id
 u10sm12651296wmj.0.2019.10.23.06.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 06:41:56 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui: Print available display backends with '-display help'
Date: Wed, 23 Oct 2019 15:41:51 +0200
Message-Id: <20191023134151.32011-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already print availabled devices with "-device help", or available
backends with "-netdev help" or "-chardev help". Let's provide a way
for the users to query the available display backends, too.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 include/ui/console.h |  1 +
 ui/console.c         | 12 ++++++++++++
 vl.c                 |  5 +++++
 3 files changed, 18 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index f981696848..b7e1a8e6c0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -440,6 +440,7 @@ void qemu_display_register(QemuDisplay *ui);
 bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
+void qemu_display_help(void);
 
 /* vnc.c */
 void vnc_display_init(const char *id, Error **errp);
diff --git a/ui/console.c b/ui/console.c
index 82d1ddac9c..2c92eb2377 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2330,6 +2330,18 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
     dpys[opts->type]->init(ds, opts);
 }
 
+void qemu_display_help(void)
+{
+    int idx;
+
+    printf("Available display backend types:\n");
+    for (idx = 0; idx < DISPLAY_TYPE__MAX; idx++) {
+        if (dpys[idx]) {
+            printf("%s\n",  DisplayType_str(dpys[idx]->type));
+        }
+    }
+}
+
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
diff --git a/vl.c b/vl.c
index 4489cfb2bb..3e215beb43 100644
--- a/vl.c
+++ b/vl.c
@@ -2006,6 +2006,11 @@ static void parse_display(const char *p)
 {
     const char *opts;
 
+    if (is_help_option(p)) {
+        qemu_display_help();
+        exit(0);
+    }
+
     if (strstart(p, "sdl", &opts)) {
         /*
          * sdl DisplayType needs hand-crafted parser instead of
-- 
2.21.0


