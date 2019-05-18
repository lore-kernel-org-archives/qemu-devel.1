Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E4C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4350820873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hk2LWuP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4350820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4i7-0006q0-8L
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:09:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dO-0002nw-U4
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b5-0002kG-Rm
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b4-0002j0-5T
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so5243771pfq.8
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=5pgxUU1cRl5UBw70ixoMtifwIrAs5XS+sRdx95+Fg/g=;
	b=Hk2LWuP2q3y8VWttu/hNazeJeZ7x6dEOuJnRrijJnUA27kNW9XNU7nBa1c2P2YRK1I
	bXSbZh4zrUF3tXfyZ5UsyF2qdSMgiLnoIBAh4yTshNglRJKuIiPYgf5JUKCCYquwOh/0
	Z5Yvy6xplKYn+4CkpL3OQcHYN3ZjFnJ3dxGjT4h0thYpTeqnuXuftfmQxwCNoliXahVZ
	GzXOQRWbmlfx6usZRRj+vtel+fjhqi0MlaMYhkl+F79BQTQnsyIPZnOlSlRJVl/AlzzY
	Y5b5x6XoNpLTHQLA/wswGo/fcgU22WFZq8RRju5nd355CpdmRtpGa2vPETmc3yIrlV3i
	o1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=5pgxUU1cRl5UBw70ixoMtifwIrAs5XS+sRdx95+Fg/g=;
	b=jexrOzbd5xfKIhgLROl1vuk+1jOuVZgKu8aHd9unD70EqeYmKSjinZIKO6St0O9wSC
	yNPusOilL7xfhR1e1ELCfL/kE3HDllyfsjexQc+KH4ijuUNx8WK5WRfJ8kSPBRjCfOPQ
	ZkYCIPlL58k/nMpJ1XXxZAhmDV3g1/HMv9kKGlMcxRw4NqggdmtlNmw9IAbFleIXBXaQ
	8FsIOfwSaC5UR+tL1SbgDdaeasSEHg9szezGUTCvU6JtCCZCNxtBGGpVBIgwawQN/0FP
	Lom+6w/iyOzbI16ITzIgT8Wd3ykSu+E+J/h2i/YQEhYks4aaP4v++tU/1sm/izv185cS
	PKdw==
X-Gm-Message-State: APjAAAWxBxRGy6wX88XEZuki7FvWOvxtDJcWOc84+AVrpnlW9NZj4UP6
	YXcn2pQg4WVFNhJDuGmM/EtaHyITpug=
X-Google-Smtp-Source: APXvYqxMml5drvLqg8yZrKFre7NUGiT+MaMIoZDwNnXd0j2kr/rGG1O4a7XMEYEvSB/vNQ3RwoVLqA==
X-Received: by 2002:a62:3085:: with SMTP id
	w127mr46884150pfw.170.1558206136676; 
	Sat, 18 May 2019 12:02:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:54 -0700
Message-Id: <20190518190157.21255-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 13/16] tcg/aarch64: Use MVNI in tcg_out_dupi_vec
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

The compliment of a subset of immediates can be computed
with a single instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1422dfebe2..0b8b733805 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -494,6 +494,7 @@ typedef enum {
 
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
+    I3606_MVNI      = 0x2f000400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -838,8 +839,13 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
+        if (is_shimm16(~v16, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            return;
+        }
     } else if (v64 == dup_const(MO_32, v64)) {
         uint32_t v32 = v64;
+        uint32_t n32 = ~v32;
 
         if (is_shimm32(v32, &cmode, &imm8) ||
             is_soimm32(v32, &cmode, &imm8) ||
@@ -847,6 +853,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
             tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
             return;
         }
+        if (is_shimm32(n32, &cmode, &imm8) ||
+            is_soimm32(n32, &cmode, &imm8)) {
+            tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+            return;
+        }
     } else if (is_fimm64(v64, &cmode, &imm8)) {
         tcg_out_insn(s, 3606, MOVI, q, rd, 1, cmode, imm8);
         return;
-- 
2.17.1


