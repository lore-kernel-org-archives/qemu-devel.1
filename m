Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvknu-0002WS-P0
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvknu-0005Pq-6R
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:42 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 16:53:11 +0200
Message-Id: <20180831145314.14736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Here are a few PID file related patches extracted from "[PATCH v4
00/29] vhost-user for input & GPU" series, with suggestions from
Daniel Berrang=C3=A9.

thanks

Marc-Andr=C3=A9 Lureau (3):
  util: add qemu_write_pidfile()
  util: use fcntl() for qemu_write_pidfile() locking
  RFC: delete PID file on exit

 include/qemu/osdep.h  |  3 +-
 os-posix.c            | 24 --------------
 os-win32.c            | 25 ---------------
 qga/main.c            | 54 ++++++--------------------------
 scsi/qemu-pr-helper.c | 40 +++---------------------
 util/oslib-posix.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c    | 27 ++++++++++++++++
 vl.c                  | 15 +++++++--
 8 files changed, 129 insertions(+), 132 deletions(-)

--=20
2.19.0.rc1
