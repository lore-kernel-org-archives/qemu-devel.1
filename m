Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D461C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D0821D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYyt2Zyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D0821D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMLE-0005bf-Pw
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIC-000162-F5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:32 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0007Gk-2B
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:32 -0400
Received: by mail-pg1-x529.google.com with SMTP id l71so3988702pge.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eth0Qo7lxODtnYEXQSTKXdT5egBkmtCsDYgIFXZmsyU=;
 b=VYyt2ZyzRh8URWydhUC2wro4KU2q+TVs6aLIUyO3mDwU8L0id/jtHtsfioA3pgVpNb
 D3phoHJyywAW5dZJ1KSCU4zv7gUwcnCRRGEIfLchT7OIjSDE8B/BIlCMwa0n72UeyHGi
 g14FRwV/4RRSIyjlCPnFJ1ivCxY46M/Lm/3UE6f5x/er2d48LBE11s7yc3uNt2vCMiJe
 GEYoSpXpMVp6w6bdi4w5c4jC5d/LWpgW+gSsZ6xhz/STbhSJG5KjnKVis39mmoumYQMk
 YQ8qYBGgakkksqm99MkPZoPpt2F582lFOMQbqr0PH7ur30fGjo20ykDw49I+IzHeFbQ6
 uz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eth0Qo7lxODtnYEXQSTKXdT5egBkmtCsDYgIFXZmsyU=;
 b=LA27qlnbtMBVNZG61SIuAwmkGV6jumk+ZdfCtPmU4aQHlA6euGIyqDMAZSOGRBoyGw
 G4onb0NhrfJ+o9vldK/iq8seDeUJf7s5gS+dDSKyARPiVNuc8QQlcdCAcuxZHe9z7xOA
 yRqlx6AjkZLaiQxDBn/GETwybO5EPTtCsu5K7NOcBAmf7MGt+iD0VHnr5xWFi7UOgvSG
 q38ztzOj0wKHTF3YwvVqyTic2vOJOencjfu/QatjF2E0VlmtmhGeu9Bl5JIUQ30wRrbj
 a/f3sBsjx4+p+wM7yONZbdkh2Ac7weKTTrVW/EltwT4HtYbRanLwKhlWpRMAbNgfwpUt
 303g==
X-Gm-Message-State: AOAM533rxlsV3jlN2YIprv0wmvxwmuIMG11gxzQxDc95NgQVfZ72jTI2
 gtzYJKulxIpPMUU5/tpvCHoWo/0GFqc1Yg==
X-Google-Smtp-Source: ABdhPJwQRyw6+u8vzCg0DqkO+2bYsXrUqZ1XdCNqvJp89Ls7oeAG3mhW16CnZFAUZr4mtJKmeRpEyg==
X-Received: by 2002:a62:3387:0:b029:13f:ed60:b208 with SMTP id
 z129-20020a6233870000b029013fed60b208mr23851107pfz.24.1600454362214; 
 Fri, 18 Sep 2020 11:39:22 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 67/81] target/arm: Implement SVE2 crypto unary operations
Date: Fri, 18 Sep 2020 11:37:37 -0700
Message-Id: <20200918183751.2787647-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0be8a020f6..9b0d0f3a5d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1551,3 +1551,9 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+### SVE2 Crypto Extensions
+
+# SVE2 crypto unary operations
+# AESMC and AESIMC
+AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4341b83414..3c46fd7e2b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8127,3 +8127,14 @@ static bool trans_USDOT_zzzz(DisasContext *s, arg_USDOT_zzzz *a)
     }
     return true;
 }
+
+static bool trans_AESMC(DisasContext *s, arg_AESMC *a)
+{
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zz(s, gen_helper_crypto_aesmc, a->rd, a->rd, a->decrypt);
+    }
+    return true;
+}
-- 
2.25.1


