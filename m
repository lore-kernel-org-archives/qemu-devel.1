Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0BDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079C520797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaSav1qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079C520797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0JO-0005AT-3v
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzti-0003gD-9A
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzta-0007lu-DE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so17980740wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVy88bjQ6oUom6zlEL/l8GFHzZ3l3YhMBHhw5mIWpLU=;
 b=UaSav1qT/HF9VDXaf7GvktosHSLrfpM5XL+7ocwJoJ6W/6T0siB7ag0zifJ/3bnvJM
 oAcYheet78yFETeTDYtaWXI02K+jWMHTzPKzKL4IcICDflysRfz67XeuCx4k6CLi19dd
 /nwhqq2pTCtflxRWoc2hakUxWOz3YvliKcCmNktT3slVtgAWV2edPQjEeSCimBPwr8HA
 2vsteglTKaQKdKbM1WBv0v/PllACDdZ9rQr/59YADuAy6Y5mvIFhzhQvPt55IpFcc5b4
 9RWvp/lsi+SYqppMyPHsu3paOhxOMWCYEze4QbS4nNh6IggUEkvYuSVX150n9bWQMkKS
 uaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVy88bjQ6oUom6zlEL/l8GFHzZ3l3YhMBHhw5mIWpLU=;
 b=naPIOpIYZAvU5h5OC5ZCeyZZo3lHmsSx/zmdel5qEsdAyW+4qUA2291AUUXHEZsFfx
 LI9Gv4Xiu6i9ncTpdwbnu9IsyV6kVl1pddrNuMUx71qdhlEv6CZOtTcvvYeawENcERMW
 ymzs/1pbrYmUuRPBJJd9Olwk0ZEYW/POnp5GIh10cTCMrB5RyBw75SqMT2lgs4mhlHNV
 1bV+Isexali6Muu0ThIPBZIT7R+JcBo9kQk4uBxrGn4NQ+6K5puC0ejDg3Ur6tdlTU2c
 c0d839xnVENI0O7Dl2Ef9kSvoMfchm3sCTlW/GANgaezy6bKfh5UnDHeXc7YVoDZT5TL
 9g1w==
X-Gm-Message-State: AOAM531SOSkoQvMDncjZJB/bnymT3H82KIwfmGS/8Qvxnz+6AtGGgniw
 oew+wg4I5KYtWcZE5lCqxQA0Ig==
X-Google-Smtp-Source: ABdhPJwQa0GzV+Pt+sSH2vIoYurYdWY/bhKwBzBJRBmWcT9qSb8+KVEk7LUcNe/c0nTrrMUIfGVtNQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr11028771wmh.94.1602517073036; 
 Mon, 12 Oct 2020 08:37:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/10] target/arm: Make the t32 insn[25:23]=111 group
 non-overlapping
Date: Mon, 12 Oct 2020 16:37:40 +0100
Message-Id: <20201012153746.9996-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The t32 decode has a group which represents a set of insns
which overlap with B_cond_thumb because they have [25:23]=111
(which is an invalid condition code field for the branch insn).
This group is currently defined using the {} overlap-OK syntax,
but it is almost entirely non-overlapping patterns. Switch
it over to use a non-overlapping group.

For this to be valid syntactically, CPS must move into the same
overlapping-group as the hint insns (CPS vs hints was the
only actual use of the overlap facility for the group).

The non-overlapping subgroup for CLREX/DSB/DMB/ISB/SB is no longer
necessary and so we can remove it (promoting those insns to
be members of the parent group).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Just a minor bit of tidying that I did while I was trying to
work out whether the v8.1M loop/branch insns needed to go in
this group. (As it turns out, they don't.)
---
 target/arm/t32.decode | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index d8454bd814e..7d5e000e82c 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -296,8 +296,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
 {
   # Group insn[25:23] = 111, which is cond=111x for the branch below,
   # or unconditional, which would be illegal for the branch.
-  {
-    # Hints
+  [
+    # Hints, and CPS
     {
       YIELD      1111 0011 1010 1111 1000 0000 0000 0001
       WFE        1111 0011 1010 1111 1000 0000 0000 0010
@@ -310,20 +310,18 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
       # The canonical nop ends in 0000 0000, but the whole rest
       # of the space is "reserved hint, behaves as nop".
       NOP        1111 0011 1010 1111 1000 0000 ---- ----
+
+      # If imod == '00' && M == '0' then SEE "Hint instructions", above.
+      CPS        1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
+                 &cps
     }
 
-    # If imod == '00' && M == '0' then SEE "Hint instructions", above.
-    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
-                 &cps
-
     # Miscellaneous control
-    [
-      CLREX      1111 0011 1011 1111 1000 1111 0010 1111
-      DSB        1111 0011 1011 1111 1000 1111 0100 ----
-      DMB        1111 0011 1011 1111 1000 1111 0101 ----
-      ISB        1111 0011 1011 1111 1000 1111 0110 ----
-      SB         1111 0011 1011 1111 1000 1111 0111 0000
-    ]
+    CLREX        1111 0011 1011 1111 1000 1111 0010 1111
+    DSB          1111 0011 1011 1111 1000 1111 0100 ----
+    DMB          1111 0011 1011 1111 1000 1111 0101 ----
+    ISB          1111 0011 1011 1111 1000 1111 0110 ----
+    SB           1111 0011 1011 1111 1000 1111 0111 0000
 
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
@@ -351,7 +349,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     HVC          1111 0111 1110 ....  1000 .... .... ....     \
                  &i imm=%imm16_16_0
     UDF          1111 0111 1111 ----  1010 ---- ---- ----
-  }
+  ]
   B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
 }
 
-- 
2.20.1


