Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A4C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F5F2083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufF2jnT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F5F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDWY-0000Oe-N5
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:34:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDSn-0005xg-GM
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDES-0004n8-OX
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSDES-0004ln-Hd
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id 145so5144978pgg.9
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7uqSx6k9s5mizV7n0y2ah5U9w3ZcH+wua84njE/R9g4=;
	b=ufF2jnT58F6RlZWanTcePlFu2XhcSsPEFlIEA3cP40HJ5n6SIjBbEpqV/HZbQzCBFm
	kcqBjtf6Uv9oAPmrstfx21BqJgYPqUfeGhr5OkEVX/xZS0DwXThA0w7mVWpLnpoxUo0Z
	N5BFYQGQWTMGh8KTISX2GmP7i/h3kp/0apfMNGuyZIUlUnqALrrJSTWSa0yctGbsofIn
	h564Y1rJNrKakwjHxLUKipZ4xs655/p6md8GqwANCmvfwkVCwqIR8AuR+t2gfm7TPmOl
	S8xbXm/WAVbLpPg9EgFmWl/OLds52Qr3LC2HRQVdjaC85KAZLZHjM6knTJUKGXzNZYPF
	8WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7uqSx6k9s5mizV7n0y2ah5U9w3ZcH+wua84njE/R9g4=;
	b=P6ZhMRcZ0aLZiJIPgNeRW0pdlas23IHGCS/8MyCmUefsOydeem0qt1qtKU96Ko2kPb
	9G0IwyM4UWnb1/MzlxV5rEyxfl1g4tmsRVhxvLtn+Wl5KXVctLHw1MJ+b8E9mkPOmLYd
	rzUjDgq/0KKiHmZTlWZwTLQF24OJ3YStGf2PipcjnPHvGmtR026MUolbBZqJLzgb5SL/
	xCjzAuxhHMjmGTTR5FVIRM5HT+SH845MmisSHvehxq+vI88Acg9Y+rjLkqb8t0M5zDXd
	QS4/n5PHPerAiMOdQ7PSCceWZOpBASs0OIItrx57/6JNOuCc9Gbr8Uvu8F9fySIjEOSq
	8+dQ==
X-Gm-Message-State: APjAAAUgqIV5iqDd6xA2shaHrd3GrJ7of7Pr1NeH3XjiTfofth+7jDfc
	xO/AP2+qj3bzDbr4x+rG6oXOUg5KwrA=
X-Google-Smtp-Source: APXvYqxiEqAvI41pbW9iNHHM4AHNsGuqaHhC3bribNxbQvNCopQeygKa0NM+igLFQVTqUb8aLoQtGQ==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr50955466pfa.49.1558239329763;
	Sat, 18 May 2019 21:15:29 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	k63sm19381200pfb.108.2019.05.18.21.15.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 21:15:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 21:15:19 -0700
Message-Id: <20190519041522.12327-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519041522.12327-1-richard.henderson@linaro.org>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 4/7] tcg/ppc: Support vector dup2
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
Cc: mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is only used for 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 9d58db9eb1..3219df2e90 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3120,6 +3120,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_dup2_vec:
+        assert(TCG_TARGET_REG_BITS == 32);
+        /* With inputs a1 = xLxx, a2 = xHxx  */
+        tcg_out32(s, VMRGHW | VRT(a0) | VRA(a2) | VRB(a1));  /* a0  = xxHL */
+        tcg_out_vsldoi(s, TCG_VEC_TMP1, a0, a0, 8);          /* tmp = HLxx */
+        tcg_out_vsldoi(s, a0, a0, TCG_VEC_TMP1, 8);          /* a0  = HLHL */
+        return;
+
     case INDEX_op_ppc_mrgh_vec:
         insn = mrgh_op[vece];
         break;
@@ -3498,6 +3506,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
     case INDEX_op_ppc_rotl_vec:
+    case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


