Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B3C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCCB2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCCB2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtJA-0005Xw-Iy
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iEtHP-0004Hg-Hs
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iEtHN-0003ee-64
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iEtHM-0003eD-W6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1CC25AFE9
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 10:51:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5B3A5D9C9;
 Mon, 30 Sep 2019 10:51:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Subject: [PATCH v4 0/3] Add virtio-fs
Date: Mon, 30 Sep 2019 11:51:32 +0100
Message-Id: <20190930105135.27244-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 30 Sep 2019 10:51:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: mszeredi@redhat.com, cohuck@redhat.com, vgoyal@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This set of patches adds the core of the virtio-fs support to qemu.
It's no longer marked experimental since both the spec and kernel have
been merged upstream.

  A future set of patches will add the optional DAX mapping support.

  The actual qemu change is pretty minimal, since it's really only
a virtio device with some queues.

Some links:
  Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
  Dev tree: Including filesystem daemon: https://gitlab.com/virtio-fs/qem=
u

v4
  Update the linux headers using the update script directly from the
    kernel tree
  No longer marked experimental

Dr. David Alan Gilbert (3):
  virtio: Add virtio_fs linux headers
  virtio: add vhost-user-fs base device
  virtio: add vhost-user-fs-pci device

 configure                                   |  13 +
 hw/virtio/Makefile.objs                     |   2 +
 hw/virtio/vhost-user-fs-pci.c               |  85 ++++++
 hw/virtio/vhost-user-fs.c                   | 299 ++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h           |  45 +++
 include/standard-headers/linux/virtio_fs.h  |  19 ++
 include/standard-headers/linux/virtio_ids.h |   2 +
 7 files changed, 465 insertions(+)
 create mode 100644 hw/virtio/vhost-user-fs-pci.c
 create mode 100644 hw/virtio/vhost-user-fs.c
 create mode 100644 include/hw/virtio/vhost-user-fs.h
 create mode 100644 include/standard-headers/linux/virtio_fs.h

--=20
2.21.0


