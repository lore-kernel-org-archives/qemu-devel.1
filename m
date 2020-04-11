Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE73BC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A325A2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE4aLBDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A325A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKtx-0006tW-Pw
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKst-00064t-Mg
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNKss-0003Nw-Gp
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNKss-0003Mr-75
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:29:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so5786131wrc.8
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yke3ZUKLJw+XC60Tce2n/o76EfZwrO98UJAy7mH0SQo=;
 b=gE4aLBDyGbvnhWJZyoSTRRmjk69xxrK8pmE6NJIf8NbqzuECbhoPncikVT8r9fq2gm
 3n1ttc0tY+Fscl/B90erOJoQ8CsCR5TZEuj8bSldrgVblg1zLQynscS/C6OWe1qw5Ssu
 PjFyraW6EAAbR9dIlhnuFlhn40+7qbBtsCJKjpiDFT7hA2ejAfNHPeatQuSwGzc931P4
 uqx4iYwtWY9YtELyl0y8pLTO5PhHmFc0KBy3HTnRX/0BR3Ywgp6gE2KXsv4p6liBTRqF
 DtmAtI7OcU3769XS2Dqzk/2l9tIb+KWB7Ofvzgxswq0A8hByzn5hNYM28ZSJeRWOYNYb
 vaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Yke3ZUKLJw+XC60Tce2n/o76EfZwrO98UJAy7mH0SQo=;
 b=mdULb/rh/hfp3uxhPDmNJ5LatsBcAwPVY/ty9JukDaiYs+78mJ+koF5bWev/vfVQES
 1H37YaD8J/UxTMn3q8/QOsJBBttfgAFDD4CzCeglVzjAEmMwiI21U5o3VDj0QUEFmYm3
 7ROYxB6IXCglKAbRbmpyZac+6HShZ9DMRIR31ihdOpJLoBwWaibXWRfFt76pkXiyErRp
 mECAktlQf8tFww3g9HJ28b/U9JZue/+0y5Oll8H/1kiqrzDIjk/48UVHQ+3YLX/gvFmU
 Sroadhbm0AyZ7vwBHR9hmwF721+yYBmPTUAj7TZUJOys0rrqm5OwoYXjCdyXm4PO/64i
 JKMw==
X-Gm-Message-State: AGi0PuZq7OIkI1vBMFuGgfFSdyT2WHKerWe4R/fLaT8wvNRnGzBh3Ov9
 gkF8Ld86jUiuiCSTspGIGlQWGHoL1JOe4Q==
X-Google-Smtp-Source: APiQypI5SNezJJd1ydnjfqgrNarkyV6yUWa36aX4xpIYt5hUpBsRn4YEi37ypOeZ41zvaKTAThEqrA==
X-Received: by 2002:adf:db0a:: with SMTP id s10mr10822813wri.361.1586629776374; 
 Sat, 11 Apr 2020 11:29:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 68sm8910939wrm.65.2020.04.11.11.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 11:29:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0? 0/3] Make docs build work with Sphinx 3
Date: Sat, 11 Apr 2020 19:29:31 +0100
Message-Id: <20200411182934.28678-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current docs don't build with Sphinx 3, as noted in
https://bugs.launchpad.net/bugs/1872113 -- this is a combination of:
 (1) we are using the sphinx-build -W option so warnings are treated
     as errors
 (3) a kernel-doc script bug meant it was omitting a close-paren
     when a function parameter was a function pointer; older Sphinx
     ignored this but Sphinx 3 parses the function declaration and
     warns about it; and because of (1) this is fatal to the QEMU build
 (2) Sphinx 3 makes a breaking change in how it wants C structs
     to be marked up (moving from 'c:type:: struct Foo' to
     'c:struct:: Foo'); our use of the old syntax provokes a
     warning, which again because of point (1) is fatal

Patch 1 extends configure's --disable-werror to cover Sphinx as
well as the C compiler, so that at least there is a workaround
(which will be automatic for release builds).

Patch 2 fixes the trivial kernel-doc bug.

Patch 3 adds and uses a new --sphinx-version option to kernel-doc,
so that our Sphinx plugin can pass the Sphinx version down and
the script can then choose the right syntax.

I've marked this up as 'for-5.0?' because I think it would be
nice if at least patch 1 went in. Patch 2 seems uncontroversial
(though I guess we should forward it up to the kernel folks
since kernel-doc is from them originally). Patch 3 is the
expedient change, but you could argue about whether this is
the best way to tell kernel-doc what to do.

thanks
-- PMM

Peter Maydell (3):
  configure: Honour --disable-werror for Sphinx
  scripts/kernel-doc: Add missing close-paren in c:function directives
  kernel-doc: Use c:struct for Sphinx 3.0 and later

 configure                |  9 ++++++++-
 Makefile                 |  2 +-
 docs/sphinx/kerneldoc.py |  1 +
 scripts/kernel-doc       | 18 ++++++++++++++++--
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.20.1


