Received: from eggs.gnu.org ([209.51.188.92]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIYK0-0004eN-H2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIY9R-0005Jc-SC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:36203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIY9R-0005DG-JA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:25 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Date: Mon, 22 Apr 2019 13:34:11 +0100
Message-Id: <20190422123411.5178-3-nick.hudson@gmx.co.uk>
In-Reply-To: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
References: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] Always return EXCP_DMAR for protection
 id trap as EXCP_DMP is considered legacy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nick Hudson <skrll@netbsd.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

From: Nick Hudson <skrll@netbsd.org>

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must use
traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr=
 addr, int mmu_idx,

     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.=
  */
-        ret =3D (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret =3D (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }

=2D-
2.17.1
