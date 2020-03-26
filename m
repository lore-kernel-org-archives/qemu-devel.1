Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B055C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CED20658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCT8eHrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CED20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbgO-0000Fx-Aa
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcQ-0002Jk-Ha
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcP-0001Te-EF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcP-0001SB-8l
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:57 -0400
Received: by mail-pg1-x52e.google.com with SMTP id o26so3638237pgc.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sz8Q6/lROF919J+K+cTqN6AeyEkEwGuAjIPol0tSqWA=;
 b=bCT8eHrH03fihfc4mys2UWYgxhCZJ3Eapf7D7S00Lg9bWrQGq0DSmu744se0BHLjGh
 DwuCyP4cypLCDASWuWTY6OYPCIoJP1OLzkFkhNICLoiZyEoLV17lB9IIWLuilfQ8FFDE
 HVOdsAKdSfZrHcS5MnA6JlC/maqVdgt+OfI5+ajF4MwkVuONJgvrmm8uUa6wfnwxaza/
 YWdK9bCWF9lafluE/31aNF/sgdtqLlWBnUQ/1YZQWTbPdfm+A+sFngvccHk+p8nIkYhi
 m2BdmtW0TikIeH+bZkBbXm/V01DSVsfBIb3TonHZ2I0JUU56JrX01i/B8IKv7jBzbOKD
 FumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sz8Q6/lROF919J+K+cTqN6AeyEkEwGuAjIPol0tSqWA=;
 b=bVN4zZvwj8pA3KvftM9AKQ4vgD0P6Sqw1PFO8t/H+Gvr1IaFR0bs/zR8IxNqPrxScW
 Be5yY8J6fhtw2ZAquapwUqv2kZlG4uwgYkrbNmA5ljkFB+9MCQWB1LoSuTrdNajd7Sqq
 A9NdeW/8a77zW0wtextgA1xIrelHooNBmosQMjlHYo+EpswoRM9A496nl3/0AsdWoY8r
 CacJ/LMfSIENMt7HolHuG7swz6zfWU2x8isY6bw3Iv+2Dj/f4I4rnhr6zC9q3kwU2giA
 AoMr5SNkDlqIAAkOmspYsTd517jFca7NLHRooJ8P+Vpj6JNWsmo3Hq+BYDyMzoHYSUJG
 Bpsw==
X-Gm-Message-State: ANhLgQ29f8hgYUy8gLGxSeKXlSkLPr3Lgyfo66SgXNpYcFb9xsqdMbTR
 QuL5u66ueSn5X4D9oTQrvedtqpdZtSc=
X-Google-Smtp-Source: ADFU+vufQa/VgUXFEoKcEMOTG6Rk0bxrgJP56bBnhXIWWQTqr/kGxpV35bkjBKY1YGqrGvfEIQ72dw==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr11080157pgk.269.1585264135783; 
 Thu, 26 Mar 2020 16:08:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/31] target/arm: Implement SVE2 integer add/subtract
 interleaved long
Date: Thu, 26 Mar 2020 16:08:19 -0700
Message-Id: <20200326230838.31112-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 7 +++++++
 target/arm/translate-sve.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a239fd3479..8d5f31bcc4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -109,6 +109,7 @@
 
 # Three operand, vector element size
 @rd_rn_rm       ........ esz:2 . rm:5 ... ... rn:5 rd:5         &rrr_esz
+@rd_rm_rn       ........ esz:2 . rn:5 ... ... rm:5 rd:5         &rrr_esz
 @pd_pn_pm       ........ esz:2 .. rm:4 ....... rn:4 . rd:4      &rrr_esz
 @rdn_rm         ........ esz:2 ...... ...... rm:5 rd:5 \
                 &rrr_esz rn=%reg_movprfx
@@ -1180,3 +1181,9 @@ SABDLB          01000101 .. 0 ..... 00 1100 ..... .....  @rd_rn_rm
 SABDLT          01000101 .. 0 ..... 00 1101 ..... .....  @rd_rn_rm
 UABDLB          01000101 .. 0 ..... 00 1110 ..... .....  @rd_rn_rm
 UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
+
+## SVE2 integer add/subtract interleaved long
+
+SADDLBT         01000101 .. 0 ..... 1000 00 ..... .....  @rd_rn_rm
+SSUBLBT         01000101 .. 0 ..... 1000 10 ..... .....  @rd_rn_rm
+SSUBLBT         01000101 .. 0 ..... 1000 11 ..... .....  @rd_rm_rn # SSUBLTB
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ee8a6fd912..accb74537b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6051,3 +6051,6 @@ DO_SVE2_ZZZ_TB(SABDLT, sabdl, true, true)
 DO_SVE2_ZZZ_TB(UADDLT, uaddl, true, true)
 DO_SVE2_ZZZ_TB(USUBLT, usubl, true, true)
 DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
+
+DO_SVE2_ZZZ_TB(SADDLBT, saddl, false, true)
+DO_SVE2_ZZZ_TB(SSUBLBT, ssubl, false, true)
-- 
2.20.1


