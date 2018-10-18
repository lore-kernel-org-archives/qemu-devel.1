Received: from eggs.gnu.org ([2001:4830:134:3::10]:39090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yt-0006lm-En
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yn-0002oC-TM
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD7yn-0002kf-MB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:45 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 18 Oct 2018 15:04:30 +0200
Message-Id: <20181018130434.23237-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] hw/misc: Add a MMIO interface to the
 pvpanic device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

Hi, this series takes Peng Hao's previous work but rather than adding yet
another device, simply add the MMIO interface to the current device (whic=
h
only implements the I/O port access).=20

The first patches are simple cleanups:
- patch 1 move the pvpanic device with the 'ocmmon objects' so we compile
  it once for the x86/arm/aarch64 archs,
- patch 2 simply renames ISA fields/definitions to generic ones.

Then instead of add/use the MMIO pvpanic device in the virt machine in an
unique patch, I split it in two distinct patches:
- patch 3 uses Peng Hao's work, but add the MMIO interface to the existin=
g
  device (no logical change).
- patch 4 is Peng Hao's work in the virt machine (no logical change).

v2 from Peng Hao is:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03433.html

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (4):
  hw/misc/pvpanic: Build the pvpanic device in $(common-obj)
  hw/misc/pvpanic: Cosmetic renaming
  hw/misc/pvpanic: Add the MMIO interface
  hw/arm/virt: Use the pvpanic device

 default-configs/arm-softmmu.mak |  2 +-
 hw/arm/virt.c                   | 21 ++++++++++
 hw/misc/Makefile.objs           |  2 +-
 hw/misc/pvpanic.c               | 68 +++++++++++++++++++++++++++++----
 include/hw/arm/virt.h           |  1 +
 5 files changed, 84 insertions(+), 10 deletions(-)

--=20
2.17.2
