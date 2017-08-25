Received: from eggs.gnu.org ([2001:4830:134:3::10]:39498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH1u-0000Xf-Nr
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dlH1q-0005M9-Qc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dlH1q-0005LM-Kh
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:00:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 25 Aug 2017 16:57:29 +0100
Message-Id: <20170825155732.15665-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for Python
 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chugh.ishani@research.iiit.ac.in, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Many scripts can benefit from the standard library argparse module, which has
improvements over the older optparse module.  Unfortunately argparse was only
shipped in Python 2.7 so we need a fallback for Python 2.6.

This patch series adds a copy of argparse.py and updates scripts as necessary
to import it.

Stefan Hajnoczi (3):
  scripts: add argparse module for Python 2.6 compatibility
  docker.py: Python 2.6 argparse compatibility
  tests: migration/guestperf Python 2.6 argparse compatibility

 COPYING.PYTHON                     |  270 ++++
 scripts/argparse.py                | 2406 ++++++++++++++++++++++++++++++++++++
 tests/docker/docker.py             |    4 +-
 tests/migration/guestperf/shell.py |    8 +-
 4 files changed, 2684 insertions(+), 4 deletions(-)
 create mode 100644 COPYING.PYTHON
 create mode 100644 scripts/argparse.py

-- 
2.13.5
