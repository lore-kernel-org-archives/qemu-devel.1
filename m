Received: from eggs.gnu.org ([2001:4830:134:3::10]:59803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXEIa-0007VU-Gd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXEIV-0001wj-GV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXEIV-0001vo-BS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D387C057EC9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:15:22 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A83EB7088E
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:15:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 17:15:13 -0500
Message-Id: <20170717221516.7692-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 0/3] NBD patches for 2.10 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-17

for you to fetch changes up to 5f66d060dbc37214c9d70305710c3e34c4531d7c:

  nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients (2017-07-17 17:06:46 -0500)

----------------------------------------------------------------
nbd patches for 2017-07-17

- Eric Blake: nbd: Fix iotests failure due to changed client error message
- Eric Blake: [0/2] NBD fixes before softfreeze

----------------------------------------------------------------
Eric Blake (3):
      nbd: Fix iotests failure due to changed client error message
      nbd: Trace client command being sent
      nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients

 nbd/nbd-internal.h         |  8 ++++++--
 nbd/client.c               |  8 ++++----
 nbd/server.c               | 18 ++++++++++--------
 nbd/trace-events           |  2 +-
 tests/qemu-iotests/140.out |  3 ++-
 tests/qemu-iotests/143.out |  3 ++-
 6 files changed, 25 insertions(+), 17 deletions(-)

Eric Blake (3):
  nbd: Fix iotests failure due to changed client error message
  nbd: Trace client command being sent
  nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients

 nbd/nbd-internal.h         |  8 ++++++--
 nbd/client.c               |  8 ++++----
 nbd/server.c               | 18 ++++++++++--------
 nbd/trace-events           |  2 +-
 tests/qemu-iotests/140.out |  3 ++-
 tests/qemu-iotests/143.out |  3 ++-
 6 files changed, 25 insertions(+), 17 deletions(-)

-- 
2.13.3
