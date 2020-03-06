Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5752051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgPtvN91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5752051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGao-0006h8-CZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ1-0004dh-MP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGYz-0006a7-Tt
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGYz-0006Wf-NE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tUCFvBBWZfpNui06GsAWCE7BeZIDuqWkKEbSa5rL7CQ=;
 b=YgPtvN91ATZ+KRo3/01qU9CrG7tcBkbky2GMwxkobKB+4k0N+qydXUHFBYiAAihvN0IKAa
 FMfxE9GpHWuQLatoAams6B6ihgBX/WCzO9GJgC3y6Cex7jJnNh+PILE8SD8tmgvl8vUGLK
 4x9xWTKLUe1NouI7k4j7PQaPwl9vxb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-SiTE-n7AP0-NA-kKIESFig-1; Fri, 06 Mar 2020 12:15:03 -0500
X-MC-Unique: SiTE-n7AP0-NA-kKIESFig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE5F713F6;
 Fri,  6 Mar 2020 17:15:01 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEDC773873;
 Fri,  6 Mar 2020 17:15:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/29] Block layer patches
Date: Fri,  6 Mar 2020 18:14:29 +0100
Message-Id: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

The following changes since commit f4c4357fbfca0fb14e477bf661ae7384b4b9b283=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200306' i=
nto staging (2020-03-06 11:11:54 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1de6b45fb5c1489b450df7d1a4c692bba9678ce6:

  block: bdrv_reopen() with backing file in different AioContext (2020-03-0=
6 17:34:09 +0100)

----------------------------------------------------------------
Block layer patches:

- Add qemu-storage-daemon (still experimental)
- rbd: Add support for ceph namespaces
- Fix bdrv_reopen() with backing file in different AioContext
- qcow2: Fix read-write reopen with persistent dirty bitmaps
- qcow2: Fix alloc_cluster_abort() for pre-existing clusters

----------------------------------------------------------------
Florian Florensa (1):
      block/rbd: Add support for ceph namespaces

Kevin Wolf (22):
      qemu-storage-daemon: Add barebone tool
      stubs: Add arch_type
      block: Move system emulator QMP commands to block/qapi-sysemu.c
      block: Move common QMP commands to block-core QAPI module
      block: Move sysemu QMP commands to QAPI block module
      qemu-storage-daemon: Add --blockdev option
      qapi: Flatten object-add
      qemu-storage-daemon: Add --object option
      qemu-storage-daemon: Add --nbd-server option
      blockdev-nbd: Boxed argument type for nbd-server-add
      qemu-storage-daemon: Add --export option
      qemu-storage-daemon: Add main loop
      qemu-storage-daemon: Add --chardev option
      stubs: Update monitor stubs for qemu-storage-daemon
      qapi: Create 'pragma' module
      monitor: Create QAPIfied monitor_init()
      qmp: Fail gracefully if chardev is already in use
      hmp: Fail gracefully if chardev is already in use
      monitor: Add allow_hmp parameter to monitor_init()
      qemu-storage-daemon: Add --monitor option
      iotests: Refactor blockdev-reopen test for iothreads
      block: bdrv_reopen() with backing file in different AioContext

Max Reitz (4):
      qcow2: Fix alloc_cluster_abort() for pre-existing clusters
      iotests/026: Test EIO on preallocated zero cluster
      iotests/026: Test EIO on allocation in a data-file
      block: Fix leak in bdrv_create_file_fallback()

Peter Krempa (2):
      block: Introduce 'bdrv_reopen_commit_post' step
      block/qcow2: Move bitmap reopen into bdrv_reopen_commit_post

 qapi/block-core.json                 | 733 +++++++++++++++++--------------=
----
 qapi/block.json                      | 512 ++++++++++++++----------
 qapi/control.json                    |  37 ++
 qapi/pragma.json                     |  24 ++
 qapi/qapi-schema.json                |  25 +-
 qapi/qom.json                        |  12 +-
 qapi/transaction.json                |   2 +-
 docs/system/deprecated.rst           |   5 +
 configure                            |   2 +-
 include/block/block_int.h            |   1 +
 include/block/nbd.h                  |   1 +
 include/monitor/monitor.h            |   6 +-
 include/qom/object_interfaces.h      |   7 +
 include/sysemu/arch_init.h           |   2 +
 block.c                              |  44 ++-
 block/qapi-sysemu.c                  | 590 ++++++++++++++++++++++++++++
 block/qcow2-cluster.c                |   2 +-
 block/qcow2.c                        |   7 +-
 block/rbd.c                          |  44 ++-
 blockdev-nbd.c                       |  40 +-
 blockdev.c                           | 559 --------------------------
 chardev/char.c                       |   8 +-
 gdbstub.c                            |   2 +-
 hw/block/xen-block.c                 |  11 +-
 monitor/hmp-cmds.c                   |  21 +-
 monitor/hmp.c                        |   8 +-
 monitor/misc.c                       |   2 +
 monitor/monitor.c                    |  86 ++--
 monitor/qmp-cmds.c                   |   2 +-
 monitor/qmp.c                        |  11 +-
 qemu-storage-daemon.c                | 340 ++++++++++++++++
 qom/qom-qmp-cmds.c                   |  42 +-
 stubs/arch_type.c                    |   4 +
 stubs/monitor-core.c                 |  21 +
 stubs/monitor.c                      |  17 +-
 tests/test-util-sockets.c            |   4 +-
 scripts/qapi/gen.py                  |   5 +
 Makefile                             |  37 ++
 Makefile.objs                        |   9 +
 block/Makefile.objs                  |   4 +-
 monitor/Makefile.objs                |   2 +
 qapi/Makefile.objs                   |   7 +-
 qom/Makefile.objs                    |   1 +
 storage-daemon/Makefile.objs         |   1 +
 storage-daemon/qapi/Makefile.objs    |   1 +
 storage-daemon/qapi/qapi-schema.json |  26 ++
 stubs/Makefile.objs                  |   2 +
 tests/qemu-iotests/026               |  53 +++
 tests/qemu-iotests/026.out           |  16 +
 tests/qemu-iotests/026.out.nocache   |  16 +
 tests/qemu-iotests/245               |  45 ++-
 tests/qemu-iotests/245.out           |   4 +-
 52 files changed, 2157 insertions(+), 1306 deletions(-)
 create mode 100644 qapi/pragma.json
 create mode 100644 block/qapi-sysemu.c
 create mode 100644 qemu-storage-daemon.c
 create mode 100644 stubs/arch_type.c
 create mode 100644 stubs/monitor-core.c
 create mode 100644 storage-daemon/Makefile.objs
 create mode 100644 storage-daemon/qapi/Makefile.objs
 create mode 100644 storage-daemon/qapi/qapi-schema.json


