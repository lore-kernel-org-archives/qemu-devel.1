Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633DC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C442084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmbOHQ0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C442084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irCU2-0005Xz-NY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 22:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54185)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3NC8dXgMKCv0op4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1irCT9-0004e2-Ip
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3NC8dXgMKCv0op4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1irCT8-0000cm-DX
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:15 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649]:34481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3NC8dXgMKCv0op4lttlqj.htrvjrz-ij0jqstslsz.twl@flex--jkz.bounces.google.com>)
 id 1irCT8-0000ad-3R
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:14 -0500
Received: by mail-pl1-x649.google.com with SMTP id x22so4436446pll.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=9Hmtms0P+9luoB1mtfwHX3WqJGaMjNUhOqWgirrPBmQ=;
 b=TmbOHQ0v8/MNuuEgYEXOvBR1ZQqEL5vzym6AlYR8XEdM34wcz30RMmfIeJcNeIUZV/
 hYRMKHZBmczbp6tZcNlXMkt3AXO13KX2yO8AZcIBtH+ahkCnIzKiLGs6nbaKiHN8v0UB
 dKRCChaSd98YZEqfeiN3eC5KVLUF9m7MIHTAspakEajNiHvx0mv1/szuqonP2hkWrZX6
 yEs+giHNOYnKwP5cKUzBpxYp4kg3mwP10M21uzW8Upjut9XxhPjOz1iGg+Xnvb4Y7hop
 tlTkziAdqkmpBBxhX1wVjGGT9yjH94NenRNLKvS+TOye/uZ28kXSUPziTzbNL43kIPdm
 C2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=9Hmtms0P+9luoB1mtfwHX3WqJGaMjNUhOqWgirrPBmQ=;
 b=kSsb4CFhnPATiJSOi1U9i3O6bzevCPgtb8SLoF5MnCsgn4vMavjv6Evp64cZbJWZyV
 zANdo2P9DtLqMj0624hcxD1strpI8Up6McFgb+pjkPA5IApftmrNUb4+AwjSUF0vpGM8
 R2DKR0pfZQWewM3fkFGICv5XvhlfP/057kgrnyCBbgKkWXqGYdaLl5Ern3VE9P3sro+Z
 N163LHD8rYSdZfXpPerf54g/HMiYnSUMsuLBC/InJEV7pMjNgWR0eCZjrjtGr43DX9cv
 hAVTqGbgPDXVTPd9bEKwLUszWxILwNUWva13obTEtN0+/jtrjqOJYuBb2OiZ0CaH+QZm
 DadQ==
X-Gm-Message-State: APjAAAWzopna3qnXsKlL2xRLRLTGMrH/gdNUQ8yTCcW6DT34oHRvPgQJ
 ZorJ52cIOwd7H9z75pcjZkQqxNjFD0eYV9ggdZXWwdeA8PaPs5ygrHWyWpYrxJ4iAsVcbJ8TFVP
 rlrgcoPcStyRDgT7BwlrawMSR5KIzIVuY3+3kXKuCpxSnXiWqMSNu
X-Google-Smtp-Source: APXvYqy700LnE5DfS9ajqqJbcQ279AT9/PohMna/ACxGJuOgVGndlmvaetx3El79d9uW2j4YExicuiY=
X-Received: by 2002:a65:420d:: with SMTP id c13mr24993465pgq.101.1578970932340; 
 Mon, 13 Jan 2020 19:02:12 -0800 (PST)
Date: Mon, 13 Jan 2020 19:01:34 -0800
Message-Id: <20200114030138.260347-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 0/4] migration: Replace gemu_log with qemu_log
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::649
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

This change introduces two new logging masks to the `qemu_log` subsystem
to support its use for user-mode logging. The `LOG_USER` mask, for
miscellaneous logs, and the `LOG_STRACE` mask for strace-specific
logging. Further, it replaces all existing uses of `gemu_log` with the
appropriate `qemu_log_mask(LOG_{USER,STRACE}, ...)` based on the log
message. To avoid potential backwards incompatibility, this patch series
also introduces a new flag: `-no-force-user-mode-logging`. Since "user
mode" logging was always enabled before this change, by-default the
LOG_USER mask is always set. The flag is provided for users that want to
disable LOG_USER. Hopefully, this flag can be removed, or turned into a
no-op in the futre, and -d/QEMU_LOG can be used directly to enable
user-mode logging if desired.

Unfortunately, this change introduces one small backwards incompatibility
for the linux-user tree: If an explicit `-D` option is provided, or the
`QEMU_LOG_FILENAME`_ environment variable is set, strace and user-mode
logging statements will log to the QEMU log file instead of stderr.

Tested:
  * Built with clang 9 and g++ 8.3
  * `make check` run with clang 9 build 
  * Verified:
    * QEMU_STRACE/-strace still works for linux-user
    * -no-force-user-mode-logging uses QEMU_LOG + `user_mode` or
      `strace` can be set in QEMU_LOG to trigger the appropriate
      logging.

Not tested:
  * Build/logging with bsd-user. I do not have easy access to a BSD system.

Josh Kunz (4):
  linux-user: Use `qemu_log' for non-strace logging
  linux-user: Use `qemu_log' for strace
  linux-user: remove gemu_log from the linux-user tree
  bsd-user: Replace gemu_log with qemu_log

 bsd-user/main.c           |  13 +-
 bsd-user/qemu.h           |   2 -
 bsd-user/strace.c         |  32 ++-
 bsd-user/syscall.c        |  31 ++-
 include/qemu/log.h        |  15 ++
 linux-user/arm/cpu_loop.c |   5 +-
 linux-user/fd-trans.c     |  55 +++--
 linux-user/main.c         |  50 +++-
 linux-user/qemu.h         |   2 -
 linux-user/signal.c       |   3 +-
 linux-user/strace.c       | 479 +++++++++++++++++++-------------------
 linux-user/syscall.c      |  43 ++--
 linux-user/vm86.c         |   3 +-
 util/log.c                |   5 +
 14 files changed, 404 insertions(+), 334 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog


