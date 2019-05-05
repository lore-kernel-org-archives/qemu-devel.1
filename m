Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6AC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B9C205C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B9C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPUZ-00074y-I7
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:20:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQp-00048h-Dv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQj-00080n-6S
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNPQQ-000792-TA; Sun, 05 May 2019 18:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C509858E25;
	Sun,  5 May 2019 22:15:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE7467C38A;
	Sun,  5 May 2019 22:15:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Mon,  6 May 2019 00:15:31 +0200
Message-Id: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Sun, 05 May 2019 22:15:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/13] hw/block/pflash_cfi02: Clean-up and fixes
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505221531.VR5NsmQZunj_wBIujHIHvBD_2NdpiUXdM4IlbuBpQzw@z>

Hi,

While reviewing Stephen Checkoway's v4 "Implement missing AMD
pflash functionality" [*] I found it hard (for me) to digest,
so I took step by step notes. This series is the result of
those notes.
Regarding Stephen's series, this series only contains the
generic code movement and trivial cleanup. The other patches
are rather dense and I need more time to study the specs.

Stephen: If you take out the patch #2 ("Use the GLib API"),
you can rebase your series on top of this.
I'd appreciate if you can adapt your tests to use the GLib
functions, else I plan to do it later.

Regards,

Phil.

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04595.html

Philippe Mathieu-Daud=C3=A9 (10):
  tests/pflash-cfi02: Use the GLib API
  tests/pflash-cfi02: Use IEC binary prefixes for size constants
  hw/block/pflash_cfi02: Fix debug format string
  hw/block/pflash_cfi02: Add an enum to define the write cycles
  hw/block/pflash_cfi02: Add helpers to manipulate the status bits
  hw/block/pflash_cfi02: Simplify a statement using fall through
  hw/block/pflash_cfi02: Use the ldst API in pflash_write()
  hw/block/pflash_cfi02: Use the ldst API in pflash_read()
  hw/block/pflash_cfi02: Extract the pflash_data_read() function
  hw/block/pflash_cfi02: Unify the MemoryRegionOps

Stephen Checkoway (3):
  tests/pflash-cfi02: Add test for supported CFI commands
  hw/block/pflash_cfi02: Fix command address comparison
  hw/block/pflash_cfi02: Use the chip erase time specified in the CFI
    table

 hw/block/pflash_cfi02.c   | 234 +++++++++++++++++---------------------
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 232 +++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+), 129 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

--=20
2.20.1


