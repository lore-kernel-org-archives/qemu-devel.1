Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83350C072AD
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E386206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPeEIANb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E386206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTKm-0003uu-Dz
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:27:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZk-0003kD-5D
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZj-0004ZO-AB
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZj-0004YN-2D
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:31 -0400
Received: by mail-pg1-x542.google.com with SMTP id a3so5748173pgb.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=OfeoJQTtaaK+fPbdLfxvz94gE9h/4wGKMQdWOeJxa7o=;
	b=sPeEIANbnrlgFVXYdGYc7ADETYF1JqEBXSg3MaLO1/2o1TFntMnojX27kpBoZZ0gbi
	BSrF1n2tEQ+0yhucLw6GH0mRAl1waOF9Cq2eRw2MDz5RLTxdI8HZUAGJk9+d4c1+0t9z
	w8u4MkDvj9E7lia3E3lFOY2urYQrqQPHj/mzQL484aSqCN6fyKk4S+YhVFOjof+ukLRZ
	McSUwzu/O2I8HUkMBEYGp2GAsWGoH0nFgG9iqSAzkDKFjWWtEpnrKJ3KF1jRZb7kh5gb
	eZzBWwCqG2/4dR5p+cPu4mMdHBc4Ap5Y+xz7xTx2k0Dl/6welJA1vVsB7YkavwAILplN
	Ndgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=OfeoJQTtaaK+fPbdLfxvz94gE9h/4wGKMQdWOeJxa7o=;
	b=Ej8FlvOXY7/vYz5bUHM/iF2dg02ytiLTHxqsyIfQlXzBYguSQ+7qz5prTKU8gTiWFa
	xuRbWAaM9EjOayyq7P7r9CQlk9d9e0xdjsWf96yuortLHTNB1enYmwRosMU1bo/nA1fc
	v6UBrZnmVBMllbSdgYqp8gJGK/OL04MHv7ALeDuAK5wEINdm2zZnXIcjNrkjbHi22rh9
	v/sFGU32I/ishYlZNnJiTpVlhzfkqT2zcHKbHWGru1rWQH3BIB05pKWaSvMpDz9t9iF9
	fJBJs9f9HK/WZsvBm7HuidLYAGXlx0UuD/jvdFE2b03JnL6T8mD0+gkPP64MiLmeG392
	2M0w==
X-Gm-Message-State: APjAAAWJKpFG1oCsO/nWLkEagguwPB+Zh/mdC4I+H2/+4wxkT29rexPX
	d+n1hstQRT6vwiF4KKFEfQLTYCWWaTM=
X-Google-Smtp-Source: APXvYqzrqZExyA59sB7DrQH2X9YeYoMfdcVjwdhUBf8yUiY9NieV6iG3vEVpYLERymKdxaGqy1KtbQ==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr72009716pga.412.1558298309801; 
	Sun, 19 May 2019 13:38:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:00 -0700
Message-Id: <20190519203726.20729-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 48/74] linux-user: Fix types in ioctl logging
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no need to cast "int" to "long"; just use the
correct format in the first place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-ioctl.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall-ioctl.inc.c b/linux-user/syscall-ioctl.inc.c
index be3f0b4b92..15d87b9663 100644
--- a/linux-user/syscall-ioctl.inc.c
+++ b/linux-user/syscall-ioctl.inc.c
@@ -791,7 +791,7 @@ SYSCALL_IMPL(ioctl)
 
     for (ie = ioctl_entries; ; ie++) {
         if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            gemu_log("Unsupported ioctl: cmd=0x%04x\n", cmd);
             return -TARGET_ENOSYS;
         }
         if (ie->target_cmd == cmd) {
@@ -864,8 +864,8 @@ SYSCALL_IMPL(ioctl)
         }
         break;
     default:
-        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
-                 (long)cmd, arg_type[0]);
+        gemu_log("Unsupported ioctl type: cmd=0x%04x type=%d\n",
+                 cmd, arg_type[0]);
         ret = -TARGET_ENOSYS;
         break;
     }
-- 
2.17.1


