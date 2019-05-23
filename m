Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F40C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95A920B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 02:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QABtF/Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95A920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTdq4-0006j9-RI
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 22:52:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTdoY-0005Qx-3m
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTdgg-0001sF-U5
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:42:35 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTdgg-0001ru-Pv
	for qemu-devel@nongnu.org; Wed, 22 May 2019 22:42:34 -0400
Received: by mail-yw1-xc44.google.com with SMTP id v81so1697769ywe.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8kd0zJ7pX2a58yAUvy9tQqu3+GflEz08T0/34sUM+/A=;
	b=QABtF/Jp0I6Hk9ojEdIqCwJXu+R+Q+xjpgknF47zdeI4E++UWXDw/6IMIQSwcAejVi
	GrJN9k7lXdxbb7swTqbi5Jsm5TkspwDwq+A3PJF2qg8Zm1bIOBlxO58IZYjago7fvrVJ
	HB3CrNZo01H2cT7FHwKSwaYvvyjWC1kpbj1aDE20rEYMSyXBqj4WA3J++7KWCTsce83B
	sH/GhMlvzuWxBuCQFlicvf7aoS/f044awBIlslXHYCch19+rgIW4LawIaVwIvGGLJhgT
	7HTfcr2zBDj2Z6Vew4jGXttF1igawk2wxJMWJiQlH4S80rmS/9We1C9rv0hePoMwOQzH
	1Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8kd0zJ7pX2a58yAUvy9tQqu3+GflEz08T0/34sUM+/A=;
	b=ngAjCD5bIXq2x8S9U17/BMLWMtFtTSU3ix9QcCYsGABlnh0ZGSjE39G+STvCeEIIXh
	HR3msQEPD8sABlKHLOwsfeKBS75hvmuWy9PzD+3TqEg4JkFJpwPnfL9pvN+w4Zg83CUL
	NUh8oFDOn14a+ZC5xBOdXQscNKX+ixBoLLSe3E8fGONwy1sONCWsgVZjVWFXsGLPPYIB
	HrmT8PNqzemnsTT++hvaAQPiE7Z3QLuCPolK9lK3JiNyEmO1OosqV/DJkE0W7jaiEOf/
	G4hfAjsquJ+RuqezEcV8tLv3Z2WEgLj7g+EJu+nr7AVgzw1qIZxMNXY5+v1P/1U5Oxg8
	avfg==
X-Gm-Message-State: APjAAAWQceOxj53ecCH0lSodOMhV0g7ogcZdWiIT+rBcQhMYhqFuzeRD
	S1VYHlVSqG7ObLs2CuVU9Ue5yhtKQgc=
X-Google-Smtp-Source: APXvYqx+LL0O4r3qY7SNttPc7IzkhqhVp4i2gY0a6rpJcf/v5dy5zEDRRvuLNgQA+fovWmm1zUTQ9g==
X-Received: by 2002:a81:a183:: with SMTP id
	y125mr46192680ywg.249.1558579353887; 
	Wed, 22 May 2019 19:42:33 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	n12sm7559320ywn.81.2019.05.22.19.42.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 19:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 22:42:28 -0400
Message-Id: <20190523024229.1158-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523024229.1158-1-richard.henderson@linaro.org>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [PATCH 2/3] capstone: Update to master
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to fbb20ea83c5a.  Choose this over the 4.0.1 tag because
master now includes the s390x z13 vector opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 capstone  | 2 +-
 configure | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..fbb20ea83c 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit fbb20ea83c5af4f29b40c17fbadb1f71b0a08fae
diff --git a/configure b/configure
index eec7f061c3..a2e4636a34 100755
--- a/configure
+++ b/configure
@@ -5016,6 +5016,7 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     LIBS="-L\$(BUILD_DIR)/capstone -lcapstone $LIBS"
+    capstone_capstone_h=yes
     ;;
 
   system)
-- 
2.17.1


