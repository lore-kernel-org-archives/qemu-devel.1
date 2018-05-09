Received: from eggs.gnu.org ([2001:4830:134:3::10]:50277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA7-0008RD-Qs
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA4-0005Ki-Qn
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGIA4-0005K4-LV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:01:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id j42-v6so44199899qtj.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 23:01:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 03:01:00 -0300
Message-Id: <20180509060104.4458-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/4] SDCard: support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Since v1:
- corrected the CRC16 offset
- addressed Peter Maydell comments
  - add Edgar Iglesias S-o-b for Alistair Francis original patch at Xilinx
  - use SD_FG_MAX to have a clearer loop
  - rename uhs_enabled/uhs_mode and add documentation
  - check all functions in group are correct before setting the values

v1 here: http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02828.html

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  sdcard: Update the SDState documentation
  sdcard: Correct CRC16 offset in sd_function_switch()
  sdcard: Implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
  sdcard: Add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit

 hw/sd/sd.c         | 210 +++++++++++++++++++++++++++++++++++++++------
 hw/sd/trace-events |   1 +
 2 files changed, 183 insertions(+), 28 deletions(-)

-- 
2.17.0
