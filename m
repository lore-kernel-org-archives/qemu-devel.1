Received: from eggs.gnu.org ([2001:4830:134:3::10]:35124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8LB-0006yY-IY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8L9-00018x-7N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:33 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 18:30:01 +0100
Message-Id: <20181212173007.11407-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] unicore32/puv3: Convert from DPRINTF()
 macro to trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>

Remove the definition of DPRINTF() in include/hw/unicore32/puv3.h
and convert to trace event all the puv3_*.c files.

Compile tested but I didn't find any unicore32 kernel to test the
trace output.

Laurent Vivier (6):
  hw/dma/puv3_dma: Convert from DPRINTF() macro to trace event
  hw/dma/puv3_gpio: Convert from DPRINTF() macro to trace event
  hw/dma/puv3_intc: Convert from DPRINTF() macro to trace event
  hw/misc/puv3_pm: Convert from DPRINTF() macro to trace event
  hw/timer/puv3_ost: Convert from DPRINTF() macro to trace event
  unicore32/puv3: remove definition of DPRINTF

 Makefile.objs               |  1 +
 hw/dma/puv3_dma.c           | 11 +++++------
 hw/dma/trace-events         |  6 ++++++
 hw/gpio/puv3_gpio.c         | 15 +++++++--------
 hw/gpio/trace-events        |  6 ++++++
 hw/intc/puv3_intc.c         | 13 ++++++-------
 hw/intc/trace-events        |  7 +++++++
 hw/misc/puv3_pm.c           | 11 +++++------
 hw/misc/trace-events        |  6 ++++++
 hw/timer/puv3_ost.c         | 14 ++++++--------
 hw/timer/trace-events       |  7 +++++++
 include/hw/unicore32/puv3.h |  7 -------
 12 files changed, 62 insertions(+), 42 deletions(-)
 create mode 100644 hw/gpio/trace-events

--=20
2.19.2
