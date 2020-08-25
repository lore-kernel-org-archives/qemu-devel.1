Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A30C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE04B20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcMHmPSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE04B20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcjr-0005ch-5p
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAcjF-0005BJ-Cg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:27:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAcjD-0007rw-E9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:27:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id 2so2414472wrj.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jFGBpg8QTM0wW80ptrMfB2TplDyv41drpm/PS9njFvg=;
 b=KcMHmPSKgSEAPjB1+sxGjRYJCZRpwXj2tf/eDofwt6GKWt50t4h6XQiuV8loVjUIQG
 kConbJ3QDURTzYr7c4GZ78f3wBZ2UrKmATqp6chMrX+pap7jw+qU9SESx9Av4wM335UB
 7CeyezW6Arhi6uhlznIdM0/cG9kiNlDt0i2u8n3D+Hf7dzOTBz3XkedBoL5KrWbN5GTh
 a46Uh3bMx551yb04oFy2LjOITQKgXHCq2K2AKrxws3UzjkF8KIL7c14CE6eKC0PkpuHo
 yRFWBIaxw9B6UiGw9hd2r9TRYS7KNV4h2d3/+PARIGXlG6kUM6GYQ64h68EOTEpvAewz
 DlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jFGBpg8QTM0wW80ptrMfB2TplDyv41drpm/PS9njFvg=;
 b=eBgmUZ+1yJH/IT6NprgSA9eyLiMPTbOi3Q3JyzuiP9kBuqEpep5Ph06NhybhZHJTIz
 RaqrCQbHHzquD7uBNAi9MxnIeFmS3kX42I2s130obRC+7tDqe9OSb+A0ggViMG2n2u+2
 wz5uDBChyLS7qy9oBjVoUS4a4FeySlJfBbt1aULodlV6dS3YQbOyiAu5H8QbkPyi2/2/
 PZEzV/we532d3rUqYNQM77HGcIWqQF7NaBZBqBBUyVCKt62a1w3LMU9FTA7JNO0y/4M4
 Z0nMSSRbQ53KJgdawkgc+zyr+3IvUNJvmq6U0DqedojggsE7aPtlcmo5koen0hn1y361
 mo7Q==
X-Gm-Message-State: AOAM5307NWlbqrQhvpmOrDg5Io33mttnvoyPvLXd934gdRcSmh26U1Kf
 TVurrWjeFKDyhD1Vns2Ki8UBIRRehC8fZc3k
X-Google-Smtp-Source: ABdhPJyh6Qn7z/ETTQs21UEUuo3/vRtohgi5Q/1LoP+FwrdeGdQDv742hpT4CYYqRAUQARDJ04xSeQ==
X-Received: by 2002:adf:f691:: with SMTP id v17mr655847wrp.344.1598376441495; 
 Tue, 25 Aug 2020 10:27:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 8sm33457529wrl.7.2020.08.25.10.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 10:27:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Deprecate Unicore32 port
Date: Tue, 25 Aug 2020 18:27:19 +0100
Message-Id: <20200825172719.19422-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Guan Xuetao <gxt@pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our Unicore32 target support:
 * the Linux kernel dropped support for unicore32 in commit
   05119217a9bd199c for its 5.9 release (with rationale in the
   cover letter: https://lkml.org/lkml/2020/8/3/232 )
 * there is apparently no upstream toolchain that can create unicore32
   binaries
 * the maintainer doesn't seem to have made any contributions to
   QEMU since the port first landed in 2012
 * nobody else seems to have made changes to the unicore code except
   for generic cleanups either

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We last considered this back in 2018, but in the end both QEMU
and the kernel gave the port a stay of execution; the maintenance
situation doesn't seem to have improved, and now the kernel has
dropped support and especially given the lack of a toolchain
I think it's time to start the deprecation process here.
---
 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 851dbdeb8ab..4c52098c707 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -416,6 +416,14 @@ The above, converted to the current supported format::
 linux-user mode CPUs
 --------------------
 
+``unicore32`` CPUs (since 5.2.0)
+''''''''''''''''''''''''''''''''
+
+The ``unicore32`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. Support for this CPU was removed from the
+upstream Linux kernel, and there is no available upstream toolchain
+to build binaries for it.
+
 ``tilegx`` CPUs (since 5.1.0)
 '''''''''''''''''''''''''''''
 
-- 
2.20.1


