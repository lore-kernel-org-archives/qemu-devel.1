Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C462075E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTesA8IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTuhs-0004NQ-1N
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:52:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTua0-0006DQ-66
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZz-0003Pt-6F
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:48 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:40884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZx-0003H7-H8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:45 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id g62so2785714ybg.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yaZVlZDEXWfOSBbbJA3wQfauT8Jz80fWSW3uiWNB6mc=;
	b=YTesA8IY48HUlfRoiX1Ns79o4itVfEyRQzvF5xWbK2lBb/S1tdqwmOGsdrt1U765Yq
	CkqIQaWqD7/8L8dwou379tWjGbm14ttiauKwpXIgT5bEDhKqzsSHT8NyvA18++P01bo1
	z2aTvKgasJkKrs0ltYaGqfHjjBvn547FuAEE0uTuIN0XWQ6cS+kW1z7LpcXNnm+ZLWtY
	EpqA4GvuiLaC9m8oWIWlJAaHBDu0pyGuv8MlyLVDXmvcVZuWSuYMUZjRByxSsWeHo72I
	zmR6K+R8muIZ92oLX/1JE3Qle/zmiw/Oh6AXX7Ua5E10DQysXFTul0ws6mn4u94cB6MZ
	D2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yaZVlZDEXWfOSBbbJA3wQfauT8Jz80fWSW3uiWNB6mc=;
	b=bt230IPqQZ4tHLVha67D3hrDzkGTzRjKyA5PNcmq4R+lKYeMSn3Ib6ltW8/4s04UU+
	C1y46HHh96X+KadLrBquOZThxjybx1AKULJNobxZm1ZrxGZ4LpeDe8WyW3X+/v7Z5Hbb
	BqJYAAlJ+/3yeofRI0xLlePk0L+Pes1dQELqw+KTOYmLil7WfRr+hcUOE49Bk1jeMDXC
	mhUvKnKrsjdxU9lSqexId+KR49eSEtt28EZDEEa0+FegfXUU4PkoUqQIxHir5slY0dbJ
	xB7iTeuSJ4MgSppitcG2ctwsYCbLnQ4SiqmMVIXfYw2zZvIoyxXr+p/as1J7QIub5yZL
	Cq/Q==
X-Gm-Message-State: APjAAAWrxvYOARmyxtiLJAByj/Y4mFG3S2Og56YWvJ21NCRo3tyRLTix
	qRrNZr2AjI0XMV5gk77pJyLY2S6T
X-Google-Smtp-Source: APXvYqzvnsYGcGrS8nYaQmH6KjJa7oRVBMPDhKGIAE+5/oBv/SkpmcF93owMKk9V8w9CdvLE9b8TWg==
X-Received: by 2002:a25:5089:: with SMTP id e131mr7852663ybb.322.1558644283566;
	Thu, 23 May 2019 13:44:43 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:43 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:09 -0400
Message-Id: <20190523204409.21068-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2e
Subject: [Qemu-devel] [RISU v3 11/11] risu_reginfo_i386: rework --xfeatures
 value parsing
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Have the --xfeatures option accept "sse", "avx" and "avx512" in
addition to a plain numerical value, purely for users' convenience.
Don't fail silently when an incorrect value is specified, to avoid
confusion.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 01ea179..194e0ad 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -53,8 +53,25 @@ const char * const arch_extra_help
 
 void process_arch_opt(int opt, const char *arg)
 {
+    char *endptr;
+
     assert(opt == FIRST_ARCH_OPT);
-    xfeatures = strtoull(arg, 0, 0);
+
+    if (!strcmp(arg, "sse")) {
+        xfeatures = XFEAT_X87 | XFEAT_SSE;
+    } else if (!strcmp(arg, "avx")) {
+        xfeatures = XFEAT_X87 | XFEAT_SSE | XFEAT_AVX;
+    } else if (!strcmp(arg, "avx512")) {
+        xfeatures = XFEAT_X87 | XFEAT_SSE | XFEAT_AVX | XFEAT_AVX512;
+    } else {
+        xfeatures = strtoull(arg, &endptr, 0);
+        if (*endptr) {
+            fprintf(stderr,
+                    "Unable to parse '%s' in '%s' into an xfeatures integer mask\n",
+                    endptr, arg);
+            exit(1);
+        }
+    }
 }
 
 const int reginfo_size(void)
-- 
2.20.1


