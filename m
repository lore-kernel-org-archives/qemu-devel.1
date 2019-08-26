Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E229720828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEuyW1+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E229720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Gke-0002AF-Oq
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gib-0000uH-Fz
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Gia-0008F0-AW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:41 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:42630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2Gia-0008EH-3s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:15:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id y1so10155869plp.9
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=XM4xt9aY/yIC8PkPmYKvB3+Fq7o3bJINztaMO4zIW2k=;
 b=AEuyW1+lqfIDyhZE+AVfb9KMkvkU85g7gPfkRlk83spBpW8g2gOgl16vCnNInAkzoJ
 sCzV6D0EBT9gGtO1gDCE75HXs3dW1Gezv/wxdprd4lZxqGP9yEH/aI+PPpKdsfEkUoV4
 5GmajDbOulOAw3MIHjw/pUJyzEqXn0yYXVwHwU/avtVKJxe7ueF9HNMGsoCjCkYg54hR
 GsL4fb4b5TEhVLXbIR+SjH8V3ivsNIx0HQ72xgkvWbGwQaRj7tU299jr8zisgdplW/i9
 WlYxH8MIR2uM7Qd3OI02HhRu/ElqkWmdkneqyROBge4mHY/F9e0mvc/03G7k0rXFKtqf
 97LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XM4xt9aY/yIC8PkPmYKvB3+Fq7o3bJINztaMO4zIW2k=;
 b=ssYMlHjC5UmcclosmgVWibpgM2LvkIyvXHhoklAEa5yVa2UapuIZYHOG+tMG67pHvf
 9wmg1QxNtO735hEcAz4I83aDW2mN2Ge+Gkpmmnudx/aJNaR81+OvLkE3EuZa3/PowC/n
 6GbKBP7TM4jKsuK4mrJ1i8JGbgJRArfoG1ObHTtigRs3+AZkIMy5gETvR/NSETzoHXh7
 0Kvvc2j7YT6+/i2kGegHAyRIGf4Bc8ER/eVpBEN/WkwVBb3UNWi1CFhlnadT8KekBPl5
 Ta1ctCLF0EuidmhvK9PQFrRRVtZE7ww4x7gqGtG3nAfnONjnSfUr/GkbrwYmEq5jbEMv
 FySA==
X-Gm-Message-State: APjAAAVEDwOxYb6+VkLbW8mnKbuzIs9Re7HKSqAEq+HrM18+kEu47lNC
 tSW/RjNlkGlPahBkyWFe5CQTf6Xbvs0=
X-Google-Smtp-Source: APXvYqzsQ50v2xmrTGmGN3ptjZCnf+nyvdOaO0k7PoO7yKKC6hubQo7F/wLIA20/AjXlqQoYw5Cm1g==
X-Received: by 2002:a17:902:9895:: with SMTP id
 s21mr19305645plp.255.1566832538451; 
 Mon, 26 Aug 2019 08:15:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q4sm13563612pff.183.2019.08.26.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 08:15:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 08:15:34 -0700
Message-Id: <20190826151536.6771-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Fix aarch64 illegal opcode
 exceptions
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As Laurent pointed out, gen_exception_insn is very different
between aarch64 and aarch32, so we shouldn't accidentally
redirect one to the other.


r~


Richard Henderson (2):
  Revert "target/arm: Use unallocated_encoding for aarch32"
  target/arm: Factor out unallocated_encoding for aarch32

 target/arm/translate-a64.h | 2 ++
 target/arm/translate.h     | 2 --
 target/arm/translate-a64.c | 7 +++++++
 target/arm/translate.c     | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1


