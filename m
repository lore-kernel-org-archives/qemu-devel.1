Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6569CC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F7920863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="vDVO3Hcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F7920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbLy-0004tV-1K
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:58:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKF-0003jm-26
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKD-0007Xk-45
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:06 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:39369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKA-0007RW-6b
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:03 -0400
Received: by mail-it1-x143.google.com with SMTP id 139so1440509ita.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=bsuwyS2u8Xt+rdaCDUMpvkgMCLgh20D23auN3wlsyXI=;
	b=vDVO3Hcui/WX67FStodABMJkZwc8HAwORPKoJycPPkpC+b/2amqFVy75XlzL5udqAK
	whFIhZZktqsbuGdPwdNgpwAe5NzT4I5zgBNc0mQQP68lWTwazKwbnZdQVqNNE7xUXlr2
	pmjIy1o0JsWIk/8slnENypXKym/SKZRVbwYPxfWH4/RTfABbkAECVgxPHt5MN5KFEwWt
	F4QKMcmJhA+wTfWkuGy7JAaTkFwBsNGWFn96nCbs6zDwuL98tjv1a1L+XitjhXJYw6Yg
	e9UpA85Sf1wQggfEb19j20jR5atvp5Uvu9PTfTswdZ6xWT5bbDFeSxzWowPlIZSu78JS
	510w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=bsuwyS2u8Xt+rdaCDUMpvkgMCLgh20D23auN3wlsyXI=;
	b=QiaNaNUiaxHryoUPl+HcNUHqr831UnIL+eqEDLuUJe/WH+igkKQ4uRqfiLrsLRWbLQ
	QLTOH7uUePJO2nGAMq0P+SMrOU+RDu4FbwpE6ANZsZHad4307hg3jA/vcYiuBuqJXN+o
	goDNY/VwNmWwVNvyevA0wNTg/NBlbWoUXtLcp7uTSgdDCwRwhQqi21lfe7BsoM4dDpnt
	eBu8lj9lUWtdy2D+xCArUyyaJIAzbvbYu8eaVo5mo9eiv8J62AcMcSK9qDlUjg1/hrt+
	BhedUa6qOMBREBe6fNwfwCkfybFBwxzSfmpJKbKifFeXrVs6Pad5v3x2O2SR5e92YB2I
	VgdQ==
X-Gm-Message-State: APjAAAWzS6Qxr87RGOvHX1iY5XlT2Nl56r7FqSgEiYqZDc9JIW0v6/H2
	hqSPW5pyAhmcrkAfkxtVOHHeSGnVE8Lr5g==
X-Google-Smtp-Source: APXvYqxsjbBnn5rwa/BbxX1ey0EPG03LOAXlLmcGeQlH4ZhhE3czKsVYObjH8yHo26ag8DQqtypXpQ==
X-Received: by 2002:a24:43d1:: with SMTP id
	s200mr23990206itb.155.1554757018236; 
	Mon, 08 Apr 2019 13:56:58 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.56.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:56:57 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:43 -0400
Message-Id: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement missing
 AMD pflash functionality
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205543.6cZrkGhTwyiQvPlJNwNwY1RCBVl_WkDKDda5MtsI6r0@z>

The goal of this patch series implement the following AMD command-set parallel
flash functionality:
- flash interleaving;
- nonuniform sector sizes;
- erase suspend/resume commands; and
- multi-sector erase.

During refactoring and implementation, I discovered several bugs that are
fixed here as well:
- flash commands use only 11-bits of the address in most cases, but the
  current code uses all of them [1];
- entering CFI mode from autoselect mode and then exiting CFI mode should
  return the chip to autoselect mode, but the current code returns to read
  array mode; and
- reset command should be ignored during sector/chip erase, but the current
  code performs the reset.

The first patch in the series adds a test for the existing behavior. Tests for
additional behavior/bug fixes are added in the relevant patch.

1. I found firmware in the wild that relies on the 11-bit address behavior,
   probably due to a bug in the firmware itself.

Stephen Checkoway (10):
  block/pflash_cfi02: Add test for supported commands
  block/pflash_cfi02: Refactor, NFC intended
  block/pflash_cfi02: Fix command address comparison
  block/pflash_cfi02: Implement intereleaved flash devices
  block/pflash_cfi02: Implement nonuniform sector sizes
  block/pflash_cfi02: Fix CFI in autoselect mode
  block/pflash_cfi02: Fix reset command not ignored during erase
  block/pflash_cfi02: Implement multi-sector erase
  block/pflash_cfi02: Implement erase suspend/resume
  block/pflash_cfi02: Use the chip erase time specified in the CFI table

 hw/block/pflash_cfi02.c   | 843 +++++++++++++++++++++++++++-----------
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 757 ++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+), 235 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

-- 
2.20.1 (Apple Git-117)


