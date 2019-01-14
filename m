Received: from eggs.gnu.org ([209.51.188.92]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj540-0003Rl-5c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj53y-00050x-Db
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gj53x-0004zp-SU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6037F58E59
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 16:26:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-16.phx2.redhat.com [10.3.117.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 205715C7A0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 16:26:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:45 -0600
Message-Id: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/20] NBD patches through 2019-01-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-14

for you to fetch changes up to 636192c4b6052820ea126a5287c58a8f53f3c84f:

  qemu-nbd: Add --bitmap=3DNAME option (2019-01-14 10:09:46 -0600)

----------------------------------------------------------------
nbd patches for 2019-01-14

Promote bitmap/NBD interfaces to stable for use in incremental
backups. Add 'qemu-nbd --bitmap'.

- John Snow: 0/11 bitmaps: remove x- prefix from QMP api
- Philippe Mathieu-Daud=C3=A9: qemu-nbd: Rename 'exp' variable clashing w=
ith math::exp() symbol
- Eric Blake: 0/8 Promote x-nbd-server-add-bitmap to stable

----------------------------------------------------------------
Eric Blake (8):
      nbd: Add some error case testing to iotests 223
      nbd: Forbid nbd-server-stop when server is not running
      nbd: Only require disabled bitmap for read-only exports
      nbd: Merge nbd_export_set_name into nbd_export_new
      nbd: Allow bitmap export during QMP nbd-server-add
      nbd: Remove x-nbd-server-add-bitmap
      nbd: Merge nbd_export_bitmap into nbd_export_new
      qemu-nbd: Add --bitmap=3DNAME option

John Snow (11):
      blockdev: abort transactions in reverse order
      block/dirty-bitmap: remove assertion from restore
      blockdev: n-ary bitmap merge
      block: remove 'x' prefix from experimental bitmap APIs
      iotests.py: don't abort if IMGKEYSECRET is undefined
      iotests: add filter_generated_node_ids
      iotests: add qmp recursive sorting function
      iotests: remove default filters from qmp_log
      iotests: change qmp_log filters to expect QMP objects only
      iotests: implement pretty-print for log and qmp_log
      iotests: add iotest 236 for testing bitmap merge

Philippe Mathieu-Daud=C3=A9 (1):
      qemu-nbd: Rename 'exp' variable clashing with math::exp() symbol

 qemu-nbd.texi                 |   4 +
 qapi/block-core.json          |  56 +++----
 qapi/block.json               |  30 +---
 qapi/transaction.json         |  12 +-
 include/block/nbd.h           |  12 +-
 block/dirty-bitmap.c          |   1 -
 blockdev-nbd.c                |  36 ++---
 blockdev.c                    | 107 ++++++++-----
 hmp.c                         |   5 +-
 nbd/server.c                  | 136 ++++++++--------
 qemu-nbd.c                    |  26 ++--
 tests/qemu-iotests/206        |   8 +-
 tests/qemu-iotests/223        |  52 +++++--
 tests/qemu-iotests/223.out    |  23 ++-
 tests/qemu-iotests/236        | 161 +++++++++++++++++++
 tests/qemu-iotests/236.out    | 351 ++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  64 ++++++--
 18 files changed, 841 insertions(+), 244 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

--=20
2.20.1
