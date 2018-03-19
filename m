Received: from eggs.gnu.org ([2001:4830:134:3::10]:36512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2NA-0003VJ-2O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2N5-0005KK-Nq
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:16 -0400
Received: from sauhun.de ([88.99.104.3]:57185 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1ey2N5-0005Hj-HH
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:31:11 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 19 Mar 2018 22:30:58 +0100
Message-Id: <20180319213101.6100-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [PATCH v2 0/3] nvram: at24c: fix problems related to
 "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

I used this driver as a template for a custom one. While hacking on my own, I
noticed some problems in this driver, too. This series fixes the first set of
them, related to the "rom-size" parameter. It fixes a segfault.

I think the first patch is clearly suitable for stable. I think the second one,
too, but not as clearly. The third one is a cleanup and not for stable. Still,
I am open for opinions about these thoughts.

Thanks,

   Wolfram

Changes since v1:

* reordered patches according to significance for stable
* use AT24C_ROMSIZE_DEFAULT instead of magic value
* patch 3 doesn't improve the ERR macro anymore but replaces
  it completely with error_report().


Wolfram Sang (3):
  nvram: at24c: prevent segfault by checking "rom-size"
  nvram: at24c: use a sane default for "rom-size"
  nvram: at24c: use standard error reporting

 hw/nvram/eeprom_at24c.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.11.0
