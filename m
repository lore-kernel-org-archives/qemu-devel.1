Received: from eggs.gnu.org ([2001:4830:134:3::10]:54663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcoq-0006JK-Uk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcon-00049H-Qn
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:12 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqcon-00048w-Il
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:09 -0500
Received: by mail-lf0-x243.google.com with SMTP id 37so26791613lfs.7
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:49:09 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 11:48:58 +0100
Message-Id: <20180227104903.21353-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] Versatile Express SiI9022 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, Linus Walleij <linus.walleij@linaro.org>

This series adds proper display bridge/connector emulation
for the Versatile Express, implementing a simple Silicon
Image 9022 emulation spawning a DDC I2C child.

After the series the Versatile Express is successfully
presented the "QEMU monitor" through DDC I2C.

The series includes two refactorings from Corey and a
minor bug fix for the i2c-ddc so that everything is smoothly
integrated.

Corey Minyard (2):
  i2c: Fix some brace style issues
  i2c: Move the bus class to i2c.h

Linus Walleij (3):
  hw/i2c-ddc: Do not fail writes
  hw/sii9022: Add support for Silicon Image SII9022
  arm/vexpress: Add proper display connector emulation

 default-configs/arm-softmmu.mak |   2 +
 hw/arm/vexpress.c               |   6 +-
 hw/display/Makefile.objs        |   1 +
 hw/display/sii9022.c            | 188 ++++++++++++++++++++++++++++++++++++++++
 hw/display/trace-events         |   5 ++
 hw/i2c/core.c                   |  18 ----
 hw/i2c/i2c-ddc.c                |   4 +-
 include/hw/i2c/i2c.h            |  23 ++++-
 8 files changed, 222 insertions(+), 25 deletions(-)
 create mode 100644 hw/display/sii9022.c

-- 
2.14.3
