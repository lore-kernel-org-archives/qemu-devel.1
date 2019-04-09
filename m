Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F0BC10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29C3213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="Leml8xVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29C3213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDg6P-0002Z5-L7
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:03:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg5S-000256-Jo
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg5R-0004uE-D0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:02:10 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg5J-0004mb-M9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:02:05 -0400
Received: by mail-io1-xd42.google.com with SMTP id d201so12862252iof.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ezyhs5vTvBqELZXaq/in78Q7ZDopgWPQKZPf36BzZoY=;
	b=Leml8xVz8g+Xt7PwcimbjRnA7VASiLj0qUKC0umg/j8q1TC2qSXODYM2iRfub5wUIQ
	DcO1weoVf0TtbSf/L0SX4PHs98vqlJFBLEUGyhKHlJ9MthH1nZ9JQwY8bZa/kV3UFlKp
	EN5ZJyZ3R37/ffS9Gvr/PoHOFz4VwTLbLYK/K/eRR4c5wY7yTQ7Db3hu/gszcp8tR1N/
	9ZOUAFTtsnS0x8rqjpjowAjjWqMxdFfGzCsEp20ZrLwvO5ULWUEbszE3vNSqkWJCfauA
	RAq5zxyC2c/Q/OUqX4ppKJRKnZa+by/sloX+0nFmIbJy/I4iU/8azHGiDxLUujAb/8Xa
	KnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Ezyhs5vTvBqELZXaq/in78Q7ZDopgWPQKZPf36BzZoY=;
	b=G6VEaso/7U2yl29Up4JEeDek2OqfmxtestbwFP7XA3kWuhCoesLRak/z4ew1RDBMhX
	OFi2IgnvT7zwf5z9PFVZ7xQCjWT9PL4Ze7R+nJD9oM0ssht4yCMlGAUH323ioq7cuP2x
	i/7svtitpJ2D/f0TqP9nE1uQdqgxWkSI/oLksyH6p1ekuuVzyo9fHAKzO4lvlYDE4uvM
	ZiBsU/SxUoIEKDcDT8QuLWibmZHpz1UrbK9A9v4SafBv7HZPCFfJ2pbeQ/J1G0mlrO2t
	sDs/43dW8ww6/MeG3s5csn7MXJtHeKcK7wqSZsQ4BpzL6OUZ9svbRgKjtXUrfUEG5eDl
	O9ow==
X-Gm-Message-State: APjAAAWPOEPUQmx9J4FWpHE0P1PDhREN0uONNdJnF4b5RbL7h+2JsGv+
	PU74k+iOEddpT7xKCzsqNPKqvG9SgaFdHA==
X-Google-Smtp-Source: APXvYqx5IWRSmRP1y9gxJABOLsS+NnN0wKqhCYyj38371NQ8DXOYtw+J1H+9KqxfVYVBJLAv9/viLQ==
X-Received: by 2002:a5e:a804:: with SMTP id c4mr22596096ioa.15.1554775313099; 
	Mon, 08 Apr 2019 19:01:53 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.01.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:01:52 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:21 -0400
Message-Id: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: [Qemu-devel] [PATCH v2 00/10] block/pflash_cfi02: Implement missing
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
Message-ID: <20190409020121.NyN6g50ii3G5ItIFt34cr6JyDeYvTTNU4tQbmgLa14k@z>

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

Changes from v1:
- Fix missing spaces around *, -, and ?.
- Fix missing Signed-off-by line on patch 7
- Replace use of errc with g_printerr and exit

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
 tests/pflash-cfi02-test.c | 759 ++++++++++++++++++++++++++++++++++
 3 files changed, 1367 insertions(+), 237 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

-- 
2.20.1 (Apple Git-117)


