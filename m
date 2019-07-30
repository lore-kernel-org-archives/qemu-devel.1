Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36063C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035332087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU/lSHtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035332087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW5V-00017W-9z
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW1l-00031n-AD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW1k-0008Km-0X
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:35:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW1j-0008Jm-Mg; Tue, 30 Jul 2019 13:35:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so30214306pff.8;
 Tue, 30 Jul 2019 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+k7ImOWWdcsZgB/ybZ+CpxeK7zst/kyGkppIZxkm9fo=;
 b=MU/lSHtdWWtBFuzwDRfeLyWZfwhVfK0Ltcl/qu5msEJYzmTbx/h+CCEYzRx5lv2Bmc
 rnH+kO2iTEwEpJcgmVoxvDmhXAI9HPk4rP3bU92qT7w4qfG+hX/1w4duvABr8z9XQxQs
 TB0ASUaEV4UGD/IIK9ug1g5vZqf21hHdivHGrwYMTNDNn0nb6jrLoIhM547k20OT9Gh/
 YeIMc4GyK9+/P9nlANGhOh+dJuvWb8Oxclk2P8YJGcG+BhRefIYUsyLTOVlTiOgZ8cLw
 6+u24TuYtU/F3r8iIyfDP3a+SqNRHhrU9uM1Yh8HeBOgeztT3wlNNVez+5FXfBlRmxKk
 yWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+k7ImOWWdcsZgB/ybZ+CpxeK7zst/kyGkppIZxkm9fo=;
 b=UtijTeBJsx/6ivTIg3Q5tsYqqdwjaW0Hpi+Az2MgszE5NybYEk/PXBFr2qbg15wwnS
 pYQyuPS8T+JeaYiNuV5bsCAcFiWSjrTz4i7RvkZk/lUzecoUlkTnQuslRbQamngA8JVd
 6DUy46Vya9cYDC7fkEcaTRHRmaSnQi4wpI54KgOMRQcUUa4Hio1U7avOOERLyC0RXBTB
 mIIPWEHlbZvWdP5wmCaUdGxD/uD+3YbMkkKo1ax5XKjjDNjYsDN79OI7pbFJhdyb/np9
 B+EXAmq6zgQzmF/OgWge9vA0sWwbXxxxOWhyl0DncFArn0JeEBja6SBckiCWBhx81vEo
 O0gw==
X-Gm-Message-State: APjAAAXTVzn5pk7OLM8Zg1OgEdfCSew4zdIDj6TB54k6rjoyHzJw4SHZ
 rm7l9rX1fthpt/als7moAOxR5xi1QX5pww==
X-Google-Smtp-Source: APXvYqwXbaXna9cIXin6ojG4bWvAVYEJPhWcl5fcjSGnP97XUu8a4x+ADXIoREI7bINGwT4v0L1PZA==
X-Received: by 2002:a17:90a:35e6:: with SMTP id
 r93mr118643480pjb.20.1564508103809; 
 Tue, 30 Jul 2019 10:35:03 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.34.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:35:03 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:25 +0530
Message-Id: <20190730173441.26486-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v8 00/16] Add support for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for the newly developed io_uring Linux AIO
interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
offers efficient buffered asynchronous I/O support, the ability to do I/O
without performing a system call via polled I/O, and other efficiency enhancements.

Testing it requires a host kernel (5.1+) and the liburing library.
Use the option -drive aio=io_uring to enable it.

Benchmarks for the system at https://github.com/rooshm/benchmarks
io_uring has similar performance as libaio but supports cache=writeback.
Further performance enhancement will be implemented

There is currently an -EIO output when guests are booted from io_uring on ext4,
the error is reported upstream.
https://lore.kernel.org/linux-block/20190723080701.GA3198@stefanha-x1.localdomain/

v8:
- adds fd_registration

v7:
- completes io-tests options
- misc fixes

v6:
- add slow path for short-read
- hooks up fsync
- enables qemu-iotests with aio options
- adds bdrv_parse_aio

v5:
- Adds completion polling
- Extends qemu-io
- Adds qemu-iotest

v4:
- Add error handling
- Add trace events
- Remove aio submission based code

Aarushi Mehta (16):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: adds bdrv_parse_aio to use io_uring
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds option to use aio engine
  qemu-img: adds option to use aio engine for benchmarking
  qemu-nbd: adds option for aio engines
  tests/qemu-iotests: enable testing with aio options
  tests/qemu-iotests: use AIOMODE with various tests
  block/io_uring: adds fd registration

 MAINTAINERS                   |   8 +
 block.c                       |  22 ++
 block/Makefile.objs           |   3 +
 block/file-posix.c            |  99 +++++--
 block/io_uring.c              | 522 ++++++++++++++++++++++++++++++++++
 block/trace-events            |  13 +
 blockdev.c                    |  12 +-
 configure                     |  27 ++
 include/block/aio.h           |  16 +-
 include/block/block.h         |   2 +
 include/block/raw-aio.h       |  12 +
 qapi/block-core.json          |   4 +-
 qemu-img-cmds.hx              |   2 +-
 qemu-img.c                    |  11 +-
 qemu-img.texi                 |   5 +-
 qemu-io.c                     |  25 +-
 qemu-nbd.c                    |  12 +-
 qemu-nbd.texi                 |   4 +-
 stubs/Makefile.objs           |   1 +
 stubs/io_uring.c              |  32 +++
 tests/qemu-iotests/028        |   3 +-
 tests/qemu-iotests/058        |   2 +-
 tests/qemu-iotests/089        |   4 +-
 tests/qemu-iotests/091        |   7 +-
 tests/qemu-iotests/109        |   3 +-
 tests/qemu-iotests/147        |   5 +-
 tests/qemu-iotests/181        |  10 +-
 tests/qemu-iotests/183        |   7 +-
 tests/qemu-iotests/185        |  17 +-
 tests/qemu-iotests/200        |   3 +-
 tests/qemu-iotests/201        |  10 +-
 tests/qemu-iotests/check      |  15 +-
 tests/qemu-iotests/common.rc  |  14 +
 tests/qemu-iotests/iotests.py |   9 +-
 util/async.c                  |  36 +++
 35 files changed, 899 insertions(+), 78 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.21.0


