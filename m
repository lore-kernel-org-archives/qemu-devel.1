Received: from eggs.gnu.org ([2001:4830:134:3::10]:35389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9d-0003Om-2q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9Z-0000Hw-Tz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:45 -0500
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:36479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edp9Z-0000HF-Pk
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:21:41 -0500
Received: by mail-qt0-x22f.google.com with SMTP id z11so26426259qtm.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:21:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:21:23 -0300
Message-Id: <20180123032135.28863-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/12] SDCard: housekeeping,
 add tracing (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

Since v2:
- split again in 2... this part is cleanup/tracing
- add more tracepoints
- move some code reusable by sdbus in sdmmc-internal.h

Since v1:
- rewrote mostly all patches to keep it simpler.

$ git backport-diff
001/12:[0007] [FC] 'sdcard: reorder SDState struct members'
002/12:[0002] [FC] 'sdcard: replace DPRINTF() by trace events'
003/12:[down] 'sdcard: add a trace event for command responses'
004/12:[down] 'sdcard: replace fprintf() by qemu_hexdump()'
005/12:[0035] [FC] 'sdcard: add more trace events'
006/12:[down] 'sdcard: do not trace CMD55 when expecting ACMD'
007/12:[down] 'sdcard: define SDMMC_CMD_MAX instead of using the magic '64''
008/12:[0083] [FC] 'sdcard: display command name when tracing CMD/ACMD'
009/12:[down] 'sdcard: display protocol used when tracing'
010/12:[----] [--] 'sdcard: rename sd_set_$REG() functions called once as sd_reset_$REG()'
011/12:[0002] [FC] 'sdcard: use G_BYTE from cutils'
012/12:[0008] [FC] 'sdcard: use the registerfields API to access the OCR register'

Based-on: 20180123030630.26613-15-f4bug@amsat.org

Philippe Mathieu-Daudé (12):
  sdcard: reorder SDState struct members
  sdcard: replace DPRINTF() by trace events
  sdcard: add a trace event for command responses
  sdcard: replace fprintf() by qemu_hexdump()
  sdcard: add more trace events
  sdcard: do not trace CMD55 when expecting ACMD
  sdcard: define SDMMC_CMD_MAX instead of using the magic '64'
  sdcard: display command name when tracing CMD/ACMD
  sdcard: display protocol used when tracing
  sdcard: rename sd_set_$REG() functions called once as sd_reset_$REG()
  sdcard: use G_BYTE from cutils
  sdcard: use the registerfields API to access the OCR register

 include/hw/sd/sd.h     |   1 -
 hw/sd/sdmmc-internal.h |  20 +++++
 hw/sd/sd.c             | 212 ++++++++++++++++++++++++++++++++++---------------
 hw/sd/sdmmc-common.c   |  72 +++++++++++++++++
 hw/sd/Makefile.objs    |   2 +-
 hw/sd/trace-events     |  20 +++++
 6 files changed, 259 insertions(+), 68 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.h
 create mode 100644 hw/sd/sdmmc-common.c

-- 
2.15.1
