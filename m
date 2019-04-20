Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F905C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CFC2087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClFSOIvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CFC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkuE-0003u7-3W
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:59:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXX-00011a-DZ
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000mm-6F
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXU-00006M-VL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id c207so3462049pfc.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=L7/jGco+/JJYnhyme4mE2WKjitzinpGKSfbQsfSJn94=;
	b=ClFSOIvv3wKxiaBOLd3diX8DzrLQocKUTRav/6HZMfPGNjCCugVz/yzulcdHG6njKY
	lo9dfqDXRHPL2wA3+R4XlVqT1q4PhHFW0FDLj/4aLbpeYaUHuEr83RNiKzVmb59vr3T3
	Q18zAxrE7ETxmVbET3JsInsJ0Q12K/zfmBtkHuIWbOnQfQoa3Dw2B1X6guZjMCyjac4F
	s5G0geHHH0K3DOn1N/LPzjVbj/ppZ4Kb8eai2lmvYyjS7rNb0PGOdioWNnfGyvNDhDUx
	A3vDvfWzoxsFz36ZWGITRpRH+k2MGvrYdC9Aw66W+l6ZMYYnE/0G/QgcLABLqbocUKOH
	UkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=L7/jGco+/JJYnhyme4mE2WKjitzinpGKSfbQsfSJn94=;
	b=S4gQaVaE4M0VBdhCDAMUZntTtJ2g1JCj42TZxHmfcVyEyof+UZkpBPVfu4h1tcgbfA
	lguxeTprgEpFzcCtyiTYW9MSum2nCfS09g0nUxsnahaX07XHMKZeVVrggELtzysFvvmL
	cRMSIiajmX6nTnRQQ5ZcmcmqDsQTU+3rx3q+cc0FvJqfMqTAjb7Fk+3yvIkDQyfUUJ36
	TEtwc+9iMW+ilvQlPG75c+dLVRm5jFxW+WvqlazFkr34N+JWYawDkIIFoZhJ9ippjxW0
	9qeU0I8Tf2/y+XLGtIrYOdm1aNDwrulQNrZzbuxzZ2FNITkwfsQYBL8UU9TKsPzgrEeq
	ZO6g==
X-Gm-Message-State: APjAAAUvxuOA09uZB6pcdyhFOpXjQ+A0tF0Yf2AQ3x3CIsnXJoDgFyA/
	TbN2kbNYb9DVtffyDxEDwusIKbZmQM4=
X-Google-Smtp-Source: APXvYqwe4exToZXzU9T7f5JKxz0o3wpqrVnAlp+dW9FGVRdWFAxiTIoD7RD2DkZa/UG0nIL/qYL8cA==
X-Received: by 2002:aa7:9116:: with SMTP id 22mr1348838pfh.165.1555745729098; 
	Sat, 20 Apr 2019 00:35:29 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:31 -1000
Message-Id: <20190420073442.7488-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 27/38] tcg/aarch64: Support vector absolute
 value
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073431.LHOtsrDZZhmkMQaf-xiRJCrYljSmeHfO0EalKAuw1jE@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 +-
 tcg/aarch64/tcg-target.inc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 21d06d928c..e43554c3c7 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -132,7 +132,7 @@ typedef enum {
 #define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 7d2a8213ec..cf891defd4 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -554,6 +554,7 @@ typedef enum {
     I3617_CMGE0     = 0x2e208800,
     I3617_CMLE0     = 0x2e20a800,
     I3617_NOT       = 0x2e205800,
+    I3617_ABS       = 0x0e20b800,
     I3617_NEG       = 0x2e20b800,
 
     /* System instructions.  */
@@ -2205,6 +2206,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_neg_vec:
         tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
         break;
+    case INDEX_op_abs_vec:
+        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
+        break;
     case INDEX_op_and_vec:
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
@@ -2316,6 +2320,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_andc_vec:
     case INDEX_op_orc_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_not_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_shli_vec:
@@ -2559,6 +2564,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-- 
2.17.1


