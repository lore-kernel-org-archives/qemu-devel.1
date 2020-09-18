Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E45C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1057E21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TprxvJD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1057E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLx1-0003CU-0e
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHC-0008W3-Ae
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHA-00077N-Cs
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id d13so3977049pgl.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X/NVWweCrcSG9yvM/pSUZVGJlFvHwlP+Fb2RbDObtgY=;
 b=TprxvJD3gwIhK8PfALgUCowt1L6Tw4uSGW0DTUdFnB7HrVSLD69JSSrR3NRDoxP8Ss
 0Mny4GKovjiqwYUUNB19WJOP713zjAnrmdlYZTRdzkH/YR5L/Nl2VaUxk0cZ39WBlSKj
 TkiS8tC/QTnbdWhtekNtJmnHZItHlDDbG3PfU4o07N9d/F1anScwNi2p3yy4CAfx2Dee
 ZJI7CfvBUKFyBupwSCIzfdoFJQ2Dh9WUg01dYCJiQBa0WHmPIHjG3LCHwGTbzpwqP5eZ
 fpxKZdq+fKzRJXZVy/T6UD2oieWIWSq64eI8O1j6MgGYRQLp37FdOyPRygogeBNmQTNd
 SKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X/NVWweCrcSG9yvM/pSUZVGJlFvHwlP+Fb2RbDObtgY=;
 b=cSz0VzFMo3lzoLbnjZQF0Jow48nlo7S0hdL1bDemKTlRoS5u+VkidKz1zEYqIGYdS8
 zwGDbrFzcgKamGh8HcuDAsN3VDRSCTHQ5YAlwTmXh49rp2NT+kPoS7lsdgQQje+NDZQz
 r57tQqMlU+k7tY3cObGb6XUYAZjjctQYgKewtqogfZ29i7neajJg4tO+bJtaZomMaR7o
 /Ct9A3MUJoCQh4gSyd862iEPkx4yFmdKBWctWN5z14OU6YbDOo2PbA++cOJN9OGm/+FP
 QCK9yycgtFp3j7TvUIyqtjnoVJIrcSCH22mz9mVXEgXoj6eYRw2OB3wyci4/NugETG1J
 CtXQ==
X-Gm-Message-State: AOAM531LaN1uy1Qow5YBUm7mQPLIjwctkq/KlI6vWA7LUYFo1/ihhUuG
 nf5Mq6B+z6RI8DCGs7zsxsGvRwgmDcrHjQ==
X-Google-Smtp-Source: ABdhPJw6P5O0rHWYgcJoQRQ5GiHirvO3q2h6zlGlbOBb6Zvu9xRyuptoMmH/WM11NsvVhIp4na1aMg==
X-Received: by 2002:a62:5a04:0:b029:142:2501:397f with SMTP id
 o4-20020a625a040000b02901422501397fmr17132534pfb.68.1600454306696; 
 Fri, 18 Sep 2020 11:38:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/81] target/arm: Implement SVE2 bitwise shift and insert
Date: Fri, 18 Sep 2020 11:36:55 -0700
Message-Id: <20200918183751.2787647-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
 target/arm/sve.decode      |  5 +++++
 target/arm/translate-sve.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7783e9f0d3..90a9d6552a 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1261,3 +1261,8 @@ SSRA            01000101 .. 0 ..... 1110 00 ..... .....  @rd_rn_tszimm_shr
 USRA            01000101 .. 0 ..... 1110 01 ..... .....  @rd_rn_tszimm_shr
 SRSRA           01000101 .. 0 ..... 1110 10 ..... .....  @rd_rn_tszimm_shr
 URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
+
+## SVE2 bitwise shift and insert
+
+SRI             01000101 .. 0 ..... 11110 0 ..... .....  @rd_rn_tszimm_shr
+SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 312a47f4b9..33e575ce72 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6438,3 +6438,13 @@ static bool trans_URSRA(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_fn2i(s, a, gen_gvec_ursra);
 }
+
+static bool trans_SRI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_sri);
+}
+
+static bool trans_SLI(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_sli);
+}
-- 
2.25.1


