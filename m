Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EFCC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D75C21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea3dckr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D75C21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT3J-00021P-QN
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT39-0001cE-VJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT38-0007UE-Nm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:35:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT38-0007Te-IS; Fri, 19 Jul 2019 09:35:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so14471382pgp.12;
 Fri, 19 Jul 2019 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SoHFuIb8qMT9oZXOEL0EMG5W0djtXLWjWyK7Xrjx2RU=;
 b=Ea3dckr9fcYHpedB+5Mb3ifbmRmcsMwNCUYfmmcTNlt1rh/i8rlaDJ1mziuY5NCeOa
 iTK86faqvB1fE8Xb4WsaBkOxgPoGBw/YFK9vrLklOufw/zZ2v4Ytypo0pgXBBMG15R6W
 3GOXdvBNoB9oSV9vPZP+bh/Lifq4ttyBwtY4gGIAOJ2sRVUQZRiR3j/jPxoKCrRLI2wK
 /UeW7YEvGQ6sRyq1I24RaBajI9KT02nb/GlnpwQYzbJbSNF+I2kG997uP6Bbbqvwushb
 oYKNzn5kUFdgJxELHERl/i6/lsLgMz2yglh7dUm6MDINpCwf7lZ9TvDYo126ilOblXd9
 wkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SoHFuIb8qMT9oZXOEL0EMG5W0djtXLWjWyK7Xrjx2RU=;
 b=VL/wZsk4/fuiLrhF34q/ikg7hQ96+eD54ybckBeG4M7obE5PBGRw38YRGZf0sXOgIF
 I2fea1td1crzSnifT1M288o2Ss2NppdSQWrjqveqRT3mHeYtpXwPY7/DTK7uc7pzxtJY
 JwszIMbYKL1HGeeMHnCWoXIf4UbM8WqcauIbP3TDV+TyJC/kitxgCv1Vj7r8AwpdGnVX
 3casxsJUiQf8Dju05a9OgnWOyZmoim4j5Dcp7BqMCHMJgImFmlobvzAYSwBuarHSNCDS
 vpo8PCA/qV2wwa+rHeOrgBjgf0oprvibEbMk2WaL5qZ87cdpYXqdF7KGDwzIZoRtbctv
 spgw==
X-Gm-Message-State: APjAAAXhT9St5wTvfB8zxknVvhWCpi/PiEQWHCCMpx1563b7KTsqkUzK
 sHGVkLm6UGTioA2JcP13CM12QcPIDBc=
X-Google-Smtp-Source: APXvYqySnDKiYW0wZSrjrswe8yzp2OngG+QaXLfeSR+cU1+c/D9A8/YJOlsGO/usjqTwTVAyjqiO+Q==
X-Received: by 2002:a63:7887:: with SMTP id t129mr1084828pgc.309.1563543348707; 
 Fri, 19 Jul 2019 06:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.35.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:35:48 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:16 +0530
Message-Id: <20190719133530.28688-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v6 00/14] Add support for io_uring
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

There is currently an -EIO output when guests are booted from io_uring
disks for the second time with clean shutdowns that is being investigated.

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

Aarushi Mehta (14):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds option to use aio engine
  qemu-img: adds option to use aio engine
  qemu-nbd: adds option for aio engines
  tests/qemu-iotest: enable testing with qemu-io aio options

 MAINTAINERS                  |   8 +
 block.c                      |  22 ++
 block/Makefile.objs          |   3 +
 block/file-posix.c           |  99 ++++++--
 block/io_uring.c             | 439 +++++++++++++++++++++++++++++++++++
 block/trace-events           |  12 +
 blockdev.c                   |  12 +-
 configure                    |  27 +++
 include/block/aio.h          |  16 +-
 include/block/block.h        |   2 +
 include/block/raw-aio.h      |  12 +
 qapi/block-core.json         |   4 +-
 qemu-img.c                   |  11 +-
 qemu-io.c                    |  25 +-
 qemu-nbd.c                   |  12 +-
 stubs/Makefile.objs          |   1 +
 stubs/io_uring.c             |  32 +++
 tests/qemu-iotests/check     |  14 +-
 tests/qemu-iotests/common.rc |  10 +
 util/async.c                 |  36 +++
 20 files changed, 746 insertions(+), 51 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.21.0


