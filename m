Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77303C33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDC620732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHAsmP0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDC620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoNA-0003by-E1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60754)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <36dw4XgMKCn4lm1iqqing.eqosgow-fgxgnpqpipw.qti@flex--jkz.bounces.google.com>)
 id 1iyoMH-0002XH-BI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <36dw4XgMKCn4lm1iqqing.eqosgow-fgxgnpqpipw.qti@flex--jkz.bounces.google.com>)
 id 1iyoMG-0002ia-1S
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:37 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:32954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <36dw4XgMKCn4lm1iqqing.eqosgow-fgxgnpqpipw.qti@flex--jkz.bounces.google.com>)
 id 1iyoMF-0002ZD-PU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:35 -0500
Received: by mail-pg1-x54a.google.com with SMTP id 37so1754426pgq.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=DpLt7V+1OL8Lj3N3GPKXUQ3O11Q0zkCbfAvIh2ChTY8=;
 b=YHAsmP0peqI4Q0lXZYOpEaLBMnL/ZbDadWF6DVQ7Z6PBp5fYGTFjdPJ/MVDEa08aH3
 9VWI+RPREZVkOyqMPwb+VClxetD7+S40QLGufVMs2UTtQZzsoZXOKcehXONYhDX9glkv
 46STbUNGWeoCoQ2YDuChtFgOIfUL9KJ7FETYXOjDdYJzys82+7vUEH52B8jyUc4n/6lZ
 cM3YAMh3bUjPa+Z0UW092ea4mbkg4gqbDrT05EvQqUS59ONTyA/kcqpbNm9eX2/NQCUg
 je3gfvyHVG9mVRDpjUwX/35cq68OGpj8CX1VAFqxniyy54u1ZoXMLdAkUKqJNL/+A0oF
 TFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=DpLt7V+1OL8Lj3N3GPKXUQ3O11Q0zkCbfAvIh2ChTY8=;
 b=hNhocU6lRrxiApLRHAQ6vkmzFNrfRcjSAQ8LFMYlOXZ7Sg8EJDSYtxum/ust9SuYlX
 e+xeonijWBMvvGvJIWpB1aauGsb9UdU+JH5v9kCnTrfIxMRcMmUJAS2N5nh8GtjmDLkI
 +iqIuSaf2nWkyrYzf8eLpieOFjz63D1+8eGwLfLfid0X/yj/mZKrTXSzu+CQ2nkSENzz
 NRmDq3Ap/YlywUXPXJcJdUl7BqedqkG1McqdLg2H/ZFWsnS1vHuGzgw4BOc6qYYFYc9z
 8/FFaZ6w2eavxKQjsfLo2tstTd3e9stBL4JcMWu7on5rKwZ4XTl/O/maYvsRVk9TxJ7w
 p92g==
X-Gm-Message-State: APjAAAWMyYTHkfiDpNBWnUf72lHeoAIFbop6dccSKT+Cjv9md/OxTviK
 Qq2RL2loPl6ATADiAV/SbIcVGynz6TQAv7xw/mYUEZgbN3kzHmq4Q7zDOwr48Sa4Xq9QWYNBeOL
 ec2ZvscpCMM0DLft4DalwlbwATOXs5TS8mki4jBFTrhIypIy79Z8j
X-Google-Smtp-Source: APXvYqy++v937S8BKr725XnrxdtbRMbJtVqW58RCCqIBy36IeCQpS0xK4jxqspriWOlAyumh+WscMxQ=
X-Received: by 2002:a63:6a02:: with SMTP id f2mr29351351pgc.219.1580784873939; 
 Mon, 03 Feb 2020 18:54:33 -0800 (PST)
Date: Mon,  3 Feb 2020 18:54:12 -0800
Message-Id: <20200204025416.111409-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 0/4] migration: Replace gemu_log with qemu_log
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::54a
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

Summary of v2->v3 changes:
  * Removed assert for CMSG handling, replaced with LOG_UNIMP. Will
    switch to assert in follow-up patch.
  * Fixed BSD-user build (dangling references to qemu_add_log), and
    verified the user-mode build works.

Summary of v1->v2 changes:
  * Removed backwards-compatibility code for non-strace log statements.
  * Removed new qemu_log interface for adding or removing fields from
    the log mask.
  * Removed LOG_USER and converted all uses (except one) to LOG_UNIMP.
    * One gemu_log statement was converted to an assert.
  * Some style cleanup.

The linux-user and bsd-user trees both widely use a function called
`gemu_log` (notice the 'g') for miscellaneous and strace logging. This
function predates the newer `qemu_log` function, and has a few drawbacks
compared to `qemu_log`:

  1. Always logs to `stderr`, no logging redirection.
  2. "Miscellaneous" logging cannot be disabled, so it may mix with guest
     logging.
  3. Inconsistency with other parts of the QEMU codebase, and a
     confusing name.

The second issue is especially troubling because it can interfere with
programs that expect to communicate via stderr.

This change introduces one new logging masks to the `qemu_log` subsystem
to support its use for user-mode logging: the `LOG_STRACE` mask for
strace-specific logging. Further, it replaces all existing uses of
`gemu_log` with the appropriate `qemu_log_mask(LOG_{UNIMP,STRACE}, ...)`
based on the log message.

Backwards incompatibility:
  * Log messages for unimplemented user-mode features are no longer
    logged by default. They have to be enabled by setting the LOG_UNIMP
    mask.
  * Log messages for strace/unimplemented user-mode features may be
    redirected based on `-D`, instead of always logging to stderr.

Tested:
  * Built with clang 9 and g++ 8.3
  * `make check` run with clang 9 build 
  * Verified:
    * QEMU_STRACE/-strace still works for linux-user
  * `make vm-build-netbsd EXTRA_CONFIGURE_OPTS="--disable-system" \
     BUILD_TARGET="all"` passed.

Josh Kunz (4):
  linux-user: Use `qemu_log' for non-strace logging
  linux-user: Use `qemu_log' for strace
  linux-user: remove gemu_log from the linux-user tree
  bsd-user: Replace gemu_log with qemu_log

 bsd-user/main.c           |  29 ++-
 bsd-user/qemu.h           |   2 -
 bsd-user/strace.c         |  32 ++-
 bsd-user/syscall.c        |  31 ++-
 include/qemu/log.h        |   2 +
 linux-user/arm/cpu_loop.c |   5 +-
 linux-user/fd-trans.c     |  55 +++--
 linux-user/main.c         |  39 ++--
 linux-user/qemu.h         |   2 -
 linux-user/signal.c       |   2 +-
 linux-user/strace.c       | 479 +++++++++++++++++++-------------------
 linux-user/syscall.c      |  48 ++--
 linux-user/vm86.c         |   3 +-
 util/log.c                |   2 +
 14 files changed, 387 insertions(+), 344 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog


