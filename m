Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE9C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3381E20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIqBnWL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3381E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbrT-0001fS-2w
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcV-0002YU-Ls
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcU-0001cl-GL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:03 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcU-0001b3-A1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:02 -0400
Received: by mail-pf1-x442.google.com with SMTP id i13so3553596pfe.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cv1t9pmvTM2or2y2OW8+tePDhkWPmqSM7xnDl7FKLbM=;
 b=uIqBnWL8T4v191boSmUZwB494xE/PGFRifYhV43jeTNSJ3Cj5Mm43BNKjSeUAl55sw
 vZpHh6nj8aEaZFog2zlzPCeedO3UXD8V9+nLMzCuqI9iircm7N7FIdUre1kskonwCdgr
 KBHtgE1vg8AQRYnz74dth6UCBR9+I222bWevRB9nK1VYtmgZ4rIND3oCiHe1/TrhKiRj
 IGGoyLmmMUQPujB2Rf9iBo5fch/Cxcbj0DMTZuam8fRBKKxY0j1JMG/s5Fbf0dobOhFe
 8SVvRMM1qrpW8VkmErq1AKHlE96DpetQ8FrjlFbH2hHMWpY8JvoWgRElvU/Kt2HJGreR
 6S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cv1t9pmvTM2or2y2OW8+tePDhkWPmqSM7xnDl7FKLbM=;
 b=cD5NE3WDJ7J4ulLw8t5WPRLYs8iMeZVZX2+kbvHesJmg9WZhFDyFOb4XQLyMPwHp7K
 psUq+VSe18iO9KlrPG5TIqKYFGZdwG0C6LhanICRclVTSj/X4xPp/Js47I+akgsjvkz7
 fIVEGxA0LT7uneqpwvE4x3EON3/Wtgp6F2MfTPzNb7RmTrj6Iew+pvXAFyO57OxuE8yx
 8KUSLxTpfOgxPwnSWWRzkrRvpY9gy73N9oI2Qxkq3u7uOiYuY/kF0Bxl18hAJv/gEohV
 czJqYK2GjIEKRtut/xlcpdTSs+rGF4sJRhmJ4dO0rjNCjWYlWGIaWFCm/m49y+SmKAcV
 r5QA==
X-Gm-Message-State: ANhLgQ0x0JEoLA+FQi7YU4tit+wViFT2Mm7Xc30eOrCxv+zm6PSmhNHa
 q5FJLDhvoZkmsgfdkYMva+u59GPGnjE=
X-Google-Smtp-Source: ADFU+vt42cA3UfdHbYZGsk8oAxIRBhVuTro4FBG3J6f9YDSKvCyVbgXzqvmyUd8xI8so8TUdQnDSag==
X-Received: by 2002:a63:e544:: with SMTP id z4mr10927219pgj.174.1585264140810; 
 Thu, 26 Mar 2020 16:09:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/31] target/arm: Tidy SVE tszimm shift formats
Date: Thu, 26 Mar 2020 16:08:23 -0700
Message-Id: <20200326230838.31112-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

Rather than require the user to fill in the immediate (shl or shr),
create full formats that include the immediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 04bf9e5ce8..440cff4597 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -151,13 +151,17 @@
 @rd_rn_i6       ........ ... rn:5 ..... imm:s6 rd:5             &rri
 
 # Two register operand, one immediate operand, with predicate,
-# element size encoded as TSZHL.  User must fill in imm.
-@rdn_pg_tszimm  ........ .. ... ... ... pg:3 ..... rd:5 \
-                &rpri_esz rn=%reg_movprfx esz=%tszimm_esz
+# element size encoded as TSZHL.
+@rdn_pg_tszimm_shl  ........ .. ... ... ... pg:3 ..... rd:5 \
+                    &rpri_esz rn=%reg_movprfx esz=%tszimm_esz imm=%tszimm_shl
+@rdn_pg_tszimm_shr  ........ .. ... ... ... pg:3 ..... rd:5 \
+                    &rpri_esz rn=%reg_movprfx esz=%tszimm_esz imm=%tszimm_shr
 
 # Similarly without predicate.
-@rd_rn_tszimm   ........ .. ... ... ...... rn:5 rd:5 \
-                &rri_esz esz=%tszimm16_esz
+@rd_rn_tszimm_shl   ........ .. ... ... ...... rn:5 rd:5 \
+                    &rri_esz esz=%tszimm16_esz imm=%tszimm16_shl
+@rd_rn_tszimm_shr   ........ .. ... ... ...... rn:5 rd:5 \
+                    &rri_esz esz=%tszimm16_esz imm=%tszimm16_shr
 
 # Two register operand, one immediate operand, with 4-bit predicate.
 # User must fill in imm.
@@ -290,14 +294,10 @@ UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
 ### SVE Shift by Immediate - Predicated Group
 
 # SVE bitwise shift by immediate (predicated)
-ASR_zpzi        00000100 .. 000 000 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
-LSR_zpzi        00000100 .. 000 001 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
-LSL_zpzi        00000100 .. 000 011 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shl
-ASRD            00000100 .. 000 100 100 ... .. ... ..... \
-                @rdn_pg_tszimm imm=%tszimm_shr
+ASR_zpzi        00000100 .. 000 000 100 ... .. ... .....  @rdn_pg_tszimm_shr
+LSR_zpzi        00000100 .. 000 001 100 ... .. ... .....  @rdn_pg_tszimm_shr
+LSL_zpzi        00000100 .. 000 011 100 ... .. ... .....  @rdn_pg_tszimm_shl
+ASRD            00000100 .. 000 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
 
 # SVE bitwise shift by vector (predicated)
 ASR_zpzz        00000100 .. 010 000 100 ... ..... .....   @rdn_pg_rm
@@ -401,12 +401,9 @@ RDVL            00000100 101 11111 01010 imm:s6 rd:5
 ### SVE Bitwise Shift - Unpredicated Group
 
 # SVE bitwise shift by immediate (unpredicated)
-ASR_zzi         00000100 .. 1 ..... 1001 00 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shr
-LSR_zzi         00000100 .. 1 ..... 1001 01 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shr
-LSL_zzi         00000100 .. 1 ..... 1001 11 ..... ..... \
-                @rd_rn_tszimm imm=%tszimm16_shl
+ASR_zzi         00000100 .. 1 ..... 1001 00 ..... .....  @rd_rn_tszimm_shr
+LSR_zzi         00000100 .. 1 ..... 1001 01 ..... .....  @rd_rn_tszimm_shr
+LSL_zzi         00000100 .. 1 ..... 1001 11 ..... .....  @rd_rn_tszimm_shl
 
 # SVE bitwise shift by wide elements (unpredicated)
 # Note esz != 3
-- 
2.20.1


