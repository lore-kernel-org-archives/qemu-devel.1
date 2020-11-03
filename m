Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8122CC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BE22080D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKT6Jqh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BE22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZnCH-0006fU-U9
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 22:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZnAm-00069V-Gy
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 22:39:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZnAk-000635-Mi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 22:39:52 -0500
Received: by mail-pg1-x543.google.com with SMTP id w4so2373394pgg.13
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 19:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bfjAIfz0w/Qz72IXs6gPJpI6mQ4YZEZ6ztRDcjP9YP4=;
 b=WKT6Jqh9laSkSuK0Gx4ybedfN1D9vFCRx56mPQkSKXL8cFkS3kGH0APhVPMqahGe1/
 qtqiybKaqa0D3wTMSVa4zPIHQfg4X1swtqPeovt5MuzUbtGB1tRRQOp71h2FT2kE1q+8
 MOMONCd+Q55s7gYYBTQQkebfwkYnpZBuECDNkHkAtdGn7ByLQXngCOGVBoK8DOAtvLGR
 r/TCIBSVPAp2NUdnC3rxH2JroOWnbADTFdeZ1Kxq25u2BHKHj7+YN2bNt9gUFSx1X8do
 sm/SGXEtA+gs9f9k2MvW2U//XMRJe0jNWSgZJH5E2D5FiHcJgSQgUroiMneFtGY1sA0r
 mE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bfjAIfz0w/Qz72IXs6gPJpI6mQ4YZEZ6ztRDcjP9YP4=;
 b=EPyKY4bnskPsUa+u8sp3xjHlVBH9QCpKhi0C1ombyWiUF47b2CsI5AqlLPFj+L0iDw
 ehlglCJN0IMzq6Ba2PKHVYCzoC5rNPo2erIFbPwyftv/1yjCN7UTpo6hCIEZYQZ4UaCI
 o/zr2eoH9cZCkK4P0dMP3Yg0VPll5wW3hRr1EHu3XyQBZMb5ZUqSpz7rl+llqoTA5Lau
 eh4ZH8NeYlA3KF1UMX6zMu0qknJzpyIfdJC9RA+BGLzGP6N0aRw9zo+8Qc0bG7WTzTsW
 T6+3eVwr9FJhfKI9mgDrrnLIhs+ouCqO1J6vv24JqK4am0j5qLQMIWwDWSq8ukkTa66W
 HwWA==
X-Gm-Message-State: AOAM531QtrcPM0V+UTUchv9WkqKw082/e64tozboLI5bci8zNe04I4q2
 kyWEX78S9osrtGSWmeZBkjE2nciLINyR0w==
X-Google-Smtp-Source: ABdhPJzeyT8MqCBaVYWqdeE3dJuk9WiDwhJ5ipPq8QcFVRxCy1La9IJwU3eKHeZU+yKFXX1QcQO3Bg==
X-Received: by 2002:a17:90b:783:: with SMTP id
 l3mr1673992pjz.122.1604374788665; 
 Mon, 02 Nov 2020 19:39:48 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id j5sm952875pjb.56.2020.11.02.19.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 19:39:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] tcg: Remove assert from set_jmp_reset_offset
Date: Mon,  2 Nov 2020 19:39:47 -0800
Message-Id: <20201103033947.94157-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
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
Cc: Sai Pavan Boddu <saipava@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The range check done here is done later, more appropriately,
at the end of tcg_gen_code.  There, a failing range check
results in a returned error code, which causes the TB to be
restarted at half the size.

Reported-by: Sai Pavan Boddu <saipava@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Sai, would you try this against your failing testcase?


r~

---
 tcg/tcg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f49f1a7f35..43c6cf8f52 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -335,10 +335,11 @@ static bool tcg_resolve_relocs(TCGContext *s)
 
 static void set_jmp_reset_offset(TCGContext *s, int which)
 {
-    size_t off = tcg_current_code_size(s);
-    s->tb_jmp_reset_offset[which] = off;
-    /* Make sure that we didn't overflow the stored offset.  */
-    assert(s->tb_jmp_reset_offset[which] == off);
+    /*
+     * We will check for overflow at the end of the opcode loop in
+     * tcg_gen_code, where we bound tcg_current_code_size to UINT16_MAX.
+     */
+    s->tb_jmp_reset_offset[which] = tcg_current_code_size(s);
 }
 
 #include "tcg-target.c.inc"
-- 
2.25.1


