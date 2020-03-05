Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AAAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7608820637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB7Yy2tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7608820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tcN-0000eu-KM
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPT-0003xF-Vx
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPS-0002vt-Vc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPS-0002v2-PN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:42 -0500
Received: by mail-wm1-x330.google.com with SMTP id g134so7045466wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tuIAaw/0Ve1Y33WX78L8SLFKzsPrOM1J0LRXPNiMpB8=;
 b=UB7Yy2tW/aYr5962Dz22/G0eZi2cfub54m0LvWD1xfVJdn5RgzOqefBuEp3QQ/Sk5a
 LtyEjy1ohC3gt2Y68igQs87Hj80jN7JC/gRUDxGHB7IiP9KsFJVqZQV41Br0nrOkMDod
 8JcojW4D3xQClAcxSXDQqoFYmOIwtt3u5HCl1G1qaXSJMrE8v7PSS2irvZVvMDDf0V5L
 5u+GyuDX6cxapmm7G18ur9twLUm+5qgdVqVUObS7bum3+OV6TZUEmi1k9RKNpY1yxtD8
 iwyw7MhA6LejpClWdD+FowcCqgj/lPaSb2ICgn46OBaU+zsj3g1GOd5P4R6iUdSgewnK
 PSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tuIAaw/0Ve1Y33WX78L8SLFKzsPrOM1J0LRXPNiMpB8=;
 b=WwgxBSfuTw3ghGc/JImD7mdKyvD4yGqPt4enNQs5tcKWYLjcmLmzRV8ulsNDxQy3lF
 Ot91/hGvABiGN5Jo4x65wLwEUug6lLzHC8s/RkRBvTq3+2CRPEWNrg7G0H7pDRIAJju0
 rEDq90Kyv4tBiK6uX0YjM1v9gWjjw+dx4qiOazxSjO3tZg7vhOS0DfrlmTYaJP+aZsvN
 ArYY7s8gcgqLc2NzATWzEA7MM2wYp50TYQe145sKBVMp6XgheIRcWX0L2unjTxzQBpHY
 Bl2ObhAgqoF/r1y73mVEXNDUbtBQuUgdlzDqVRttOzcJ8beCP568RF3FnAmVIB+GA3Jz
 +uAw==
X-Gm-Message-State: ANhLgQ0wRZ4pGfmTyruVJeEB64yS4rPxX7YorD5h8z04psa+sC7xdtXA
 6zfdGr6yfQcZ/x1ZeBeNSbeFk875Rpx54Q==
X-Google-Smtp-Source: ADFU+vtXQeEIlyhTLoD/ZhHgIfVBDyIIOFvAWApzeY4acwek+eAPdTMUtjcvbzo5GbIQA1pOxfZLeg==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr10374932wme.30.1583425901439; 
 Thu, 05 Mar 2020 08:31:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/37] target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
Date: Thu,  5 Mar 2020 16:30:59 +0000
Message-Id: <20200305163100.22912-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

The function does not write registers, and only reads them by
implication via the exception path.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200302175829.2183-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index b1a5935f618..3df7c185aa1 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -90,7 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
-DEF_HELPER_2(dc_zva, void, env, i64)
+DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
-- 
2.20.1


