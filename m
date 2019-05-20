Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B4AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D629214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkz0Jidp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D629214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlJ1-00020h-Il
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:38:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9B-00031V-KH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl98-0001Fi-1d
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSl95-0001DE-Rg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id j187so5782wmj.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=cEu3plm2JnEz4zF57Dl9xMi74nNuVpPFcKATYhpH4io=;
	b=qkz0JidpSNoylM3MLl+G/1xILgwruSaa0LidMNP2QzD4hAIsK38BUX3FD1j9YZL6+7
	i0+EJHW60XWI2mCLmDP5qESUX1MFZ8sDWPQHZjCss1cU/px3Sbb93egRJSWUGV5SbjP0
	EK/pu/KqdQohweqbdJdiXssoXVCntTbTNQ5AxcDnIOhTw+toXQaMVVXeEyeVe5+yhbmg
	jrFTJpqwswULv6YT3pjiichaQuUouJVszIShqgQ+zPzaLcfymrmoZ6pzF0KIju2lrChr
	jsP9l4/laWS6nyLniItVXsrrM3ikxMvhwlggS2qyub07USqGlPX9WuOO5E8on/eOMnjA
	b6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cEu3plm2JnEz4zF57Dl9xMi74nNuVpPFcKATYhpH4io=;
	b=VlWtl9vfZpUB52rneLEvj2DT3f9cTxL31nvd7hOTTtwZ21hpAkj+tm1JbKLJuaKKWx
	SHsLGduexJFs0ZJlve3A2R+l+mpCc2WyTjisfArR6V6ZnaEOdujKJD9ZUD0dbX3nXGjE
	VTFuvQrE6QqC1bcXAYGUSrR4GQln2AZQnbvNBhPm68abzcgQCrI0S+6kzodXB0YVFDW5
	e6Epjv9hKYFKyd6/HzUZjdLnlpb/Mg6bBXmrprHu+jx6S0MG/yJZR+JQ6z3YWsoAlIsq
	SfPS2XMn2iyd0wLuD35GTUMpFDu5Vpc/WzZX5VuY9NmM3HMdTY9Ihj3+E+7RZufcvapT
	IF0Q==
X-Gm-Message-State: APjAAAUXJeqnpdFBNTzf3jD175wl52ESMQkE1UlM7Y1hKJA5CUJ/0fR7
	88d0Uusyuen5XjI0/dL2VSyu7Q==
X-Google-Smtp-Source: APXvYqzFaWlrUc9e2BOWC7brgFQAbju6M8BhJRvMNQA4FGEf0eeba7mBfCEZNbaXJ9WPEgg9GSxAIg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr2872014wmc.47.1558369693589;
	Mon, 20 May 2019 09:28:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id x2sm5830394wrs.39.2019.05.20.09.28.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:28:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:28:06 +0100
Message-Id: <20190520162809.2677-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520162809.2677-1-peter.maydell@linaro.org>
References: <20190520162809.2677-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 1/4] hw/intc/arm_gicv3: Fix decoding of ID
 register range
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GIC ID registers cover an area 0x30 bytes in size
(12 registers, 4 bytes each). We were incorrectly decoding
only the first 0x20 bytes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_dist.c   | 2 +-
 hw/intc/arm_gicv3_redist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 53c55c57291..335386ff3ac 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -533,7 +533,7 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     }
-    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
+    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
         /* ID registers */
         *data = gicv3_idreg(offset - GICD_IDREGS);
         return MEMTX_OK;
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 3b0ba6de1ab..9bb11423382 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -233,7 +233,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         }
         *data = cs->gicr_nsacr;
         return MEMTX_OK;
-    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
+    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
         *data = gicv3_idreg(offset - GICR_IDREGS);
         return MEMTX_OK;
     default:
-- 
2.20.1


