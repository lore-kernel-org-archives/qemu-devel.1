Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82838C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B98020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWZPqBcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B98020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v6J-0006CQ-DP
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4w-0003A5-F0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4v-0001WS-Am
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v4v-0001UF-2W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id r11so3166917wrq.10
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0IbAcXPnVNL1M99L3vAYUmiNlHM1q7zQnW91i3q1wDA=;
 b=QWZPqBcFTCdv7WOOpHVWZDV/ymF78kcO/Fc0ryg0eviHt2zwKsItSZrFaU1CW1wbKi
 GUNfwQx929V7pfvYfXPld4QaedcNr4fxQdiSTlNFoesOQ0PJIPVKs/Me2MSZUtjKRAY0
 tAstrhN5M2gtdrzUWYkaDEdIrk2RbLXa55C2W+EeWe7e8T386YcEvh9nN7gLJgNTY83n
 syHOYNzZrOCTz5XHnLYvB0vbqKKJBQdYMwaPVAv7q5L34DTNPEbuHqLw/yDzzIgNrC9B
 1hs3IA6Wkwpc37LBdtIehI+iTvr2X2oUjI1eqf6NACs5WZi7fMdTnmOx+6Elvjr1DXcE
 g8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0IbAcXPnVNL1M99L3vAYUmiNlHM1q7zQnW91i3q1wDA=;
 b=pDAiiM+t46LAUNR7A5kLhFYOGrOG8iCp+2ELvoK3CGr16zRdW/uRAnw3GKbtBWup6l
 b8E9x1U70djtJVMlL3SEjHq7Z/6n+oRU5MnZgLCcpBtXR9nhi+eXU8NGPFikc6SLyZV3
 x41Gy9EgoIR/5HPukqptoj3CjVefBBEa4mmOh7Q1snn0lFAxZmCkHUv7el8g1w0ctGNH
 /llzek5V2hugxasYv8e5xH6hUZZnJ5yU16IdW0HdJRrPkw/S2jHo4AlqTICtNlJdeOUB
 3djPLcNsAWmIisObSB3ESrGIBPaoUF3JuEXa5dHBCtdigLoHqxnG3iL6qN5vD+cOkd5+
 Oz9g==
X-Gm-Message-State: APjAAAX2IFJwvQ790Px/K2ZMkHBL6mWFPiktCwKJG6a8x9ItLBWZbOn7
 0ms/q7gAmpgHi3qShnoupxjab+Gm
X-Google-Smtp-Source: APXvYqyZi80wt1E2NY1+eD3wBELScR1fzEb4QXOjvaIB1C5nimMW+S4Yak3UTin24iDg7w7lA4x/ZA==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr15809499wrp.355.1581525691395; 
 Wed, 12 Feb 2020 08:41:31 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Mini misc patches queue for 2020-02-12
Date: Wed, 12 Feb 2020 17:41:20 +0100
Message-Id: <20200212164129.6968-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-02-04' into staging (2020-02-04 16:12:31 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to be02cda3afde60d219786e23c3f8edb53aec8e17:

  target/i386: enable monitor and ucode revision with -cpu max (2020-02-12 16:29:51 +0100)

----------------------------------------------------------------
* various small fixes and cleanups
* fixes for the ucode revision patch from the previous pull request

----------------------------------------------------------------
Luc Michel (1):
      seqlock: fix seqlock_write_unlock_impl function

Marc-André Lureau (1):
      minikconf: accept alnum identifiers

Pan Nengyuan (1):
      vl: Don't mismatch g_strsplit()/g_free()

Paolo Bonzini (5):
      exec: do not define use_icount for user-mode emulation
      build: move TARGET_GPROF to config-host.mak
      target/i386: fix TCG UCODE_REV access
      target/i386: check for availability of MSR_IA32_UCODE_REV as an emulated MSR
      target/i386: enable monitor and ucode revision with -cpu max

Peter Maydell (1):
      Remove support for CLOCK_MONOTONIC not being defined

 bsd-user/syscall.c        |  6 +++---
 configure                 |  4 +++-
 exec.c                    |  8 ++++----
 include/qemu/seqlock.h    |  4 ++--
 include/qemu/timer.h      |  5 +----
 linux-user/exit.c         |  4 ++--
 linux-user/signal.c       |  2 +-
 scripts/minikconf.py      |  2 +-
 target/i386/cpu.c         |  2 ++
 target/i386/kvm.c         |  7 +++++--
 target/i386/misc_helper.c |  8 ++++----
 tests/check-block.sh      |  2 +-
 util/qemu-timer-common.c  | 11 ++++-------
 vl.c                      |  2 +-
 14 files changed, 34 insertions(+), 33 deletions(-)
-- 
2.21.0


