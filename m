Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24138C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58382084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tptGsGvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58382084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQEQ-0003Nr-Mn
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPmy-0008AZ-Bj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPmx-0000EO-4p
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:12 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKPmw-0000Dp-Vu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id 23so12476981pgk.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=H6OVoJrQX7RGgK41fMCeCXgNG3P+xR1iomsErR3VVAM=;
 b=tptGsGvcuiDdignTWCEnJsfOkpLL0mIF7qSYukBqx5kpO/ZSgPBfbQJMuhcG5+j6Cd
 IYJzVxNnoNWNq7kI6mVPwx/TEcb+IwiBA4FQbDo9X8RP/o/7iW/7br8byGj0OUnIOhUz
 MZ1aQavjk4sYDWdT6TJHy63BoL2BMA8FuWcozGHEsVHTKxbggSJxWeFk7Pd1vVIo8cfR
 eFsIesGghWdEZa9qRUnu2jyJu53UpOlj8kRMH2GHapngd6ptWpH4v9lu7yhIK8Lt74Ag
 81axfUlVlrDXoBZJv0mbbjbLK5/EbxnOD3AGLm0B5czBMG5yMopjvYcgqKucOT8ew52s
 XLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=H6OVoJrQX7RGgK41fMCeCXgNG3P+xR1iomsErR3VVAM=;
 b=ScwfvQ9SJOG0N3oAkcMnsRzMTQb8vHo4cqgXvk+Xy9LajbWUZSPhcCbz1XKjWXXruO
 1TaFpbVEk1A2NX43jPCln9/nG93wzbCRyFMhe7l+b7czea0T/WuwVVvWgLLvJUB3eUq4
 LnjAX/7twYth/jxEuTQcoVMleKy3s2Bj/II6oMBpebyN9vw506hp5dmT7ARHlmBzUG6L
 YFxwLKZ4SoEDlGX5+1wkkpqSeZDqyBpuYNZmuSrqMAijPDOtV223nv1laca7XhSxFQVj
 9KA1+ohgzX6dDEfeWU7DH1wtZYl0tmQAf4lnmh6YvMHtEivJODL4+Db62dKMRFX86sfg
 j/MA==
X-Gm-Message-State: APjAAAXEQ6fvwLg4rg7yQ5utMvdl1oijwDTNGsyXvvUsJTCcHXeSZal7
 fifHYPa0Kitm6vgHznFCr0BWysoUP1Y=
X-Google-Smtp-Source: APXvYqw8PUUNorYJhXzynVKfMgaumNth08pebIIkQpp2QCiK9KQoCTorLAP8ay0EknlCwOSD8O1yhA==
X-Received: by 2002:a17:90b:d90:: with SMTP id
 bg16mr43937814pjb.143.1571157309569; 
 Tue, 15 Oct 2019 09:35:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m22sm22011593pgj.29.2019.10.15.09.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 09:35:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Implement ARMv8.5-MemTag, user mode
Date: Tue, 15 Oct 2019 09:35:04 -0700
Message-Id: <20191015163507.12153-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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


