Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65936C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A3C206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6GZm5KC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A3C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Yy-0001pZ-HE
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7P1-0005xw-KE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7P0-0006cU-BN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:31 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7P0-0006a6-3g; Mon, 29 Jul 2019 11:17:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so28202104pfo.1;
 Mon, 29 Jul 2019 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gqQiGoFiW+lpg1rPNQrONW25rfL/th38heAefJfZSA0=;
 b=r6GZm5KCfz/8cRyF6cB9GrZDQq+FyFDfB9wrezlcGFoBEHyRTytxJVaVF1acbCcDFI
 BRJJYPJYfvpZi7SRfv4N5z7zjieObjYUD+UXWse9IaNIIAUvKicNKLPS3DNo6Q/HDAmo
 b3aliuLb1iT3TIEkIpOZ7teSUx+YWo5+UEgB/2m+0xb8cZ5y8kGaS3D0uXmK9sdg0pHX
 XeZwH0/2K9FevNN3kxKeThPQgUoVLFeENmtQfvfpGFBGFVAha5SQrYEcMd/DNWxwA3VD
 QyxiI0dVbdJqVL4qcm5jMOAi/sRN3ppZI5qAEGDTg4FoKOeJurlhdBUxhkMlL3rKJAVq
 QuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gqQiGoFiW+lpg1rPNQrONW25rfL/th38heAefJfZSA0=;
 b=Ix7ALbqXPF3WUxGtuw1AM37B5C3DlsgCYRQ61tZ7M2pnDFc0EqgBfDdydDW36aQRQu
 KhkEiWdpoeWRJZM6sKVL9NKb2vr/ppGJudn0zcdjAu9tcraWmmXAAoWzVYHpuq0gIizA
 X3uNbS8pnIGzL9VHuGT1+SWqQIyGTFwcvVRnY8HSIFSFfLewuiS9w8NDvY57GMQfUO39
 j+RRNuKns2SgYOoDf/IUFGUh0ezWfmJ7RcRJdiStPtrsx49pJnLGhimM45/KgB6McpoC
 8vHw+6hizVrgwo+nsvr0BuNtAJ1nMhOZZwchByrl+5yNlTv1qyeHCrcvUtoH8xvXOWH0
 eMVg==
X-Gm-Message-State: APjAAAXvHprmRsopZl9oZfsimd9Gv5uKUsQQXNRQ6xdxBgGJSzilowa2
 mUdxtWW2jUwubzMxQ6us71ktqg5Tj2s=
X-Google-Smtp-Source: APXvYqyW30VE9bwSRhhVu+0I2Dl7pkW2zI0Tik3a3GfsfcLgkyXKaUQAi7Ogqlj+yq4NolaBEDKy+g==
X-Received: by 2002:a63:590f:: with SMTP id n15mr58185179pgb.190.1564413448228; 
 Mon, 29 Jul 2019 08:17:28 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.17.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:17:27 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:36 +0530
Message-Id: <20190729151651.21306-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 00/15] Add support for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
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

Aarushi Mehta (15):
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

 MAINTAINERS                   |   8 +
 block.c                       |  22 ++
 block/Makefile.objs           |   3 +
 block/file-posix.c            |  99 ++++++--
 block/io_uring.c              | 439 ++++++++++++++++++++++++++++++++++
 block/trace-events            |  12 +
 blockdev.c                    |  12 +-
 configure                     |  27 +++
 include/block/aio.h           |  16 +-
 include/block/block.h         |   2 +
 include/block/raw-aio.h       |  12 +
 qapi/block-core.json          |   4 +-
 qemu-img.c                    |  10 +-
 qemu-img.texi                 |   5 +-
 qemu-io.c                     |  24 +-
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
 tests/qemu-iotests/common.rc  |  14 ++
 tests/qemu-iotests/iotests.py |   9 +-
 util/async.c                  |  36 +++
 34 files changed, 812 insertions(+), 77 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.21.0


