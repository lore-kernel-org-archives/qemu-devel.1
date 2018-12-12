Received: from eggs.gnu.org ([2001:4830:134:3::10]:47283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMu-0005YN-IK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXAMt-0007jA-ME
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:40:28 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 20:40:05 +0100
Message-Id: <20181212194009.2951-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] block: Convert from DPRINTF() macro to
 trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Liu Yuan <namei.unix@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>

Convert all the remaining uses of DPRINTF() in the directory block.

Compiled for all target but only tested with "make check"

Laurent Vivier (4):
  block/ssh: Convert from DPRINTF() macro to trace events
  block/curl: Convert from DPRINTF() macro to trace events
  block/file-posix: Convert from DPRINTF() macro to trace events
  block/sheepdog: Convert from DPRINTF() macro to trace events

 block/curl.c       | 29 ++++++++--------------------
 block/file-posix.c | 25 ++++++------------------
 block/sheepdog.c   | 47 +++++++++++++++++-----------------------------
 block/ssh.c        | 46 +++++++++++++++++----------------------------
 block/trace-events | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 99 deletions(-)

--=20
2.19.2
