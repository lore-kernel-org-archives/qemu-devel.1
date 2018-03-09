Received: from eggs.gnu.org ([2001:4830:134:3::10]:50321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4s-0006Ju-VH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4p-0008At-QQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:37:02 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euK4p-0008AN-KA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:36:59 -0500
Received: by mail-wm0-x241.google.com with SMTP id a20so3955245wmd.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:36:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Mar 2018 16:36:46 +0100
Message-Id: <20180309153654.13518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] SDCard: improve tracing, support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This series contains the leftover patches from these 2 series:
- SDCard: housekeeping, add tracing (part 4)
- SDCard: bugfixes, support UHS-I (part 5)
with Peter Maydell comments addressed.

I misunderstood the 2.12 train deadline, but better to have the series
standing in the list rather than forgot it.

Philippe Mathieu-Daudé (8):
  sdcard: Do not trace CMD55, except when we already expect an ACMD
  sdcard: Display command name when tracing CMD/ACMD
  sdcard: Display which protocol is used when tracing (SD or SPI)
  sdcard: Add the Tuning Command (CMD19)
  sdcard: Implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
  sdcard: Add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit
  sdhci: Fix a typo in comment
  MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard)

 hw/sd/sdmmc-internal.h |  20 +++++
 hw/sd/sd.c             | 208 ++++++++++++++++++++++++++++++++++++++++++-------
 hw/sd/sdhci.c          |   4 +-
 hw/sd/sdmmc-internal.c |  72 +++++++++++++++++
 hw/sd/Makefile.objs    |   2 +-
 hw/sd/trace-events     |   9 ++-
 MAINTAINERS            |   8 ++
 7 files changed, 288 insertions(+), 35 deletions(-)
 create mode 100644 hw/sd/sdmmc-internal.c

-- 
2.16.2
