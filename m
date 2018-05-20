Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKj-0005zK-39
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKh-0004ka-IR
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:45 -0400
Received: from sauhun.de ([88.99.104.3]:54046 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1fKIKh-0004jP-CX
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:00:43 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Sun, 20 May 2018 09:00:34 +0200
Message-Id: <20180520070037.8593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 RESEND 0/3] nvram: at24c: fix problems
 related to "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

I used this driver as a template for a custom one. While hacking on my ow=
n, I
noticed some problems in this driver, too. This series fixes the first se=
t of
them, related to the "rom-size" parameter. It fixes a segfault.

I think the first patch is clearly suitable for stable. I think the secon=
d one,
too, but not as clearly. The third one is a cleanup and not for stable. S=
till,
I am open for opinions about these thoughts.

Thanks,

   Wolfram

This is the same v3 as last time. Rebased to current master, but that pro=
duced
no diff.

Changes since v2:

* removed '\n' from error_report-strings
* made sure checkpatch is happy
* added tags from Philippe (thanks!)

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

--=20
2.11.0
