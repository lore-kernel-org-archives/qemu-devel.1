Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE32C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B4F20684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECyfWCRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B4F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isB4b-0006hG-HM
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3V-0004yX-1c
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isB3T-0007M8-H4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:48 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isB3T-0007LG-9r
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:43:47 -0500
Received: by mail-pl1-x642.google.com with SMTP id c23so8781474plz.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jXy/1lL6+e+ldr6xT+nT+01QQf0eUPsN0Q7trNJBae8=;
 b=ECyfWCRPimOGHp0w01lz+hjD4lxUWkbGtOhNIWMQSpOOXMOHx33Cn2zXBvFlCjAcwt
 UVlvf6ZEBzyaV15kY5pKAfZ/T+ae+cPVcxCCPN3gDpSv6h9rhDgMRFsT3Na5N86bVFrY
 nU8eD9yUMp3UBZCrDgbmrXqCMPTlO6phL7IpmFHYxn1NS7EMi8pScG1IIczY1XKS7SnI
 iV30gMe8PqfGyEbqk7KtkJ+zGD+KpILYkfNpbKfftx60Rg5kwyJPijuQ7ThZL7Tj/ndQ
 d0pDUgy9Eoicj5dg28NunfiH7+RpY6utlgGgf0az1cWAXxWHprWFYVv+99BYbd6N7K4E
 l7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jXy/1lL6+e+ldr6xT+nT+01QQf0eUPsN0Q7trNJBae8=;
 b=BSzqNeme++8jP3kg6gapyJxlos01K5pMm+R4Rq2MFliXH972t9aS+zecjbA1sSe+CM
 1nlC4bp5gNPYdovcNcUfu8gEl+CQ2CqGg39GBteEV3bJ7+nkyR91gJWu0+lPDm6V9shA
 DqwmlsYK0334jk84YrQ47IUO6i+HppZG6Xx2s6Wu3j2VOrqGz6vKjcSzAHjdQL7CtAej
 cTjD2rlrOhZxE4Rv0Dap4Vv68FCOu3Kf27LF+k1qQPW6m3BZwcEfD9ploLgMH71rQMdQ
 HQqIJ4LtJCjwatnpeIJGPXu+WeDRnM0C5L24YmorAEh/1Y+GYDyLxoKangtwfuDS8pr3
 E7kg==
X-Gm-Message-State: APjAAAX4UwAkG+lq55VGa9fttobuSKr2POsSBWvWbLyzL8/3RIJ6KeUu
 SlR4OcdETOA6Acw1oQ5+LQuGjEg9HFs=
X-Google-Smtp-Source: APXvYqwMkJYhe7YKdZG5hSmsAJNZ0l0dNhyXkGbhGTlqoDrDx7acOViuev8Zv8uZdJxHILgLxx5fYA==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr959314pju.57.1579203825380; 
 Thu, 16 Jan 2020 11:43:45 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id g2sm26411831pgn.59.2020.01.16.11.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 11:43:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] linux-user: Implement x86_64 vsyscalls
Date: Thu, 16 Jan 2020 09:43:36 -1000
Message-Id: <20200116194341.402-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v2:

  * Add /proc/self/maps line

	I'm not sure this is really necessary.  The linux kernel
	self-test checks for it, and modifies the set of tests that
	it runs based on it.  But otherwise I think it's unused.

  * Fix errors in base gettimeofday syscall

	This is also checked by test_vsyscall, as noticed by AJB.


r~


Original blurb:

The x86_64 abi has a legacy vsyscall page.  The kernel folk
have been trying to deprecate this since at least v3.1, but

(1) We don't implement the vdso that replaces vsyscalls,
(2) As of v5.5, the vsyscall page is still enabled by default.

This lack is affecting Peter's linux-user testing.

The dependency is not obvious because Peter is running the tests
on x86_64, so the host is providing a vsyscall page to qemu.

Because of how user-only memory operations are handled, with no
validation of guest vs host pages, so long as qemu chooses to
run with guest_base == 0, the guest may Just So Happen to read
the host's vsyscall page.

Complicating this, new OS releases may use a kernel configured
with CONFIG_LEGACY_VSYSCALL_XONLY=y, which means the the vsyscall
page cannot be read, only executed.  Which means that the guest
then cannot read the host vsyscall page during translation and
will SIGSEGV.

Exactly which of these many variables is affecting Peter's testing
with Ubuntu 18.04 of my TCG merge, I'm not exactly sure.  I suspect
that it is the change to drop the textseg_addr adjustment to user-only
static binaries.  IIRC bionic does not support -static-pie, which is
the preferred replacement.  This could mean that the host and guest
binaries overlap, which leads to guest_base != 0.

I vaguely remember someone (Paolo?) implementing something like
this many years ago, but clearly it never got merged.

In any case, this emulation has been missing for too long.


Richard Henderson (5):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls
  linux-user: Add x86_64 vsyscall page to /proc/self/maps
  linux-user: Flush out implementation of gettimeofday

 target/i386/cpu.h          |   6 +-
 linux-user/i386/cpu_loop.c | 198 ++++++++++++++++++++++++++-----------
 linux-user/syscall.c       |  36 ++++++-
 target/i386/translate.c    |  16 ++-
 4 files changed, 190 insertions(+), 66 deletions(-)

-- 
2.20.1


