Received: from eggs.gnu.org ([209.51.188.92]:41072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTW-0001XS-MP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JTV-0002Kw-Rf
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h2JTV-0002KT-Ky
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:40:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCF3F30832CB
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 17:40:00 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-35.phx2.redhat.com [10.3.118.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A158F5D704
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 17:40:00 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  8 Mar 2019 11:39:54 -0600
Message-Id: <20190308173958.20618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] NBD patches for 2019-03-08, 4.0 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit c557a8c7b755d8c153fc0f5be00688228be96e=
76:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2019=
0306a' into staging (2019-03-06 14:50:33 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-03-08

for you to fetch changes up to 054be3605459d4342e9ee5a82ae0fcffeeb09e4d:

  iotests: Wait for qemu to end in 223 (2019-03-06 11:05:27 -0600)

----------------------------------------------------------------
nbd patches for 2019-03-08

- support TLS client authorization in NBD servers
- iotest 223 race fix

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (3):
      qemu-nbd: add support for authorization of TLS clients
      nbd: allow authorization with nbd-server-start QMP command
      nbd: fix outdated qapi docs syntax for tls-creds

Eric Blake (1):
      iotests: Wait for qemu to end in 223

 qemu-nbd.texi              | 11 +++++++++--
 qapi/block.json            | 10 ++++++++--
 include/block/nbd.h        |  4 ++--
 blockdev-nbd.c             | 11 ++++++++---
 hmp.c                      |  2 +-
 nbd/server.c               | 10 +++++-----
 qemu-nbd.c                 | 19 ++++++++++++++++++-
 tests/qemu-iotests/223     |  1 +
 tests/qemu-iotests/223.out |  1 +
 tests/qemu-iotests/233     | 32 +++++++++++++++++++++++++++++---
 tests/qemu-iotests/233.out | 11 +++++++++++
 11 files changed, 93 insertions(+), 19 deletions(-)

--=20
2.20.1
