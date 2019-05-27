Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5FC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B55C2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWNd2XH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55C2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41641 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAdM-0008PQ-MM
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:05:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbm-0007UA-Vz
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAbm-0001Sv-2B
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:03:50 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAbl-0001SD-Tr; Mon, 27 May 2019 04:03:50 -0400
Received: by mail-pl1-x643.google.com with SMTP id p15so6754110pll.4;
	Mon, 27 May 2019 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=Cuxtsiu5nLaWfg7GMUO5CDp3YFkqp7Kjlhh2eLc5Rew=;
	b=FWNd2XH3bm5DLzhmsj/8UStPk3yf7PMbd8HvxLZl2/HqMR07nEDtjGWK845W6yp/wb
	WZQZ1VxOZFLdRBJKwfreRPSWQ9xhnGGOdWT9nTnVmnqAVk2+trOGg+z9tnXSepIJc0y6
	kjXcqL1ognOn/3jkkGsDgSpPV7NzYFn8yrrAIrSPRX/BKo6o2Cjs/CDm2z6BkfouIq77
	/V0GjARso83TZZJp3eMursoZZIJ5Df4G2voty5/mgE6PyeUoGxAxjkF6dEO3fXLsKJKr
	deTEmnKdCqTWk6r0cvXVIMkjSsDcAR7gI1BFOlOrXPoR5cCOvxcnVxhCyFVxvTWm2PIU
	PE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Cuxtsiu5nLaWfg7GMUO5CDp3YFkqp7Kjlhh2eLc5Rew=;
	b=Teo/kA2rZnIsYtI1aQeB5EXTQacdsjOIKN4DHq3+LgfGZsQQ7orz6AWeJ/pLgGzXWn
	zSKYZ0HjwJ1XbtZVCXA8t/iK0a3oaLYv4UXFWa5WKtq8gN4KRwOftW1lYqjgo2ffZCeS
	ZLGsQt96o2icBeJ1CyKSDGGvFSI7xNyPlru6BCPwbIcpBZ5Wa9gYWpfK2a5DNcSczdg/
	UJ6wPrkZdOEVHKLUuLJMPcM6lkcCU/fUeXsKmrVoupfvpsufX6mqb6vh1cmbVzQfF8B/
	tjb9XqscfoA/ZD7FOSrR9UrDI0YYbZUeGiFhtLGrrW72C3yOduogbMd4zhTf+SLAkgbC
	YoAg==
X-Gm-Message-State: APjAAAV/shKOrzjc/4k3JlL+VNVL7g0/gXqhfNP2D+QqQlhSwqr8N5NF
	sDjS9xXzawnuCP/JyJ7srr6qsCK78iMPTA==
X-Google-Smtp-Source: APXvYqzVgZFobTauvmSLwKcoWGUEMzhGJZUtgNIANujGURsQC9ci4EKCI9UyG7idwnx4ArXXKYIO4g==
X-Received: by 2002:a17:902:a81:: with SMTP id
	1mr80124293plp.287.1558944227937; 
	Mon, 27 May 2019 01:03:47 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.03.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:03:47 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:19 +0530
Message-Id: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 0/8] Add support for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for the newly developed io_uring Linux AIO 
interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code, 
offers efficient buffered asynchronous I/O support, the ability to do I/O 
without performing a system call via polled I/O, and other efficiency 
enhancements. Testing it requires a host kernel (5.1+) and the liburing 
library. Use the option -drive aio=io_uring to enable it.

v2:
- Fix Patchew errors
- Option now enumerates only for CONFIG_LINUX in qapi
- Removed redudant and broken code in io_uring
- io_uring now aborts on sqe leak

v3:
- Fix major errors in io_uring (sorry)
- Option now enumerates for CONFIG_LINUX_IO_URING
- pkg config support added

Aarushi Mehta (8):
  configure: permit use of io_uring
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  block/io_uring: implements interfaces for io_uring
  stubs: add stubs for io_uring interface
  util/async: add aio interfaces for io_uring
  blockdev: accept io_uring as option
  block/fileposix: extend to use io_uring

 MAINTAINERS             |   8 ++
 block/Makefile.objs     |   3 +
 block/file-posix.c      |  65 ++++++++-
 block/io_uring.c        | 301 ++++++++++++++++++++++++++++++++++++++++
 blockdev.c              |   4 +-
 configure               |  27 ++++
 include/block/aio.h     |  16 ++-
 include/block/block.h   |   1 +
 include/block/raw-aio.h |  15 ++
 qapi/block-core.json    |   6 +-
 stubs/Makefile.objs     |   1 +
 stubs/io_uring.c        |  32 +++++
 util/async.c            |  36 +++++
 13 files changed, 506 insertions(+), 9 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

-- 
2.17.1


