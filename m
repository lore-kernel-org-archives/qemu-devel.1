Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0M-0008Qt-DL
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0L-0006X4-GQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:14 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:50:57 +0100
Message-Id: <20180615155103.11924-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] Add authorization support to all network
 services
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

This series builds on the core authorization framework:

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04469.html

enabling its use with the VNC, chardev, NBD and migration network servers=
.

In combination with TLS x509 client certificates, this allows these
services to whitelist specific clients, which avoids the need to setup
restricted child certificate authorities.

In VNC it also allows whitelisting based on SASL user names.

Based-on: <20180615154203.11347-1-berrange@redhat.com>

Daniel P. Berrang=C3=A9 (6):
  qemu-nbd: add support for authorization of TLS clients
  nbd: allow authorization with nbd-server-start QMP command
  migration: add support for a "tls-authz" migration parameter
  chardev: add support for authorization for TLS clients
  vnc: allow specifying a custom authorization object name
  monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
    acl_remove

 blockdev-nbd.c        | 14 ++++++++---
 chardev/char-socket.c | 11 +++++++-
 chardev/char.c        |  3 +++
 hmp.c                 | 11 +++++++-
 include/block/nbd.h   |  4 +--
 migration/migration.c |  8 ++++++
 migration/tls.c       |  2 +-
 monitor.c             | 23 +++++++++++++++++
 nbd/server.c          | 12 +++++----
 qapi/block.json       |  4 ++-
 qapi/char.json        |  2 ++
 qapi/migration.json   | 12 ++++++++-
 qemu-doc.texi         | 19 ++++++++------
 qemu-nbd.c            | 13 +++++++++-
 qemu-nbd.texi         |  4 +++
 ui/vnc.c              | 58 ++++++++++++++++++++++++++++++++++++-------
 16 files changed, 167 insertions(+), 33 deletions(-)

--=20
2.17.0
