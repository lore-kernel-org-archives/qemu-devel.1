Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0CC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BE02082E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqIKMJQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRljG-0008CH-8F
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:53:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbO-0001NM-1i
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbN-0005kv-3R
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:22 -0400
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:39996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbM-0005jg-Um
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:21 -0400
Received: by mail-yw1-xc2a.google.com with SMTP id 18so3349059ywe.7
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Gi+xV8hZZ8MM2hR8q1Ptxgv3mk/SLE89TCM1Wb+jzls=;
	b=qqIKMJQDynycgLbBvSyiAX1GayrfB3gNTiIz7ycbiQ7cpvNBgnhyY75fJ9K5fDWQxG
	dZ4KXHqa/rzFrZRBhRDeP7eNjAtrDfoXgFM0xNoLcSJasBBIOrdd0H9TT9LcQzTw7Q0v
	HwFQEk/w4L5JY2S8q0/4X29/doHodeP29TH5WrihMfpDs524mKDa5wsHU5so43zkbKpg
	Mj2MSByx/0w1xx+rnVowUESrkHNK8ddV8ehaJyrVeqOlwIQPQ/GDyav1yr6NyEhi+OwX
	CsKCIvP1ihgWKZ1jki2fY2DgYdMbkRPHk0g0kbiioX3M9IoluhEi9/W1eC21WCCS0hOD
	CLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Gi+xV8hZZ8MM2hR8q1Ptxgv3mk/SLE89TCM1Wb+jzls=;
	b=nR7IG7Xhc+iLxk0ZG+75Phw0rgUALxwXIpdyq+Dwd8e7pZkFzuGjd9E7aTDKddFwEB
	ICif8RfP8SEibrIN533f00s1F+sRcKnTwlOZvHlUeVNqKipHzgDQdXI+bKeIwosptiZ/
	/Z5dovtchRVCvzsFbZq9mS8F8d5mwRXtItauhZK43R5Ll1oTo73qWiy2tWjVngkFInXI
	q9SJN7OBKZ0+d7pHeZIB/XicFSLNU/vSOS9oZpLWa8DSO7XNLZsKaLitVI0v8jbwnlWX
	3T6KR79B3lig3t63kx75BjBnnNWO1xdZaHWQxh8EgVLpPW8F0zus0RWDI7cYzBiJhAh1
	dseg==
X-Gm-Message-State: APjAAAVwoTSR5QlhVxTs/wT4iTda359Ob6E2qfQxSQzzcc1iE1Qy/kZe
	kavNl0OUoQdGVCtw6IRgHNbXFbrU9JQTnQ==
X-Google-Smtp-Source: APXvYqweCUY3sA18NV8cfz9omN08JXU6c7MPBg4xG+my+QYYvbcrBrePJ57joayQiGOk5Tt5ziJ6og==
X-Received: by 2002:a81:a983:: with SMTP id
	g125mr15328434ywh.417.1558133120328; 
	Fri, 17 May 2019 15:45:20 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:19 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:50 -0400
Message-Id: <20190517224450.15566-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2a
Subject: [Qemu-devel] [RISU v2 11/11] risu_reginfo_i386: accept named
 feature sets for --xfeature
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

Have the --xfeature option accept "sse", "avx" and "avx512" in
addition to a plain numerical value, purely for users' convenience.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index aba5ae3..c15fe63 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -54,7 +54,16 @@ const char * const arch_extra_help
 void process_arch_opt(int opt, const char *arg)
 {
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
+        xfeatures = strtoull(arg, 0, 0);
+    }
 }
 
 const int reginfo_size(void)
-- 
2.20.1


