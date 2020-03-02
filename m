Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A082C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C162173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K11Wsy62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C162173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pMH-0000Wl-3D
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKz-0006hn-2z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j8pKy-0007af-2g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:40 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j8pKx-0007aN-UN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:58:40 -0500
Received: by mail-pj1-x1044.google.com with SMTP id o5so97950pjs.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sDW3bpZw++8P1yHtjBOvr8FuMKG/oaa/CtErSbPyuzs=;
 b=K11Wsy62Uob0x9+Jsx0rXlOWzEAQikbw/McJCgMH5MJn4S2Z865P0iwzpvJcRAshcg
 rJTiLy4YryqUtdxbGJnXN2yJUvyVsRsCO1C7r4tVFZih5VkWfgQyWqcNSxzcb2/AS1vb
 uRdExe18JW2/C/DAjxHVhoT2s0O81+stNfHBmN0athMChyNF2K+ZUMiccN2MzIpn+vzA
 j9EStfP840jsIO1OVqoFtUF8VejVZHvbeNfDCKu4cSBXGGPh7Pmjsi1tHK9YKiGai7TE
 oVWxkfYXHTXLBD+3rl/27aThuC07BmCAXi2Lct0Beq5k1LZ1lqAZjT5TkFtFg1wRNAeS
 hkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sDW3bpZw++8P1yHtjBOvr8FuMKG/oaa/CtErSbPyuzs=;
 b=c1ZrgSEHmMwcqoH7zHoKmS8aevG5ShJsGi6N7DZ1htDvrJNbpbfJoh9LVKoLrnMqhz
 xRZ5uPrpJY4uOH9Zh6xc17pqHsokdJd0rCnEY/rKS/pw1tw/6sWFx4G8U3Dgyq0oGX4M
 yfb+N/Q+kdaW8SrWlCdHlmI1p87dptJNXgyJ070WkPH28p+m9IU0Tt1YsyV/GK7dygiz
 naD2ZannGHMQCihwe+rWnJMMkK1GGfFyyvbF3Nu58uQjj9qccqdbv1qr9nzpz9zgjCKu
 ZulK6whZ3Q7UzvGZXLp/jFC2LjKIr4aFFre3qQyfb2NRHe8X3MZYPugJfOzZ/aUiZeWl
 FcAw==
X-Gm-Message-State: ANhLgQ2qHdKHp0IhQXCPb64OjxMQMCMB/0zUxfdzqzlMJ8dSj74HFPmx
 RHxgQjaXXeC0GC3fo0pgEh5OZceOBx8=
X-Google-Smtp-Source: ADFU+vt5CiWA3THaLO9J/XzJ3J8X0PGszo3PcehcrnHQ3ybNTwd0Bt2S6hUsYI4cda5GOVqd3KbXfw==
X-Received: by 2002:a17:902:34f:: with SMTP id 73mr361523pld.50.1583171918760; 
 Mon, 02 Mar 2020 09:58:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id s18sm99510pjp.24.2020.03.02.09.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 09:58:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] target/arm: Use DEF_HELPER_FLAGS for helper_dc_zva
Date: Mon,  2 Mar 2020 09:58:26 -0800
Message-Id: <20200302175829.2183-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302175829.2183-1-richard.henderson@linaro.org>
References: <20200302175829.2183-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function does not write registers, and only reads them by
implication via the exception path.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index b1a5935f61..3df7c185aa 100644
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


