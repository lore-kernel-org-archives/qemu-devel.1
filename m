Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A864C34049
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A88821D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdq+mRnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A88821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48k1-0005G4-F4
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iW-0003Z1-O5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48iV-0004GJ-Qs
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:36 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:45753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48iV-0004EM-KJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:35 -0500
Received: by mail-pf1-x42c.google.com with SMTP id 2so11142079pfg.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9xp9YT+6BXF/GDcu+K5TvURlBEjt56+scFGDcoCg8XI=;
 b=rdq+mRnlGdvIWcenw2xPzU7WNU/j2DqSZy2NjxrUkjLMMGLByuPfYOhu9vlhDipfcm
 KlC50yJ3NYUnW6g+6l127yLp8lnj5yxhDCRCrnc6hfi/yh52v6THJrlx90ZzthLVkHr1
 KRC6c5vEKqSm2ZbqXqSVqNWHZPdC6WKJdXKwdE6lhM9jMqYjM4kNPBrJLY/xU5985nok
 ZQ6mhaDTGq8nbuG8AzaE1TUc0sWdBoNgyHazJrdppLwppQbmcHOa+srx1xKooESfO9vS
 h+3SbgWCpkpDp29UjSTPk2G6vW7J8hZpts5sJDKpzWuiDS4wWgB0yvOTvjBCyHIxAmui
 chjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9xp9YT+6BXF/GDcu+K5TvURlBEjt56+scFGDcoCg8XI=;
 b=XfkzOo/Qb7ZCgJfr5tUILzGx/SJKcpmnJck4HyHhuzDqU1/xkC4J/SJ0+VWF8WGYPW
 ttbl3NdIFQc+hzlQEZcWWJW0J/lD20JDQhI2E+x9DDL7TNleXbboaO1Ew35DDKF3vhfv
 BdWQ9k91t2jHH0Jx3Yr1mWDZJ4KoEXZW9i1xa8dlJ01D5Up+csUggBtCSqFwUs4zoGcZ
 tveq3rUDDyrS8z4Glux9aqcjxkMLxKJW7/HcSNROv/wEsQ2bXRkZGS+0SLCfxOSbT3qy
 YRFyP50YbLbI2UyuzLI+1/uAe37+A2NHk1xL6Tm3/v5rSMNemmP9vtEfMa+Kk0VwkTbm
 alaQ==
X-Gm-Message-State: APjAAAVmW+MhWgiXyBBMBHfL2vLozBCqdK9xLnZyD/0kxorJQn4gMDmS
 Y+bAPk2Ia6YyeB7uZydDM6K2owVMfR4=
X-Google-Smtp-Source: APXvYqzmav0L416/hgm6vkFmeVjp5sbY85GYkqbfi3wYw+wnmMhnLT/L0EpYqCzCK+djgjDNuAsTBA==
X-Received: by 2002:a63:78c4:: with SMTP id t187mr21661123pgc.88.1582054774237; 
 Tue, 18 Feb 2020 11:39:34 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/display/artist: Remove pointless initialization
Date: Tue, 18 Feb 2020 11:39:22 -0800
Message-Id: <20200218193929.11404-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We are initializating incy inconditionally:

    if (y1 <= y2) {
        incy = 1;
    } else {
        incy = -1;
    }

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20200214001303.12873-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index abacb0e27d..47f0e9f0bc 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -572,7 +572,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     c1 = false;
-    incy = 1;
 
     if (x2 > x1) {
         dx = x2 - x1;
-- 
2.20.1


