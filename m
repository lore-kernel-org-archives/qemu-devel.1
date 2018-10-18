Received: from eggs.gnu.org ([2001:4830:134:3::10]:39084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7yt-0006lR-0N
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gD7ys-00032Y-9i
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gD7ys-0002yK-3J
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:04:50 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu, 18 Oct 2018 15:04:31 +0200
Message-Id: <20181018130434.23237-2-philmd@redhat.com>
In-Reply-To: <20181018130434.23237-1-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] hw/misc/pvpanic: Build the pvpanic
 device in $(common-obj)
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

The 'pvpanic' ISA device can be use by any machine with an ISA bus.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6d50b03cfd..74e7300f30 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
=20
 common-obj-y +=3D unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
+common-obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
=20
 # ARM devices
 common-obj-$(CONFIG_PL310) +=3D arm_l2x0.o
@@ -70,7 +71,6 @@ obj-$(CONFIG_IOTKIT_SECCTL) +=3D iotkit-secctl.o
 obj-$(CONFIG_IOTKIT_SYSCTL) +=3D iotkit-sysctl.o
 obj-$(CONFIG_IOTKIT_SYSINFO) +=3D iotkit-sysinfo.o
=20
-obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
 obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
 obj-$(CONFIG_AUX) +=3D auxbus.o
 obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
--=20
2.17.2
