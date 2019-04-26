Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FFC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5E3206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BByqt0lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5E3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4n2-0003QH-3Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:37:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aX-00009I-Mz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aW-00076W-Mf
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aW-00072j-Gw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so1892625plp.2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=57LLTjI1nQcm9nBGSTBf3sb093E20lD7cyEUFj3ghB4=;
	b=BByqt0lG9dxC5Aw+SJl20Z1l6u56Mfo19JQu1ynxm2tQQ+d7qvcyfD3rUrKdNw4NFP
	V/iyBOrvX6uIRQuBtNJLWfkTPXuE/OLRW/PLVLTw+aUQOc60ncPZ85JxT+M0r56noJNu
	Zc8seyzRCQ6lt+2NzzaYoDA78fyBBx4Jxs9ANgwZNqNz9TxZ5l8gWYPA9hifVaST3hnA
	JpU8FzJEq7CvyautvrX62zuzAs/2U0dlUdkc2rEIezOyBpDkjzSUHkaH2KldOPVEXy4H
	0UYYYmlK7jldacKJE+x4B2Diq01dBG08lFPVC3Nr1jyK0IKxiPtSdh7c2VPjVJ6zbqPo
	K2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=57LLTjI1nQcm9nBGSTBf3sb093E20lD7cyEUFj3ghB4=;
	b=IXqkDCYU+ka4mpYqzCnfbXw0XwcaF3iN6IPmXeipVRPYJ+VV1HZ4M/WICo+KtPo1JR
	mit0ILUVNT4W0bZiXxXyCEmHtEkBxqrlz9bf2+K/ABJXOqKxE4edlNDTDtMhQ2Jf09sZ
	V0aJSv9VjW2wQwZeShIjPT6bDvbWT4kX2GIemsuN152TE7ecr39MFEeLG6RwdApIBMQ1
	Fxr0Ha00byVxEnzHQZJwmMff+HoMK9TBpqxYJtB3lti1Sn7Amlzyk8KttetEOPd5stjh
	4OoDA1UaRcp699MgUg8qMDtlG+d5Gi671K9tM4D9c+Du2YYAXAwAf4BAra9/gM/n9kZo
	LNlA==
X-Gm-Message-State: APjAAAXv6mGf2RyuH16hW9s/GWeNhkXYRubCqmoKWpavNxQ4qX0aeSVg
	6td3i90OFHylCtTHxHxG60URvnjoZYM=
X-Google-Smtp-Source: APXvYqxLmhUr8GQj9Sz/A8DIDAmyQbsSpMTlo1XB6tONW2XFvxcRcmeOHe3uNjZLo1GajxXQ76ozrA==
X-Received: by 2002:a17:902:b407:: with SMTP id
	x7mr48029005plr.288.1556299479245; 
	Fri, 26 Apr 2019 10:24:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:19 -0700
Message-Id: <20190426172421.27133-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 13/15] tcg/ppc: Allow the constant pool to
 overflow at 32k
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426172419.ub1bLPtCPynjomlVJS1LVwSOhIPsErN-1Dw-ZzycRSY@z>

There is no point in coding for a 2GB offset when the max TB size
is already limited to 64k.  If we further restrict to 32k then we
can eliminate the extra ADDIS instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index c0923ced4f..36b4791707 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -529,7 +529,6 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_insn_unit *target;
-    tcg_insn_unit old;
 
     value += addend;
     target = (tcg_insn_unit *)value;
@@ -540,22 +539,16 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
     case R_PPC_ADDR16:
-        /* We are abusing this relocation type.  This points to a pair
-           of insns, addis + load.  If the displacement is small, we
-           can nop out the addis.  */
-        if (value == (int16_t)value) {
-            code_ptr[0] = NOP;
-            old = deposit32(code_ptr[1], 0, 16, value);
-            code_ptr[1] = deposit32(old, 16, 5, TCG_REG_TB);
-        } else {
-            int16_t lo = value;
-            int hi = value - lo;
-            if (hi + lo != value) {
-                return false;
-            }
-            code_ptr[0] = deposit32(code_ptr[0], 0, 16, hi >> 16);
-            code_ptr[1] = deposit32(code_ptr[1], 0, 16, lo);
+        /*
+         * We are (slightly) abusing this relocation type.  In particular,
+         * assert that the low 2 bits are zero, and do not modify them.
+         * That way we can use this with LD et al that have opcode bits
+         * in the low 2 bits of the insn.
+         */
+        if ((value & 3) || value != (int16_t)value) {
+            return false;
         }
+        *code_ptr = (*code_ptr & ~0xfffc) | (value & 0xfffc);
         break;
     default:
         g_assert_not_reached();
@@ -701,8 +694,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
                        -(intptr_t)s->code_gen_ptr);
-        tcg_out32(s, ADDIS | TAI(ret, TCG_REG_TB, 0));
-        tcg_out32(s, LD | TAI(ret, ret, 0));
+        tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
 
-- 
2.17.1


