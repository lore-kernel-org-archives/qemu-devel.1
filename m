Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B89C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889A72087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889A72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5OsF-0008LM-V4
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5Onf-0006RG-Kv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5OnZ-0003fm-T0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5OnG-0003Dk-Ft; Wed, 04 Sep 2019 02:29:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B7C318012F2;
 Wed,  4 Sep 2019 06:29:24 +0000 (UTC)
Received: from secure.mitica (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E07E19D70;
 Wed,  4 Sep 2019 06:29:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 08:29:10 +0200
Message-Id: <20190904062915.6488-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 04 Sep 2019 06:29:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] Fail patches
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3483534ec314f6057e66966bfceaa9df02c28f=
bf:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-09-03 16:48:37 +0100)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/fail-pull-request

for you to fetch changes up to 0705e56496d2b155b5796c6b28d4110e5bcbd5d8:

  multifd: Use number of channels as listen backlog (2019-09-03 23:24:42 =
+0200)

----------------------------------------------------------------
Fix multifd with big number of channels

As all of it is migration, danp told me to do the pull myself.

----------------------------------------------------------------

Juan Quintela (5):
  socket: Add backlog parameter to socket_listen
  socket: Add num connections to qio_channel_socket_sync()
  socket: Add num connections to qio_channel_socket_async()
  socket: Add num connections to qio_net_listener_open_sync()
  multifd: Use number of channels as listen backlog

 blockdev-nbd.c                 |  2 +-
 chardev/char-socket.c          |  2 +-
 include/io/channel-socket.h    |  4 ++++
 include/io/net-listener.h      |  2 ++
 include/qemu/sockets.h         |  2 +-
 io/channel-socket.c            | 35 +++++++++++++++++++++++++---------
 io/net-listener.c              |  3 ++-
 io/trace-events                |  4 ++--
 migration/socket.c             |  7 ++++++-
 qemu-nbd.c                     |  2 +-
 qga/channel-posix.c            |  2 +-
 scsi/qemu-pr-helper.c          |  3 ++-
 tests/test-char.c              |  4 ++--
 tests/test-io-channel-socket.c |  4 ++--
 tests/test-util-sockets.c      | 12 ++++++------
 tests/tpm-emu.c                |  2 +-
 ui/vnc.c                       |  4 ++--
 util/qemu-sockets.c            | 33 +++++++++++++++++++++-----------
 util/trace-events              |  3 +++
 19 files changed, 87 insertions(+), 43 deletions(-)

--=20
2.21.0


