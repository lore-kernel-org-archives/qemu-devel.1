Received: from eggs.gnu.org ([2001:4830:134:3::10]:43271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPEe-0004Kg-Jo
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPEY-0007Ex-Sl
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:13:36 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  8 Nov 2017 14:13:05 +0200
Message-Id: <cover.1510143008.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/1] qcow2: Check that corrupted images can be
 repaired in iotest 060
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi,

I sent the 'Misc qcow2 corruption checks' series the other day, and
Kevin suggested that we check that the corrupted images can be
repaired using qemu-img.

This patch extends the tests that I wrote in order to do just
that. Since the series is already in Max's branch I decided to write
this as a follow-up patch, but if you prefer I can resend it instead.

Regards,

Berto

Alberto Garcia (1):
  qcow2: Check that corrupted images can be repaired in iotest 060

 tests/qemu-iotests/060     | 10 ++++++++
 tests/qemu-iotests/060.out | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

-- 
2.11.0
