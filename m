Received: from eggs.gnu.org ([209.51.188.92]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIPql-0007YS-Kx
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgfbeta@me.com>) id 1hIPqk-0003kT-Of
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:35 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:54072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hIPqk-0003kA-Io
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:42:34 -0400
From: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <087F1D9C-109D-41D1-BE2C-CE5D840C981B@me.com>
Date: Mon, 22 Apr 2019 11:42:25 +0800
Subject: [Qemu-devel] [PATCH] hvf: Add missing break statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

In target/i386/hvf/hvf.c, a break statement was probably missing in =
`hvf_vcpu_exec()`, in handling EXIT_REASON_HLT.

These lines seemed to be equivalent to `kvm_handle_halt()`.

Signed-off-by: Chen Zhang <tgfbeta@me.com>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 42f9447303..2751c8125c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -708,6 +708,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu->halted =3D 1;
                 ret =3D EXCP_HLT;
+                break;
             }
             ret =3D EXCP_INTERRUPT;
             break;
--=20
2.21.0
