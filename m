Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3845C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012021530
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012021530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1yp-0004Zd-IX
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hn1ya-00040X-Vj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hn1yZ-0005qM-R3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hn1yX-0005oa-Cv; Mon, 15 Jul 2019 10:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CCE4309174E;
 Mon, 15 Jul 2019 14:29:08 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C2B5C28D;
 Mon, 15 Jul 2019 14:29:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 16:28:54 +0200
Message-Id: <20190715142905.9078-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 15 Jul 2019 14:29:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/11] Block patches for rc1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67=
f2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' =
into staging (2019-07-15 12:22:07 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-07-15

for you to fetch changes up to 0b1847bbc2b4f50e7497cb05c4540bf7b016c9c6:

  gluster: fix .bdrv_reopen_prepare when backing file is a JSON object (2=
019-07-15 15:48:41 +0200)

----------------------------------------------------------------
Block patches for 4.1-rc1:
- Fixes for the NVMe block driver, the gluster block driver, and for
  running multiple block jobs concurrently on a single chain

----------------------------------------------------------------
Max Reitz (9):
  block: Add BDS.never_freeze
  block/stream: Fix error path
  block/stream: Swap backing file change order
  block: Deep-clear inherits_from
  iotests: Fix throttling in 030
  iotests: Compare error messages in 030
  iotests: Add @use_log to VM.run_job()
  iotests: Add new case to 030
  iotests: Add read-only test case to 030

Michal Privoznik (1):
  nvme: Set number of queues later in nvme_init()

Stefano Garzarella (1):
  gluster: fix .bdrv_reopen_prepare when backing file is a JSON object

 include/block/block_int.h     |   3 +
 block.c                       |  42 +++++++---
 block/commit.c                |   4 +
 block/gluster.c               |  12 ++-
 block/mirror.c                |   4 +
 block/nvme.c                  |   2 +-
 block/stream.c                |   4 +-
 tests/qemu-iotests/030        | 150 +++++++++++++++++++++++++++-------
 tests/qemu-iotests/030.out    |   4 +-
 tests/qemu-iotests/iotests.py |  18 ++--
 10 files changed, 193 insertions(+), 50 deletions(-)

--=20
2.21.0


