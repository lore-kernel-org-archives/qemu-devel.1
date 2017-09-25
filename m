Received: from eggs.gnu.org ([2001:4830:134:3::10]:35138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdk-0005Db-Cr
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdf-0006BF-Gi
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dwTdf-00069m-AK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59F167EA8D
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 13:41:33 +0000 (UTC)
Received: from red.redhat.com (ovpn-124-97.rdu2.redhat.com [10.10.124.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E367D6F10A
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 13:41:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Sep 2017 08:41:25 -0500
Message-Id: <20170925134130.13262-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] NBD patches for 2017-09-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf4=
17:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-09-23 12:55:40 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-09-25

for you to fetch changes up to a693437037328a95d815ad5aec37ac2f8e130e58:

  block/nbd-client: nbd_co_send_request: fix return code (2017-09-25 08:2=
1:26 -0500)

----------------------------------------------------------------
nbd patches for 2017-09-25

- Eric Blake: nbd-client: Use correct macro parenthesization
- Vladimir Sementsov-Ogievskiy: 0/3 nbd client refactoring and fixing

----------------------------------------------------------------
Eric Blake (1):
      nbd-client: Use correct macro parenthesization

Vladimir Sementsov-Ogievskiy (3):
      block/nbd-client: refactor nbd_co_receive_reply
      block/nbd-client: simplify check in nbd_co_receive_reply
      block/nbd-client: nbd_co_send_request: fix return code

 block/nbd-client.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--=20
2.13.5
