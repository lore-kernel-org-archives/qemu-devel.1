Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbU-0007rN-Rd
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDUbU-0005l1-8R
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:14:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 19 Oct 2018 15:14:00 +0200
Message-Id: <1539954845-26716-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Add more CONFIG switches to make the build
 more modular
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We've got many devices that can not be created directly by the user
and which are only used on some few target architectures. When the
user does not compile the corresponding qemu-softmmu-xxx target, we
should also not compile these devices. Add some CONFIG switches to
make our build system a little bit more flexible here.

Thomas Huth (5):
  configs: Add a CONFIG_OR_IRQ switch for the or-irq device
  configs: Add a CONFIG_SPLIT_IRQ switch for the split-irq device
  configs: Add a CONFIG_REGISTER switch for the "register" device
  configs: Add a CONFIG_UNIMP switch for the "unimplemented-device"
  configs: Add a CONFIG_SMC37C669 switch for the "smc37c669-superio"
    device

 default-configs/alpha-softmmu.mak      | 1 +
 default-configs/arm-softmmu.mak        | 4 ++++
 default-configs/microblaze-softmmu.mak | 1 +
 default-configs/ppc-softmmu.mak        | 1 +
 hw/core/Makefile.objs                  | 6 +++---
 hw/isa/Makefile.objs                   | 3 ++-
 hw/misc/Makefile.objs                  | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.8.3.1
