Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD234C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A68205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 04:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrUh6pSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A68205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKxdZ-0008LJ-Q3
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 00:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcU-00074a-6n
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKxcS-00024I-OY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:37 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:41588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKxcS-000241-JN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 00:42:36 -0400
Received: by mail-pg1-x529.google.com with SMTP id t3so558493pga.8
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=VGGT3zBbzVc/cTftpyLP217c9MkvFdIixs9regxae10=;
 b=ZrUh6pSWLktkvMbmRVVzxc8zMZFJfq0BgGhuGdGCzwN/hKtq68o0/ljkdRStxOuq6z
 IUjMU3FcxVTMnO6F3wxxPH+PPGvJOaXnTQOAKg7+FNrdfibPAxEZdQgIbO1FT4WGjj7h
 /BZeuZmXNSOr7zXiKTVD9gGnVfpEo+GET7dyU+olHUk0+ZjraIvcZ6hZvpZSVHjeK6Mk
 IejJ1NfVaHqdNTakupY979pp7abpWdWW1facPRGS36gWE2cx2m7yLSOkpRGVwyP0BYvb
 cfIdLOvVqcPz+fJEMCNuVGgnzwjU3GXdZpk2iocqX34zncc/MOaa1e8S7QLt9m7KtoE0
 Y7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=VGGT3zBbzVc/cTftpyLP217c9MkvFdIixs9regxae10=;
 b=QuUyqGu19IYk3XdwJWpfhckKIlyvFS+piwQ9JY0gLeBzR2FaPj4FGo7MVU9EpZQKSM
 sP6lRvqENCFa77dCPlXMTDzxygToyIcRBMcrjO18oRoikuIu08nPT5u5nRziRwZNDgqU
 xub8gF6RPgNMNdMcpFQqprOu4LBcWMwUNxsjazp/0JQGTxSSLr3VOfBDKuhnwripVepv
 /LDeGeX5ZiSnjnCFWBsCBAU68yIowgFbInwpFWOqsD9kAcRTNDsJoCcchztggfkbKPjA
 rp8WT8d1eYV2+ic0fLcXqEKTOv3Z8uzyrnBCdNG1spmtNK/hyExfLiqk0I8w1I3Pz40c
 FQLw==
X-Gm-Message-State: APjAAAWALmB6SYdw5TO9JuPmEBoc2YHJTtY9lMeiClaH+4S7JRdaJCWk
 xdksEgwXYtXruNmsNGMPhDmxcsOyYak=
X-Google-Smtp-Source: APXvYqxJywoAf2w+8oBFTEU7GzEkVz9YRWj3M+SMn9jkNWYZuHr0H0K4DIMfB0IpGwiEWFjWPG3XAQ==
X-Received: by 2002:a63:5a03:: with SMTP id o3mr1846145pgb.381.1571287354897; 
 Wed, 16 Oct 2019 21:42:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n15sm718923pjt.13.2019.10.16.21.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 21:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm vector improvements
Date: Wed, 16 Oct 2019 21:42:28 -0700
Message-Id: <20191017044232.27601-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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

The first patch has been seen before.

  https://patchwork.ozlabs.org/patch/1115039/

It had a bug and I didn't fix it right away and then forgot.
Fixed now; I had mixed up the operand ordering for aarch32.

The next 3 are something that I noticed while doing other stuff.

In particular, pmull is used heavily during https transfers.
While cloning a repository, the old code peaks at 27% of the
total runtime, as measured by perf top.  The new code does
not quite reach 3% repeating the same clone.

In addition, the new helper functions are in the form that
will be required for the implementation of SVE2.

The comment in patch 2 about ARMv8.4-DIT is perhaps a stretch,
but re-reading the pmull instruction description in the current
ARM ARM brought it to mind.

Since TCG is officially not in the security domain, it's
probably not a bug to just claim to support DIT without
actually doing anything to ensure the algorithms used are in
fact timing independent of the data.

On the other hand, I expect the bit distribution of stuff
going through these sort of hashing algorithms to approach
50% 1's and 0's, so I also don't think we gain anything on
average to terminate the loop early.

Thoughts on DIT specifically?


r~


Richard Henderson (4):
  target/arm: Vectorize USHL and SSHL
  target/arm: Convert PMUL.8 to gvec
  target/arm: Convert PMULL.64 to gvec
  target/arm: Convert PMULL.8 to gvec

 target/arm/helper-sve.h    |   2 +
 target/arm/helper.h        |  21 ++-
 target/arm/translate.h     |   6 +
 target/arm/neon_helper.c   | 117 -------------
 target/arm/translate-a64.c |  83 ++++-----
 target/arm/translate.c     | 350 ++++++++++++++++++++++++++++++++-----
 target/arm/vec_helper.c    | 211 ++++++++++++++++++++++
 7 files changed, 562 insertions(+), 228 deletions(-)

-- 
2.17.1


