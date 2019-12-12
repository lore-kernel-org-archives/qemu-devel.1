Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11849222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz9tF1ME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11849222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFmg-0002Xm-QW
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFez-0000vo-Gy
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFex-0004Dv-8J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:05 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFew-000496-VR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:03 -0500
Received: by mail-pj1-x1043.google.com with SMTP id s35so442317pjb.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ywIseiPjqJvH3CWY8/pVr57z5YPy7BfDXHEc/+9ytCA=;
 b=Rz9tF1ME67gJJZM40CeR0XA5kZvUVVWGW+Uu6+bWkRMTWXhNRaZWP5ee35YTZ5jNft
 BYVSIxuqxvvBNlOA034hdJhQYkVgWqvcZqx6wPki17xQ4Gvt5cMPTh9QbBZHkOgNG6GV
 tX3dyN5x/GW4en/tE29/L1WSlyrqwQ/5Pff17Ol6y4JVxc+pAitdPJuJethLnBYI1NmE
 vzAT8CZjG39VF/KXQJ7vQZdyyyw1n48JA3NyNIeAsK3M8BS1ibfBkkSK1RAdyRabFrAg
 9f4s1HjyK7JFs+Sh9E9RRJmj5QJ97hn3uWmHvWZIt6canv+iRqxzlOeQpcZ0cbMyzQaZ
 0I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ywIseiPjqJvH3CWY8/pVr57z5YPy7BfDXHEc/+9ytCA=;
 b=pjXS10N5/lEJNJVFD1LxskBS2VV8x88FVdycDdGVvAVASSV93gqpXHe9JBOCHQAIVi
 7Mbm+o4mbgWqjLUoxGSlfV56Ud9hL/GaW4VxlA4pmo7kRIzjHBboXc/mNikncoNN/SPI
 /wOf+t5tzfuHQZ2dYMRKhbKIhr/6rsaSkaulhy+vrbqFZdnBzidnyk5HaBdgybSrKr0r
 YACH6GeziUKpmvu8CRd1C2DWrb92XWKwSoBcdKRWDhTMjncm/q7m5C2tVvtfLLMn/Jnf
 lPDClLLNeviPE3vztuhMMFnEPQL1RfHD68GxYvZ6NBV/brmFs9nhj+QMgoMh4opHr3qj
 LXhg==
X-Gm-Message-State: APjAAAVPY2fSKXqqYDkC8XCcfC1ETYsGq1/a6M/1swvRJXR5rrxHr8+S
 x9PnHzJ++vhWoFCfPBeB338mYJpIH3o=
X-Google-Smtp-Source: APXvYqwMPT50/7nSxMPL/ihlin99D2JsB5zvC04apgBYj3zZtVk/qsuVUsEH+/Cs5T/vxeENq+cGnA==
X-Received: by 2002:a17:902:a418:: with SMTP id
 p24mr7104159plq.52.1576123259760; 
 Wed, 11 Dec 2019 20:00:59 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/28] target/nios2: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:26 -0800
Message-Id: <20191212040039.26546-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/nios2/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 361b06ffeb..78f633f970 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -217,8 +217,6 @@ void do_nios2_semihosting(CPUNios2State *env);
 #define CPU_SAVE_VERSION 1
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_SUPERVISOR_IDX  0
 #define MMU_USER_IDX        1
 
-- 
2.20.1


