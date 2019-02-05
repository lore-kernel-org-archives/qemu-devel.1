Received: from eggs.gnu.org ([209.51.188.92]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrB-0000bI-1q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrA-0002kT-8d
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gqrrA-0002k1-3Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8CF71368E6
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 03:57:06 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-162.phx2.redhat.com [10.3.116.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54D0C5C8B3
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 03:57:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:56:56 -0600
Message-Id: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] NBD patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 773c4a6228fd910556cee2d477ee56c591a300=
00:

  test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:0=
3:20 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-04

for you to fetch changes up to bc5a03350c220698229e7d6929dd242d5d358345:

  block/nbd-client: rename read_reply_co to connection_co (2019-02-04 15:=
11:27 -0600)

----------------------------------------------------------------
nbd patches for 2019-02-04

- deprecate 'qemu-nbd --partition'
- preparation for NBD reconnect, including better logging of read errors

----------------------------------------------------------------
Eric Blake (1):
      qemu-nbd: Deprecate qemu-nbd --partition

Vladimir Sementsov-Ogievskiy (7):
      nbd: generalize usage of nbd_read
      block/nbd-client: split channel errors from export errors
      block/nbd: move connection code from block/nbd to block/nbd-client
      block/nbd-client: split connection from initialization
      block/nbd-client: fix nbd_reply_chunk_iter_receive
      block/nbd-client: don't check ioc
      block/nbd-client: rename read_reply_co to connection_co

 qemu-deprecated.texi |  33 +++++++++
 qemu-nbd.texi        |   6 +-
 block/nbd-client.h   |   6 +-
 include/block/nbd.h  |  32 ++++++++-
 block/nbd-client.c   | 199 ++++++++++++++++++++++++++++++++-------------=
------
 block/nbd.c          |  40 +----------
 nbd/client.c         |  88 ++++++++---------------
 nbd/common.c         |   2 +-
 nbd/server.c         |  27 +++----
 qemu-nbd.c           |   2 +
 10 files changed, 239 insertions(+), 196 deletions(-)

--=20
2.20.1
