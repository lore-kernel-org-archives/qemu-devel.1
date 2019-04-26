Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8CC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FC82146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfk8zAr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FC82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4fH-00044f-8H
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:29:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aQ-0008Tq-P0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aP-0006VT-MA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:37923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aP-0006SD-Fh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id j26so1936424pgl.5
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qG8cIyjXu/sgNDmtduLrdTs106BZZN6hG6Kr2t2NXJo=;
	b=xfk8zAr56yHDNB6Km7PICzN7QktqkbjB3oJK4JWsnqfeuDPLLbArlx4VS/clmd4hTu
	6ba7WpAE7fM31v1aKdZPcyDgT9VHAY4vXZFt41Mox95bVZMITnQy0r8iE9kRoSjlwBXM
	UUMFBbtnmHQOeWdMu1m6h3rR3O19BusieUhGUvdMKDik68/CqO8OpnQTw/et+jswBrxF
	Fgk/7B3/nqSaFnwzJXM0DWHJ5h5CyAfDLFfM5M6Gb29sN5UEopYvA/4FgISpOibuaKPy
	4rwBwFz3p9L8bmvvmFTBzAbPs+N4Cj3f6E1Pkmk6aHP6ncP2owjLZUrbmK5TVMPFEjJa
	81yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qG8cIyjXu/sgNDmtduLrdTs106BZZN6hG6Kr2t2NXJo=;
	b=GF/Wqs5nWAaap6qYGCIaPUcbhpC0oYY5/5lSLQbQ6LjT1JvmsQXo/3RzK7j5PznCN4
	sT/EAKz5gMGNsDjKFeNcW0fRYzyyfpr5d9lCviyIwOj8J1K4oBYjVVaBxEK30MOx91k7
	NE+Wmo1IaN6tkcFBVYvcl+08vTwMcbkvNUvdlZr9RXAC9dNtsiTIWcZL8mU9U/MXbQ+Y
	yPfmOQNXNkNimpQqSzkCs4SYGZWZ1Q/x/fBSnoYjKWrXbu2ZANEnIiTu70jwvS0+P1p/
	lF0Blw8/G5aJfoqAduantwmnstgTR/jayokIwX9Wso+uAqIFyYczYwmcPGt9FwWjEWuQ
	WppQ==
X-Gm-Message-State: APjAAAUts7WD09z9aELc09hceTKk4VKZeYkZRr+ipVOhE5+5glY8KXI+
	eyJe8DtV3Q49g3kSuiokuxx+qvjfrKo=
X-Google-Smtp-Source: APXvYqwiIlxtoCAVoSWAplZXOZo/jnVLtMnP28PACmZQfl5yvOWhD2IQRD86sTFAeY3KwxR6WtfBuw==
X-Received: by 2002:a63:f444:: with SMTP id p4mr44903840pgk.32.1556299472193; 
	Fri, 26 Apr 2019 10:24:32 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:13 -0700
Message-Id: <20190426172421.27133-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PULL 07/15] tcg/aarch64: Support
 INDEX_op_extract2_{i32, i64}
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426172413.Xo7RofqmGqx-lRvlWRi4XXiua3RKZiETP3RowRz_s-Y@z>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  4 ++--
 tcg/aarch64/tcg-target.inc.c | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 6600a54a02..ce2bb1f90b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -77,7 +77,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_extract2_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -114,7 +114,7 @@ typedef enum {
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
-#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extract2_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index d57f9e500f..8b93598bce 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2058,6 +2058,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
         break;
 
+    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2_i32:
+        tcg_out_extr(s, ext, a0, a1, a2, args[3]);
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
                         (int32_t)args[4], args[5], const_args[4],
@@ -2300,6 +2305,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "r", "r", "rAL" } };
     static const TCGTargetOpDef dep
         = { .args_ct_str = { "r", "0", "rZ" } };
+    static const TCGTargetOpDef ext2
+        = { .args_ct_str = { "r", "rZ", "rZ" } };
     static const TCGTargetOpDef movc
         = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
     static const TCGTargetOpDef add2
@@ -2430,6 +2437,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_deposit_i64:
         return &dep;
 
+    case INDEX_op_extract2_i32:
+    case INDEX_op_extract2_i64:
+        return &ext2;
+
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
-- 
2.17.1


