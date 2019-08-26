Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB08C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5CA20850
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVE2F2Pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5CA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2IHo-0003k3-KR
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 12:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IGN-00031h-TN
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IGM-0004Vk-Cj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:39 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2IGM-0004VA-4q
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 12:54:38 -0400
Received: by mail-pl1-x643.google.com with SMTP id bj8so10313034plb.4
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bnII35kWuX2vmNoRHH5p+r4TOW7TPxuN5wRH4ShYedA=;
 b=oVE2F2Pu/+KcESIWaA7zDi1nxF6DI9ZA41njpWAiVNWwTrsAnYI8Zipm1osQ3YqXh8
 /wgA/nxT9Cfvf+qiA0HIHeKMNn5vJ4MpgMN1bCHpcjE9KFPOXTTHtQFMLCvd6rmxeHBi
 BqXLBfr8/6s5FoiybjQUrMwo3/fAx2z5Oqn31SU4ND274Ppt/s1W7y3m28ZMhIiLbTIy
 33fz+2oQBSp1a9LFRgHGNiRKzhwsxm7bgJJpMbXFmAnjzgfqTrguFWdPtRCcWoEVyxje
 vQAk8OYl6D3Ym25Me8lYnz1gqzWnDSLJVl19B7pOkogwVIlGXyF7YvbiiOi09S1N2EG2
 Hzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bnII35kWuX2vmNoRHH5p+r4TOW7TPxuN5wRH4ShYedA=;
 b=GTZwjWIA8TDPW2kpt118d9YXFpqkzehUaqi19LTqQ8cUi3bRM2k7evPMV2/y9K0pHe
 JqI74bMMgwXAWHuh1+IOhtBNS7eoYCWRb3yQ1Ir59MhMkA+rLoJHr7a56izvnOK2jZPC
 HllJg/Wb40JH4sr76ybjkGiUPfo3wwwQ816Lodl0pClxFh1NOWDaHCXpZf2TOxSZONSi
 ZEVl1cfLKrp8WaX+kyiRyt6RsIVJkiy1YvyPdhWa3zo2uQaETbmcxsEGS75FLZhT9NMK
 nNpPtm2v0z1nVfZaswCI+bR9YKnemVNqv7+dBDNJqgyl78tTl7hScqOMu1eulZV4kC7J
 qTnQ==
X-Gm-Message-State: APjAAAW90LsHVfZ7Y5rGH/KNQQwaZjhWz8xSf/0ddX4hPh/ibhJd85dj
 AHww6KoZeNHJXmh/78JngcmWaCo9UhA=
X-Google-Smtp-Source: APXvYqxslIRh+RCZ0j/Zu4cOH8RYuaB5yIXrQ/5cLq285ui2mzkUk6VzQe+PCaU/iVDdYC/9HbtXMQ==
X-Received: by 2002:a17:902:b789:: with SMTP id
 e9mr7636512pls.294.1566838476763; 
 Mon, 26 Aug 2019 09:54:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q8sm551374pje.2.2019.08.26.09.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 09:54:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 09:54:33 -0700
Message-Id: <20190826165434.18403-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 0/1] Fix LP#1841442 for powerpc
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
Cc: qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I only attempt to fix this bug for powerpc at the moment.

For x86_64... there is no existing attempt to handle fp
exceptions at all.  It will be quite the job to fix.


r~


Richard Henderson (1):
  target/ppc: Fix do_float_check_status vs inexact

 target/ppc/fpu_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.17.1


