Return-Path: <SRS0=ZAHP=ZJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536EDC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146F520730
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2019 09:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnPjvF17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146F520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWGWr-0005Uh-4h
	for qemu-devel@archiver.kernel.org; Sun, 17 Nov 2019 04:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGVz-0004Zw-Gx
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWGVy-0004TC-6t
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWGVy-0004SM-0E
 for qemu-devel@nongnu.org; Sun, 17 Nov 2019 04:06:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id i12so15932515wro.5
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2019 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=SGfl2y9lHToEAGK9tMI/T6+zySNivW6LSE2vIExJswk=;
 b=GnPjvF17QUQGd0H4nRB4yrHTxzhBw+2E7tHfDX8E8QuOBTuN/7yqo2LItrVR0w7E+T
 QIh31btITDYs2BIgRs8JKSDFVy7b5sOno51D2poh7hZdQjT/s24fbFz917JZWHO9K7/K
 WauRBUEdx91t/qJIw0R+HRsni/361/MITkg4pef0GHkmu3WksK9mBlIlhp+QZZ8sjYIn
 9x3mcDHOLyh3lSYbd2z6OPI1W5x5dA/YeEFvJJrgnf6DL/Ni67DCkZ2zu5NryrC7PDZW
 eCzm8fbJX8rbwS6jPaWFZ6dukpn6hZL1Mc/y35GDNip/zdKGcLaJcP7oPpB/E3MOCU9K
 oSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SGfl2y9lHToEAGK9tMI/T6+zySNivW6LSE2vIExJswk=;
 b=NujhY/AcjpPq/lhKtSqy8+o+fChZ/9ZF9heSTZEQKoFqBKD6VcthJTwlWzHhaSYGE2
 1+VW1iau5qvrRadPWLkS+Tq/xSPjNiow+7nlrcCmao4jMz2HTghhAQgFwxZ1cQVTSFG/
 e5MXfDyMovU/HW3UVuJWkQN7TFcAwf9pOnOQfBgy6sXvjI+K9KbZeYsIRpYxZZV0Uluu
 YHz7sRLJdLQyo43QSECaEI1WEeA8IJmkN+f4pMG1OQoVSh1sWjPIAcEtI+re5qej1e8C
 k/X3U66MG7/+6AjoAXdYx3pgfCnLCKQDrSeof1iaujygf6Zs1XzwIYatYIFMRO5cJ6eO
 qCDw==
X-Gm-Message-State: APjAAAVsODaCY5gEOgJ9GTv5MoKU255LQWNkqgz/JmRrifx+GftiZEnX
 tic+Ljm5p1VIm2FWbLDC7sywPKCvUmgC/w==
X-Google-Smtp-Source: APXvYqwnRKsLJ7izTpyZbAD0HMcKCCPwAZS3fWVJj4HNz9KNzSocNRiRQx6NoHzjmuHaLJQgCnELDQ==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr23219475wrc.151.1573981596297; 
 Sun, 17 Nov 2019 01:06:36 -0800 (PST)
Received: from localhost.localdomain (180.red-80-27-55.dynamicip.rima-tde.net.
 [80.27.55.180])
 by smtp.gmail.com with ESMTPSA id 91sm19773679wrm.42.2019.11.17.01.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2019 01:06:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-4.2 0/2] target/arm: two fixes for ldrex/strex
Date: Sun, 17 Nov 2019 10:06:19 +0100
Message-Id: <20191117090621.32425-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

During this cycle I added checks for UNPREDICTABLE behavior,
but didn't quite get it all right.


r~


Richard Henderson (2):
  target/arm: Do not reject rt == rt2 for strexd
  target/arm: Relax r13 restriction for ldrex/strex for v8.0

 target/arm/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.17.1


