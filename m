Received: from eggs.gnu.org ([208.118.235.92]:46616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcCmT-0006dV-Oz
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcCmQ-0004m4-C0
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39438 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcCmQ-0004ks-0v
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:15:38 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 18:15:11 +0100
Message-Id: <1545844514-1854-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545844514-1854-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545844514-1854-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] MAINTAINERS: target/mips: Add MIPS
 files under default-configs directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, pburton@wavecomp.com, hpoussin@reactos.org, jhogan@kernel.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add following files as maintained within the main MIPS target
section in MAINTAINERS:

default-configs/mips64el-linux-user.mak
default-configs/mips64-linux-user.mak
default-configs/mipsn32el-linux-user.mak
default-configs/mipsn32-linux-user.mak
default-configs/mipsel-linux-user.mak
default-configs/mips-linux-user.mak
default-configs/mips64el-softmmu.mak
default-configs/mips64-softmmu.mak
default-configs/mipsel-softmmu.mak
default-configs/mips-softmmu.mak
default-configs/mips-softmmu-common.mak

Future nanoMIPS user mode will also have its .mak file, and
because of that "*mips*" was used instead of "mips*" as a
shorthand in the new item in MAINTAINERS.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 180695f..374e4c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -208,6 +208,7 @@ M: Aleksandar Markovic <amarkovic@wavecomp.com>
 R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Maintained
 F: target/mips/
+F: default-configs/*mips*
 F: hw/mips/
 F: hw/misc/mips_*
 F: hw/intc/mips_gic.c
--=20
2.7.4
