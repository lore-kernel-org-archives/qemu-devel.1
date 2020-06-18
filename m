Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C59EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4531921883
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdpzleGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4531921883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmPv-0004VY-F5
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAC-0004vC-By
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmA8-0002Z1-9L
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id h10so2320586pgq.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0RZoidkINKk+4kSs+3+p0XQ23yggd+OITaADAOtdoSQ=;
 b=WdpzleGlCy8bwgXaTGEstzgWarF1p0trcqnl5Ic7uXErpKv3IqDiKeD1MeZWx0lxFR
 HViZj0fL9V2F32F4FwTh9ccZ6aWTaDzdwkla6zsgq+xK6MFjGQzEzN7QMduy5afWr34b
 OHlPL9NRuGxlw0BR0ZpuswS7oM/Og2VGclH/Mpi3tdY+EUfvi06OglPOsOxIexMZOKkB
 HZ2dwZNZW3GaM/y2+rRyYFwjXptnuZUX0iHehJGxk9C7muT/KpOr4hpIZFNtHEVaGBl2
 ePKCO1+bwz067626lHm9aXxCT7BBAPMD44hEyWqrYj2m3+hMFM4+jIDqdAFguZZVjwrx
 fhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0RZoidkINKk+4kSs+3+p0XQ23yggd+OITaADAOtdoSQ=;
 b=cnvg4PnedGifBKqDGklHhsNT33Tgym8EPW2vlKywERA7uCvFhKEzYMPZl6bqCIVEyp
 u8iOareqbSbW2j4YY1OLlMw9XZ/zUuWmeHZbbSzavHGVATH0StWW7NCDVd/IyVA8iJkR
 YnopYBII2pq59ZwrGmFiBb41y5wWRWA/3Ej3udUR57fI1HQs/U7xaIZIeE/pnbHwF+a5
 ADo5oyHKmNGJPdE8dhHH/8xV4S+448mldRvty42IplQKdlkdjhONlj+7IyOohcoM/yJl
 wMTeYhGtBIti2em2f9TbztjB/udVcVQ+DgH6mkHcpxuAwD7PHp0qnOc2H07jtO9+7nue
 YYLA==
X-Gm-Message-State: AOAM531pZ8U1p2Bk7qVDxQQW8sU0YiLLSpmxbRNuIo+RTVNikPLb7cuF
 mI9IjWOiCFCbgZWZy5koqPfVKIh9KNk=
X-Google-Smtp-Source: ABdhPJym2mQgDN/Yany/nEOzZJxpH8Y/6HRDSTTbsocFS/zFiiXQyCBWf3fTix5X704BbtJqdzfJWA==
X-Received: by 2002:a62:1b82:: with SMTP id b124mr1914290pfb.172.1592454506533; 
 Wed, 17 Jun 2020 21:28:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l134sm1154412pga.50.2020.06.17.21.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:28:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 029/100] target/arm: Tidy SVE tszimm shift formats
Date: Wed, 17 Jun 2020 21:25:33 -0700
Message-Id: <20200618042644.1685561-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
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
index 079ba0ec62..417b11fdd5 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -150,13 +150,17 @@
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
@@ -289,14 +293,10 @@ UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
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
@@ -400,12 +400,9 @@ RDVL            00000100 101 11111 01010 imm:s6 rd:5
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
2.25.1


