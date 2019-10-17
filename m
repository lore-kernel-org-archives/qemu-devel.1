Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31250ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED67821A4C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN3O3PNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED67821A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6x5-0000fd-JQ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-00063O-6v
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wD-0004XE-3M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wB-0004Sv-2P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id p14so2399356wro.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YEs/lUjotuLdLq3mW4zXQsTPxT1HP2QzsnSAtyXeLV8=;
 b=BN3O3PNRfTbP7VzwYNVf+Wt4Cym5m1AIFi436ViEZok/Ywx/tC9gQNTc0Ln1Ak4QnE
 3OMim7SEtOoMNFWnT+bkeGrDPpbi0hSkqWVQpKfaRhGD1YOGc/+vmKHMj/JvzlKeFKk7
 XcE4d54nw2blW5jGEB0Je5gRnUFuSZ0wXc5d3F3wXR/8OF8jNVKbEy4nlTCGR06wElRA
 5pygMBY1yUmwl9fR8ul+GhIP31h+1ZPlfVtM3rWctO16nbQ8qdWqQpUeBiQbKrRBn83H
 +Bo26eqgCyZALf6pVoKrrvZk2qWK9rM/+dqV/KfKJiCJQINuVN6CIlgMlyQha9sDs7a1
 plpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YEs/lUjotuLdLq3mW4zXQsTPxT1HP2QzsnSAtyXeLV8=;
 b=LJEf0jipDpiHWjHjoGscMTWOsEKtgOZ2gRm8C5PJPXjwUuG/Xd2qBtBTyVis0NPGVF
 7fhHR03jQTg46hB1sG6beVg7T4T1DB0hfIv1Sou+UBBBMDb7RSAdCah9X25nGh80aiFI
 OwjKO9Y49Gf4203UTsHH6S9Z0tFCTkDrLsxy+F5Kr98OgqovlD2Yp+sydAR2dfTR48t4
 v9Fr55ajDk/oF9YjnlirJNecgHbXkjr0f2GouJJv3vO4ZHsGDA4yhhIbTS+pCoIo8IOB
 1MkYAKWikTYiczGsuFBucBZF6BKo7z5GHlbELvWvsEVlE5GrPuAXEzGtEwZWQ7FA55oR
 gA+A==
X-Gm-Message-State: APjAAAUFfZXPPYN8HeqAa10yQ4/L6eRx7DPUVD73/nhx2YIUzsg9cT01
 WY2G1CVTRGtwSKEfGJLyBWzneQ==
X-Google-Smtp-Source: APXvYqxgS3lkRNS/BwsAImd40WyNx0dBmF5SCOoqVwC9zzVn5RC5UX3HTonV35Yc2pI2U3OUeoVzBQ==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr3047023wrq.344.1571319329956; 
 Thu, 17 Oct 2019 06:35:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm3122531wmg.41.2019.10.17.06.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED5451FF90;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 43/54] tests/tcg/Makefile.target: fix path to
 config-host.mak
Date: Thu, 17 Oct 2019 14:16:04 +0100
Message-Id: <20191017131615.19660-44-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since moving where the tests are run the path to config-host.mak has
been wrong. This doesn't affect much but things like the time fallback
for CONFIG_DEBUG_TCG and will also get in the way of checking for
PLUGINS support.

Fixes: fc76c56d3f4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 5a9a6faba4..84abbd24f3 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -30,7 +30,7 @@
 #
 
 all:
--include ../../config-host.mak
+-include ../../../config-host.mak
 -include ../config-$(TARGET).mak
 
 # for including , in command strings
-- 
2.20.1


