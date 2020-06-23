Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BBF2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOmstwkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BBF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnoxD-0005VV-4q
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok3-00059L-8e
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:34289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojy-0005u6-DQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id z63so10572096pfb.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lFZIBVnnlVZuvCXE23rLh8+qqZ5/2nVCbq1tYJwjFwg=;
 b=vOmstwkxAs/gwrcc72YsEcWqCT3EAiWXwfrqY6qneV2A+eQy8XSggm1VIuogPJRP7h
 dl2od+DNNRJma0JAKOHFzxtH5eCB/hVvyOHe3+mYrDT/0RNYkbKQ/VuH4RP5u/s2tanZ
 7HOH4aj2EMrHn4cVVrVhKFlNAb5Gt8Nv6brsHjRaqJJv4KQRnADXkBOokgRCc/eNq6h3
 Ov0hUIX6R8xnMQoy1UpCV3v73kNSUuybYRJKk33cVM//NRBDVT+HmwTsaGptEw3DSUQv
 GcDiUj2z6PNODRcisM2yeVvkpmnWLZdJMBQip73LCM2osQVoM9RoSVcVd6zXOanoJrTp
 oA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lFZIBVnnlVZuvCXE23rLh8+qqZ5/2nVCbq1tYJwjFwg=;
 b=gtGN3s+0LTC8JP0qeNvDEegGF+vzlT1jyIWZUNGdZjfRNHm+DofYSGt+eW7zA4rBQR
 Hhy8MtzlpehPS1nmFJqSvQkOJSXPv5MTJvJUa02GoAw4CLBifJparboFlhRXM2sGAH5O
 xDByRyzGoM8XcvxXTDE2j24yT77jk5ljdpsikK+bgK6fGlD5xLdhXncf8raa0zSgYOQz
 ZQkyrROcQ9IsB9iE8TwQ70SXNHjKvSoW7QjZRCYXTlTqzRMHGJY+qu6RGvlm4+tOCASU
 IXbBQN/DEwRYjfpb0ny3bnifia9z/gKngMeWvvBC5W11rwyTQm9+0UMAyDc/36z65zPb
 +RmQ==
X-Gm-Message-State: AOAM531cL9m/SbPcY1oX+61FrVHjpH+yPgZBw2u61CT+NPLhF8qpyhum
 g2SmS9ntKa1Cx52ZrJlxt/DVtxXfqVY=
X-Google-Smtp-Source: ABdhPJz0vc219wKhe28hxWiWGtVjOOj5U383TFk1qoIzhO+wyR9c3Jp/FAhvERhEFHj4339gzumKZg==
X-Received: by 2002:a63:1207:: with SMTP id h7mr18448438pgl.241.1592941072798; 
 Tue, 23 Jun 2020 12:37:52 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 38/45] target/arm: Complete TBI clearing for user-only for
 SVE
Date: Tue, 23 Jun 2020 12:36:51 -0700
Message-Id: <20200623193658.623279-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are a number of paths by which the TBI is still intact
for user-only in the SVE helpers.

Because we currently always set TBI for user-only, we do not
need to pass down the actual TBI setting from above, and we
can remove the top byte in the inner-most primitives, so that
none are forgotten.  Moreover, this keeps the "dirty" pointer
around at the higher levels, where we need it for any MTE checking.

Since the normal case, especially for user-only, goes through
RAM, this clearing merely adds two insns per page lookup, which
will be completely in the noise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ad974c2cc5..382fa82bc8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3966,14 +3966,16 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    *(TYPEE *)(vd + H(reg_off)) = (TYPEM)TLB(env, addr, ra);                \
+    *(TYPEE *)(vd + H(reg_off)) =                                           \
+        (TYPEM)TLB(env, useronly_clean_ptr(addr), ra);                      \
 }
 
 #define DO_ST_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TLB(env, addr, (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                 \
+    TLB(env, useronly_clean_ptr(addr),                                      \
+        (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                            \
 }
 
 #define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
@@ -4091,6 +4093,19 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
     int flags;
 
     addr += mem_off;
+
+    /*
+     * User-only currently always issues with TBI.  See the comment
+     * above useronly_clean_ptr.  Usually we clean this top byte away
+     * during translation, but we can't do that for e.g. vector + imm
+     * addressing modes.
+     *
+     * We currently always enable TBI for user-only, and do not provide
+     * a way to turn it off.  So clean the pointer unconditionally here,
+     * rather than look it up here, or pass it down from above.
+     */
+    addr = useronly_clean_ptr(addr);
+
     flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
                                &info->host, retaddr);
     info->flags = flags;
-- 
2.25.1


