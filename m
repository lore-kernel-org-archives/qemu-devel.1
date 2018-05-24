Received: from eggs.gnu.org ([2001:4830:134:3::10]:37858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLuvb-0005D6-44
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLuvX-0000hS-9p
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:25:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLuvX-0000hK-5u
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:25:27 -0400
Date: Thu, 24 May 2018 21:25:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527186303-192100-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v4 0/3] libqtest: verify QEMU exit status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

Whenever QEMU coredumps, the test would previously succeed.
With this patchset applied, one sees:
    assertion failed: !WCOREDUMP(wstatus)

Changes from v3:
- add osdep stubs for non-linux platforms, suggested by Thomas

Changes from v2:
- bugfix
- assert returned pid
- rework complex asserts for clarity

Changes from v1:
- drop SIGTERM as suggested by Eric

Michael S. Tsirkin (3):
  osdep: add wait.h compat macros
  libqtest: fail if child coredumps
  libqtest: add more exit status checks

 include/qemu/osdep.h | 10 ++++++++++
 tests/libqtest.c     | 19 ++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
MST
