Received: from eggs.gnu.org ([209.51.188.92]:39859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNi-00018r-0v
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNd-0004yP-J5
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gliNb-0004sv-Cg
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDDBD3680B
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 22:49:09 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-44.phx2.redhat.com [10.3.117.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B25D560123
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 22:49:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:46 -0600
Message-Id: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] NBD patches through 2019-01-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 166609e6070fab3424510ac7292ecb585f8b80=
fb:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-january=
-17-2019-v2' into staging (2019-01-21 17:53:28 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-21

for you to fetch changes up to ddd09448fd833d646952c769ae9ce3d39bee989f:

  iotests: Enhance 223, 233 to cover 'qemu-nbd --list' (2019-01-21 15:49:=
52 -0600)

----------------------------------------------------------------
nbd patches for 2019-01-21

Add 'qemu-nbd --list' for probing a remote NBD server's advertisements.

- Eric Blake: 0/21 nbd: add qemu-nbd --list

----------------------------------------------------------------
Eric Blake (21):
      iotests: Make 233 output more reliable
      maint: Allow for EXAMPLES in texi2pod
      qemu-nbd: Enhance man page
      qemu-nbd: Sanity check partition bounds
      nbd/server: Hoist length check to qmp_nbd_server_add
      nbd/server: Favor [u]int64_t over off_t
      qemu-nbd: Avoid strtol open-coding
      nbd/client: Refactor nbd_receive_list()
      nbd/client: Move export name into NBDExportInfo
      nbd/client: Change signature of nbd_negotiate_simple_meta_context()
      nbd/client: Split out nbd_send_meta_query()
      nbd/client: Split out nbd_receive_one_meta_context()
      nbd/client: Refactor return of nbd_receive_negotiate()
      nbd/client: Split handshake into two functions
      nbd/client: Pull out oldstyle size determination
      nbd/client: Refactor nbd_opt_go() to support NBD_OPT_INFO
      nbd/client: Add nbd_receive_export_list()
      nbd/client: Add meta contexts to nbd_receive_export_list()
      qemu-nbd: Add --list option
      nbd/client: Work around 3.0 bug for listing meta contexts
      iotests: Enhance 223, 233 to cover 'qemu-nbd --list'

 qemu-nbd.texi              | 119 +++++--
 Makefile                   |   2 +
 include/block/nbd.h        |  31 +-
 block/nbd-client.c         |   9 +-
 blockdev-nbd.c             |  10 +-
 nbd/client.c               | 775 ++++++++++++++++++++++++++++++++-------=
------
 nbd/server.c               |  24 +-
 qemu-nbd.c                 | 224 ++++++++++---
 nbd/trace-events           |  17 +-
 scripts/texi2pod.pl        |   2 +-
 tests/qemu-iotests/223     |   2 +
 tests/qemu-iotests/223.out |  20 ++
 tests/qemu-iotests/233     |  30 +-
 tests/qemu-iotests/233.out |  19 +-
 14 files changed, 945 insertions(+), 339 deletions(-)

--=20
2.20.1
