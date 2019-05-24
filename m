Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C1C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F55120879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ungfwpkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F55120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAtN-00076A-8n
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:09:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoS-0003SB-5d
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAnf-0002Lp-Hg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAnf-0002Kx-9K; Fri, 24 May 2019 10:03:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id u17so5396845pfn.7;
	Fri, 24 May 2019 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=NAlK3IXTaFLznSZf1TdQM7YTbALj0xbQ+SmrBQupY3I=;
	b=UngfwpklISqNSRXh5/oBvHueGyyADAgtI/HdjMgqkUFbs0/Bid71PXstOa3esjm3Cr
	0kGegym+22I6H54SrGMNPmzaynxkJZfTJJKg70QkPxnkT4AExmEv4YcdHhpQY42dEAXy
	nNfGB7cPB8LmuK475rJdLTvmrwkzznsM4XMb0bJuw+ymbzl5QqYCF4hqkYq42YKzR5+W
	tWl62IsqRNMtmywpo1ae+hfYxBDejSiyd5Z+2NTJVpUsIBWlha3avVKrHycH/1znaYHn
	2ElpYtPX32q6CiVAKq0Relf+xCE6qv7eJ1++cllOeRci3ZRH6rvdogAQzPVWLG2baf7A
	7nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NAlK3IXTaFLznSZf1TdQM7YTbALj0xbQ+SmrBQupY3I=;
	b=TbPj37K6iufeKbPxMkvG5PUC2fFkocLb/LZw8k2ZjEnRbuqV+dh0c0zj6CtEc0bu3S
	FFYIhgfy5W6xZ3BNyy2SpXeXzKiJ6UjIWz6l9d0uLDp7zK9P925/NAIht6nwPBa8GQHp
	jKZJNhUZ651yBHIy+MmC99C9ACvCWy6do3h3UuXirqz2MT6/8e9h0rkB1uuLskmzoTl4
	50WrCmj53w6467mQin0/8hli2wrdis35pvqgvlvCFFf4gko7si1VSNMgOao+5eYIuFLH
	kj6bQdNg39bTSZtunvyvlQEFqlrr9nHcORV5Nhhvts6Qrsy5yNskM6zL8Ot4CxTyZWqX
	Z23Q==
X-Gm-Message-State: APjAAAXIo8J391CaSWgLoXq11UYKYqSygGipIaVLeIaZOBRrQFqMnTeT
	yk9Q+/NBFmN0DstyXvKGw9yOGYYoDWpi9Q==
X-Google-Smtp-Source: APXvYqwKuiJ1k6+Ezs21ya6ATKU0heEr5lL7ltsOP7DzBFLgfC7Aq5PG9c8cP7xCPuVXSEgXK+eAEw==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr103317820pgv.22.1558706637087; 
	Fri, 24 May 2019 07:03:57 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.03.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:03:56 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:28 +0530
Message-Id: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [RFC PATCH v2 0/9] Add support for io_uring
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
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds support for the newly developed io_uring Linux AIO interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code, offers efficient buffered asynchronous I/O support, the ability to do I/O without performing a system call via polled I/O, and other efficiency enhancements. It is expected that it will replace the old AIO interface

Testing it requires a host kernel 5.1 or newer and the liburing library. Use the option -drive aio=io_uring to enable it.

v2:
- Fix Patchew errors
- Option now enumerates only for CONFIG_LINUX in qapi
- Removed redudant and broken code in io_uring
- io_uring now aborts on sqe leak

Aarushi Mehta (9):
  qapi/block-core: add option for io_uring
  block/block: add BDRV flag for io_uring
  include/block: declare interfaces for io_uring
  stubs: add aio interface stubs for io_uring
  util/async: add aio interfaces for io_uring
  block/io_uring: implements interfaces for io_uring
  blockdev: accept io_uring as option
  block/file-posix: extends to use with io_uring
  configure: permit use of io_uring

 MAINTAINERS             |  11 ++
 block/Makefile.objs     |   2 +
 block/file-posix.c      |  63 ++++++++-
 block/io_uring.c        | 306 ++++++++++++++++++++++++++++++++++++++++
 blockdev.c              |   4 +-
 configure               |  27 ++++
 include/block/aio.h     |  16 ++-
 include/block/block.h   |   1 +
 include/block/raw-aio.h |  15 ++
 qapi/block-core.json    |   6 +-
 stubs/Makefile.objs     |   1 +
 stubs/io_uring.c        |  32 +++++
 util/async.c            |  36 +++++
 13 files changed, 511 insertions(+), 9 deletions(-)
 create mode 100644 block/io_uring.c
 create mode 100644 stubs/io_uring.c

--
2.17.1

