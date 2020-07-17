Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D735020759
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcHE8MRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D735020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPut-0006IA-0z
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPte-0004SE-CP
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPta-0008JY-Sn
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ev0U6kbBSILivhI8keW2anf4yjg7QjyclxbAuctFXcg=;
 b=hcHE8MRWdeYCoc+4NA3zClqEKAQvoZ0ziHUfZPtYyAZ9zjJeV/JyvZ1jpFDpDOppkwC4Kv
 Ux/Q9IRuWfr1nKsNw+nqiMvba29t7WDNnC4QwiE3oobXb6wvX6l87c5RXditoBC+NGH/LM
 ze3bB4fjq3p81kb4s4o3xg1Nspk5gB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-s1sxlEPeO6aA1e8oamJtdw-1; Fri, 17 Jul 2020 08:55:18 -0400
X-MC-Unique: s1sxlEPeO6aA1e8oamJtdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E9E1099;
 Fri, 17 Jul 2020 12:55:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE4CA5829;
 Fri, 17 Jul 2020 12:55:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/12] Block layer patches for 5.1.0-rc1
Date: Fri, 17 Jul 2020 14:54:58 +0200
Message-Id: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 151f76c689b1ff4c2c59e6d8469a0d4fe5346f55:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-07-16 21:46:18 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to a8c5cf27c945d392edd85b0b0c64cd5c52cae658:

  file-posix: Fix leaked fd in raw_open_common() error path (2020-07-17 14:20:57 +0200)

----------------------------------------------------------------
Block layer patches:

- file-posix: Fix read-only Linux block devices with auto-read-only
- Require aligned image size with O_DIRECT to avoid assertion failure
- Allow byte-aligned direct I/O on NFS instead of guessing 4k alignment
- Fix nbd_export_close_all() crash
- Fix race in iotests case 030
- qemu-img resize: Require --shrink for shrinking all image formats
- crypto: use a stronger private key for tests
- Remove VXHS block device
- MAINTAINERS: vvfat: set status to odd fixes

----------------------------------------------------------------
Daniel P. Berrangé (1):
      crypto: use a stronger private key for tests

Kevin Wolf (7):
      qemu-img resize: Require --shrink for shrinking all image formats
      iotests/030: Reduce job speed to make race less likely
      block: Require aligned image size to avoid assertion failure
      file-posix: Allow byte-aligned O_DIRECT with NFS
      file-posix: Move check_hdev_writable() up
      file-posix: Fix check_hdev_writable() with auto-read-only
      file-posix: Fix leaked fd in raw_open_common() error path

Marc-André Lureau (1):
      Remove VXHS block device

Prasad J Pandit (1):
      vvfat: set status to odd fixes

Vladimir Sementsov-Ogievskiy (2):
      nbd: make nbd_export_close_all() synchronous
      iotests: test shutdown when bitmap is exported through NBD

 qapi/block-core.json             |  22 +-
 docs/system/deprecated.rst       |   8 +
 configure                        |  39 ---
 block.c                          |  16 ++
 block/file-posix.c               | 122 +++++---
 block/vxhs.c                     | 587 ---------------------------------------
 nbd/server.c                     |   8 +
 qemu-img.c                       |  14 +-
 tests/crypto-tls-x509-helpers.c  |  59 ++--
 MAINTAINERS                      |   2 +-
 block/Makefile.objs              |   2 -
 block/trace-events               |  17 --
 tests/qemu-iotests/017           |   1 -
 tests/qemu-iotests/029           |   1 -
 tests/qemu-iotests/030           |   2 +-
 tests/qemu-iotests/073           |   1 -
 tests/qemu-iotests/114           |   1 -
 tests/qemu-iotests/130           |   1 -
 tests/qemu-iotests/134           |   1 -
 tests/qemu-iotests/156           |   1 -
 tests/qemu-iotests/158           |   1 -
 tests/qemu-iotests/282           |   1 -
 tests/qemu-iotests/299           |  65 +++++
 tests/qemu-iotests/299.out       |  10 +
 tests/qemu-iotests/check         |  10 -
 tests/qemu-iotests/common.filter |   1 -
 tests/qemu-iotests/common.rc     |  33 ---
 tests/qemu-iotests/common.tls    |  57 ++--
 tests/qemu-iotests/group         |   1 +
 29 files changed, 273 insertions(+), 811 deletions(-)
 delete mode 100644 block/vxhs.c
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out


