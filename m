Received: from eggs.gnu.org ([2001:4830:134:3::10]:34123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7wk-0003kJ-Dr
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7wj-0004yE-Je
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:14 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 19:27:50 +0400
Message-Id: <20181120152753.10463-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1? 0/3] strcpy: fix stringop-truncation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

Some of those warnings have already been fixed, others have been
delayed as it could make sense to disable/ignoring the warning, or
write a custom strncpy() function.

In some cases where NUL-ending string is not mandatory (because the
string length is bound in some format or protocol), we can replace
strncpy() with qemu strpadcpy(), so that the destination string is
still NUL-ending in cases where the destination is larger than the
source string.

Some warnings can be shut up with assert() lines in some cases.

Marc-Andr=C3=A9 Lureau (3):
  sheepdog: fix stringop-truncation warning
  migration: fix stringop-truncation warning
  acpi: fix stringop-truncation warnings

 block/sheepdog.c         |  1 +
 hw/acpi/aml-build.c      |  6 ++++--
 hw/acpi/core.c           | 13 +++++++------
 migration/global_state.c |  1 +
 4 files changed, 13 insertions(+), 8 deletions(-)

--=20
2.19.1.708.g4ede3d42df
