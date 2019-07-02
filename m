Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE9C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66367216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66367216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi97K-0003wm-Qc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi78t-0002db-4e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi78r-0000uF-C1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 20:59:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi78j-0000my-DI; Mon, 01 Jul 2019 20:59:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4D0130C747A;
 Tue,  2 Jul 2019 00:59:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0B511001B2F;
 Tue,  2 Jul 2019 00:59:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:58:45 -0300
Message-Id: <20190702005912.15905-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 00:59:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/27] pflash-next patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/pflash-next-20190701

for you to fetch changes up to 3ae0343db69c379beb5750b4ed70794bbed51b85:

  hw/block/pflash_cfi02: Reduce I/O accesses to 16-bit (2019-07-02 02:34:=
55 +0200)

----------------------------------------------------------------

Implement the following AMD command-set parallel flash functionality:
- nonuniform sector sizes;
- erase suspend/resume commands; and
- multi-sector erase.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (19):
  hw/block/pflash: Simplify trace_pflash_io_read/write()
  hw/block/pflash: Simplify trace_pflash_data_read/write()
  hw/block/pflash_cfi02: Fix debug format string
  hw/block/pflash_cfi02: Add an enum to define the write cycles
  hw/block/pflash_cfi02: Add helpers to manipulate the status bits
  hw/block/pflash_cfi02: Simplify a statement using fall through
  hw/block/pflash_cfi02: Use the ldst API in pflash_write()
  hw/block/pflash_cfi02: Use the ldst API in pflash_read()
  hw/block/pflash_cfi02: Extract the pflash_data_read() function
  hw/block/pflash_cfi02: Unify the MemoryRegionOps
  tests/pflash-cfi02: Refactor to support testing multiple configurations
  hw/block/pflash_cfi02: Remove pointless local variable
  hw/block/pflash_cfi02: Document the current CFI values
  hw/block/pflash_cfi02: Hold the PRI table offset in a variable
  hw/block/pflash_cfi02: Document 'Page Mode' operations are not supporte=
d
  hw/block/pflash_cfi02: Extract pflash_regions_count()
  hw/block/pflash_cfi02: Split if() condition
  hw/block/pflash_cfi02: Document commands
  hw/block/pflash_cfi02: Reduce I/O accesses to 16-bit

Stephen Checkoway (8):
  tests/pflash-cfi02: Add test for supported CFI commands
  hw/block/pflash_cfi02: Fix command address comparison
  hw/block/pflash_cfi02: Implement nonuniform sector sizes
  hw/block/pflash_cfi02: Fix CFI in autoselect mode
  hw/block/pflash_cfi02: Fix reset command not ignored during erase
  hw/block/pflash_cfi02: Implement multi-sector erase
  hw/block/pflash_cfi02: Implement erase suspend/resume
  hw/block/pflash_cfi02: Use chip erase time specified in the CFI table

 hw/block/pflash_cfi01.c   |  11 +-
 hw/block/pflash_cfi02.c   | 701 ++++++++++++++++++++++++++------------
 hw/block/trace-events     |  10 +-
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 681 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1172 insertions(+), 233 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

--=20
2.20.1


