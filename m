Received: from eggs.gnu.org ([2001:4830:134:3::10]:54344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZS-0006OQ-LI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZR-0008TB-Cx
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZR-0008Sg-7f
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:21 -0500
Date: Thu, 8 Feb 2018 21:09:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-26-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/26] acpi-test: update FADT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Previous commit ("tests: acpi: fix FADT not being compared to reference table")
started tracking changes to the FADT. Generate the expected FACP files -
apparently these weren't updated since 2013.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-test-data/pc/FACP  | Bin 116 -> 116 bytes
 tests/acpi-test-data/q35/FACP | Bin 116 -> 244 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/acpi-test-data/pc/FACP b/tests/acpi-test-data/pc/FACP
index 0639999ed1f748d44977f88e63d6a0ab49add040..261ebdc5d1c3bdf18fb7935314a04fd7f6f92a7a 100644
GIT binary patch
delta 70
zcmXRZ;c|0y4k%$@U|?K0kxN<=$N&LG22O@eK>FhcAi)L_VPIf^(jYbm+eAM(4kI9I
IX#)cT0Ciyr82|tP

delta 70
zcmXRZ;c|0y4k%$@U|_sCkxN?h!T)*(AZBFXWY`20{P+P#Yye^)V1d#gHphmEesUZj
J*3t$B1^}tB5E%df

diff --git a/tests/acpi-test-data/q35/FACP b/tests/acpi-test-data/q35/FACP
index 19f3ac3ce6ab732caa750d835ce1261bc7343cf2..72c9d97902a4bbf14896023d9ba78e0899d6517b 100644
GIT binary patch
literal 244
zcmZ>BbPo8!z`(#P@8s|75v<@85#a0w6k`O6f!H7#1{fJQ88!hqOw2%n4I;_{r9nIn
zAX@<@&cwhX02KSr|DPYCl7Ybp$XMFKz`)4C!0?j?A_|v;DFV`r3P1wMTp$k&7=Z>N
X+XoXzrWq9=?f{7~HXz&s;==#{<X{c~

literal 116
zcmZ>BbPgzCU|?YEaPoKd2v%^42yk`-iZKGkKx`1raN&Qw0}wMZa58KHa+#Qc#0HQA
i0|N_`2C+GSYz3G&69bC?Q0zbde}0f03@mM6U;qFojS~R?

-- 
MST
