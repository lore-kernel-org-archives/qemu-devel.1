Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0440EFC6195
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41EE2187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+qKLnox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41EE2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSilq-0004jT-IG
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSik8-0003Ee-45
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSik6-0006iS-SC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:35 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSik6-0006ht-MR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:34 -0500
Received: by mail-pf1-x443.google.com with SMTP id c184so2813854pfb.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=i6s8Az0FUsPJZ565XYdvaeMR1+BDJ/EdtPYoO0AA8QY=;
 b=U+qKLnox8zRFWF9g6dDz5f6lGieJxGs8Q8tPlPUNdfbWMAXrzvmqV4KuwmFsG5720b
 vteP04tpekAJCWiVCx5soDDWJv/jmoZtpSISrJhmBmqplh5YNjbFIJ44LArVHbcAMotp
 Hy+mMpNJ1FK07EypORos5KVokhfqvG7KKiH2nBtQvZERBYmlQ9jml62GjYzq5uonYvme
 VPDgaLksXCAdOZnFyYtkGcABHaHIJxTxxn76haTo5qMa7yvQ6KTajCghSh+OEr/I4F5f
 vMoIj3Jj14mzhrugll8PFbxx/yufOSOHHEH6D3jTEAtqhJ4fa4hYvw7/EP1FcjbX0GbZ
 Zh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=i6s8Az0FUsPJZ565XYdvaeMR1+BDJ/EdtPYoO0AA8QY=;
 b=IvtwmDly8fpUE7epjqvb/ScEzqAIRLZmQjpMCeDYA16YQo18g9tfdRy4XMC+yYHeN5
 8YVdSNzqyib1Sxti5yxBJEd11dxr5IOXwt6EDWw8qZlBuVAz0lWEsmLWqIBtOumZtrcF
 2r7c6JfC3G9linRBhStQpnPvNE8KR+OLwRtTHgPCWYaJyUcmK/3fKIXh1lad0n693dRA
 PnbrB4Q90xeJtS8qKG5YN+Y54nBdwdGxsCzNMDcHUqdyL+zs35IuVm8RmF0bTtR3KoFm
 8Y/+v03gb5m2u7ZT7GtX3F5M016WQPW6ywANPAhQiKq8lpyXweQkXjuNr15OOcaEFdZV
 ZTvw==
X-Gm-Message-State: APjAAAVb5szdwUHhPyi1Dcif2QgHQLJ2WHd9iezfxRMYfIFi2/Ja4DP/
 D/KAptF1dSyplFg5IpPics7YBUjwFOo=
X-Google-Smtp-Source: APXvYqzbtnE4JVMOL7L0mtoN8QmcqKtdMRGWiwVu/tYpzbATVeb3fOlrV32rz/8Ze/ebQLae5jcWfw==
X-Received: by 2002:a63:491e:: with SMTP id w30mr4755719pga.342.1573136793167; 
 Thu, 07 Nov 2019 06:26:33 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id f8sm3375502pgd.64.2019.11.07.06.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:26:32 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Make the qemu_logfile handle thread safe.
Date: Thu,  7 Nov 2019 09:26:09 -0500
Message-Id: <20191107142613.2379-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds thread safety to the qemu_logfile handle.  This now
allows changing the logfile while logging is active, and also solves 
the issue of a seg fault while changing the logfile.

This patch adds use of RCU for handling the swap out of the 
old qemu_logfile file descriptor.

Robert Foley (4):
  Add a mutex to guarantee single writer to qemu_logfile handle.
  Add use of RCU for qemu_logfile.
  qemu_log_lock/unlock now preserves the qemu_logfile handle.
  Added tests for close and change of logfile.

 accel/tcg/cpu-exec.c          |  4 +-
 accel/tcg/translate-all.c     |  4 +-
 accel/tcg/translator.c        |  4 +-
 exec.c                        |  4 +-
 hw/net/can/can_sja1000.c      |  4 +-
 include/exec/log.h            | 33 ++++++++++--
 include/qemu/log.h            | 51 +++++++++++++++---
 net/can/can_socketcan.c       |  5 +-
 target/cris/translate.c       |  4 +-
 target/i386/translate.c       |  5 +-
 target/lm32/translate.c       |  4 +-
 target/microblaze/translate.c |  4 +-
 target/nios2/translate.c      |  4 +-
 target/tilegx/translate.c     |  7 +--
 target/unicore32/translate.c  |  4 +-
 tcg/tcg.c                     | 28 ++++++----
 tests/test-logging.c          | 74 ++++++++++++++++++++++++++
 util/log.c                    | 99 ++++++++++++++++++++++++++++-------
 18 files changed, 273 insertions(+), 69 deletions(-)

-- 
2.17.1


