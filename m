Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F6C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1650207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbdo5YJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1650207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulpy-0002ba-Vy
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloW-00009l-7v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuloV-0007iI-79
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:04 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuloV-0007hu-1R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:23:03 -0500
Received: by mail-pg1-x543.google.com with SMTP id u131so4183pgc.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b03RbSukzpoEye2uxHCZinu0Fc887c6qTcIlfZvoadY=;
 b=bbdo5YJcZl4eb0SO0yz1Ld5DAVwK4FKTVA/t5oTI2a1CArXaeBMXLdwET3E2ExS/R2
 x7kdTnyJCWoEyGoxEomKpMo5FIuhINX823HzRXH458+3o7U0mxnyyfkyT/JGJuO3CKFK
 A/cBd0QnNLjtUURhKcoVa8BcGXHNhzJlrk1N7zcocP+HtkdNYkXHqRBKo4Kcz0QwSQMD
 6YFTgkmy0KS6NdrEjSWOEZrxYMCfLSMaDzWbsWLsFv5Tx2SeYvO226ktr7IlhgMccdr8
 i0RkUu/6ZNfQPEj1i86qZxg+k/jA2RzpXGkjPPx6SbPDHLWVEXJvewl5u9sDSX8jDPyq
 T9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b03RbSukzpoEye2uxHCZinu0Fc887c6qTcIlfZvoadY=;
 b=EMwECKLLYebWIjllVzw7UmSsDQWs5a7hqUMFqgm7+d+cL/CKPkHvi8bV2qA8EqcNpu
 i5o409xN3EYMO3tFqMvFSP8SaYBgoNfU7KPayY42ZRUDfvZ+aeSJLWLed7d0Ig5/RmOy
 TlbaWcEz9YgQR5tbLSRN4AgzaUuHFYuMl5mEOpogtomw4T2d2Ue+NwiHgbYKML0S9LVF
 vkTExBk+DNyOFsIGL2MG3loIsV86+WSJtnwToUCzgBO/FgiEhV+tETqlnY80y1Nxlxtj
 yh1bippXNPhP/rOVjcqm2MWh332G3+yovuvURRrZ2iBqDwL7in4Lakglnf1jMGpxHyWi
 n0/w==
X-Gm-Message-State: APjAAAUtPJADgf5Rh+YLcm4Z7FJCfXsLaNfOltvpWIHCpKeJw/bdilES
 eGW2BkeAYNPKZ9OMN/zGUxKiknNuy+U=
X-Google-Smtp-Source: APXvYqwvMIsph4RsNc1J/WABk+9JM5VgCh63cL6kIqYNJ3xD6w5TeYqJCOvbHoF/qEftDQdalJMViw==
X-Received: by 2002:a63:d249:: with SMTP id t9mr848680pgi.263.1579821781678;
 Thu, 23 Jan 2020 15:23:01 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id z5sm4136008pfq.3.2020.01.23.15.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 15:23:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/s390x: Remove DisasFields argument from
 extract_insn
Date: Thu, 23 Jan 2020 13:22:48 -1000
Message-Id: <20200123232248.1800-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123232248.1800-1-richard.henderson@linaro.org>
References: <20200123232248.1800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: thuth@redhat.com, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The separate pointer is now redundant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 3674fee10c..0bd2073718 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6183,8 +6183,7 @@ static void extract_field(DisasFields *o, const DisasField *f, uint64_t insn)
 /* Lookup the insn at the current PC, extracting the operands into O and
    returning the info struct for the insn.  Returns NULL for invalid insn.  */
 
-static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
-                                     DisasFields *f)
+static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
 {
     uint64_t insn, pc = s->base.pc_next;
     int op, op2, ilen;
@@ -6264,13 +6263,14 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
         break;
     }
 
-    memset(f, 0, sizeof(*f));
-    f->raw_insn = insn;
-    f->op = op;
-    f->op2 = op2;
+    memset(&s->fields, 0, sizeof(s->fields));
+    s->fields.raw_insn = insn;
+    s->fields.op = op;
+    s->fields.op2 = op2;
 
     /* Lookup the instruction.  */
     info = lookup_opc(op << 8 | op2);
+    s->insn = info;
 
     /* If we found it, extract the operands.  */
     if (info != NULL) {
@@ -6278,7 +6278,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
         int i;
 
         for (i = 0; i < NUM_C_FIELD; ++i) {
-            extract_field(f, &format_info[fmt].op[i], insn);
+            extract_field(&s->fields, &format_info[fmt].op[i], insn);
         }
     }
     return info;
@@ -6302,10 +6302,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     DisasOps o = {};
 
     /* Search for the insn in the table.  */
-    insn = extract_insn(env, s, &s->fields);
-
-    /* Set up the strutures we use to communicate with the helpers. */
-    s->insn = insn;
+    insn = extract_insn(env, s);
 
     /* Emit insn_start now that we know the ILEN.  */
     tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
-- 
2.20.1


