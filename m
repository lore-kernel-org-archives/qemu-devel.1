Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA91C10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F35924679
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KP0ClTAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F35924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOO9-0007Ey-5Z
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMd-0005kL-5G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMb-0008Q3-46
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:46:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39318
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMb-0008Pa-0L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YQlg5F9btXAweC89JM+ELU4g4D3Ss5MCMl6Nievohz8=;
 b=KP0ClTAeA2nS+FGENOWFNkfXFFBY73pIzNyUPMoOyRkpLDm0oVaHF7QGZzvAf5+SIj83pN
 9KoIYunoELWasbcxj/FMbOAQwBBgUcBJOwpn+Ww6fTZgDzE9cpqjWSesFzZlY+tplg35ER
 qYpcXtLExBs81kYO12yp8MGSj2iNU3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-zGjnVK8JOrKEBIT17DgBCw-1; Mon, 09 Mar 2020 15:46:54 -0400
X-MC-Unique: zGjnVK8JOrKEBIT17DgBCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6840DBA3
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:46:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE1535C28D;
 Mon,  9 Mar 2020 19:46:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 00/12] hmp queue
Date: Mon,  9 Mar 2020 19:46:38 +0000
Message-Id: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506=
:

  qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20200309

for you to fetch changes up to b4983c570c7a5848c9df519cd9e056bea3177fe2:

  net: Remove deprecated [hub_id name] tuple of 'hostfwd_add' / 'hostfwd_re=
move' (2020-03-09 18:44:04 +0000)

----------------------------------------------------------------
HMP Pull 2020-03-09

Maxim's hmp block move, Thomas's deprecation in hostfwd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

----------------------------------------------------------------
Maxim Levitsky (11):
      usb/dev-storage: remove unused include
      monitor/hmp: inline add_init_drive
      monitor/hmp: rename device-hotplug.c to block/monitor/block-hmp-cmds.=
c
      monitor/hmp: move hmp_drive_del and hmp_commit to block-hmp-cmds.c
      monitor/hmp: move hmp_drive_mirror and hmp_drive_backup to block-hmp-=
cmds.c
      monitor/hmp: move hmp_block_job* to block-hmp-cmds.c
      monitor/hmp: move hmp_snapshot_* to block-hmp-cmds.c
      monitor/hmp: move hmp_nbd_server* to block-hmp-cmds.c
      monitor/hmp: move remaining hmp_block* functions to block-hmp-cmds.c
      monitor/hmp: move hmp_info_block* to block-hmp-cmds.c
      monitor/hmp: Move hmp_drive_add_node to block-hmp-cmds.c

Thomas Huth (1):
      net: Remove deprecated [hub_id name] tuple of 'hostfwd_add' / 'hostfw=
d_remove'

 MAINTAINERS                    |    1 +
 Makefile.objs                  |    2 +-
 block/Makefile.objs            |    1 +
 block/monitor/Makefile.objs    |    1 +
 block/monitor/block-hmp-cmds.c | 1015 ++++++++++++++++++++++++++++++++++++=
++++
 blockdev.c                     |  137 +-----
 device-hotplug.c               |   91 ----
 docs/system/deprecated.rst     |   15 +-
 hmp-commands.hx                |    8 +-
 hw/usb/dev-storage.c           |    1 -
 include/block/block-hmp-cmds.h |   54 +++
 include/block/block_int.h      |    5 +-
 include/monitor/hmp.h          |   24 -
 include/sysemu/blockdev.h      |    4 -
 include/sysemu/sysemu.h        |    3 -
 monitor/hmp-cmds.c             |  782 -------------------------------
 monitor/misc.c                 |    1 +
 net/hub.c                      |   23 -
 net/hub.h                      |    2 -
 net/slirp.c                    |   44 +-
 20 files changed, 1110 insertions(+), 1104 deletions(-)
 create mode 100644 block/monitor/Makefile.objs
 create mode 100644 block/monitor/block-hmp-cmds.c
 delete mode 100644 device-hotplug.c
 create mode 100644 include/block/block-hmp-cmds.h


