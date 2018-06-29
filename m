Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaU-0000Bu-T4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaQ-0008JF-R0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaQ-0008IS-Mr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:19 +0100
Message-Id: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>

The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f=
18:

  Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-reque=
st' into staging (2018-06-28 17:53:31 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 13019f1fd6c683b243120b7eb999f1b50a224940:

  hw/block/pflash_cfi: Convert from DPRINTF() macro to trace events (2018=
-06-29 15:04:18 +0100)

----------------------------------------------------------------
Pull request

 * Python 3 support in simpletrace.py
 * Convert DPRINTF() to trace events

----------------------------------------------------------------

Eduardo Habkost (1):
  simpletrace: Convert name from mapping record to str

Philippe Mathieu-Daud=C3=A9 (10):
  trace: Fix format string for the struct timeval members casted to
    size_t
  sdcard: Reduce sdcard_set_blocklen() trace digits
  hw/char/serial: Convert from DPRINTF macro to trace events
  hw/char/parallel: Convert from pdebug() macro to trace events
  hw/input/tsc2005: Convert a fprintf() call to trace events
  hw/net/ne2000: Add trace events
  hw/net/ne2000: Convert printf() calls to trace events
  hw/net/etraxfs_eth: Convert printf() calls to trace events
  hw/block/fdc: Convert from FLOPPY_DPRINTF() macro to trace events
  hw/block/pflash_cfi: Convert from DPRINTF() macro to trace events

 hw/block/fdc.c                   |  6 ++---
 hw/block/pflash_cfi01.c          | 42 ++++++++++++--------------------
 hw/block/pflash_cfi02.c          | 18 +++++++-------
 hw/char/parallel.c               | 16 +++++++++---
 hw/char/serial.c                 |  5 ++--
 hw/input/tsc2005.c               |  7 +++---
 hw/net/etraxfs_eth.c             |  8 +++---
 hw/net/ne2000.c                  | 25 ++++++++++---------
 hw/block/trace-events            | 17 +++++++++++++
 hw/char/trace-events             |  8 ++++++
 hw/input/trace-events            |  3 +++
 hw/net/trace-events              | 11 +++++++++
 hw/sd/trace-events               |  2 +-
 scripts/simpletrace.py           |  2 +-
 scripts/tracetool/backend/log.py |  2 +-
 15 files changed, 106 insertions(+), 66 deletions(-)

--=20
2.17.1
