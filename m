Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B7EC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB3B20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzrU8rc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB3B20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKiZ-0001u7-2U
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKg8-00080w-14
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKg5-0001Rg-1Z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:49:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKg2-0001PB-9d; Mon, 10 Jun 2019 09:49:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id s27so5094275pgl.2;
 Mon, 10 Jun 2019 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SkZdXXP1RT6GlBNOU0KZBP1J+G70aIB9iGnW4DTD5wY=;
 b=MzrU8rc7mWKFuMk5odSTQJfgCBeuk2zEPM3zyUaEM3eqwv2fKn5Ia4oIynXIZ4tPq5
 JTS6HeAQ12z2QjDelrvXt4IoBR09AcKlRyXeOesZLyjPWovAlK1D2pxOe1waEBvp+sFB
 3LJA6k/j+4d265FAsc6nxgQkL/Ja2wZFlqQCFfAjfAmRfw/nvVx0mFN4cQ92AzswcxLs
 gWW0AK/X7zA8jcZ+TC0WWD8v2OwMVfOIUYGg8kfVzC9u0Zeieo+C1+osKpyuQXc/tary
 zF8/uy+oimp41i67MRXWSlZNoPiFogZQaauC1khXZhwafVozKgbq5/QYlSwOAL2hFrn9
 cjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SkZdXXP1RT6GlBNOU0KZBP1J+G70aIB9iGnW4DTD5wY=;
 b=JGej8p/cDRknIBqY3DaPpECHGOf7f4rM5e7G0A144n8vOSesRGW66ktUXWR0AFiNtW
 yOe/QxUaOufmS3n1ze3V3VREM+af94RJOvprc3YK8azTEZAJ1O2gqo50LNk+xxYcuAOL
 V990nZSTKj6JHwk7APkH+p9CpU0hGWB3xR8nkcrDDw5rTlxFBpEvApyntVVxFrak3VkN
 fsMMet6dxitSY/xwUW5nNu7H9gPLfv4an1+8r4W6tdcnQgM12C36Pmrm/r4RHXc609PR
 VHitNQgAq/l9wgh0ciEqk6ZYiK1CPXnzRaX/m5dNKdiM5EwmqIstrB1LxwvP3wJQjtdi
 2uJw==
X-Gm-Message-State: APjAAAWkCKBGhnkgB1MxbC+n32QWQwYFI1lsUSmswKIKYrUYopFDhAK1
 P13SLvL/yYv2Fw1WVKOH8XKYAK7IjMRZ5w==
X-Google-Smtp-Source: APXvYqx5QUz01h3qCMU0zxweNDqxiTtxRbXxPoxxpBU+kGy3011iDrKZFQmxy12VoJ6Gg/k6O+YMTg==
X-Received: by 2002:a17:90a:2008:: with SMTP id
 n8mr21031660pjc.4.1560174570057; 
 Mon, 10 Jun 2019 06:49:30 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.49.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:49:29 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:18:53 +0530
Message-Id: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 00/12] Add support for io_uring
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
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for the newly developed io_uring Linux AIO
interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
offers efficient buffered asynchronous I/O support, the ability to do I/O
without performing a system call via polled I/O, and other efficiency enhancements.

Testing it requires a host kernel (5.1+) and the liburing library.
Use the option -drive aio=io_uring to enable it.

v5:
- Adds completion polling
- Extends qemu-io
- Adds qemu-iotest

v4:
- Add error handling
- Add trace events
- Remove aio submission based code

v3:
- Fix major errors in io_uring (sorry)
- Option now enumerates for CONFIG_LINUX_IO_URING
- pkg config support added

Aarushi Mehta (12):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring Only enumerates option for
    devices that support it
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring Aborts when sqe
    fails to be set as sqes cannot be returned to the ring.
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring
  block/io_uring: adds userspace completion polling
  qemu-io: adds support for io_uring
  qemu-iotests/087: checks for io_uring

 MAINTAINERS                |   8 +
 block/Makefile.objs        |   3 +
 block/file-posix.c         |  85 ++++++++--
 block/io_uring.c           | 339 +++++++++++++++++++++++++++++++++++++
 block/trace-events         |   8 +
 blockdev.c                 |   4 +-
 configure                  |  27 +++
 include/block/aio.h        |  16 +-
 include/block/block.h      |   1 +
 include/block/raw-aio.h    |  12 ++
 qapi/block-core.json       |   4 +-
 qemu-io.c                  |  13 ++
 stubs/Makefile.objs        |   1 +
 stubs/io_uring.c           |  32 ++++
 tests/qemu-iotests/087     |  26 +++
 tests/qemu-iotests/087.out |  10 ++
 util/async.c               |  36 ++++
 17 files changed, 606 insertions(+), 19 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.17.1


