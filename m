Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E489AC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B272B2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaViSs1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B272B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaoP-00040H-WB
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad0-0005TL-C5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacw-0004OX-DB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so632831wrk.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4hajnpKFneC9oXevGNiTQq4b67IRN1ocHkswRCYvHPU=;
 b=NaViSs1ZgL5OJGdbKx3IS8JRj8KReaROYoZ1GQ7/pKWZ01UU0H0Zqy7C6J7eb+LaK2
 FKU4QUZDIe+HAgitGetlOeNarO5gZBvRbELJZafy4ih8tTSMMLlyQAWns3o9qKFymjSG
 T6JeMOkHZZJEcgwiPunh/1vpv1fMoxY1Zw8m0r8r7XF1vXSqo2X8msIweztEvp1C8ykM
 yoE4vKfCphgLYW4CH5rxNTV1wQ1oRp29ypd2ts9btKgRQEHU3eJUpEw16wHGOSlVov1a
 OoEi5b5ukpJYRComEZnTSyjmNBU1mQqnm87K317TjQWJr7tM702apCjMHLtesP/vaNwH
 DLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4hajnpKFneC9oXevGNiTQq4b67IRN1ocHkswRCYvHPU=;
 b=MKCUTetw07dRgjCmfmgclQGBtC4vr0ScfaDfVOykzZQlFIb8/959oneYeEKR19glBh
 SzLiUlyK9q+aptCWpuu/OaxgGrERz/Q75QU5wXYNMqJYrMIh9qSI1sOj09BBhUu2pj0+
 flcqrazA2M2yuoTb4fkOxiQASy5kIOTJWO3Gxz1/PtkQK4kKQDcUIzFhlamRE7ux3Qao
 5QXZ+fcvbxYUD02dK89v2zwwyftnQqF1M8becWVGnkPK0s6td9C3oVJ39Lt3gfjXBjvr
 nl1VCIQ81IBpbn0QEUd0C6yvKoJAjG3fRFHrqWbWvQ6nn7iOqnEci0OM0xwJQdF7hddm
 k35A==
X-Gm-Message-State: AOAM532hQeJRAG7s4Q47yVYN5j22PTxPkZ+8xUoVkLZOgXHJXabKmhs6
 K4j/+A8PA33+QBdz9U8Pw54uVZw0YlYY11qW
X-Google-Smtp-Source: ABdhPJxlOpiIivhoqio1Bdtdq2z2XX/4Pi8mXL0YAWer6cT9AKWyIq88BCOkkjuxSAHN9/GckfneAg==
X-Received: by 2002:adf:e982:: with SMTP id h2mr684209wrm.394.1598606692672;
 Fri, 28 Aug 2020 02:24:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/35] target/arm: Tidy SVE tszimm shift formats
Date: Fri, 28 Aug 2020 10:24:09 +0100
Message-Id: <20200828092413.22206-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Rather than require the user to fill in the immediate (shl or shr),
create full formats that include the immediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve.decode | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4f580a25e70..6425396ac1a 100644
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
2.20.1


