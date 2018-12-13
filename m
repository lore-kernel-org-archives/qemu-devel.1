Received: from eggs.gnu.org ([2001:4830:134:3::10]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXTpr-0006lL-Ut
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gXTpq-0002fg-Pm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:27:39 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 13 Dec 2018 17:27:23 +0100
Message-Id: <20181213162727.17438-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] block: Convert from DPRINTF() macro to
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
Cc: qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Convert all the remaining uses of DPRINTF() in the directory block.

Compiled for all target but only tested with "make check"

v2: replace "sd_" prefix by "sheepdog_"
    remove the dot at the end of the text strings
    use %zu with size_t
    change an uint64_t to int64_t to match % PRIi64

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
