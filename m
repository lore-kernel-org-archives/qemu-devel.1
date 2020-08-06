Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32DE23104
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owI3qGqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32DE23104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fDF-0002BS-RL
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAq-0007ZS-Mm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:55068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fAp-0004K6-8C
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:39:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id d190so8694846wmd.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qmRyE1Mkm8Vubn9zx81Xdm8VLm6bfTzeQ1FPEWQdai8=;
 b=owI3qGqKATKM/4OsqcWrKRBmStP8N+KpcELoOXcQMy5lxag03iIUfFpXhtpZLSrV0k
 o5XKuzTSXDkj8tU5YNClYbT1dPOeQjNzIoCgYrSh1jROf6WSCvnDio5jpFEyrqZgkvcI
 9kQ57xcaka26a1TR+dRwbcW5e+hZh6YeJuGFDeq96XQ6UMhcCLD5glDGxxvKHsaVbxeL
 AEeB7aqwsswPAPCG7BcFfJ+MkA5myexfW0z00v9NS8lST3dTx+REudVc+zMuUMcQ2S1a
 SxwvNauQzcstK1B3EjAjtKleSmCtyRjtHTUdaUAZZ2/xUnoWpUCitgcrO55mhJLch03V
 D6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qmRyE1Mkm8Vubn9zx81Xdm8VLm6bfTzeQ1FPEWQdai8=;
 b=YMVI0/WJ8uyzOuaa8JnoSh9r9eF62sqEDc+X2pL08madKnbF3e5JLAFHgdUrSySz/r
 G9b12i0c20PfWOBY1OzGnQCO6Qq+9vhPUeCEuU6Wg6xxKnqn07fyZi4pbEXI9GwC41p1
 TvpmfL1eXRoiXSjOsTFJESNWwaYeQmGW6Vw6FQo0YAIx7dAwkTqbMk0mcsMeCMSjpzZ0
 mjHHXFiQ5BBMRwop1gE2RAS5BQwgicYqqDdvC0l0oKeUhXtzaBs6qaLVuvcIxaQvNe7p
 h/F3W6EkBtF8EIIQZi6E8GzW1SDUXmum5+q4pmZwHCN4ZoidNLHW2sgqpyLHHg3vv2my
 D5kw==
X-Gm-Message-State: AOAM530Pg6iiwDbBAiiB0uEtM0DOMd2EyKaFqNODzwnPa+gUM/iH09ge
 eKsi45Mwgc8z0zlbE6M1b8+qTLt9
X-Google-Smtp-Source: ABdhPJxp3Ffw8jt8L6Z2EVxL7WDY1v5vRRFCdS40SVDleJSE6f1G5zFVHx9+UvnlqoIm3NBGcQTGzg==
X-Received: by 2002:a05:600c:21c2:: with SMTP id
 x2mr8167486wmj.142.1596717545309; 
 Thu, 06 Aug 2020 05:39:05 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j5sm6615395wmb.15.2020.08.06.05.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:39:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/3] hw/clock: Only propagate clock changes if the
 clock is changed
Date: Thu,  6 Aug 2020 14:38:58 +0200
Message-Id: <20200806123858.30058-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806123858.30058-1-f4bug@amsat.org>
References: <20200806123858.30058-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid propagating the clock change when the clock does not change.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/clock.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/clock.h b/include/hw/clock.h
index d85af45c96..9ecd78b2c3 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -165,8 +165,9 @@ void clock_propagate(Clock *clk);
  */
 static inline void clock_update(Clock *clk, uint64_t value)
 {
-    clock_set(clk, value);
-    clock_propagate(clk);
+    if (clock_set(clk, value)) {
+        clock_propagate(clk);
+    }
 }
 
 static inline void clock_update_hz(Clock *clk, unsigned hz)
-- 
2.21.3


