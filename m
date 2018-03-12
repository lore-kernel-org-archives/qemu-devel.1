Received: from eggs.gnu.org ([2001:4830:134:3::10]:44530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDQ-0002bc-NS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004Yz-PM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:44 -0400
Received: from sauhun.de ([88.99.104.3]:53432 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evVDM-0004YG-IC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:42:40 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 12 Mar 2018 22:42:27 +0100
Message-Id: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [PATCH 0/3] nvram: at24c: fix problems related to
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
Cc: Michael Davidsaver <mdavidsaver@gmail.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

I used this driver as a template for a custom one. While hacking on my own, I
noticed some problems in this driver, too. This series fixes the first set of
them, mostly related to "rom-size". It fixes a segfault.

Wolfram Sang (3):
  nvram: at24c: remove doubled prefix for ERR
  nvram: at24c: prevent segfault by checking "rom-size"
  nvram: at24c: use a sane default for "rom-size"

 hw/nvram/eeprom_at24c.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.11.0
