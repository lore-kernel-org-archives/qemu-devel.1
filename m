Received: from eggs.gnu.org ([2001:4830:134:3::10]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf5-00061s-Gd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf2-0000w1-BN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:51 -0500
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:38617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRf2-0000vk-6e
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:05:48 -0500
Received: by mail-qk0-x232.google.com with SMTP id s198so1551558qke.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:05:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:05:29 -0300
Message-Id: <20180215220540.6556-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/11] SDCard: housekeeping,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Since v3:
- use assert() in sd_state_name() and sd_response_name() (Alistair review)
- added sdmmc-internal.h & sdmmc-common.c to reuse helpers with hw/sd/core.c

Since v2:
- split again in 2... this part is cleanup/tracing
- add more tracepoints
- move some code reusable by sdbus in sdmmc-internal.h

Since v1:
- rewrote mostly all patches to keep it simpler.

$ git backport-diff
001/11:[----] [--] 'sdcard: reorder SDState struct members'
002/11:[0003] [FC] 'sdcard: replace DPRINTF() by trace events'
003/11:[0001] [FC] 'sdcard: add a trace event for command responses'
004/11:[0007] [FC] 'sdcard: replace fprintf() by qemu_hexdump()'
005/11:[----] [--] 'sdcard: add more trace events'
006/11:[----] [--] 'sdcard: do not trace CMD55 when expecting ACMD'
007/11:[0014] [FC] 'sdcard: define SDMMC_CMD_MAX instead of using the magic '64''
008/11:[0020] [FC] 'sdcard: display command name when tracing CMD/ACMD'
009/11:[----] [--] 'sdcard: display protocol used when tracing'
010/11:[----] [-C] 'sdcard: use G_BYTE from cutils'
011/11:[----] [-C] 'sdcard: use the registerfields API to access the OCR register'

Philippe Mathieu-Daudé (11):
  sdcard: reorder SDState struct members
  sdcard: replace DPRINTF() by trace events
  sdcard: add a trace event for command responses
  sdcard: replace fprintf() by qemu_hexdump()
  sdcard: add more trace events
  sdcard: do not trace CMD55 when expecting ACMD
  sdcard: define SDMMC_CMD_MAX instead of using the magic '64'
  sdcard: display command name when tracing CMD/ACMD
  sdcard: display protocol used when tracing
  sdcard: use G_BYTE from cutils
  sdcard: use the registerfields API to access the OCR register

 hw/sd/sdmmc-internal.h |  18 +++++
 include/hw/sd/sd.h     |   1 -
 hw/sd/sd.c             | 184 ++++++++++++++++++++++++++++++++++---------------
 hw/sd/sdmmc-common.c   |  72 +++++++++++++++++++
 hw/sd/Makefile.objs    |   2 +-
 hw/sd/trace-events     |  20 ++++++
 6 files changed, 241 insertions(+), 56 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.h
 create mode 100644 hw/sd/sdmmc-common.c

-- 
2.16.1
