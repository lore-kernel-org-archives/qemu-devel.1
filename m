Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA2C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9770721D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUYFJ2yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9770721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41113 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48la-0000D3-Oz
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iZ-0003co-F7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iY-0004Lg-GJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:39 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:42812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iY-0004K7-Ag
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:38 -0500
Received: by mail-pg1-x529.google.com with SMTP id w21so11428992pgl.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VWkmmOSNRrmSWVThvM1btX2IQ2jQ25rI+tGcKooV13k=;
 b=RUYFJ2yBNNB/FI7ZcZaMOn8rTEZ+F93tRFKn0W8+h0ccY49o6pkEK5NCCN1NFgRg2C
 wzIwa1CUwDgPi2j8yKasWW10C+TW+ojUGT+eyzNSMWkvDp+XFkOiBPXPJZRSgOCQJkzb
 mUFNWsne7c5mmXgxhHQavOr1d9kT+dJyGI/EtyPpYAkkafCxSUXd3ocxlt+QFxYck3Hy
 wwWxwdmX2oICJ7QFUA3hw5C8+HnBVPad+polGMGpXcn4iJRr6mJ/VSUSZ+hW0hRE6GGs
 rqFHsrpS52Rqp5t7Blyl43osNdAZv3u3kcZXDznH2y+A1SJ/3SDEbEF3Wyz52yJPOEf+
 yM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VWkmmOSNRrmSWVThvM1btX2IQ2jQ25rI+tGcKooV13k=;
 b=oda91bcmlEmJz7K+YoZ9Tb9PWa60Nf4YCDgwHc+M0klxRu9WDIDUrgmyrB3GDMM3Et
 ikqF/l0nHpicy7QydXzdfp8LjWVKZ+oqbnL3GPVOcKqAJFMFNeCNKA4qBf5vHe1kuZFX
 l9TZ2KQo8XjGUINfkkxYbIVlbX3QmkdIPhSdhoHjSdG9u2lKPYAMnAcNau7XUHUTPJgs
 OQJkgaTNYanz911jiwdYaZH4MdO4/ppukfMH/I6dND6YgEuZHX5EBhIJ7WBoj0H5VS4o
 yixv7MOc287QSLCKNGMVMG/wberZCWfZvL48ZDVwDxJ7WaQP4HXusJG3r+zJEpsY4VNY
 mkEA==
X-Gm-Message-State: APjAAAXp6hyK0i/cPyEwgDEVOEW/z/zq6e1HFphVs5hQCM3+0MgELXTW
 3UT+aLxuOe55DOGapKKe/x1J5PF73mw=
X-Google-Smtp-Source: APXvYqyA7qE32ZvlMFM5lBu/BNrz+hfUDRXG94ZN3t1fXbjejvSEk852WMSf7KA2XksPv2V7hfxVKw==
X-Received: by 2002:a63:445e:: with SMTP id t30mr24625651pgk.367.1582054776923; 
 Tue, 18 Feb 2020 11:39:36 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] hw/display/artist: Avoid drawing line when nothing to
 display
Date: Tue, 18 Feb 2020 11:39:24 -0800
Message-Id: <20200218193929.11404-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200214001303.12873-5-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 97c811b35e..5492079116 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -579,6 +579,9 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     } else {
         dy = y1 - y2;
     }
+    if (!dx || !dy) {
+        return;
+    }
 
     c1 = false;
     if (dy > dx) {
-- 
2.20.1


