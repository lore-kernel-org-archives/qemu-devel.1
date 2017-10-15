Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wyw-0006SS-88
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wyt-0003cj-4H
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e3Wys-0003c6-Vg
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EA1E85550
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 00:40:37 +0000 (UTC)
Received: from red.redhat.com (ovpn-122-223.rdu2.redhat.com [10.10.122.223])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7AAD60BEE
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 00:40:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:24 -0500
Message-Id: <20171015004033.3248-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] NBD patches through 14 Oct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57=
d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
71012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-10-14

for you to fetch changes up to 92652b124336f5c08c7eb4616af202ea910dd3ea:

  nbd: header constants indenting (2017-10-13 09:27:38 -0500)

----------------------------------------------------------------
nbd patches for 2017-10-14

- Marc-Andr=C3=A9 Lureau - NBD: use g_new() family of functions
- Vladimir Sementsov-Ogievskiy - first half of 00/13 nbd minimal structur=
ed read

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      NBD: use g_new() family of functions

Vladimir Sementsov-Ogievskiy (8):
      block/nbd-client: assert qiov len once in nbd_co_request
      block/nbd-client: refactor nbd_co_receive_reply
      nbd: rename some simple-request related objects to be _simple_
      nbd/server: structurize simple reply header sending
      nbd/server: do not use NBDReply structure
      nbd/server: refactor nbd_co_send_simple_reply parameters
      nbd/server: simplify reply transmission
      nbd: header constants indenting

 include/block/nbd.h                      |  21 ++++---
 nbd/nbd-internal.h                       |  32 +++++-----
 block/nbd-client.c                       |  18 +++---
 nbd/client.c                             |   4 +-
 nbd/server.c                             | 101 +++++++++++++------------=
------
 nbd/trace-events                         |   3 +-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +-
 7 files changed, 88 insertions(+), 95 deletions(-)

--=20
2.13.6
