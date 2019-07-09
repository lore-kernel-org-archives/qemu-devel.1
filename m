Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F33C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FB1214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPv0t56E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FB1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmKU-00083W-5y
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJ5-0006le-IX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJ4-0001kA-FC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:03 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d]:36957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJ4-0001hs-72
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:02 -0400
Received: by mail-io1-xd2d.google.com with SMTP id q22so19833539iog.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=aslcPXfLU1TSCE/SrDWJaSKWFbXWWjgh8Wz68TylcYE=;
 b=qPv0t56EOYDG4jB984oUtmrVo8l7wVc1yrMQanP/8YxnqZ53eGyPCvGUe3G/43KHh8
 z9d5Wcha5CodNy0G7Dl9UXAo/WEeuDrxM9BYco3YTUnXd3iPzWU64Gj9Lu3rtl5fY4Qw
 44RCOePcOz2wE/rikQIMEH3XHWrwiQQbBRBuRVabUyts4wnIEzg2wSKeQZBXhCWC2lfs
 BQcDJLtch8R8OdFy7VONfFuw1j5BEetPxtFtrytlqUpcdX8PdozX5ejGpDN9F4X977ju
 OP60OjNyOHXE3Yn4hiLpibcpZLB7ng/99wzPVI7BPLxwAMLMt2kLEUYVLeNw7fRXoqmR
 Z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aslcPXfLU1TSCE/SrDWJaSKWFbXWWjgh8Wz68TylcYE=;
 b=nIeERY09+eNWHUxD++d32QS5xBk9J/UryNDrb2c6xr1CPouOnnr2nr3cTeNHYakQDk
 Jqti6VdNwq/UjzWrXmjjQ4f6mwGF1EbYP8bERyNf5lprrlI3J9iOCIkuFjdz5wtazpTE
 /N20uN0ZUp/ck11u8sab9rrBq8cdtxUUKpNrgrCVV/bLXt9RToHsaVgTqey/sxtHQxHo
 LMpfEW+uEfeilLqFD6TqrEFL90ANoptm9McDE7IDKjmrvwIe39o2B0yAuOZx3S/Myjrw
 0x3EieP6L0EI7lHrMpsAXt05oRd3A8rgrRbnTkB0TnwHw/Yoj31bytJn7IkwF7FA/3cE
 fEYA==
X-Gm-Message-State: APjAAAVjwDctFCm/7hsHMv0ihu+9xfP4I/y0J9+aacnp19/MkjkHKUCX
 tgdd+WN0i8jNYwQ6Qhk/grmgx5bnOC0=
X-Google-Smtp-Source: APXvYqw2g4wsJFnzJbrqCDtVMtvlHZi7XM5tu71Evf8qDWnGwyOU8VcxP+g29mnkheZJk+6MuG9Obw==
X-Received: by 2002:a6b:4101:: with SMTP id n1mr57157ioa.138.1562664060818;
 Tue, 09 Jul 2019 02:21:00 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.20.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:44 +0200
Message-Id: <20190709092049.13771-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2d
Subject: [Qemu-devel] [PATCH 0/5] tcg: Fix mmap_lock assertion failure,
 take 2
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While I could not replicate the failure Peter reported, the apparent
root cause -- the old magic fixed page -- should affect other guests
as well.  In particular, the old arm32 magic fixed page at 0xffff0f00,
and the hppa magic fixed page at 0.

In the arm32 and hppa cases that I just mentioned -- but notably not
the x86_64 case that Peter reported -- there is special-case code in
target/*/translate.c to handle those addresses without actually doing
the read from the unmapped address.

Therefore, until we fix these sort of address space representational
errors, we cannot even rely on page_check_range() to validate the
execute access.

Instead, modify the host signal handler to intercept this at SIGSEGV.
At this point we're sure that there is no guest special case that we
have overlooked, because we did attempt the read for execute.

Also, I noticed that we really ought to have some barriers around this
code to make sure that the modifications to helper_retaddr are in fact
visible to the host signal handler.

Also, some minor cleanups to the set of read functions that we expose
for use during translation.

Also, a trivial duplicated condition.


r~


Richard Henderson (5):
  include/qemu/atomic.h: Add signal_barrier
  tcg: Introduce set/clear_helper_retaddr
  tcg: Remove cpu_ld*_code_ra
  tcg: Remove duplicate #if !defined(CODE_ACCESS)
  tcg: Release mmap_lock on translation fault

 include/exec/cpu_ldst.h                   | 20 ++++++
 include/exec/cpu_ldst_useronly_template.h | 40 ++++++++----
 include/qemu/atomic.h                     | 11 ++++
 accel/tcg/user-exec.c                     | 76 ++++++++++++++++-------
 target/arm/helper-a64.c                   |  8 +--
 target/arm/sve_helper.c                   | 43 +++++++------
 6 files changed, 135 insertions(+), 63 deletions(-)

-- 
2.17.1


