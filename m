Received: from eggs.gnu.org ([2001:4830:134:3::10]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXf-0000e0-NT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXa-0006Wm-PF
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:19 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnGXa-0006WO-Ki
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 23:53:14 -0400
Received: by mail-qk0-x244.google.com with SMTP id a21so24032qkg.4
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:53:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 31 Aug 2017 00:52:59 -0300
Message-Id: <20170831035306.29170-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] serial: add serial_chr_nonnull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

Hi,

This series add the serial_chr_nonnull() which connect to the "null" chardev
backend if none is provided.

Inspired by Peter's suggestion:
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05987.html
which also refers to this issue:
http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03546.html

Some boards still check serial_hds[x] non null before calling serial_mm_init(),
this check could now be removed on the SoC which always have an UART mapped.

This might be a follow up if this series is accepted.

Regards,

Phil.

Philippe Mathieu-Daudé (7):
  serial: add serial_chr_nonnull() to use the null backend when none provided
  serial: use serial_chr_nonnull() in serial_mm_init()
  hw/arm/fsl_imx*: use serial_chr_nonnull()
  hw/mips/malta: use serial_chr_nonnull()
  hw/char/exynos4210_uart: use serial_chr_nonnull()
  hw/char/omap_uart: serial_mm_init() already check for null chr
  hw/xtensa: serial_mm_init() already check for null chr

 include/hw/char/imx_serial.h |  1 +
 include/hw/char/serial.h     |  1 +
 hw/arm/fsl-imx25.c           |  9 +--------
 hw/arm/fsl-imx31.c           |  9 +--------
 hw/arm/fsl-imx6.c            | 10 +---------
 hw/char/exynos4210_uart.c    | 14 ++------------
 hw/char/omap_uart.c          |  6 ++----
 hw/char/serial.c             | 15 ++++++++++++++-
 hw/mips/mips_malta.c         |  6 +-----
 hw/xtensa/xtfpga.c           |  4 ----
 10 files changed, 24 insertions(+), 51 deletions(-)

-- 
2.14.1
