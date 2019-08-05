Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEE12067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGyUpmg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEE12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huckw-0001fb-7A
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huckP-0000Yf-Jg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huckO-00046w-D3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:09:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huckO-00045R-7H
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:09:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so84482893wru.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PfycPF5aiJmuNstFajU/Uk41X7HWSjK63QrpgD0M47o=;
 b=TGyUpmg/2kGRs4D2xVOEN1JtsN9P0F2e4WjLrFWEDIm1c5UkX4J+wzIItOSMU46GSP
 v9fHjy7vrIAqtDbbU58pA80IAiTZzLGjQcbOn8xzzLOMseZ6CezxMDFzdxXeC9cmaWQU
 Q/Zs8zTWiH4myFzQ+CZ5nuyBdyR6A5JUOz5QzloIY/kKaqVC0lhwvDZ/DVYXVeLH0ba0
 kwDkOfOwZZg66tolcbzmeIAedFADhYwk0HQJ3rCB6xkChQMAgtTM9l1BHMmxe3dmEYM7
 k1Oq9VKgB5Ocz2s1TOR4+RPpt+CCod4dnA8hQ82vQPXQEpDnU91mxs14E2NIrb/W2jFj
 1ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PfycPF5aiJmuNstFajU/Uk41X7HWSjK63QrpgD0M47o=;
 b=a93/dOA0NRRP+WCmHanN0tlM21NL3UjEyUBczFmwgZ4UvPZDxvyznl8D0fINqkqcXj
 iuEZbYzJyn2mjgM7aCGBPkP39G1oO9yVYzowPWDrlCBzESmZ0YluAoNfwGEAvamnjoo5
 sMMRWpDROn3FV8vo4kJtVOCrYRRi521QyzbD853uTnStEij5cGPpXALAOdk5kISRzLxh
 sj3u8k6DzihFY3PLU7Ur24BcWCjNCWKI+TUVM/9E8oW1tyIFgANtntSmkv2d1QgLnDzQ
 e9AN3CVL+PwsQUisKB8ZAUAbAYi+WPQmhUMl2e/xZNQ9xLm6p19iCyStnkUpBssRSghc
 9AcQ==
X-Gm-Message-State: APjAAAWEQQaiTs94SwHVfG6099nbDhCkLPhIvk4Yvt0CSUSmqzy5u1e0
 d5cUd/nJzAiRSiwyarQbujGyTQ==
X-Google-Smtp-Source: APXvYqwisBKksEy09WO+ZJFgemYryilRt3isnFEzVeChqEzOL6YqAQbiQQYzCitkIVHBmavKbVF0Ag==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr59897575wrs.136.1565010594873; 
 Mon, 05 Aug 2019 06:09:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x20sm65233782wmc.1.2019.08.05.06.09.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 06:09:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 14:09:50 +0100
Message-Id: <20190805130952.4415-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Fix routing of singlestep
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bug https://bugs.launchpad.net/qemu/+bug/1838913 reports that
when doing architectural singlestepping we send the singlestep
exceptions to EL1, even if the guest has configured the debug
exception level to be EL2 or EL3.

This patchset fixes that, by putting the debug target EL into
the TB flags and sending exceptions there, rather than sending
them to the default exception level.

Patch 1 is a preliminary refactoring out of the "generate the
exception" code into translate.h; we then have a single
place to do the actual fix, which is in patch 2.

(This bug has been present for ages, and it only affects
guests that try to do debug to EL2, which is pretty rare,
so it's not 4.1 material, especially at this point in the
release cycle.)

thanks
-- PMM

Peter Maydell (2):
  target/arm: Factor out 'generate singlestep exception' function
  target/arm: Fix routing of singlestep exceptions

 target/arm/cpu.h           |  5 +++++
 target/arm/translate.h     | 34 ++++++++++++++++++++++++++++++++--
 target/arm/helper.c        |  6 ++++++
 target/arm/translate-a64.c | 21 +++------------------
 target/arm/translate.c     | 24 +++++-------------------
 5 files changed, 51 insertions(+), 39 deletions(-)

-- 
2.20.1


