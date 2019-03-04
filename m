Received: from eggs.gnu.org ([209.51.188.92]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0uuK-00036K-8G
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0uq3-0002i8-Rc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:33 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41348 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h0uq2-0002f2-S0
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:31 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  4 Mar 2019 22:08:58 +0100
Message-Id: <1551733750-4902-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 02/14] disas: nanoMIPS: Add graphical
 description of pool organization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add graphical description of nanoMIPS instruction pool organization.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 102 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 102 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 10f6d96..9b44208 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -16592,6 +16592,108 @@ std::string NMD::YIELD(uint64 instruction)
=20
=20
=20
+/*
+ *                nanoMIPS instruction pool organization
+ *                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *
+ *                 =E2=94=8C=E2=94=80 P.ADDIU =E2=94=80=E2=94=80=E2=94=80=
 P.RI =E2=94=80=E2=94=80=E2=94=80 P.SYSCALL
+ *                 =E2=94=82
+ *                 =E2=94=82                                      =E2=94=
=8C=E2=94=80 P.TRAP
+ *                 =E2=94=82                                      =E2=94=
=82
+ *                 =E2=94=82                      =E2=94=8C=E2=94=80 _PO=
OL32A0_0 =E2=94=80=E2=94=BC=E2=94=80 P.CMOVE
+ *                 =E2=94=82                      =E2=94=82             =
  =E2=94=82
+ *                 =E2=94=82                      =E2=94=82             =
  =E2=94=94=E2=94=80 P.SLTU
+ *                 =E2=94=82        =E2=94=8C=E2=94=80 _POOL32A0 =E2=94=80=
=E2=94=A4
+ *                 =E2=94=82        =E2=94=82             =E2=94=82
+ *                 =E2=94=82        =E2=94=82             =E2=94=82
+ *                 =E2=94=82        =E2=94=82             =E2=94=94=E2=94=
=80 _POOL32A0_1 =E2=94=80=E2=94=80=E2=94=80 CRC32
+ *                 =E2=94=82        =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P32A =E2=94=80=E2=94=A4
+ *                 =E2=94=82        =E2=94=82                           =
=E2=94=8C=E2=94=80 PP.LSX
+ *                 =E2=94=82        =E2=94=82             =E2=94=8C=E2=94=
=80 P.LSX =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
+ *                 =E2=94=82        =E2=94=82             =E2=94=82     =
        =E2=94=94=E2=94=80 PP.LSXS
+ *                 =E2=94=82        =E2=94=94=E2=94=80 _POOL32A7 =E2=94=80=
=E2=94=A4
+ *                 =E2=94=82                      =E2=94=82             =
=E2=94=8C=E2=94=80 POOL32Axf_4
+ *                 =E2=94=82                      =E2=94=94=E2=94=80 POO=
L32Axf =E2=94=80=E2=94=A4
+ *                 =E2=94=82                                    =E2=94=94=
=E2=94=80 POOL32Axf_5
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 PBAL
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P.GP.W   =E2=94=8C=E2=94=80 PP.LSX
+ *         =E2=94=8C=E2=94=80 P32 =E2=94=80=E2=94=A4           =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.GP.BH =E2=94=80=E2=94=B4=
=E2=94=80 PP.LSXS
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.J =E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 PP.BALRSC
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P48I
+ *         =E2=94=82       =E2=94=82           =E2=94=8C=E2=94=80 P.SR
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=9C=E2=94=80 P.SHIF=
T
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.U12 =E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80 P.ROTX
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=9C=E2=94=80 P.INS
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=94=E2=94=80 P.EXT
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.LS.U12 =E2=94=80=E2=94=80=
 P.PREF.U12
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.BR1 =E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80 P.BR3A
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=8C=E2=94=80 P.LS.S=
0 =E2=94=80=E2=94=80=E2=94=80 P16.SYSCALL
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=82           =E2=94=
=8C=E2=94=80 P.LL
+ *         =E2=94=82       =E2=94=82           =E2=94=9C=E2=94=80 P.LS.S=
1 =E2=94=80=E2=94=A4
+ *         =E2=94=82       =E2=94=82           =E2=94=82           =E2=94=
=94=E2=94=80 P.SC
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=82           =E2=94=
=8C=E2=94=80 P.PREFE
+ *  MAJOR =E2=94=80=E2=94=A4       =E2=94=9C=E2=94=80 P.LS.S9 =E2=94=80=E2=
=94=A4           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=9C=E2=94=80 P.LS.E=
0 =E2=94=80=E2=94=BC=E2=94=80 P.LLE
+ *         =E2=94=82       =E2=94=82           =E2=94=82           =E2=94=
=82
+ *         =E2=94=82       =E2=94=82           =E2=94=82           =E2=94=
=94=E2=94=80 P.SCE
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=9C=E2=94=80 P.LS.W=
M
+ *         =E2=94=82       =E2=94=82           =E2=94=82
+ *         =E2=94=82       =E2=94=82           =E2=94=94=E2=94=80 P.LS.U=
AWM
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.BR2
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P.BRI
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=94=E2=94=80 P.LUI
+ *         =E2=94=82
+ *         =E2=94=82
+ *         =E2=94=82       =E2=94=8C=E2=94=80 P16.MV =E2=94=80=E2=94=80=E2=
=94=80=E2=94=80 P16.RI =E2=94=80=E2=94=80=E2=94=80 P16.SYSCALL
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P16.SR
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P16.SHIFT
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P16.4x4
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=82       =E2=94=9C=E2=94=80 P16C =E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80 POOL16C_0 =E2=94=80=E2=94=80 POOL16C_00
+ *         =E2=94=82       =E2=94=82
+ *         =E2=94=94=E2=94=80 P16 =E2=94=80=E2=94=BC=E2=94=80 P16.LB
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P16.A1
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P16.LH
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P16.A2 =E2=94=80=E2=94=80=E2=94=80=
=E2=94=80 P.ADDIU[RS5]
+ *                 =E2=94=82
+ *                 =E2=94=9C=E2=94=80 P16.ADDU
+ *                 =E2=94=82
+ *                 =E2=94=94=E2=94=80 P16.BR =E2=94=80=E2=94=80=E2=94=AC=
=E2=94=80 P16.JRC
+ *                             =E2=94=82
+ *                             =E2=94=94=E2=94=80 P16.BR1
+ *
+ *
+ *  (FP, DPS, and some minor instruction pools are omitted from the diag=
ram)
+ *
+ */
+
 NMD::Pool NMD::P_SYSCALL[2] =3D {
     { instruction         , 0                   , 0   , 32,
        0xfffc0000, 0x00080000, &NMD::SYSCALL_32_      , 0,
--=20
2.7.4
