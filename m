Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144FC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A97D206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/QAwii/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A97D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Y1-00064Z-DY
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DZ-0006Fn-Do
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DX-00007p-B0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:21 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:44237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DX-0008VY-5u
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:19 -0400
Received: by mail-yw1-xc42.google.com with SMTP id l79so286360ywe.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=48lyFWBj0n/nrnlkJTcKCrCMcCKDd/O/WUATIxnd1g8=;
 b=l/QAwii/y6cdjQiOeT/luoMnLgIh3nie71xIUpMXlSRzgjR5909r7TSHK3GxhPHh+5
 P2dIg17/VYN+2mH/cvypV9BqAgATzdCumuzvzUlhZEMG3UCGLhzXoUraUey8oYug3ntN
 IykxcGVI8H/I6umHEhD6468Bpl3df0/mshl9rD2tJRi0TbLbrzY/gCfE4oY+VXG2gUbS
 TRg8P1kw7TfDruUAfRMhyzxTm8/ao+t5pMHVK0yydDLd93UX4gfNW02JBUQU3uJtiVZK
 JEyKc5ReUypn5f1IYBcM0vHjGP3X3jmGH40IoBy1k/P7OaOsJKMMgzEoV94nv51oS4Ip
 Y/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=48lyFWBj0n/nrnlkJTcKCrCMcCKDd/O/WUATIxnd1g8=;
 b=S1ea6ssxR4JdB/skZXq8uz8GkF8NVzfoyROq85I809nPm8IMRADVGxuK42YYkf2mcQ
 TlDjHGaU8WvA0ooLiJeo45MRK2g/rhBcmmJNHERuc9HkM/QqKIP6iiuieWjK1F3odANj
 OGKcwjj5YjbCRFVxUDEbLnNehNg/tVYBoivQAFBU/1ixe3CADzbfvHCoa4m2teo58kc6
 MLiH6KjobGhJTMFFWvPEUIe6J1rTaEcENRWCH0CLDObjM+mEeK9Hok0moEZDWclAO+FK
 EeZO6nEL5WnfOJoS5JENYSHD6w6eVWTPn7Xs1dHpsXVlbm/zPdkgJSV5uMjE4ri9rHKY
 sz8A==
X-Gm-Message-State: APjAAAUXcjK9p17EiocniLw/NCY4I096lV6NSFghkRYw+MZDV05BYr1b
 /kH4uk5t3kfTTC+yTnz9COhg45Rv
X-Google-Smtp-Source: APXvYqw0iYU+mEN8TVWhYWs6Q7LI4ym0aqr98KcdZ2Bv+8rV5BNz0wfXVakdmfhauPW6U34xJCrRwA==
X-Received: by 2002:a81:99d2:: with SMTP id q201mr1541318ywg.461.1565835016829; 
 Wed, 14 Aug 2019 19:10:16 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:16 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:06 -0400
Message-Id: <20190815020928.9679-25-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v3 24/46] target/i386: introduce operand
 vex_v
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

This operand yields value of the VEX.vvvv field.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c918065b96..4562a097fa 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4859,6 +4859,26 @@ INSNOP_FINALIZE(modrm_rm_direct)
     insnop_finalize(modrm_rm)(&ctxt->rm, env, s, modrm, is_write, arg);
 }
 
+/*
+ * vex_v
+ *
+ * Operand whose value is the VVVV field of the VEX prefix.
+ */
+typedef int insnop_arg_t(vex_v);
+typedef struct {} insnop_ctxt_t(vex_v);
+
+INSNOP_INIT(vex_v)
+{
+    return !(s->prefix & PREFIX_VEX);
+}
+INSNOP_PREPARE(vex_v)
+{
+    return s->vex_v;
+}
+INSNOP_FINALIZE(vex_v)
+{
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


