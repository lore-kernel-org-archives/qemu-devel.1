Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5870206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctvexfqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5870206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwv30-0004yq-5H
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jpewhacker@gmail.com>) id 1iwsqo-0000k5-9c
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 14:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jpewhacker@gmail.com>) id 1iwsqn-0008Sw-D2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 14:18:10 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jpewhacker@gmail.com>)
 id 1iwsqn-0008Rf-9U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 14:18:09 -0500
Received: by mail-io1-xd42.google.com with SMTP id d15so1042878iog.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JssBp+Af03CgiiTxeYvhyMv5hXNuQpZd/7qsT00yHQk=;
 b=ctvexfqjoGQ5T5Sn1vLgbpYvSzDPoj0uoS0TVohl3YJz2a5tiDMM2aGASlTNA4rsx2
 mpuudbsaV3AZLL6Vh7gIfijPEHoqBPgPhuesItEkbDDzOTIKd4fvn3Yqgma/MyRog04b
 f8kjNuD9QFnqMNCYEjSTQ7c+MMeFQ2TSwjFNPYL/wyAlJUXyim/H3XyhDo+kwxKCKuK+
 lkszu7Y7eYQt2l0h8qj5xS3BkelgIH1uCUFCZ4kD7Kyi/evF9lu5NIl0obgY1dZlIqA0
 RCJHQo4AmV8vG54JUEV37uDn4xUk18n91xqRk6gim7rZz73J/xzy2BwKCGJV2Lb7nnRq
 dw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JssBp+Af03CgiiTxeYvhyMv5hXNuQpZd/7qsT00yHQk=;
 b=kRVzyOqrrYtk+tblnqVWoQsu02R+E/8Opm3jcn1JwF4wQ3VWktqZgYIN21n65Gssvs
 RIrnLoKxDo9QLM1wn+VgQqkxJmePJzJUjB26CHDbViJUZrMo6Y/KqcVXuppMbybpT/zU
 OtiebODkJk9dPlrFVPs8zsikHz3E0Gnta3gTmtulgjtfCBizuJacm6RyuK32FrE8ciYg
 HZVa+RWcLkyTqznXGjCJWgLGGxyp4YkX4CAhDWGDKbSkzbZx4nSsbbUwfHUdzyfL8VEw
 A+n9uMeObqBtdkFRtxkz1Fp2ZJWWp7lIjfkzxce8MKFNwK19NAEzksGgN5G9INOGwcug
 IusA==
X-Gm-Message-State: APjAAAWymEUUsYUauCb61OMPnoWmkYrd0zC2ssnILXVC8jaqw6xrMWsB
 Vj/Gr6/5OD3xwpGY8OGNW9LlDd3mLJY=
X-Google-Smtp-Source: APXvYqxuHq/oBv4epVwHoQWW9A0tiqDb88Ly6lD0S4ibzNEGAvMeRJlBG3wt4HVmpfBJUbFMirJsmQ==
X-Received: by 2002:a5d:905a:: with SMTP id v26mr887540ioq.77.1580325487942;
 Wed, 29 Jan 2020 11:18:07 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
 by smtp.gmail.com with ESMTPSA id i13sm767646ioi.67.2020.01.29.11.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 11:18:07 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Respect -show-cursor option
Date: Wed, 29 Jan 2020 13:17:29 -0600
Message-Id: <20200129191754.3578615-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
X-Mailman-Approved-At: Wed, 29 Jan 2020 16:37:05 -0500
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Joshua Watt <JPEWhacker@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user specifies the -show-cursor option, force the cursor to be
shown even if it would not otherwise.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 ui/gtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index d18892d1de..bdd1b53236 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -258,7 +258,8 @@ static void gd_update_cursor(VirtualConsole *vc)
     }
 
     window = gtk_widget_get_window(GTK_WIDGET(vc->gfx.drawing_area));
-    if (s->full_screen || qemu_input_is_absolute() || s->ptr_owner == vc) {
+    if (cursor_hide &&
+        (s->full_screen || qemu_input_is_absolute() || s->ptr_owner == vc)) {
         gdk_window_set_cursor(window, s->null_cursor);
     } else {
         gdk_window_set_cursor(window, NULL);
-- 
2.24.1


