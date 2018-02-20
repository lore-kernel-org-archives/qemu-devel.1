Received: from eggs.gnu.org ([2001:4830:134:3::10]:56702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoCSW-0003S7-Po
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoCSS-00016L-O2
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:16:08 -0500
Message-Id: <cover.1519150239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 20 Feb 2018 19:10:39 +0100
Subject: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

I've created a git repo for the Sam460ex u-boot sources and this adds
that as a submodule and a separate patch to add the binary built from
these sources. Feel free to keep this as two patches, squash them into
one patch or take the git repo and commit the content under the QEMU
repo and use that as a submodule as you see fit (or let me know if any
changes are needed for these patches).

BALATON Zoltan (2):
  roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
  pc-bios: Added u-boot-sam460 firmware binary

 .gitmodules                        |   3 +++
 Makefile                           |   2 +-
 pc-bios/u-boot-sam460-20100605.bin | Bin 0 -> 524288 bytes
 3 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100755 pc-bios/u-boot-sam460-20100605.bin

-- 
2.7.6
