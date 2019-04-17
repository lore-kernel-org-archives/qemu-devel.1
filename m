Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A1AC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD67217FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="NgsXw1e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD67217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGsf0-0007zg-GQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 18:04:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdE-0006tW-Tg
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdC-000453-SO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:16 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGsd9-0003yu-88
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:13 -0400
Received: by mail-it1-x144.google.com with SMTP id k64so250994itb.5
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BDnA97pyOxqR1sx9FPoDoSdOMgmHsTc2cD+9az3b1ds=;
	b=NgsXw1e88gG97v4zWnuppq9o3/ebxPzCB9AvvJlBrUS+h+7ciidx1rXfGXOXG9W7OC
	ok7v09AS7iFldLdFD07Nik1tqYwib9cHgq6nI0flfK4lqQ0xmd9MaAYVgab7rRsyS1Nx
	YlPP8aPfStAZWwEzdszq+iBwU7aVQsiDZgvb6CGwtvYyCD+8Gev0DQzmdmnHoss4V8X1
	XoBrAvY4q9+qmtx3kImQciqkGbCh/h5/0J8EmK9byswHhfNm3CHxgS0YIm1RcSYWWiM5
	PIDJn9ZIKb2RudPHYCpVSsObqqa7dR6cJOgV2JPCe7V0TVljg3wRSIXHAssM1+tJLtuv
	XVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BDnA97pyOxqR1sx9FPoDoSdOMgmHsTc2cD+9az3b1ds=;
	b=e0bzWC4tVos9hCl1uPZad7itT7xgPjoNWC+Ox64i7yGHn8oRwtEjgb4YKwga3DX3JS
	cbdSlkbB+aBE+SQ4OFgpWHYddE3gDs0u3YNrw/tn8BlZnJO/2LnsfhsWtcb1TE0eKeAh
	JeuKpTkNHe+8JnlkEaNihCMzxOM5ltxUpC/c7sk5Xz16AibaPsf2OJ2UNRPEzljzt6DJ
	+n4+zZ1wpK1fO3fGeQTgoZM1uVWqd9U3uNXWzRa4yKbu5eYnxNttdpnk+ERpY+HEwF+g
	Rx7E86oZSMxJFO9v6x8xRmh+sf2TTlwftOQwlDUCRRmAKADiuCTLr2+3H2k79ICbfH6J
	JtwA==
X-Gm-Message-State: APjAAAUtVnl/Iu+OvoTx+LIHLUvg+xe6ROvN41RPPrPVvMQH+JPWxJgN
	CEzWXls4d9MkGUeyAmjuMTiUKm484Szv+5SE
X-Google-Smtp-Source: APXvYqw/m1KXc49hiqiCrOcQLI56D9mzN04hDM3xiznOpHAdB486EaZIyG5NPB2k0QEDhExTS736Ug==
X-Received: by 2002:a24:3c4c:: with SMTP id m73mr769095ita.23.1555538530391;
	Wed, 17 Apr 2019 15:02:10 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93])
	by smtp.gmail.com with ESMTPSA id e81sm147874itc.3.2019.04.17.15.02.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 15:02:09 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 18:01:37 -0400
Message-Id: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: [Qemu-devel] [PATCH v3 00/10] block/pflash_cfi02: Implement missing
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417220137.QMenYf2l-8sbD8bjN1h1s0-82cFYc1Hv2PGTxoV2Wrs@z>

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
- Fix missing spaces around *, -, and ?;
- Fix missing Signed-off-by line on patch 7; and
- Replace use of errc with g_printerr and exit.

Changes from v2:
- Remove global_qtest from tests; and
- Test the CFI table changes.

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
 tests/pflash-cfi02-test.c | 815 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1423 insertions(+), 237 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

-- 
2.20.1 (Apple Git-117)


