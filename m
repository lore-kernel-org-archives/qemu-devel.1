Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A428C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A1622B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMBlvJvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1622B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48J3-0000jQ-CO
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Fv-0004pq-OK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Fu-0001iD-MZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:03 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:32972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48Fu-0001gU-Gi
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:10:02 -0500
Received: by mail-pl1-x641.google.com with SMTP id ay11so8468591plb.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hM3BmODxHsfSDsqzi/dhi4yKt4/pOP8vyrMHfxPPoU8=;
 b=IMBlvJvTdEw1le/3ggdyZaL/x4azzyTn9ALiuudKi/gYoDduoPBbtbgN0FTMOgO1j8
 qVHFGBwbMq3b4Rjrb2l5g9rTthaiXLYucS6ZH6XlZmYwpmB4Q8WKlDdXauqVl8fWQwpK
 zFdeJintzrAHSRklojRfLwFZWLU32CwF5usFIZ8WrhmFKSS9SqcrmQVzfyOXZFhIALff
 mkEU4zCbV2Lu0xPZwhu9AYL7KB2OP0UJimvuwmi2ZCNGv+UzmlHFYT58sSFolgyILC7d
 8fWWsl7FETkgJ/L5COdZOHId4kR95hk4l/Klh9d/BBCsSs7GDoB952t1RvzzPE7Mw2EX
 j5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hM3BmODxHsfSDsqzi/dhi4yKt4/pOP8vyrMHfxPPoU8=;
 b=Hef0j5b9VwvJIhiUwv1TadGbQZyZyPrRq4JSCG6KYqCD47HMVthAKU+TB086AJMM5k
 exk+rPTZplsu4Tbkq5sklF8fuRINzUJXIB12Mf2DY2M8NftpRzgI1j01qwJXyxTp2JIq
 8RaEKZBS3Aw/uu98UavSXc2Afz818bWXskgCiecC50HjSbzh9UWKwLJsovEIqUwWjh7+
 UnnJKEF+0nSrrsrS6E1amPw8MZn7kgWXtSCpPQ7TJKpIqodFvPPi7SVLhwWlEDxIzU+k
 8yibyqhzKYJMy7vUHD8TqCVIEPDZhUTmgz7uZNmEyhY/N/NZNi503NuNi/6T9LpjElr5
 0ELw==
X-Gm-Message-State: APjAAAWwXEwbMzWIZINM5tpuFKLFuPpZ5E/wu6JMJuiBqxofzo3uhl1o
 7b+XmnD6lwTNiheUAo8VLTZ+5mmgBg4=
X-Google-Smtp-Source: APXvYqzwklJcSgoSdHaSqvx8RKsQc1p1Q22c2iq2bKRgvxb4pHdapH4BPPehl2gblNB0+WBCCxlwrA==
X-Received: by 2002:a17:902:204:: with SMTP id
 4mr22688063plc.266.1582053000912; 
 Tue, 18 Feb 2020 11:10:00 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i68sm5139399pfe.173.2020.02.18.11.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:10:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] target/arm: Honor more HCR_EL2 traps
Date: Tue, 18 Feb 2020 11:09:51 -0800
Message-Id: <20200218190958.745-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

Based-on: 20200214175116.9164-1-peter.maydell@linaro.org
("arm: ARMv8.1- and v8.4-PMU, ID reg cleanup, [H]ACTLR2")

Patch 1 is a latent error that I noticed while reviewing
Peter's patch set.

Patches 2 and 3 have already appeared separately on list,
with patch 2 bearing a v2.  Thus this patch set is labeled v3.

Patch 4 is dependant on Peter's [H]ACTLR2 fix, and the reason
for the Based-on tag.


r~


Richard Henderson (7):
  target/arm: Set ID_MMFR4.HPDS for aarch64_max_initfn
  target/arm: Honor the HCR_EL2.{TVM,TRVM} bits
  target/arm: Honor the HCR_EL2.TSW bit
  target/arm: Honor the HCR_EL2.TACR bit
  target/arm: Honor the HCR_EL2.TPCP bit
  target/arm: Honor the HCR_EL2.TPU bit
  target/arm: Honor the HCR_EL2.TTLB bit

 target/arm/cpu64.c  |   1 +
 target/arm/helper.c | 284 ++++++++++++++++++++++++++++++--------------
 2 files changed, 196 insertions(+), 89 deletions(-)

-- 
2.20.1


