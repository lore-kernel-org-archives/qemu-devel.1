Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BDC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1103521479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tP+nEY2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1103521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkg6-0008Ro-6z
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:44:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-00010D-5X
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXU-0000kq-CU
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXT-0000CP-Hn
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id y3so3581595pgk.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wJcaUBM/vMrRB+8pVZI+UVwqYtaFLioXLl9e3hXIiDY=;
	b=tP+nEY2ADU1xwbMpw7bbjzbv9adN9LWg3TjcNdZcu0NPliDIiq7oQHE0tCjV5EkVyd
	Zf2md4I7vWO2iVJMGdaXSYhofnMifuzBBix1hyhKpFk3U9EV6wZW4q853cX/+sSCaNcF
	jIx72Dc3azHiQww3t+hMJwPVjYHMmCZbQJNS2qmr/JRUJoI4P9F2YFS8hTdIzlH2TUSI
	ZiekbYnirFSbtMb4kfyIwPzrjhpO8Wrs5jig6lR1zdYQjCFXNGrbE3+OcIz/oZAXiBrS
	dRWIGPrt/c61YgDxze5dIV5RrGT9xEUjmjNv0GQVnNKfWVNQP3GTsPaaMR+qddLXR4wQ
	73gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wJcaUBM/vMrRB+8pVZI+UVwqYtaFLioXLl9e3hXIiDY=;
	b=hdyu2tG3XUchd3DWCe5bwnnabsmGN2M5nxeze/gk2+bJC+kgt79kfoH9R1IQdW1GSJ
	icCEKGZLBgtEF9SZbVYVvAs892nsylaTWdgUbGXTS0CfyYIZxV2yfk8ocO/ca25W95KB
	yVIfQO5jiS+PT7TUgA1txpY8O1pdHhPhgsj70qopNWjsaJX7reMsOTYB/87qxWriXPzH
	HPQFvF5q4kEgrSiZAh+0Lu/kitaacbGPZ01uZfCwy9hnODaH12SfDUWRBK9xS3yorxLV
	QRNp0HgjyGSq/VrEUlDGinswma96IyXFlZi+0RooB+/9LW6wGwnLgkgo4y3nJLFNpS/R
	gZoQ==
X-Gm-Message-State: APjAAAVK/+en+pzEHTCVddmJu+TADud2vH4myTGITW5v6ZOGSLiFtppp
	ftbdZ0HZs4SCzVqP9YWf8PkmMuytQD8=
X-Google-Smtp-Source: APXvYqxgrK+FYqA6YrThe0xh0OylKh8U7D+IdeHshAvs2XWr6Gxm9OjDv00tp3C/qKl7iq+svtSKNg==
X-Received: by 2002:a62:12d0:: with SMTP id 77mr8551481pfs.15.1555745732073;
	Sat, 20 Apr 2019 00:35:32 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:33 -1000
Message-Id: <20190420073442.7488-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 29/38] tcg/i386: Support vector comparison
 select value
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
Message-ID: <20190420073433.-flOQ69PmDiNw3s2UJ0TFAxHCrU1uO1Zhdc9UoYRY60@z>

We already had backend support for this feature, but with a
backend-specific opcode.  Remove the old name, and reorder
the arguments to match the generic opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.opc.h |  1 -
 tcg/i386/tcg-target.inc.c | 13 ++++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 683e029980..acdf96b99d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -190,7 +190,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index e5fa88ba25..d761cca0cd 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -3,7 +3,6 @@
    consider these to be UNSPEC with names.  */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
 DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3dae0bf0c5..50296b4b2f 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2921,13 +2921,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, sub);
         break;
 
-    case INDEX_op_x86_vpblendvb_vec:
+    case INDEX_op_cmpsel_vec:
         insn = OPC_VPBLENDVB;
         if (type == TCG_TYPE_V256) {
             insn |= P_VEXL;
         }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
-        tcg_out8(s, args[3] << 4);
+        tcg_out_vex_modrm(s, insn, a0, a2, args[3]);
+        tcg_out8(s, a1 << 4);
         break;
 
     case INDEX_op_x86_psrldq_vec:
@@ -3223,7 +3223,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sari_vec:
     case INDEX_op_x86_psrldq_vec:
         return &x_x;
-    case INDEX_op_x86_vpblendvb_vec:
+    case INDEX_op_cmpsel_vec:
         return &x_x_x_x;
 
     default:
@@ -3241,6 +3241,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
+    case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
         return -1;
@@ -3537,9 +3538,7 @@ static void expand_vec_minmax(TCGType type, unsigned vece,
         TCGv_vec t2;
         t2 = v1, v1 = v2, v2 = t2;
     }
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
-              tcgv_vec_arg(v2), tcgv_vec_arg(t1));
+    tcg_gen_cmpsel_vec(vece, v0, t1, v1, v2);
     tcg_temp_free_vec(t1);
 }
 
-- 
2.17.1


