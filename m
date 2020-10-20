Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F91C388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810FF21707
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kd4VcaY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810FF21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuAk-0000ne-Fy
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0s-0004jX-De
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0q-0003tZ-Ip
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id n18so2798417wrs.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2iFviitDl5greJ6XddSkN6uHSPkj+fpazfKldoUVZt8=;
 b=kd4VcaY0DFoqvGN15E4DZTFUflmEr6vKYi124fLVdTnq9H7I4/+McAm9p7MKmyNO9B
 Ws4Iac3TfkpZ1PDOe2ZLw9wBayJJJK4Y8gE1d+DbF3VAFlcIpDJ8AGa/qNAY+hJtMfTF
 JzdBtGMQrJ10WH68DUKwCrK3UNFhZ5Mi6d/Fj4jw6GYhVZmfxMzXvEQ6Qpq42Pa7f3u2
 LBatwBJXs7YJY3bqBNO4XqBMePA/JX5Cwqck3rr3S+m0tgxUfe1c72GfqkGaKxROdfSJ
 hzORFx3nyETdKN9I70EhUiuDOHkaKdpx7/QftKRFPj+VFTyQ1RBdXzJ3mKMk/rYEuldt
 9y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2iFviitDl5greJ6XddSkN6uHSPkj+fpazfKldoUVZt8=;
 b=IkDMnFxnH4reVLVEw26fZDRVWeS5YxpSlX5XtDcT7vWFhVidy7SX5a65HOAKUQqVdo
 cPkWQMoC8o5/laLUOi0CrAjKbDhhjbh91ySl+Mo+FmuCCsVI5oQopZZQygHJdTmkg61U
 zWiEgFdRbwpd3cATkLjEaL96VHcAZjRCk4Xt8IEy8GATp5KC2x7gypC+iLUScO570gkY
 sXNlhRaNocDDLtvkzI72/oO2K2t2Y/e0NES7C//8vH30xnrQrKkqGu3kNdL6f4085nNR
 fpXtusIKioNPKaKeqdjP1n8xSu8S2yITJ0qGJn2OUpRIDhJK4AuNS+vVoH+J7KBQDbBg
 m9Lw==
X-Gm-Message-State: AOAM533f9JuJiR3ipX1Lqy8Z5Ht4qsFf7kh8wWS7Q/2BRAxBVx0fvB/y
 8Lebzd8hQdoPDcdfmkQbCo68MtnhHUwZ5Q==
X-Google-Smtp-Source: ABdhPJyaNyiUXbbVS8jl4Uo4DTPTgpqM5rP7hNatAxHg8K3JKp6D9bb95g4cN/7gd8vj/xU6J6Y4Ag==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr4132007wro.22.1603209442814; 
 Tue, 20 Oct 2020 08:57:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/41] hw/intc/bcm2836_control: Use IRQ definitions instead of
 magic numbers
Date: Tue, 20 Oct 2020 16:56:29 +0100
Message-Id: <20201020155656.8045-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The IRQ values are defined few lines earlier, use them instead of
the magic numbers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201017180731.1165871-3-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/bcm2836_control.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 53dba0080ca..2ead76ffdce 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -157,22 +157,22 @@ static void bcm2836_control_set_local_irq(void *opaque, int core, int local_irq,
 
 static void bcm2836_control_set_local_irq0(void *opaque, int core, int level)
 {
-    bcm2836_control_set_local_irq(opaque, core, 0, level);
+    bcm2836_control_set_local_irq(opaque, core, IRQ_CNTPSIRQ, level);
 }
 
 static void bcm2836_control_set_local_irq1(void *opaque, int core, int level)
 {
-    bcm2836_control_set_local_irq(opaque, core, 1, level);
+    bcm2836_control_set_local_irq(opaque, core, IRQ_CNTPNSIRQ, level);
 }
 
 static void bcm2836_control_set_local_irq2(void *opaque, int core, int level)
 {
-    bcm2836_control_set_local_irq(opaque, core, 2, level);
+    bcm2836_control_set_local_irq(opaque, core, IRQ_CNTHPIRQ, level);
 }
 
 static void bcm2836_control_set_local_irq3(void *opaque, int core, int level)
 {
-    bcm2836_control_set_local_irq(opaque, core, 3, level);
+    bcm2836_control_set_local_irq(opaque, core, IRQ_CNTVIRQ, level);
 }
 
 static void bcm2836_control_set_gpu_irq(void *opaque, int irq, int level)
-- 
2.20.1


