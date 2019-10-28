Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B10CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD8720830
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Na24R2mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD8720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6jL-0000My-5h
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uq-0007YW-PZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uo-00045D-2P
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Un-00044P-1h
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id q13so10207874wrs.12
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0fs1ku4GpjAYa04lupxk+gKk8sjfZMUU6XuR/WsE7FA=;
 b=Na24R2mVEeeLhwHOwkNVLqmDId9gPgkjejP+02yQ7DOa7LHmPXDSoCfUXcN/SVvif9
 hL2OFf3rI3A3oc62FbI3RQy/qFVkh5zuFBAO/BkxbpQREvOwRTYxeXgOgxQyza876P1S
 +WeaKlZGM3lseU5V6QPOhsYVf13cE1hv0+ougMeWHXyvpVoX4qSFkBDPD/KQ3H/VrBP8
 twcDNWq3ub2FiEXHqiXVrQmMpPcfXFwaKHoTV/q8gsowkmFGeRLccJ/jkZCvXU1ZWvfz
 mJIbxOlBKitIBx5Pt+fmBH2u9qUpaD39h4O5cElq71E9FaWsQfbWhTFiLGfxPGDfVFYt
 fs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0fs1ku4GpjAYa04lupxk+gKk8sjfZMUU6XuR/WsE7FA=;
 b=ixfM/4JjEPC0IuXoOBKT9zZFKCEc99SGVJhYzKaaEPoXnrqc9gSfg+Kp8uQjPrCcFI
 0NYYWDeOx376aLofKsnXFuR2PEoP4pW24BYTbI1HzdaMnD4gyr9PTwUufIvkZGf9XnWa
 Pa+Eal3xDU2AR/MDyapJ8hZJJH2NRrQm9Sl08CIIql5X0/pOsiG7WSP1i1phqR/F2upR
 5bmjPEjBBO1aZFpVTwddUliOXURfMbTfKchNbFr0uUSz4hNNYaDLX1Xw4SeotZf9zps6
 dXdD47YlA1zO2Q0r+sVKlkwOhg4QvOGOjpfJzbyyRIpbxqFs5MIqb0WfCHIK7iA6ZcRD
 73cw==
X-Gm-Message-State: APjAAAXlx4Ia44ZiiWm3zxUcHCSzAXLvpswi2+cov3qeJalPHbhD53WD
 bW8W2twg8FPhIf2x8BsT2ydvJLjaVob2/g==
X-Google-Smtp-Source: APXvYqym20Rmf+gvG1Lm3ZNN0cs3/CWSKNBytetBJA3HulCyUR+fzdET/ThWQzC+lte4yRLWQng7Xg==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr16289868wrn.143.1572274786801; 
 Mon, 28 Oct 2019 07:59:46 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/12] exec: Promote TARGET_PAGE_MASK to target_long
Date: Mon, 28 Oct 2019 15:59:33 +0100
Message-Id: <20191028145937.10914-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some uint64_t uses that expect TARGET_PAGE_MASK to
extend for a 32-bit, so this must continue to be a signed type.
Define based on TARGET_PAGE_BITS not TARGET_PAGE_SIZE; this
will make a following patch more clear.

This should not have a functional effect so far.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 525059970c..0543359d0f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -229,7 +229,7 @@ extern TargetPageBits target_page;
 #endif
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
+#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
-- 
2.17.1


