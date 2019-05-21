Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B601C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A52D217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmt//6dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A52D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEhG-0001n5-KS
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:01:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEca-0005oR-Nl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYb-0001ZF-36
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYa-0001Yk-Rr; Tue, 21 May 2019 19:52:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so272212pfn.7;
	Tue, 21 May 2019 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=JFeWPDQ2SxgUizCJNAqAjhUiNJ/N/RmdbAtexNyjQgM=;
	b=tmt//6dKph/aY5Hq180pEQAfucnx1mJvG8aGT0CW/5/Msi93Kaq67VSca1ytwUWCHW
	G35zChu/6/pTQFPZf/xZFtvDiFywv/+kSrd85e+xDxnoE68j3IlrIG67kuFX32/EKPVW
	hd/YxjTvjU6qBw6f9XJMps3/f0UXm36j+2YeynFix6FWVEJIqcb+5VaJnonnctY8ClDi
	v3qjNvya7MxlYV9T/pPyxV1PAXPQ/hZiSavPRk9YiNCdEsLtg/+t5wU49i1Xw0zY9q5n
	RVuB9xwpbrz1EEXNGuKGQka4Q/pvkDQCrLCkqRrE9MQ/dN0L48T4PqA2uBRJs1WHfm88
	/E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JFeWPDQ2SxgUizCJNAqAjhUiNJ/N/RmdbAtexNyjQgM=;
	b=Jbvle3eT0BdiLy82mhuDswHw7+56rC4KQ/FuQ+e0HfVJyiEax7ugAxb1iaIvdlDugQ
	B+e9X3w61wcob+CBvY3voO04K/ogRY+ykLG/O6YQ7Hrve8A6l61b1zGHPpfaTO30gL73
	IUpM8N+Y0Tancsqig+pg28n7MglozTThY8GdM5jmbkSdpsln4zpPnCIrjyDsdMpN6O/U
	YMde2YGYid9+lxzO5WRKlCu9K6Y+6Vt8NaQL7NDtLFBdm1UQJ9FKeH08iQ9QNIuBDX5L
	3uN2kMyvslPj6qTD5Rk8N0C0Z5K8x0429lt7eH5OM/56UxWqxUJmtypMplTUKKuqtyVt
	tLIg==
X-Gm-Message-State: APjAAAWGxh/28z/uh/+wj+gawO/3ndlhNAfcBoSzm8QaxQilIUHyajaM
	FqAG338TvuxykeGsT+8H0DrrHnQXIZSwEg==
X-Google-Smtp-Source: APXvYqzwJI42TG9byIj8CnBs2iBbU09bRXL3HXx+jk0wd3g5ZtlDhLETIwTsHVmvUgmLniPI5zjHcg==
X-Received: by 2002:aa7:930e:: with SMTP id 14mr34447509pfj.262.1558482751504; 
	Tue, 21 May 2019 16:52:31 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:30 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:06 +0530
Message-Id: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [RFC PATCH 0/9] Add support for io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds supports for the newly developed io_uring Linux AIO interface. Testing it requires a host kernel with it and the liburing library. Use the option -drive aio=io_uring to enable it.

Aarushi Mehta (9):
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  include/block: declare interfaces for io_uring
  stubs: add aio interface stubs for io_uring
  util/asyn: add aio interfaces for io_uring
  block/io_uring: implements interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix: extends to use with io_uring
  configure: permits use of io_uring with probe

 block/Makefile.objs     |   2 +
 block/file-posix.c      |  63 ++++++-
 block/io_uring.c        | 385 ++++++++++++++++++++++++++++++++++++++++
 blockdev.c              |   4 +-
 configure               |  27 +++
 include/block/aio.h     |  16 +-
 include/block/block.h   |   1 +
 include/block/raw-aio.h |  15 ++
 qapi/block-core.json    |   3 +-
 stubs/Makefile.objs     |   1 +
 stubs/io_uring.c        |  32 ++++
 util/async.c            |  32 ++++
 12 files changed, 573 insertions(+), 8 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

--
2.17.1

