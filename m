Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB501C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7682B2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zl3sWEF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7682B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ61-0008CA-J9
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPkq-0005Ew-2i
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPko-0007PM-Jq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKPko-0007Oa-DU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:32:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id v4so12819350pff.6
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=H6OVoJrQX7RGgK41fMCeCXgNG3P+xR1iomsErR3VVAM=;
 b=zl3sWEF/MS+j7lZIxe67oEtKIkuRKHcYsJsQmpsETegnV9urD4UhOJay7qRlZr4wJ/
 u+bo9vuXgGYQyuGtzTSdIf9Tqo777e+BN3QdZ0cm1lnVz1NxvLQ6Rrd2qbJRP8cIKHDn
 p1DQfdDXHiTFLwI5h4jop8b5DGm4XmcWh4HfiWuL627yxIkFbr5rr3wK03alxevF/+8x
 BlRjvg/regGi5camyzZkQN3uKEP2lXKg0rqQGrD4kAeCCZf/T+rMXpsjQBy0B8GNA2d/
 fXQfHMQkhcUVr0joFzR69OAqvVWpPp8vNKj1oCk+bvet4dV8HMv7kQJ20SuLA/LGPCdG
 ebFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=H6OVoJrQX7RGgK41fMCeCXgNG3P+xR1iomsErR3VVAM=;
 b=DpSbhvtWOcheXMhtSrZS/X5jjJu+L6E9T2aPVmrkD7AOJtUNHqokQllQJM8aEW989v
 P2oaLbWrNhoZ+15LGYogWvJ23BH+uNS5wl3eUtvtcSBAz33Mqclen0mMxYW+msjp66Nj
 JHWklxO/A7qB5kTRsqhdPmQALTeGY9eOI+uNb/wah03JaXBe81JoqZT1G0qAKPxEelDI
 gnBclNffGynYE77UDgON9r2zFclu3H3pvf4FsLbohDtDLSGURT7FalOCJ5QPhc0ippzd
 7Z03ntKyLCBZ8tSbfFT3SYqIVGnGumh2bttEasiTuKdn1UTX8R1iXHHo2TRmBcLY7zKG
 1fgw==
X-Gm-Message-State: APjAAAU9td4nEN+T2ilnAJ7UpomH33WFLJZofhSQXwEpcHr29z4S4SfM
 sgerxn3j8XhmiMM6gkbbaFsdD1BAs8Q=
X-Google-Smtp-Source: APXvYqzBSIejfbnTGYu/rKwYuL+CBJZlrEzvovRwLCj46tJARhIUOhB7kOuYYfr/XiwGD/hLpj99yg==
X-Received: by 2002:a62:1dd2:: with SMTP id
 d201mr40173621pfd.131.1571157176172; 
 Tue, 15 Oct 2019 09:32:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm20082824pfo.33.2019.10.15.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 09:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Implement ARMv8.5-MemTag, user mode
Date: Tue, 15 Oct 2019 09:32:48 -0700
Message-Id: <20191015163254.12041-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: elver@google.com, icb@rice.edu, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a refresh of the user-only patch set from March.

I do not attempt to implement any part of a kernel abi wrt mmap
and/or mprotect.  Instead, it uses a x-tagged-pages property to
assume that all anonymous pages have tags.

The tests added are disabled by default, but do pass if you have
binutils 2.32 installed.


r~


Based-on: <20191011134744.2477-1-richard.henderson@linaro.org>
("target/arm: Implement ARMv8.5-MemTag, system mode")

Based-on: <20190803210803.5701-1-richard.henderson@linaro.org>
("target/arm: Implement ARMv8.5-BTI for linux-user")

Complete tree: https://github.com/rth7680/qemu/tree/tgt-arm-mte-user


Richard Henderson (3):
  tcg: Introduce target-specific page data for user-only
  target/arm: Add allocation tag storage for user mode
  tests/tcg/aarch64: Add mte smoke tests

 include/exec/cpu-all.h            | 10 ++++++--
 target/arm/cpu.h                  |  4 ++++
 accel/tcg/translate-all.c         | 28 ++++++++++++++++++++++
 linux-user/mmap.c                 |  8 ++++++-
 linux-user/syscall.c              |  4 ++--
 target/arm/cpu64.c                | 20 ++++++++++++++++
 target/arm/mte_helper.c           | 35 +++++++++++++++++++++++++--
 tests/tcg/aarch64/mte-1.c         | 27 +++++++++++++++++++++
 tests/tcg/aarch64/mte-2.c         | 39 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++++
 10 files changed, 173 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c

-- 
2.17.1


