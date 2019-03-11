Received: from eggs.gnu.org ([209.51.188.92]:60076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL3-0005Lh-MA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QL2-0003Tz-RK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:11:53 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 11 Mar 2019 20:11:23 +0100
Message-Id: <20190311191128.30562-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/5] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Laszlo Ersek <lersek@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 208d92df447bde0f1f810fae8a2c523cdeb7a28f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190311' into staging (2019-03-11 16:27:14 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 3b777a79c1cfa40f39f96220bc733eccd7392c9c:

  hw/nvram/fw_cfg: Use the ldst API (2019-03-11 18:48:20 +0100)

----------------------------------------------------------------
fw_cfg and thunk code clean up

----------------------------------------------------------------

Aarushi Mehta (1):
  thunk: improve readability of allocation loop

Philippe Mathieu-Daudé (4):
  hw/nvram/fw_cfg: Remove the unnecessary boot_splash_filedata_size
  hw/i386: Remove unused include
  hw/arm/virt: Remove null-check in virt_build_smbios()
  hw/nvram/fw_cfg: Use the ldst API

 hw/acpi/piix4.c         | 1 -
 hw/arm/virt.c           | 4 ----
 hw/nvram/fw_cfg.c       | 9 ++++-----
 include/sysemu/sysemu.h | 1 -
 thunk.c                 | 2 +-
 vl.c                    | 1 -
 6 files changed, 5 insertions(+), 13 deletions(-)

-- 
2.20.1
