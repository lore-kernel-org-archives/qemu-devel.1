Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03255C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5222083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTjhePcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5222083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmtw-000239-S7
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLU-0006wL-4F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:48 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:52138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmLS-0006By-C4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id ds1so32988pjb.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/gvE9gRrBdUc3JON5McXpRJVtB1reGxqOBY4wQzJOY=;
 b=oTjhePcCcl59mZVSlQQ5cEys26p1YinKmHKROoaM8d8m8w/dvrW/3nDg2HcxHJRL8J
 mKL+IJy8VvfJ6owhVbuFAyo1MENokHLKRzGY2oSQVWj1fLjph86FMgK/D3B+R+SnSAsQ
 tijzlIzI7L40DwaSUdE8I1qWZY1/ljQi63npgdg2QRkw5iIatqKnFzisdSsYkkMlJARY
 3bvD3Ke7WIwGe6uAusNHsk3h2Ei7T67PKilnsaQ2n4OdphalUIyQP+MN6wwJhLNVaLxB
 vyCvA1Y0s8CIjFY5xTPLSk3zNqzp75yFE+Kv9yuHSivKwl4mS/ModOjibn4ANN4bgwnO
 LP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/gvE9gRrBdUc3JON5McXpRJVtB1reGxqOBY4wQzJOY=;
 b=Qp2oj6i1L7BqqoCskVD7zF+E/uJfuDPIvYK+md9hvVc2y24rlFRmB5yqrvsyqM9YTl
 reO4VlDvyQ44zxOSeONIo+EX0T0muFKND0ZvF3eNI83uh/q6uJ4ZxbnPQXfA/zue/AMp
 3lnSNd/85vWdZf8Y/kfAG66lDu4KbxnA1763AKCE58hAlDtmELq0Kwz8UQrLT0u5/uYe
 BldAnG7n+OtBVuVBKI+VJwAGNRNBzQcQs/VODr+mGPe6BZ5BzYWZ0Gx7xN8WSTXjoqnn
 PeEJ8EKK4bOgnprdP9FPhbRwIe/mnrfg8ttAC62gM5DgXctZ4XLyysi3AYPZL7IUy/6w
 GY+A==
X-Gm-Message-State: AOAM531wUCEIFQWNfvZL0oVZQin1IPcueYLpKL4SZn/1LiZiKTCE2ofW
 1EGhWeWxc1ThT/YeJFB7FU7vb+/cEbcZqw==
X-Google-Smtp-Source: ABdhPJw1zO/15yWVZQHzg82Co05z/6pC52SDbb7r0jrz85WQNO3U7UKbh0WlxfAuIVzsImdIk1o1iw==
X-Received: by 2002:a17:90b:4b89:: with SMTP id
 lr9mr96294pjb.190.1598890064662; 
 Mon, 31 Aug 2020 09:07:44 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 75/76] target/microblaze: Add flags markup to some helpers
Date: Mon, 31 Aug 2020 09:06:00 -0700
Message-Id: <20200831160601.833692-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mmu_read, mmu_write, get, and put helpers do not touch the
general registers, or any of the other variables managed by tcg.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 3980fba797..f740835fcb 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -21,11 +21,11 @@ DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_3(mmu_read, i32, env, i32, i32)
-DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
-DEF_HELPER_2(get, i32, i32, i32)
-DEF_HELPER_3(put, void, i32, i32, i32)
+DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
+DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
-- 
2.25.1


