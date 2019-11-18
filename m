Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E62C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BE9208CE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNMlAj2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BE9208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoRX-0004js-Vm
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN8-0008Q4-5z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN3-0005hq-Ub
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:33050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoN3-0005hZ-Nt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id ay6so10482166plb.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWgWHy/VsErSeqWDM+/otxG0psdTm5gcLYEEVbdKoW0=;
 b=GNMlAj2l1HjUUaJHvhBCslxnJ1KeT4MIy5WTjsaUqTpabvEf3lTB0yCZHCieirPFeO
 c5WHTJky81py5wkkE2GnMbpG8g3Jru2j59VMbbp7lQy6Cd6wQTPS8ZzlkFfejYpXs4f/
 7nSwqpSu/rWlxLVNSA1tUNqVT9YNmZ/MWz1OOf3TUz2DM4w99sJixru24cwq9mb3itsl
 Jq8zILMc7Ik1FOU6ysLAK9ry4yXUjnJN1ItsnMXz5ldLGJ6h5hpDCbV3NAtf4cBipINl
 5DfeEZHLBPRtpp4MawcqNZt1v6olbzC5gNtzfhb4Tv8VOQ2ThLH8nHh9O9g2/5EhGCtq
 u51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWgWHy/VsErSeqWDM+/otxG0psdTm5gcLYEEVbdKoW0=;
 b=gSmJJfMO86SmQjlDhFE/3GE188QgPPQ4zwUwgNlldQ+HCh5EqZRcK3IAb6CtKF+7wa
 Uxi18buYO9jt0uAqxIV8MaVDr/y1m5czGuGXAWLB5ItZTy4s8v9lSnKB+qJ+VKjQENE9
 XYRPutvvZIKxqaECl55ZxMoPYJ6AqdmxY2Ji7nZDxoSd2b+N3y1TZHnXd6CLJtjicfhm
 xjL4Ruf0GY00c5IRgswfFDL28SZOa7n43QVBGRVQfuemuZOVGVoRm5IbYLA0zvimKFCV
 t2oSPIq61KFN1XKk19S4l6goMT4lm14Q/FOpoFTRoEhbGLkcxfNNA+zLVAxEDqIaEOYW
 9P+g==
X-Gm-Message-State: APjAAAUrZCmSiocGtj0mbLilrENQCjOPVXPF5dWxjpmajPPdXToSa2L0
 ijgkKsxcdsqy1Y4Hr6XnIW3V1E9vY4M=
X-Google-Smtp-Source: APXvYqyJ1eClhvWpcS+dVg/JlhHxK+3WqdiadViKOaSnWfZjz1ehHMSWZIGRj73zLIH3GQ4nXviI6A==
X-Received: by 2002:a17:90a:de4:: with SMTP id
 91mr1366099pjv.113.1574111739882; 
 Mon, 18 Nov 2019 13:15:39 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:37 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] Make the qemu_logfile handle thread safe.
Date: Mon, 18 Nov 2019 16:15:22 -0500
Message-Id: <20191118211528.3221-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds thread safety to the qemu_logfile handle.  This now
allows changing the logfile while logging is active, and also solves 
the issue of a seg fault while changing the logfile.

This patch adds use of RCU for handling the swap out of the 
old qemu_logfile file descriptor.

Also added a few tests for logfile including changing the logfile
and closing the logfile.

One change also added for a pre-existing double free issue in 
qemu_set_log_filename() uncovered with the new test.

We also cleaned up the flow of code in qemu_set_log().
---
v3
    - This version of the patch incorporates a few minor changes.
    - Change patch which adds qemu_logfile_mutex to remove the
      asserts that mutex is initialized, instead we will rely
      on the constructor.
    - Also added details to commit for patch adding mutex to explain some
      unavoidable temporary ugliness that we cleanup in a later patch. 
    - Change qemu_log_lock() to unconditionally hold the rcu_read_lock()
      until qemu_log_unlock().  
    - Also changed one use case in target/tilegx/translate.c
      to eliminate use of qemu_log_lock()/unlock().
---
v2
    - This version of the patch adds some cleanup of code in
      qemu_set_log().
    - Also changed the order of patches to move our fix for the
      double free issue in qemu_set_log_filename() up to the beginning
      of the patch.
---
v1
    - This version of the patch incorporates changes 
      from the first round of review.  
    - It also includes a fix for an issue in
      qemu_set_log_filename().  This issue was uncovered 
      by the test added for this patch.
---

Robert Foley (6):
  Fix double free issue in qemu_set_log_filename().
  Cleaned up flow of code in qemu_set_log(), to simplify and clarify.
  Add a mutex to guarantee single writer to qemu_logfile handle.
  qemu_log_lock/unlock now preserves the qemu_logfile handle.
  Add use of RCU for qemu_logfile.
  Added tests for close and change of logfile.

 accel/tcg/cpu-exec.c          |   4 +-
 accel/tcg/translate-all.c     |   4 +-
 accel/tcg/translator.c        |   4 +-
 exec.c                        |   4 +-
 hw/net/can/can_sja1000.c      |   4 +-
 include/exec/log.h            |  33 +++++++++--
 include/qemu/log.h            |  48 +++++++++++++---
 net/can/can_socketcan.c       |   5 +-
 target/cris/translate.c       |   4 +-
 target/i386/translate.c       |   5 +-
 target/lm32/translate.c       |   4 +-
 target/microblaze/translate.c |   4 +-
 target/nios2/translate.c      |   4 +-
 target/tilegx/translate.c     |   6 --
 target/unicore32/translate.c  |   4 +-
 tcg/tcg.c                     |  28 ++++++----
 tests/test-logging.c          |  80 +++++++++++++++++++++++++++
 util/log.c                    | 100 ++++++++++++++++++++++++++--------
 18 files changed, 268 insertions(+), 77 deletions(-)

-- 
2.17.1


