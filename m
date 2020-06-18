Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B15C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10B42186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEK3WGfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10B42186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmgr-0007Zr-PC
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCr-0003DI-Pz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:17 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:38130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCo-0003JG-TH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:17 -0400
Received: by mail-pj1-x1032.google.com with SMTP id d6so2079943pjs.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3xtlpb1WwGZiRpO7W3OfThl71V0T/0uQ3DRTvjquBPA=;
 b=PEK3WGfkzkbk/S+s2T8emApTb2CoyDrPCwYi3Ylt0pGzX0EdkJ3nUeZaM4/d/SbMIt
 j2FpPOZ3vT3cEXWiIQgtz3UFuYNzUy3WywfYMRiKBkFBr1pYFOUgjolAdMQFD8kpEFVA
 yzhcnw/YK1dAjRy5YQY1g2PUJ97w8tC4eQK89alD4kFdLSYqrmk++EXwuylFyWDVdCzc
 J1djcRHGYlK5hUJ+9/fjZekoHXEo3UzEANWwCJBdcEYl+dmSqXJ5a3vNQBnKaCq0to5l
 79mvnNrArisa6+0ZOQ/ZuaGXPPghRRbrIH49UZ3vdDjPI81cYS1/Sev+hS5v+KuEIYKr
 TztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3xtlpb1WwGZiRpO7W3OfThl71V0T/0uQ3DRTvjquBPA=;
 b=gRzBvyCTxz0IJKqwUduDbto4+klWbD1EGiJuuswlJI4Lo/uP5V0qOzvoCZ6tOu2v0h
 V7b7xifmB0uxvmkgYXHAHMNoNP0gaxrA1PVfte/Ma5+DsnhPZKEk5bOhcUFE5+sSXJyx
 tWKjQ901t8Xhc+L2npaLjJJYblasBfy6F/HmRrxbg2V1cO+DFqkIQSmqvp0J5GNSU28G
 X0P09D9n0ZeTOTV3HyOotaMNf1VtnPxI4Wo7ox3AlsniLNatwnDl/X3TT6h4JmR57YHe
 2Gn1kO0LPpTSy5JkF4N7ucuh8lSr/PB6zEdCaw7PMl+Niml5gOOhpUuuN6M++lVjmRa9
 xmvg==
X-Gm-Message-State: AOAM531kjoOOBheXtvEzJCiUU9ob+ArN/UPxl7xlcdEMSJYnr00z71U6
 QTTQo7lE5//9UY69yZVGKFaUfnvEnqk=
X-Google-Smtp-Source: ABdhPJwWEUI+JX9HRMcqHNeFWkci0V1G1UhGp+cRfqfrwDAIrciDls598e7T2CuiswV+A6FDNzz+RA==
X-Received: by 2002:a17:902:aa42:: with SMTP id
 c2mr2246393plr.216.1592454673120; 
 Wed, 17 Jun 2020 21:31:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 061/100] target/arm: Implement SVE2 gather load insns
Date: Wed, 17 Jun 2020 21:26:05 -0700
Message-Id: <20200618042644.1685561-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Stephen Long <steplong@quicinc.com>

Add decoding logic for SVE2 64-bit/32-bit gather non-temporal
load insns.

64-bit
* LDNT1SB
* LDNT1B (vector plus scalar)
* LDNT1SH
* LDNT1H (vector plus scalar)
* LDNT1SW
* LDNT1W (vector plus scalar)
* LDNT1D (vector plus scalar)

32-bit
* LDNT1SB
* LDNT1B (vector plus scalar)
* LDNT1SH
* LDNT1H (vector plus scalar)
* LDNT1W (vector plus scalar)

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200422152343.12493-1-steplong@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 11 +++++++++++
 target/arm/translate-sve.c |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index dc784dcabe..1b5bd2d193 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1389,6 +1389,17 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
+### SVE2 Memory Gather Load Group
+
+# SVE2 64-bit gather non-temporal load
+#   (scalar plus unpacked 32-bit unscaled offsets)
+LDNT1_zprz      1100010 msz:2 00 rm:5 1 u:1 0 pg:3 rn:5 rd:5 \
+                &rprr_gather_load xs=0 esz=3 scale=0 ff=0
+
+# SVE2 32-bit gather non-temporal load (scalar plus 32-bit unscaled offsets)
+LDNT1_zprz      1000010 msz:2 00 rm:5 10 u:1 pg:3 rn:5 rd:5 \
+                &rprr_gather_load xs=0 esz=2 scale=0 ff=0
+
 ### SVE2 Memory Store Group
 
 # SVE2 64-bit scatter non-temporal store (vector plus scalar)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7fa1e0d354..77003ee43e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5622,6 +5622,14 @@ static bool trans_LD1_zpiz(DisasContext *s, arg_LD1_zpiz *a)
     return true;
 }
 
+static bool trans_LDNT1_zprz(DisasContext *s, arg_LD1_zprz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return trans_LDNT1_zprz(s, a);
+}
+
 /* Indexed by [be][xs][msz].  */
 static gen_helper_gvec_mem_scatter * const scatter_store_fn32[2][2][3] = {
     /* Little-endian */
-- 
2.25.1


