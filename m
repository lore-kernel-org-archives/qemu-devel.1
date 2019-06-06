Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CEC28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83D9207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83D9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqPv-0001VI-Tq
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:18:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFR-0000Sk-6I
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFQ-0003g4-3a
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:57 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFM-0003Yj-BB; Thu, 06 Jun 2019 07:07:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MD9CZ-1hQHVM09Kb-009CQ1; Thu, 06 Jun 2019 13:06:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:09 +0200
Message-Id: <20190606110625.32127-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jXBw7xjNhugMNssuQYniItqf9lQA5/h/Qq88/KbeErJwbnqLpdt
	7ui3P6JZ7OxOIMpyB9CibBkKRDFhoAA7dcJ8ZhnKUkFayXS7Rr+arXJgFtOyI1w6vla9Cjl
	b6penN1tKfSd3/HpXBsc0eqG4iWsM0X/OsD45+qMPo32/wwS9P+IyOQpan1tx7yOASheJbJ
	fZ8H5ic5X+j6ej6HMaRkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Mmxt/cZHXM=:ZQB9PFrxywQi13M79hZF8E
	r1fUhE89o58WGZtmB1P9IiZKmf2mgf1gdh6ad8N+1DjXL4SKUrTtsOBLV91iVrN3iBmlKuUEG
	5SpMugJz8zqdHD4XTR+VapItEbDkehwMs8yAT3VNLCtB2OuteJHW5znx3MOkJJTn49rW8yVYY
	h39UP93BjMDb7jUd8cqPXSUwlcvaP8WGDMKe2eJx+mHeKTyYi9yM2uSYUd3LhQBcZGu28w9OB
	jeA24GN//EPuXcaoBXIHKGyJP36/3MYXxhlnzfR01F6vRp2RYSejBV+OdW3k9YVNWzH/TXBJR
	lqTIivEpCG4B5jhtlgBwDtH8ro16toi46WGVQY2DaUNTAwW0YBlGkcGfmXvCfbDIB5NKErNun
	EZ/3gQ3tG9+XeDp9i04MfMOpQ+gf+NLZCbHRqpkdJuzNQuOZCSqKJNRl5aDoPNcBLmJCGEO7/
	Vpg4aWSVbGn/T7lTJtVhoNWmZHYXJjv79Es5WihW7k/ZZ3fZcMqBaBfgbB9cOEuU3vTODuyD+
	LwiHSrW5XnbeRDgW6yyvVQbwVxkwN/GGBcGQqMi68eKtAVM6c+T3Kx37bIvFydLcIR8LeBkZO
	+UL8J92zpV2XcBAOR12MuXTQHXOFGFuJZ/V+xI9+w2fraduUBAuOmcjzpFv762AlU4n5EQDOs
	HwNRSv2ve8tGFCnVAh61aK2eZ9klhC05ZY9nKJBcgCP37bMFHXbhqXVbbRMnWnS/Oh4dsvh91
	1a4FWUBo+U1sc9w42goA5hHp6Lb4kkHYlPuShbDcD350iulVOT6IMERyXHQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 00/16] Trivial branch patches
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to f1114d321246f9177072923e1c2a20e7aab82700:

  hw/watchdog/wdt_i6300esb: Use DEVICE() macro to access DeviceState.qdev (2019-06-06 11:55:04 +0200)

----------------------------------------------------------------
Trivial fixes 06/06/2019

----------------------------------------------------------------

Jie Wang (1):
  vhost: fix incorrect print type

Li Qiang (1):
  migration: fix a typo

Markus Armbruster (1):
  test: Fix make target check-report.tap

Philippe Mathieu-Daudé (11):
  docs/devel/build-system: Update an example
  hw/scsi/vmw_pvscsi: Use qbus_reset_all() directly
  hw/pci-bridge: Use the QOM BUS() macro to access BusState.qbus
  hw/s390x/event-facility: Use the QOM BUS() macro to access
    BusState.qbus
  hw/isa: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/usb-storage: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/vfio/pci: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/audio/ac97: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/sd: Use the QOM BUS() macro to access BusState.qbus
  hw/scsi: Use the QOM BUS() macro to access BusState.qbus
  hw/watchdog/wdt_i6300esb: Use DEVICE() macro to access
    DeviceState.qdev

Richard Henderson (1):
  util: Adjust qemu_guest_getrandom_nofail for Coverity

Yuval Shaia (1):
  hw/rdma: Delete unused headers inclusion

 docs/devel/build-system.txt | 19 +++++++------------
 hw/audio/ac97.c             |  2 +-
 hw/isa/lpc_ich9.c           |  2 +-
 hw/isa/vt82c686.c           |  2 +-
 hw/pci/pci_bridge.c         |  2 +-
 hw/rdma/rdma_backend.c      |  7 -------
 hw/s390x/event-facility.c   |  4 ++--
 hw/scsi/lsi53c895a.c        |  2 +-
 hw/scsi/mptsas.c            |  4 ++--
 hw/scsi/virtio-scsi.c       |  2 +-
 hw/scsi/vmw_pvscsi.c        |  4 ++--
 hw/sd/milkymist-memcard.c   |  2 +-
 hw/sd/ssi-sd.c              |  2 +-
 hw/usb/dev-storage.c        |  2 +-
 hw/vfio/pci.c               |  4 ++--
 hw/virtio/vhost.c           |  2 +-
 hw/watchdog/wdt_i6300esb.c  |  2 +-
 migration/ram.c             |  2 +-
 tests/Makefile.include      |  2 +-
 util/guest-random.c         |  2 +-
 20 files changed, 29 insertions(+), 41 deletions(-)

-- 
2.21.0


