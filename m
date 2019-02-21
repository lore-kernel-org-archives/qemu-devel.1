Received: from eggs.gnu.org ([209.51.188.92]:53901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwteA-0006ta-5O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwte8-00037A-6G
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:04:37 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:39858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwte6-00032i-Ab
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:04:36 -0500
Received: by mail-pg1-x536.google.com with SMTP id r11so14180636pgp.6
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:04:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 11:04:25 -0800
Message-Id: <20190221190426.22810-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190221

for you to fetch changes up to 368bec88d1916f65050be305f88c10a46075a51c:

  hw/hppa/dino: mask out lower 2 bits of PCI config addr (2019-02-21 10:16:19 -0800)

----------------------------------------------------------------
Fix dino pci config access.

----------------------------------------------------------------
Sven Schnelle (1):
      hw/hppa/dino: mask out lower 2 bits of PCI config addr

 hw/hppa/dino.c            |  27 ++++++++++++++++++++++++---
 pc-bios/hppa-firmware.img | Bin 215936 -> 760040 bytes
 2 files changed, 24 insertions(+), 3 deletions(-)
