Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2558C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D442087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBKKszkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D442087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHktO-00038y-Pp
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:58:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012q-IL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000nG-FA
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0000Px-7j
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pl1-x62c.google.com with SMTP id w23so3539961ply.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=R0QqxrQEMqfALEw2bMQE+5E2LW+Mhp5XpDv3PusuZQk=;
	b=qBKKszkzqmZLSpPi+dn+VAqtu/jNi1nmj6cL11ZW3BvZKYBebX6Op4paK4F2zm/0wv
	TH1CNck2bfDHz+B4beP3mczruHihNlVE6sQz0XRN3oFnhVcTm5V0zMl4HA1rsD4O+9RJ
	8qEIbV5wIx2pZgzJ5N3rzcjm4Q5bAC9VjshX6FN5M9jnAg3qLBRWoeWkZ8CUuEfn5gL1
	xF2vAhdn1VshTdNbVCd05D8ZAPydL37RCDy1W4ZFbNCPanzPorUyKV22V0UktDt+4+f7
	oaxx2gSD1wV+Y3ROQlmghyZTQmaxGX3RYuaOskKUben/qcNPcyOqomBRtVXKuT3jNUjW
	vvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=R0QqxrQEMqfALEw2bMQE+5E2LW+Mhp5XpDv3PusuZQk=;
	b=PvS/Ho4yemB2SaA5BosgV17tfsBOscSafIx0sSQ03nM4Y4RkYKUm32nxeUNybeXVkp
	cOudvT/1t//yNftMKcMmdixTtR+KhMeKHNR9syBkj9/PXZrBsIUbA7+jUJYa9pCdTnWu
	ZLSSG8e2Os/nGX9OvP8LggcaBOg9R4Q7U5g3gfzOSHkW9F/POLKYwdHTv2H3T3rPKtoP
	1znJdJxupMMocQF19altjXI78l3+wHTsX1ObHp+AczRPckRaPVgt9OP5wS9NVj8Bzww6
	3ZaiAT0HwJNOMmdBrXq8W3zeQWMbxzx4uwW0Hgjlle2ugNCrmAhagk6yEj3Jl+covSAj
	hBVQ==
X-Gm-Message-State: APjAAAV2CfZMt3CUkpJLPRarEgIUKeZevYKH897lLSGJI/XJ0ABEbKXT
	FFnrYqomY4oOwHgVVdHxP8gt2AKRx14=
X-Google-Smtp-Source: APXvYqwghTj5Nl1xZMKzljOeShUko7pPThAioDrcTbMU8lLwnYls6ZhxHvtn4icxxQexN2ZozL4MPQ==
X-Received: by 2002:a17:902:2aa6:: with SMTP id
	j35mr2390510plb.236.1555745742505; 
	Sat, 20 Apr 2019 00:35:42 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:40 -1000
Message-Id: <20190420073442.7488-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62c
Subject: [Qemu-devel] [PATCH 36/38] tcg: Expand vector minmax using
 cmp+cmpsel
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
Message-ID: <20190420073440.5VX0UhYwe-8_UzZPjq3kUKjziE-1FcxGDkWfrLrr14k@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c |  8 ++++++++
 tcg/tcg-op-vec.c  | 19 +++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index e7029d26f4..dddb00719a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -99,6 +99,14 @@ static bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_cmpsel_vec:
             /* Fallback expansion uses only required logial ops.  */
             continue;
+        case INDEX_op_smin_vec:
+        case INDEX_op_smax_vec:
+        case INDEX_op_umin_vec:
+        case INDEX_op_umax_vec:
+            if (tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece)) {
+                continue;
+            }
+            break;
         default:
             break;
         }
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 5868a51270..43abeb0674 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -520,24 +520,35 @@ void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_op3_nofail(vece, r, a, b, INDEX_op_ussub_vec);
 }
 
+static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
+                      TCGv_vec b, TCGOpcode opc, TCGCond cond)
+{
+    if (!do_op3(vece, r, a, b, opc)) {
+        TCGv_vec t = tcg_temp_new_vec_matching(r);
+        tcg_gen_cmp_vec(cond, vece, t, a, b);
+        tcg_gen_cmpsel_vec(vece, r, t, a, b);
+        tcg_temp_free_vec(t);
+    }
+}
+
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smin_vec, TCG_COND_GT);
 }
 
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umin_vec, TCG_COND_LTU);
 }
 
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smax_vec, TCG_COND_GT);
 }
 
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umax_vec, TCG_COND_GTU);
 }
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-- 
2.17.1


