Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F27C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86178214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3gT/Clv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86178214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlKy-0003bP-NV
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:40:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9D-00033b-H5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9B-0001H4-M6
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSl98-0001Ev-02
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id f8so8932535wrt.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=dQHnN+4pHJlYmoFJPk7sNMgKdxxuc9MbNwGNtlQi5Ao=;
	b=A3gT/ClvCRV7rtEPPnJmn1DsOMTebZrY5pD/AfpV30uVMBPOpEHXpgiWVrtV9TK4Hl
	AP0HbS3dNqAPrTIvYLokPQrdvhn5xlIKW8Y68A2SZff2mG5VIbW1GMhQPKIUeqB6whKV
	+NSf6ixOc2BjT69T/0eecTslatzI3woee0R5waM7PeBLNnFlXs1eLf3GFZ8jcNKXWoSX
	ULUM6hU6VJXZcwkW0Np4q9fQyWeS7AohOA2xpu0iWzGdHNMlHtEk+VrDMxxjGHGoYkLa
	hpNkwVkYxvAEY7BhnxFC+kUjEJtvHsJ5+yse+UQn/HFEAxK0rmHFW/E0A5UktknsV926
	YWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dQHnN+4pHJlYmoFJPk7sNMgKdxxuc9MbNwGNtlQi5Ao=;
	b=WAEkI19FRuCzOYwhtmx4ezOjJJcSdM7CqYjvv93q7b70Ta0AmBeISslueIKvBqtC4M
	uq7BWV37HMTI7edasFx2xja2oKA5ieyHxQt294H97zrLghbZSNV6Ip/h+OEumy+utO5M
	+64OfFfmBYJ/R5YK7O76MJ5HDizXoha71PE/ABsLJ09N5sdHMcZe5iz4WeZM25spJDcw
	60NR3WqwZs8oBcyAKpRy0KQzBYsV5Esq8jBBrtDe75dHHqEXaBFDEn3cGh4tZl1cnQ6w
	SmWCIthjk54AlTS56sBEPPvZzBs/tjOifcTZezp+kriSpIsYDOYAy1x3ALAq3i5XrXnR
	EjQQ==
X-Gm-Message-State: APjAAAUzlBjwgCFwmlc4j/P05udABFuVKpAniOq2qyEFe9O5MKvzfG5u
	WwgjPApyHSEdsgsEefciXiy4Tg==
X-Google-Smtp-Source: APXvYqwhsSNkVEU1Cq7W9MtpNZpWzpTWVhQYuM/DyzelUGIeb4ge+ZgGW3Md49cOQFQGSSKQEmgkeQ==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr17181726wrw.105.1558369695764;
	Mon, 20 May 2019 09:28:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id x2sm5830394wrs.39.2019.05.20.09.28.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:28:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:28:08 +0100
Message-Id: <20190520162809.2677-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520162809.2677-1-peter.maydell@linaro.org>
References: <20190520162809.2677-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 3/4] hw/intc/arm_gicv3: Fix write of
 ICH_VMCR_EL2.{VBPR0, VBPR1}
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

In ich_vmcr_write() we enforce "writes of BPR fields to less than
their minimum sets them to the minimum" by doing a "read vbpr and
write it back" operation.  A typo here meant that we weren't handling
writes to these fields correctly, because we were reading from VBPR0
but writing to VBPR1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index cbad6037f19..000bdbd6247 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2366,7 +2366,7 @@ static void ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* Enforce "writing BPRs to less than minimum sets them to the minimum"
      * by reading and writing back the fields.
      */
-    write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G0));
+    write_vbpr(cs, GICV3_G0, read_vbpr(cs, GICV3_G0));
     write_vbpr(cs, GICV3_G1, read_vbpr(cs, GICV3_G1));
 
     gicv3_cpuif_virt_update(cs);
-- 
2.20.1


