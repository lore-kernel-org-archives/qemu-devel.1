Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E4C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687DE21670
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687DE21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUVe-0003Rj-EP
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hkUTY-0001fG-OG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hkUTX-0008Kh-Ki
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hkUTV-0008Bz-06; Mon, 08 Jul 2019 10:18:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 865973001441;
 Mon,  8 Jul 2019 14:18:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-204.ams2.redhat.com
 [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB892B18D;
 Mon,  8 Jul 2019 14:18:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Jul 2019 16:18:06 +0200
Message-Id: <20190708141812.3974-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 08 Jul 2019 14:18:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/6] Block layer patches
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

The following changes since commit df34fe314b5da628bc9a2664fb1b887bc0a6cc=
6d:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90708' into staging (2019-07-08 14:23:32 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to f7077c9860a438087c2d9a8cc27cb8438c98a748:

  qcow2: Allow -o compat=3Dv3 during qemu-img amend (2019-07-08 16:00:31 =
+0200)

----------------------------------------------------------------
Block layer patches:

- virtio-scsi: Fix request resubmission after I/O error with iothreads
- qcow2: Fix missing v2/v3 subformat aliases for amend
- qcow(1): More specific error message for wrong format version
- MAINTAINERS: update RBD block maintainer

----------------------------------------------------------------
Eric Blake (1):
      qcow2: Allow -o compat=3Dv3 during qemu-img amend

Jason Dillaman (1):
      MAINTAINERS: update RBD block maintainer

John Snow (1):
      block/qcow: Improve error when opening qcow2 files as qcow

Stefan Hajnoczi (3):
      vl: add qemu_add_vm_change_state_handler_prio()
      qdev: add qdev_add_vm_change_state_handler()
      virtio-scsi: restart DMA after iothread

 include/hw/qdev-core.h            |  5 ++++
 include/sysemu/sysemu.h           |  2 ++
 block/qcow.c                      |  7 ++++-
 block/qcow2.c                     |  6 ++--
 hw/core/vm-change-state-handler.c | 61 +++++++++++++++++++++++++++++++++=
++++++
 hw/scsi/scsi-bus.c                |  4 +--
 hw/virtio/virtio.c                |  4 +--
 vl.c                              | 59 +++++++++++++++++++++++++++++----=
----
 MAINTAINERS                       |  2 +-
 hw/core/Makefile.objs             |  1 +
 10 files changed, 130 insertions(+), 21 deletions(-)
 create mode 100644 hw/core/vm-change-state-handler.c

