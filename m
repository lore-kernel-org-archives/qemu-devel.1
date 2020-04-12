Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C6C2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF1A206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlDD9CHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF1A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjwC-0006c0-AZ
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jNjt1-0002AF-TJ
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jNjt0-0005ZP-AH
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:46117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jNjt0-0005Yz-3v
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:11:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id x2so2713071plv.13
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=znwQGzpwVZMT8/oRR4xUarlSwmHNfQ3WO6PxGITHhHM=;
 b=zlDD9CHJj5U7NRwyGJaiFz+7npyDx26x9E/UMl9IMjRD9+7UoaT28sSUxkeGYmyL54
 VZu3U7/NO9A+iCvfopGeLeBHzWvx/tfOgkZU2q0qLcw4K3ib/HXWj1OHsb17mAyAU4F0
 eUR8Ub1+WaDD+Wow9N17R6NS+AAX10wlveDEgmJ5fz6VDjlDo0LugEs75ciXXKgzNyh2
 iXw8FzCFr+4+KnloaWEmMt4S1fkHXUpUE8imV1c12SSqyuwT/Fi3OjSpgaYnwtpCAdxg
 eIoDXwGw9qVh/Px3wn8ZGZvDmtj/ZrbSMkaLn/ARwFJ4HQ4QK/+FoNMIXdjLl0jW70fw
 vBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=znwQGzpwVZMT8/oRR4xUarlSwmHNfQ3WO6PxGITHhHM=;
 b=UG8g+ksXQ2/XJAb6ALD773cLnjWtl8gtzv+HMm/cQGbTYQLk7j+qmfZkJ3YSDs6W+u
 uUTERnZYfuC2zDb0RqRmcUKQTzlYCUPxp8q1FQ+8gEcimz+HL3fMds97nRlAuqLn4eP/
 lQnW7OJmdyES1xDff2RV8ajs9jvLB6GHGrbB1pY6T55VEcqiXDGPV1OqNxGCge7KFIDE
 V0gA5RcWti9Flt+6cCxdpMBHmIy7idB6vWbgNAHq3UbaITGDS0OdGowhI0Mj8P6ll6OD
 3VUWpB4Uobg90THCg2WEA3eROjJoCCB1GTwSllQS6wKkXV4aO0D44rUVeJ1BuEwokQul
 1rrA==
X-Gm-Message-State: AGi0PuZVngtFzGPYU0NQj4v9jvdmQUq6Sv9EKnLM0XL5LujGUijKZTbE
 OvSjQaRyaJL4AzKBPZvpp+un14NPUbY=
X-Google-Smtp-Source: APiQypIZptAOc5GvIMjXRy9zE0eykQLlewC8uwPC1p+BiDGymsih5xp1NlRakYyCSK0dyiZI20EQYg==
X-Received: by 2002:a17:90a:17cc:: with SMTP id
 q70mr18185040pja.26.1586725883669; 
 Sun, 12 Apr 2020 14:11:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id jx1sm4916804pjb.5.2020.04.12.14.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 14:11:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/1] tcg patch queue
Date: Sun, 12 Apr 2020 14:11:20 -0700
Message-Id: <20200412211121.13579-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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

The following changes since commit 17e1e49814096a3daaa8e5a73acd56a0f30bdc18:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-04-09 19:00:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200412

for you to fetch changes up to a4e57084c16d5b0eff3651693fba04f26b30b551:

  tcg/mips: mips sync* encode error (2020-04-12 14:07:07 -0700)

----------------------------------------------------------------
Fix tcg/mips barrier encoding

----------------------------------------------------------------
lixinyu (1):
      tcg/mips: mips sync* encode error

 tcg/mips/tcg-target.inc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

