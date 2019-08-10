Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93AC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26090217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDivdAqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26090217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwJ0L-0006KS-U9
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl3-0006DT-IN
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl2-0004SO-I0
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl2-0004Rq-Cm
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id o101so5584537ota.8
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dEeYOdO8k86iFOdeCG1Qzb5tXqRbL2ElGcxu6RqHdc=;
 b=jDivdAqrqL1DVKKaLjvcYB31mue+KhN+kOzHfewLqwg/aYjcvEYQ68/FfpHHLBhmg4
 Bl4vgo5NZspCuAXD2hwK4QcOsvj3onncWuv6YPVCx423dxH4CGsHangSDvrOHOL4norE
 /vZTOoyCSR8hiXnC6KzdQXgBjnvBvIuwomoz9MgVpPlVhhRyszkhyyEOkzqeDc4xPMVV
 f0zLW82bCNb0CkIcMNl2INir9qKXvB7ZXnJYov1uBmgWvOpyprwHKGJ3AjYwSmJISV9/
 JjtDxpb5t+NGy7p2RTJj/ZhcelIhVTinnUFQvc0nTMW/6zzxh74eSwnUCfgYu+WJbxJE
 x7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2dEeYOdO8k86iFOdeCG1Qzb5tXqRbL2ElGcxu6RqHdc=;
 b=oDlIW/RfPqwF78xmgnavqvSoYp1m2rn5IpOhsnKwNoy0qy2EDzkw46nGDcypvdEeV7
 Ot++pSOyL1AClX3v+Vaiu5izOe90+ISdrz2UWBXgeCmusknVPA4kAW4MqsYvcmsow7Ut
 u6uzpMweZLzR2g6CS6c65zSat4eDWMFjeja7PMWFL9DnpD1BjjlHh/j3dpzlBFAJCk0l
 LnGOGmE4CRuRSo/18kwP9fPi8YD6+BxdDdGMMMlHgwWQxD3hgVzYwrMH7W13uZpRpl7X
 wJl4x0zzgdCu8LIkh9LWNYFC9eI2VwE29IVhl7j2tRjhFYZHeQ85RmQ1PqRgv/TzPac9
 UWgg==
X-Gm-Message-State: APjAAAW9SbH0IMXrEwwucBPaPbVNpEMAMdQgoNPJ4GBbz8xiuYyaF3KM
 pXklSGs3JJyyEk6mkEp8t2LP+zbv
X-Google-Smtp-Source: APXvYqwOwCFwXc7MSoxKVEVNxIerOai2LPKKv/Rh9qpUW4b9BJu0afEs97UM12Tiozwv5fFLuyk9sg==
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr19460742otk.107.1565410411740; 
 Fri, 09 Aug 2019 21:13:31 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:31 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:41 -0400
Message-Id: <20190810041255.6820-26-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 25/39] target/i386: introduce M*
 (memptr) operands
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory-pointer operand decodes the indirect form of ModR/M byte,
loads the effective address into a register and passes that register
as the operand.

Note: This operand has a known flaw: if an instruction is writing to
memory (rather than reading), this operand cannot and will not load
the effective address into the register (as it should). The current
workaround is to declare the memory operand as read (rather than
write); this flaw will be addressed in the next iteration.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b8e6eaebb4..301dc4eddf 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4705,6 +4705,31 @@ INSNOP(Ib, int8_t,                              \
        (*op = x86_ldub_code(env, s)),           \
        INSNOP_FINALIZE_INVALID)
 
+/*
+ * Memory-pointer operand
+ */
+INSNOP(
+    M, TCGv,
+    do {
+        if (decode_modrm_mod(env, s, modrm) == 3) {
+            INSNOP_INIT_FAIL;
+        } else {
+            INSNOP_INIT_OK(s->A0);
+        }
+    } while (0),
+    do {
+        assert(*op == s->A0);
+        gen_lea_modrm(env, s, modrm);
+    } while (0),
+    INSNOP_FINALIZE_NOOP)
+
+INSNOP_ALIAS(Mb, M)
+INSNOP_ALIAS(Mw, M)
+INSNOP_ALIAS(Mq, M)
+INSNOP_ALIAS(Md, M)
+INSNOP_ALIAS(Mdq, M)
+INSNOP_ALIAS(Mqq, M)
+
 /*
  * Code generators
  */
-- 
2.20.1


