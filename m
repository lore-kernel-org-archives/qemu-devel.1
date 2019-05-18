Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6DC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08E520873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJOYH0Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08E520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4ht-0006aX-3g
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:09:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dK-0002lS-Gf
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b8-0002m1-FP
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b7-0002lH-PN
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:21 -0400
Received: by mail-pf1-x442.google.com with SMTP id s11so5235312pfm.12
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xoXIkCrK3V7BH4MhmjLPxOrcr1ayi9bYK48w1V2yt0Q=;
	b=kJOYH0VjIG7gZVYODI9E/MlwlsNMuX8r9npnryj3scJ5lTguCR+yzEFTix1GMlKQDu
	yGEuFcyjDNGwEGk3V3fMExRNo1B7JEDsbdPJ8om1LuHKXeZ1R+mhZupD/i5WCvsp5xxz
	1Gw9aPpYOFkFi58rgX54H3612WNhDcAYmZMMGuO4isj7t1pkUE0IVwiDvTr2x7+n7qjw
	Vfv6y2LxVSiDvAjnOPc+Yb5eWfnksAw4SzZ7ksq8BouURkp95J8V1+TnE6+dWcvCrKCk
	wu81XHwHJK8bbMpGKnlFYbxOEJ2SIr+uhBbkXIrYqrspmqiaWObtF2OLn3Ec85XnDMtP
	1mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xoXIkCrK3V7BH4MhmjLPxOrcr1ayi9bYK48w1V2yt0Q=;
	b=r3kRDiwG3WNEmJ7cIhcKtJ09H6LIQ3EGjmBBmFUabdd41c2mwNfLHAo7vaBLpRpg6y
	YeiDJab5P0y7w1vXmS21Mef+JQ2unGZ5vuILLr7xa2OuSKI1YvsU5JvkdPjRMqYSCCma
	oWtVfkLfEK34Z5u29QPC2DrlaNN007JCa7ISZRBvFBoA9ZLhrHpHamkY8y18MyqPyty1
	WGF9ZnyZRHri8jg51o4WRHNZICRvLorlcSOUCqUWVxkRzbNdoZ9PEZBbujNffWWIrAi/
	MIPR/ALjdU0PLw8p7BZvWHi4sUVeY6tMPHTaqCHBkHoa0VItWzcMJVPyRz/ryUgjWclZ
	LDKw==
X-Gm-Message-State: APjAAAXr7gcbTs1vN3LLeO8agDELpEItdm0P8g85WyPIdqFepmlhTpgc
	nBAZPnxQKDw95VpN7tTsty/2poLMUbA=
X-Google-Smtp-Source: APXvYqzy0MyJcIBydTeMkUkBWEY+ryeT8VFx+ErSm7cUYn0OnYnrbcncResptwjLOsQNmBP/PI9Fnw==
X-Received: by 2002:aa7:8dc3:: with SMTP id j3mr69600746pfr.141.1558206140057; 
	Sat, 18 May 2019 12:02:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:57 -0700
Message-Id: <20190518190157.21255-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 16/16] tcg/i386: Use MOVDQA for TCG_TYPE_V128
 load/store
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This instruction raises #GP, aka SIGSEGV, if the effective address
is not aligned to 16-bytes.

We have assertions in tcg-op-gvec.c that the offset from ENV is
aligned, for vector types <= V128.  But the offset itself does not
validate that the final pointer is aligned -- one must also remember
to use the QEMU_ALIGNED() attribute on the vector member within ENV.

PowerPC Altivec has vector load/store instructions that silently
discard the low 4 bits of the address, making alignment mistakes
difficult to discover.  Aid that by making the most popular host
visibly signal the error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6ec5e60448..c0443da4af 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1082,14 +1082,24 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         }
         /* FALLTHRU */
     case TCG_TYPE_V64:
+        /* There is no instruction that can validate 8-byte alignment.  */
         tcg_debug_assert(ret >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVQ_VqWq, ret, 0, arg1, arg2);
         break;
     case TCG_TYPE_V128:
+        /*
+         * The gvec infrastructure is asserts that v128 vector loads
+         * and stores use a 16-byte aligned offset.  Validate that the
+         * final pointer is aligned by using an insn that will SIGSEGV.
+         */
         tcg_debug_assert(ret >= 16);
-        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx, ret, 0, arg1, arg2);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQA_VxWx, ret, 0, arg1, arg2);
         break;
     case TCG_TYPE_V256:
+        /*
+         * The gvec infrastructure only requires 16-byte alignment,
+         * so here we must use an unaligned load.
+         */
         tcg_debug_assert(ret >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx | P_VEXL,
                                  ret, 0, arg1, arg2);
@@ -1117,14 +1127,24 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         }
         /* FALLTHRU */
     case TCG_TYPE_V64:
+        /* There is no instruction that can validate 8-byte alignment.  */
         tcg_debug_assert(arg >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVQ_WqVq, arg, 0, arg1, arg2);
         break;
     case TCG_TYPE_V128:
+        /*
+         * The gvec infrastructure is asserts that v128 vector loads
+         * and stores use a 16-byte aligned offset.  Validate that the
+         * final pointer is aligned by using an insn that will SIGSEGV.
+         */
         tcg_debug_assert(arg >= 16);
-        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx, arg, 0, arg1, arg2);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQA_WxVx, arg, 0, arg1, arg2);
         break;
     case TCG_TYPE_V256:
+        /*
+         * The gvec infrastructure only requires 16-byte alignment,
+         * so here we must use an unaligned store.
+         */
         tcg_debug_assert(arg >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx | P_VEXL,
                                  arg, 0, arg1, arg2);
-- 
2.17.1


