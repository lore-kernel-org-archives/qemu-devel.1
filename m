Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F4FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1CC21A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwI6lzif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1CC21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL71Q-0006bZ-6a
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w7-0005xg-5k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5w5-0004Qq-BX
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5w5-0004Q3-5D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id o15so1964205wru.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hhz5NftkB3QXUXFUzOn5HECwSeZUD2c0OTNQIOBv7F0=;
 b=EwI6lzifCVniPD8blopg09XF/jzqzCD7V2veVErVmbQdwtfebm33xskuPIJyGeNwS/
 pym/yiabwK5B7osi4kC8XpbclpNxDZLFt2ZtoTRQNkRmKFBi2+mVxJZM89qrlbkZZVfW
 xIG6J+Aua2vxLNbuSf1fJ3irZQ7HXJBGrl0sLCUNmxiJE78RiBIezIeb8SkNnJLmMxqJ
 Vzbb5hzTuskMYJxLhY7Ir2g4gRcS7b+Do2MGrVoULemsN/cD2C8WztnLVblC6Ckhg/Wo
 8/7lUYT4x3uOHODMhHjbh0iTn30xPRcVNQUqg5QM+8W/q11NGd6tEAkJ7wc21mKDfFq9
 UoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hhz5NftkB3QXUXFUzOn5HECwSeZUD2c0OTNQIOBv7F0=;
 b=ViKv23nnHX+GPRJReHea2CTpQ+2y0/d4aLVg6UIgP8AN8zM/cXXkUXRN+ogqNNk8ht
 t0lqmOU7iQt66E0s4zIjiPtCjIH90P6eZNMCt3QvUuXI3zpro50LwhC1dFgBX2qyxZNo
 Q+vHmEemWdhJ/Agj4T/GfnxvhjgllY0JDl50RKH3ZbCc2piP6XBRB4hcqv3lKTgWgHmw
 SksK1UdNPOiIpng5tNvykH/6bL80eTmBFRzLrjud1UXt2ffi+A7OfY7XmYb0rwnvEtSQ
 yYwoxOh3KhfhcaQkd6PvDfEMHLU2z3QxZENOzwHGKJ+kpA3ADC15HIoJh8hCgayNYb7p
 ABig==
X-Gm-Message-State: APjAAAUw/fuesCh/JAjuZ4VBVt592yPyJU/gTjfYt9622ig9NuevHmHC
 XxfQtXcZV5+xThbUyCnivZynOg==
X-Google-Smtp-Source: APXvYqzuGxdhlnmfpVN20doNVuKkuWIMv1ALEDw9CUDN9Z0WXD4uh/OmuxYVOcaE+7Sb5sKtJOynbQ==
X-Received: by 2002:a05:6000:1051:: with SMTP id
 c17mr3020255wrx.124.1571319323302; 
 Thu, 17 Oct 2019 06:35:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c132sm2187935wme.27.2019.10.17.06.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F0C81FFC2;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 44/54] tests/tcg: set QEMU_OPTS for all cris runs
Date: Thu, 17 Oct 2019 14:16:05 +0100
Message-Id: <20191017131615.19660-45-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will important for ensuring the plugin test variants will also
work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/cris/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
index c1173ead42..24c7f2e761 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -47,7 +47,7 @@ CRT_FILES = crt.o sys.o
 	$(CC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT_FILES)
 
 # The default CPU breaks (possibly as it's max?) so force crisv17
-$(CRIS_RUNS): QEMU_OPTS=-cpu crisv17
+QEMU_OPTS=-cpu crisv17
 
 # Additional runners to run under GNU SIM
 CRIS_RUNS_ON_SIM=$(patsubst %, %-on-sim, $(CRIS_RUNS))
-- 
2.20.1


