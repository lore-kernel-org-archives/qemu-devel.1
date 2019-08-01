Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE8C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64EA206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2gsBVpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64EA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKiI-0006dA-7r
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKh5-0005B7-Ke
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKh3-0002RR-Rv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:11 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKh3-0002Nq-Fd; Thu, 01 Aug 2019 19:41:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so25873233pld.10;
 Thu, 01 Aug 2019 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H8jEgLxbjzvi1LJWqETWpE1O1UiCKTDP3/+FlMOjTfE=;
 b=X2gsBVpdH4vRndvMrzbboNQcOqjCi9kxmxUxKXMLMzMdfWQt6K6bbvkDQeNcV3IVRg
 zx9CvX5YshbqXzvg+shzl/6cgLRgfP+vw0PV1/nwlHj7bYxooSAPqbV5tb+0Yl4tteNs
 9Q9W0xj8Z05+TWMzfi9pCPg5G9bioXpH+arinYkdxZKIuCU6hxHK0IVUfvzwKt6DwDtb
 U8SF55yhqLNZv1Cq7vdi+NrKoLMLihwEUABdmDPlDxzg5WIlXDDM0XcUfQIo7qJDDQLQ
 3TVLvUCB5Qcr5R1kMRckpIINjyGTNwhzq3qLbWo0HLDfqj6q4jG6aNHy+2Odb/n2YQbs
 4Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H8jEgLxbjzvi1LJWqETWpE1O1UiCKTDP3/+FlMOjTfE=;
 b=p6hNtNhIqqwn9yw2VPHE2Qx+/xgc6t7XPAbkqyAVylsQZu11nlp31JX2IOuiWyg61y
 4K6o6zCSqd72mD8pUHXZkt4S3lfBkUmFDwiq/gO0NOI531M0HguWUAcRC7xB8FTllRod
 S+JdEVJVqxPF2qBKlgoYmijwOMlr/q+xDaX6EFdfu3fDBEWfGlgQYNhwAg+J9Wf4EtdY
 8gkDJ0WX8gBlmf80HheaDbIm5PPAeYThimUcAREBEnmvoYa3R8bNOeWwGMZMO5seW832
 JyXDehWhuDNGU2zSgBJrI3SrLirJ0LdzmyMe+7bpPwnfDGyYrVjFfRCo3VpD89nXg/hc
 EMFw==
X-Gm-Message-State: APjAAAVw2HBa4MxZgP0Ctz5++jNclD4+1npGpXzEC29i4nRMScR0Clrc
 G+0xBxeAnC2P8w8Ck6FQDqoIlCCaVC0RXA==
X-Google-Smtp-Source: APXvYqw8NtFoH+QWsECUjKndbAlp0taztWwZd35iHpehUuPpeZkTiNr9yfNJ5+xB+8YIMWnKKFgCJA==
X-Received: by 2002:a17:902:b591:: with SMTP id
 a17mr46982408pls.96.1564702863990; 
 Thu, 01 Aug 2019 16:41:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.40.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:03 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:14 +0530
Message-Id: <20190801234031.29561-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v9 00/17] Add support for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
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

Benchmarks for the system at https://github.com/rooshm/benchmarks.

There is currently an -EIO output when guests are booted from io_uring on ext4,
the error is reported upstream.
https://lore.kernel.org/linux-block/20190723080701.GA3198@stefanha-x1.localdomain/

v9:
- adds sq_polling
- fixes leaks in fd_registration

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

Aarushi Mehta (17):
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
  block/io_uring: enable kernel submission polling

 MAINTAINERS                   |   8 +
 block.c                       |  22 ++
 block/Makefile.objs           |   3 +
 block/file-posix.c            |  99 ++++--
 block/io_uring.c              | 560 ++++++++++++++++++++++++++++++++++
 block/trace-events            |  13 +
 blockdev.c                    |  12 +-
 configure                     |  27 ++
 include/block/aio.h           |  16 +-
 include/block/block.h         |   2 +
 include/block/raw-aio.h       |  12 +
 qapi/block-core.json          |   4 +-
 qemu-img-cmds.hx              |   4 +-
 qemu-img.c                    |  11 +-
 qemu-img.texi                 |   5 +-
 qemu-io.c                     |  25 +-
 qemu-nbd.c                    |  12 +-
 qemu-nbd.texi                 |   4 +-
 stubs/Makefile.objs           |   1 +
 stubs/io_uring.c              |  32 ++
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
 35 files changed, 938 insertions(+), 79 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.21.0


