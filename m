Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEF2C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAE62053B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIf8x036"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE62053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04vb-0002tg-5o
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04ub-0001bB-1m
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04uZ-0001MN-Fj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:19:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id b6so15285254wrs.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PZFpVZfQpAAFemnJfw1bta1je15PzH0gg3ZsQFBq8iI=;
 b=VIf8x036KsTgU/ng8WCiKOyytOQ5iM2vvTbq/C/FbgVZ2LqKcWg39+9GIBRxNtRoug
 tQ35IX60aKfQLW6LeEERtTnKWxfO4IUW3Sn7Gtk8SPSK/T5dfMRNhAjWaETKv3IR85bw
 y2U7zzipUR0+dXfKx1RaDDA2xfcOrA2hArMSN2SxKM11v0cn4zGnLgLND9w67Mr8IUb9
 W2vGdfWIy3kuyBOyyYjUVOGmU0h8ZlSHuz1T+ACE0YlYGEsKrcoqnvqaWh38wna9YNaC
 AXwinQiP7mCXeMwfFR2JHoXK0zdpdkgi9zLbEUu/23jU+cD7cIqtR7N/2Fy3uy4Zm3NQ
 y/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PZFpVZfQpAAFemnJfw1bta1je15PzH0gg3ZsQFBq8iI=;
 b=sH8ekD+oR2HCshA90OeAYqYxPPf21f++rAd4RsMn5Cck1InHL+/1YwFAnULOcO74Mn
 DPvyBJIO5CUNfEFiDAZOX5HrPF5SUjT3koPVM4bom/PiWupBYW0mNh2ug3YI1yU2V9MY
 7TtvsKF3WlbKipbM3n0A2ybpfTZs1+JxJeuVR9cWPiilQ9EN1raCe3e680B8r5zXow+3
 p+YwwHD3njUOYhPa69yUvVwUcedfwnAkqQ71daght9GVR8LsLeVNxkmRZOik+jI9tWMU
 dfchtN4pBaEWGXvnsOd5qqBSOQ8488b9c7Leopy1HedojeepOPbL3yUt2EnT/hQRfkxb
 71lQ==
X-Gm-Message-State: AOAM530sUiXkMPM8pnAf2fXRf0iBjwMO/ulY+yLCx5kCZPrgdfCBF6pC
 FQBqz37CL9KqKztVMz9a8gn+kAiQJ/gz0Q==
X-Google-Smtp-Source: ABdhPJzVMAqNzTNYH4pOYTY4FGkkG2LqIRl6g737fGmUnRuF64v+Y93sLUWeD1uRsAgIrhe8U6ikGQ==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr19989737wre.424.1595863169112; 
 Mon, 27 Jul 2020 08:19:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h199sm18744996wme.42.2020.07.27.08.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 08:19:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] docs/system/arm/virt: Document 'mte' machine option
Date: Mon, 27 Jul 2020 16:19:17 +0100
Message-Id: <20200727151920.19150-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727151920.19150-1-peter.maydell@linaro.org>
References: <20200727151920.19150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Commit 6a0b7505f1fd6769c which added documentation of the virt board
crossed in the post with commit 6f4e1405b91da0d0 which added a new
'mte' machine option. Update the docs to include the new option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/virt.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 6621ab7205d..32dc5eb22ee 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -79,6 +79,10 @@ virtualization
   Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
   Arm Virtualization Extensions. The default is ``off``.
 
+mte
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Memory Tagging Extensions. The default is ``off``.
+
 highmem
   Set ``on``/``off`` to enable/disable placing devices and RAM in physical
   address space above 32 bits. The default is ``on`` for machine types
-- 
2.20.1


