Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308FDC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DF921726
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCnDlNNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DF921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu1Gx-0002cn-4s
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 17:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GD-0000xa-KE
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1G5-0005MO-Hm
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hu1G4-0005LX-NM
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:08 -0400
Received: by mail-pl1-x643.google.com with SMTP id az7so34925757plb.5
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=NSPLjACG69kNYWPaNBk+06B1y1rFaDkEzgMb35jlC8g=;
 b=oCnDlNNf5zNP3/Oi+lvw0lUsjJpABryCJ+9Jb9i/DaJgNIytsrFiiyfeWkedYUEXtL
 dJjzmeBuc8pYvNjXU2A6PD4Ygjg6nyzFS9RZMXYr01n1oCaqwy1qIiVXQcQzWlSq5DBM
 l/chYORv/qjUFsuVWPP3pxQY/24q3gwokexTc5/HG0msH7LtDKJOBgQfjhkXg/vXtjP3
 WQoDMb7hGxzNi62o2BzHXk865GiC0wMA46DRCpAo9rn5SML4GFNEBtvkQbdBL0i+6ar8
 jKsuxD3QuJuCv4ZFQ/8LTw0w9rJ6ID8hk1AWj/vafPx0rNv4k7iXxy/8DWCpHDS08Dx3
 rNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NSPLjACG69kNYWPaNBk+06B1y1rFaDkEzgMb35jlC8g=;
 b=tjX6mxAo5Ws3AV2Q63LpeT2h9tGTUYpMi6gH5WA7h7L1wlo1dsCxU9gz5ueEZVvLn2
 dd+ljKAbicLHokP0T3Gz7TgUxWK3kozdIXELgfTyTPThJmgrXweA0EFTsIPyQkxxNw22
 5UUcdGMjZ+SfP1w5gH8vq810UjeCBH/OLm/J+zWgB+lw7cB8LpfGKoHQhsEs+9/i7sTE
 qoYEEffQUZi3IRPVbFzKdFxAYncEpAc5Z1vvb2BVKhvmwBmtVT5fyurbQi0NbjWUcmi2
 Qjec6BYYLtXIU5l0doZhOWM7oNHWqvQAU5/1VKyoAsD09gxCXj1ZMWpk3614irBmDixn
 TOCg==
X-Gm-Message-State: APjAAAWRKB2rQLqKi/JhwNk07w2IWZcwjW4S+OcOO1XI9UPCrw6nFsDV
 BwE7Y4dMnn/fzd2ZtYHcdpAq5rAKntg=
X-Google-Smtp-Source: APXvYqyHAY3ScBRbXoWwdAJoy2rS58cmuHWiYevubWRtgAUvVaxrBxznA5Wt5Qm9RqKr9i/OP2W+gg==
X-Received: by 2002:a17:902:1e2:: with SMTP id
 b89mr30397176plb.7.1564866487066; 
 Sat, 03 Aug 2019 14:08:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm110129644pfa.90.2019.08.03.14.08.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 14:08:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 14:07:57 -0700
Message-Id: <20190803210803.5701-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 0/6] target/arm: Implement ARMv8.5-BTI for
 linux-user
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v6:
  * Rebased on the ARMv8.1-VHE patch set.
  * Review from Dave Martin:
    + Remove PSTATE.BTYPE adjustment on syscall entry.
    + Rely on PT_GNU_PROPERTY to find the NT_GNU_PROPERTY_TYPE_0 note.
    + For the test case, add a linker script to create the PHDR.

Changes since v5:
  * New function to validate the target PROT parameter for mmap/mprotect.
  * Require BTI in the cpu for PROT_BTI set.
  * Set PSTATE.BTYPE=2 for the signal handler.
    Adjust the smoke test to match.
  * Tidy up the note parsing.

Based-on: 20190803184800.8221-1-richard.henderson@linaro.org
"[PATCH v3 00/34] target/arm: Implement ARMv8.1-VHE"


r~


Richard Henderson (6):
  linux-user/aarch64: Reset btype for signals
  linux-user: Validate mmap/mprotect prot value
  linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
  include/elf: Add defines related to GNU property notes for AArch64
  linux-user: Parse NT_GNU_PROPERTY_TYPE_0 notes
  tests/tcg/aarch64: Add bti smoke test

 include/elf.h                     |  22 ++++++
 include/exec/cpu-all.h            |   2 +
 linux-user/syscall_defs.h         |   4 +
 linux-user/aarch64/signal.c       |  10 ++-
 linux-user/elfload.c              |  94 +++++++++++++++++++++--
 linux-user/mmap.c                 | 121 ++++++++++++++++++++++--------
 target/arm/translate-a64.c        |   6 +-
 tests/tcg/aarch64/bti-1.c         |  77 +++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   |  69 +++++++++++++++++
 tests/tcg/aarch64/Makefile.target |   3 +
 tests/tcg/aarch64/bti.ld          |  15 ++++
 11 files changed, 379 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c
 create mode 100644 tests/tcg/aarch64/bti.ld

-- 
2.17.1


