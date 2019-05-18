Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75644C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341482054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbQFSHmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341482054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4kl-00011U-HD
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:12:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dP-0002qF-Kt
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4az-0002h8-3W
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ay-0002gB-UF
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:13 -0400
Received: by mail-pg1-x542.google.com with SMTP id d30so4826165pgm.7
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=cyPCzZg9DUKeW2pqf+eu++K5/1I4IivLKFA9dQuPgvg=;
	b=tbQFSHmv+dDsabC/U32Pcoi0BFI9mPCug1jfNkNmSBElKKsAGb7e+447Idhz2zljiv
	EvxsGRRqscjDRKmwPGa7LgLIl3pJLbsVVRqxEYSLyISJMmnuiDnXdDXk6sniXz4Xezcg
	sXaf8dWQXfN8oncx0MqCvtR4Xb/BhzCHr673aFGaqGWCYoAIeJNtOdlOv+XOFkkOMmvR
	PyOmAJ8OPzw2eo6AtcL7fZggS/7qemeDrFRu0FqZ98ehzMHdhFEphY8loBtcmrg+Zi8x
	YajK9+GBw2mlkHvMlBnqOQJrZEFJN3AZCcBei/Rcs6EEp/b7Z09OdYOSRRp4hFMKCXzh
	jUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=cyPCzZg9DUKeW2pqf+eu++K5/1I4IivLKFA9dQuPgvg=;
	b=Ste4+FlI4P0/L/9vhdiADB2CnRM4skyGMfRpJI0B31FFdVP91Ej0hGbEVpgL3i3H53
	AtfjpMtR9yuLj0biMor3gzHyY3Lqdyvm3zt9zczq0iD7hkjBT6V1p6AauRa8HzABCqEB
	I+9BsuNSv/SNY3tTdKSBing3K0bGIpFGuMj1SzoVeiGRg8Y2rVNb397pUxY17Kh6xDWk
	VuWFllfGtNEhvEnt1GGDUdpM0sit4yH1puYNKSMU5wZvsfSFeraqNolx/Pna/O1rufY+
	Q4LlpjMDK7BQwGiVtSrJvMpPEVkTCsy8NvvXpnYp68AViEiipFll5p+OFc+f8Fdek/ho
	CdyA==
X-Gm-Message-State: APjAAAWhYXtdPqo+hpCFZttb4JKiV5n6rkBethiyRnJO/Y5Ysj+lYeiP
	hjBvgSdiLPw+Sr1GFgllFP0FAMvTI4o=
X-Google-Smtp-Source: APXvYqwtsb98oQBhy1fmkyb8Z8QIWVYUYf5UfMgHrmzMgTRg9ykcPZDJMa0k3XABR552U4UAgBWnSg==
X-Received: by 2002:a63:6907:: with SMTP id e7mr22562145pgc.209.1558206131801; 
	Sat, 18 May 2019 12:02:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.10
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:50 -0700
Message-Id: <20190518190157.21255-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 09/16] tcg/i386: Remove expansion for missing
 minmax
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

This is now handled by code within tcg-op-vec.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index ffcafb1e14..569a2c2120 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3297,7 +3297,6 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
-        return vece <= MO_32 ? 1 : -1;
     case INDEX_op_abs_vec:
         return vece <= MO_32;
 
@@ -3551,25 +3550,6 @@ static void expand_vec_cmpsel(TCGType type, unsigned vece, TCGv_vec v0,
     tcg_temp_free_vec(t);
 }
 
-static void expand_vec_minmax(TCGType type, unsigned vece,
-                              TCGCond cond, bool min,
-                              TCGv_vec v0, TCGv_vec v1, TCGv_vec v2)
-{
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-
-    tcg_debug_assert(vece == MO_64);
-
-    tcg_gen_cmp_vec(cond, vece, t1, v1, v2);
-    if (min) {
-        TCGv_vec t2;
-        t2 = v1, v1 = v2, v2 = t2;
-    }
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
-              tcgv_vec_arg(v2), tcgv_vec_arg(t1));
-    tcg_temp_free_vec(t1);
-}
-
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
@@ -3609,23 +3589,6 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
         expand_vec_cmpsel(type, vece, v0, v1, v2, v3, v4, va_arg(va, TCGArg));
         break;
 
-    case INDEX_op_smin_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GT, true, v0, v1, v2);
-        break;
-    case INDEX_op_smax_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GT, false, v0, v1, v2);
-        break;
-    case INDEX_op_umin_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GTU, true, v0, v1, v2);
-        break;
-    case INDEX_op_umax_vec:
-        v2 = temp_tcgv_vec(arg_temp(a2));
-        expand_vec_minmax(type, vece, TCG_COND_GTU, false, v0, v1, v2);
-        break;
-
     default:
         break;
     }
-- 
2.17.1


