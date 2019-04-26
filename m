Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08340C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CEE208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="jd1rYYva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CEE208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3im-0005M8-Kn
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:29:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gq-00042j-Ms
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3go-0000tw-Oe
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:08 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:53363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gm-0000sZ-VC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:05 -0400
Received: by mail-it1-x141.google.com with SMTP id z4so6802301itc.3
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6bmjlAcIklyoU6zvkQ4we8ntzsqdm4a9sFwiN+s3kT0=;
	b=jd1rYYvaYry3fdHTolD9W7Q0Cubv+KBnvJorQ9Bi8l5t5/Ruq2fLqF4EpbR8jbL6Ni
	tuu0n2IPOsu4pNfaAGV7l1D8IY9fVS59q754YRX2piiXInZAsuuhPXVTFaCY5dnf6bPH
	q6NBSpkJhp/ux/ExmHnO0VBR3J7q3QXx5G68nI2hvGcRwg4FlWR/Z2/MAfmm5fjOrEAX
	MBbKUUIBkpu4NiPM7CklrHM2mDQ1x2ktkLSNdWu5LRYnAva5nrmtsOEdBgk7oDfjSpc2
	UcLrQQNnml6AQtYnLEXxckmO1x3MEQPPG552I1hEdo1+BedgdjtXGXk5IGMIoJia3upA
	E78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=6bmjlAcIklyoU6zvkQ4we8ntzsqdm4a9sFwiN+s3kT0=;
	b=YmgPV/WV9OqXUzeR9haQJv8pzWop5xLkVoaQyqoXOyr76yXemvyOUK132qsak9efi1
	bpjWwOr+iMQXfvBL4E5EWwmbF6mbDnNuDrj/TsjjGPItFprE3YeSxoA58cpTGe+dHJgV
	MykmAAsQsu4HDC8Wryyh6C0tcnhSueocInl58DVg8iYPmHYuBDUCj5oQmWisx3wsUqgg
	YJh4PTspa01cuDhYNeT8lTzaT+Ywnrc7IuLbzmm4VpVoUlqsPpnOkOupAI2a4xT+iIMc
	M0cfSyaMcoOo5GLXqN41TDMjsMPWdkY3ZjBYeif1jj6GTbCom9ah161ZhvlUmwpcmzfT
	OFew==
X-Gm-Message-State: APjAAAVgGmfSup7hKgDDYn8K1X3SOTZ9jxedNL53yx4bZa/+biAShpFs
	tetHz1MNqyDghtEMVqLQhAOeJR/BccckRg==
X-Google-Smtp-Source: APXvYqzX/VwIrMa6vDug/lo90XNmrBXG4t/3ZfNdIoPGL5nzolkCf2EGYPQpBFZT452TbEFmySOfXA==
X-Received: by 2002:a24:13c6:: with SMTP id 189mr646615itz.135.1556296023347; 
	Fri, 26 Apr 2019 09:27:03 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:02 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:14 -0400
Message-Id: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
Subject: [Qemu-devel] [PATCH v4 00/10] block/pflash_cfi02: Implement missing
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426162614.L-9H4I_YRw6VUba7nm1uflA3U3AHXUlr35qWSOYKwL8@z>

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

Changes from v3:
- Replace err.h/err() with glib functions; and
- Reformat qtest_initf lines.

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
 tests/pflash-cfi02-test.c | 812 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1420 insertions(+), 237 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

-- 
2.20.1 (Apple Git-117)


