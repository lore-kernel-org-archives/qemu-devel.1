Received: from eggs.gnu.org ([2001:4830:134:3::10]:50167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW38z-0004fv-Iv
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW38u-0001zt-LX
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:46 -0300
Message-Id: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] hw: various conversions to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

Hi,

This series is a collection of various trivial patches from
different stagnating branches. Time to share before loosing
them.

Only the first differs and is meant for Stefan, other will
probably go via the Trivial tree once Acked.

Regards,

Phil.

Philippe Mathieu-Daudé (11):
  trace: Fix format string for the struct timeval members casted to size_t
  sdcard: Reduce sdcard_set_blocklen() trace digits
  hw/char/serial: Convert from DPRINTF macro to trace events
  hw/char/parallel: Convert from pdebug() macro to trace events
  hw/display/cirrus: Convert printf() calls to trace events
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
 hw/display/cirrus_vga.c          | 25 +++++--------------
 hw/input/tsc2005.c               |  7 +++---
 hw/net/etraxfs_eth.c             |  8 +++---
 hw/net/ne2000.c                  | 25 ++++++++++---------
 hw/block/trace-events            | 17 +++++++++++++
 hw/char/trace-events             |  8 ++++++
 hw/display/trace-events          |  2 ++
 hw/input/trace-events            |  3 +++
 hw/net/trace-events              | 11 +++++++++
 hw/sd/trace-events               |  2 +-
 scripts/tracetool/backend/log.py |  2 +-
 16 files changed, 113 insertions(+), 84 deletions(-)

-- 
2.18.0.rc2
