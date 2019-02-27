Received: from eggs.gnu.org ([209.51.188.92]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz22C-0004Xu-EP
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz228-0005c0-BE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:26:15 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 16:20:32 +0000
Message-Id: <20190227162035.18543-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/3] nbd: support for authorization control
 on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series provides the NBD parts of the authorization control series
previously posted as:

  v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.html
  v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.html
  v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.html
  v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.html

Then separated for merge:

  v5: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07347.html

The core authz framework is now merged & these patches have all had
positive review. Thus these NBD parts are ready to go into the NBD
maintainer's tree, should the maintainer consider them acceptable.

Changed in v6:

 - Fix qapi annotations
 - Add qemu-nbd example
 - Reject authz parameter with --list

Daniel P. Berrang=C3=A9 (3):
  qemu-nbd: add support for authorization of TLS clients
  nbd: allow authorization with nbd-server-start QMP command
  nbd: fix outdated qapi docs syntax for tls-creds

 blockdev-nbd.c             | 11 ++++++++---
 hmp.c                      |  2 +-
 include/block/nbd.h        |  4 ++--
 nbd/server.c               | 10 +++++-----
 qapi/block.json            | 10 ++++++++--
 qemu-nbd.c                 | 18 +++++++++++++++++-
 qemu-nbd.texi              | 11 +++++++++--
 tests/qemu-iotests/233     | 31 ++++++++++++++++++++++++++++---
 tests/qemu-iotests/233.out | 11 +++++++++++
 9 files changed, 89 insertions(+), 19 deletions(-)

--=20
2.20.1
