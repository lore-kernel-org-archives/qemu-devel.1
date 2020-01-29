Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD1CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D901D206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjfKNlhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D901D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwx7w-0007FY-Vs
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6b-0005yb-Oh
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6a-0001og-J8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:45 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:37566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwx6a-0001na-Cn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:44 -0500
Received: by mail-pf1-x42c.google.com with SMTP id p14so492764pfn.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Porl5wHKMsrkKEwhwV0RaIA5+WTtb1IXZ5cuVd/BzoI=;
 b=zjfKNlhjDpxW/tAWQ9ttPcufDKoPfGdWlCxHC1447Dh8wnwIq0W7pjWEEaoqXd1QgC
 9wYf8h7An01hGP1hlPMAxUm00ND5hJNOw9YbkRWMo9+mAmGGcMs1al2mo94eEagV2KiF
 i+IKr8HMDpHQlKkd7C1GVifuM8pG6glrhx3MwHcCkcWLZIXz+w7juex5awAqhjrc6EQc
 bFcLXe33lsseo8oW5H2Rya6GrCdFPG7d7RG0W25Todd0BNYeab/6l1E+exwkrprBSmm7
 QjLv5hOPSCzJ5XTaXbsRsI4yLQPGsZ9mI05p3GSgNv+/0btGcnbJBvxrzcOSglp5HQBO
 mLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Porl5wHKMsrkKEwhwV0RaIA5+WTtb1IXZ5cuVd/BzoI=;
 b=RwbfPqJ4e1DxJt9RyGeexmcOYgbxeBJKdFTR5pJ7kbM06VzyrhRyOdgI0uGMW3U9xg
 g/5F4reE7ct8spFjWKREMJvXbYtoHSIRMMdkcvrltD3ZHy6bfcy8AWTa1EiaJ2iCmhRx
 P1PeXltzNdsDYc3UhRVh6RAToUVyrUCP4YZol4lUX6+pl9p8vc8ANohHR/wHyWVRqDpv
 cl76XrOqkD0izBHYqBdvCFsZJEXz6ir54bEf+0PNUhhXOuNR/PCSzij8OOtW+7q5PPSt
 ZitxoYYkgEthbu6quSWeu3b3ecKS3MH6kpeH0kR+JoktcCXN3ER0oTyuSnqlTHghHjEZ
 en6A==
X-Gm-Message-State: APjAAAV018wXMLIIe+dEW9lZ8FklGTr2s5ok0dLNtKpEG4g8bFh+YzPK
 5L9vqZNaAtm/NlOrszKZG9CPb2/UcE0=
X-Google-Smtp-Source: APXvYqxgw1O4JZSMgsITxEDg3W/KfWeetovn9ask4NvIsoDHg8DEkdQQYfUWMUWqi4tdBpxM0D644Q==
X-Received: by 2002:a63:7843:: with SMTP id t64mr1698391pgc.144.1580341842946; 
 Wed, 29 Jan 2020 15:50:42 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id 13sm3740195pfi.78.2020.01.29.15.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:50:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/ppc: Use probe_access
Date: Wed, 29 Jan 2020 15:50:36 -0800
Message-Id: <20200129235040.24022-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first two address the performance regression noticed
by Howard Spoelstra.  The last two are just something I
noticed at the same time.


r~


Richard Henderson (4):
  target/ppc: Use probe_access for LSW, STSW
  target/ppc: Use probe_access for LMW, STMW
  target/ppc: Remove redundant mask in DCBZ
  target/ppc: Use probe_write for DCBZ

 target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
 1 file changed, 162 insertions(+), 35 deletions(-)

-- 
2.20.1


