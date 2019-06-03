Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9BC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAD927F9B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUYXA47H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD927F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmRk-0004Db-Gc
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:52:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmL1-0007Hi-M4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmEc-0006Re-TV
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:38:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmEc-0006Od-No; Mon, 03 Jun 2019 08:38:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id a186so9851429pfa.5;
	Mon, 03 Jun 2019 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=AaE53greKWPWfxk0mQUfYB5AefuproOTcNmfTvVZZOQ=;
	b=DUYXA47HNd4n5tH0dcDQjkEwqzMz4Tb1O/hVVEy//XYXmyghlN9jrDYm6hJ0oEqCLK
	Qq0ea6PtE2AZfSnAxSUiIHEEGI3iO5hPRuBgtFJ0Pkspsni6njaRUD+vVi/9YCm2K3CD
	hkujHLzILUa1oRO1rloK+ZPGZg1EiwroUB7d3h8hGUSecPVDBEhNQ96ekqX/a77oTEWO
	zAP3AgRGQ2O35UB/LYwstHJ3QTKKL1JichsQRohpvEgASU5bkjAs6dSZNiyfessYoMnB
	9SMMRi4ZoV5CZUndWIp2kF3Es3wdDIoObYe0A655naVzIVxSKftjfC3zd+t3dmowlxap
	WG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=AaE53greKWPWfxk0mQUfYB5AefuproOTcNmfTvVZZOQ=;
	b=tPXYZGi8ev6NDURdLfajZ4IllQ47C0BiGkb9dzAvmIkKQU690N41HirwPmpqVBl331
	VH2xI+TPpCI0uyIy6taUfbJmcMkFFjlhOYa5k4wh2K1/3zTuOmzy7gx1ftyFOT1vFlV4
	kGuP0pIjsI9i4yA9sqvXBoIhHwo4x0HUkZ45R3txQOMtuzCHqEZE8/h7NUiEgXcISfQI
	rh1z3pzUfaAzMamuDHmNxy/EzsPq0Pab2TvjNP+2lRjuQiAU+nKr2T6pfDvunDpQZPx/
	EVV99nXRA0ggua7CeORS0DkvrGSTPB82kfDCSK/FCHJmxX4AjFc+PHVGLyJR+HgflhTt
	47qg==
X-Gm-Message-State: APjAAAV4R6kej3Xvqcsc/0WDMmV07lWX78P0gzSa+l1OLSktlBx8hFMO
	u4YB21tgVXIijgQe7Je4FVPqF3u0Jko=
X-Google-Smtp-Source: APXvYqzzvWW2oFT9ZfvdKKpVndcWUjwUvreK6vzchv2vVXUAxuYY79xHjOBsqSZzjB1RTOLcRhT4sA==
X-Received: by 2002:a65:62c7:: with SMTP id m7mr28340474pgv.223.1559565520815; 
	Mon, 03 Jun 2019 05:38:40 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.38.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:38:40 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:14 +0530
Message-Id: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 0/9] Add support for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

v4:
- Add error handling
- Add trace events
- Remove aio submission based code

v3:
- Fix major errors in io_uring (sorry)
- Option now enumerates for CONFIG_LINUX_IO_URING
- pkg config support added

Aarushi Mehta (9):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix.c: extend to use io_uring
  block: add trace events for io_uring

 MAINTAINERS             |   8 +
 block/Makefile.objs     |   3 +
 block/file-posix.c      |  85 +++++++++--
 block/io_uring.c        | 325 ++++++++++++++++++++++++++++++++++++++++
 block/trace-events      |   8 +
 blockdev.c              |   4 +-
 configure               |  27 ++++
 include/block/aio.h     |  16 +-
 include/block/block.h   |   1 +
 include/block/raw-aio.h |  12 ++
 qapi/block-core.json    |   4 +-
 stubs/Makefile.objs     |   1 +
 stubs/io_uring.c        |  32 ++++
 util/async.c            |  36 +++++
 14 files changed, 543 insertions(+), 19 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.17.1


