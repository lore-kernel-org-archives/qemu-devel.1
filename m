Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15681CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D041D20873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 16:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRpC0LVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D041D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQD4a-0006wh-D1
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 12:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iQCot-0008MB-Jl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iQCoq-0005Yb-1U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iQCop-0005Ul-Sz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 11:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572537421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XM8yZmpBFd/bVIiIsms5odj+mrhPDDi88GvqSNQ2NCM=;
 b=SRpC0LVhSArPb+4cfchURtYf4MRlbi7ZyD5wOsgSgk4PwZ3eeRXq7dx4/cL84SEngXK61F
 OY4fFWindH0PyRBXfMBkm7X6UArEFXulwDymHuZQiLiA9CPDEVlLtZSEtSksUBy3inebb8
 YgwJKikSFFKRA6IDEz8SQ9ct1NkdP0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-NPbf4b19P_yGdEdaOGG10A-1; Thu, 31 Oct 2019 11:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05A2C107ACC0;
 Thu, 31 Oct 2019 15:56:57 +0000 (UTC)
Received: from probe.redhat.com (ovpn-126-19.rdu2.redhat.com [10.10.126.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 898D060132;
 Thu, 31 Oct 2019 15:56:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 0/9] Ide patches
Date: Thu, 31 Oct 2019 11:56:27 -0400
Message-Id: <20191031155636.18589-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NPbf4b19P_yGdEdaOGG10A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 68d8ef4ec540682c3538d4963e836e43a211dd17=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-28101=
9-4' into staging (2019-10-30 14:10:32 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to dc237c45aee52f268369dc6a485c623f1232e1d3:

  hd-geo-test: Add tests for lchs override (2019-10-31 11:47:43 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

John Snow (1):
  IDE: deprecate ide-drive

Sam Eiderman (8):
  block: Refactor macros - fix tabbing
  block: Support providing LCHS from user
  bootdevice: Add interface to gather LCHS
  scsi: Propagate unrealize() callback to scsi-hd
  bootdevice: Gather LCHS from all relevant devices
  bootdevice: Refactor get_boot_devices_list
  bootdevice: FW_CFG interface for LCHS values
  hd-geo-test: Add tests for lchs override

 qemu-deprecated.texi          |   5 +
 include/hw/block/block.h      |  22 +-
 include/hw/scsi/scsi.h        |   1 +
 include/sysemu/sysemu.h       |   4 +
 bootdevice.c                  | 147 +++++++--
 hw/block/virtio-blk.c         |   6 +
 hw/ide/qdev.c                 |  10 +-
 hw/nvram/fw_cfg.c             |  14 +-
 hw/scsi/scsi-bus.c            |  16 +
 hw/scsi/scsi-disk.c           |  12 +
 tests/hd-geo-test.c           | 551 ++++++++++++++++++++++++++++++++++
 tests/Makefile.include        |   2 +-
 tests/qemu-iotests/051.pc.out |   6 +-
 13 files changed, 753 insertions(+), 43 deletions(-)

--=20
2.21.0


