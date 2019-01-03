Received: from eggs.gnu.org ([208.118.235.92]:38586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UM-0004pW-U4
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UK-00081c-NM
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:58 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46268 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UK-0007jW-DW
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:11 +0100
Message-Id: <1546535297-11040-39-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 38/44] disas: nanoMIPS: Comment the decoder
 of 'gpr1' gpr encoding type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Comment the decoder of 'gpr1' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 6f15821..23556b4 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -389,6 +389,27 @@ uint64 NMD::decode_gpr_gpr3_src_store(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr1() - decoder for 'gpr1' gpr encoding type
+ *
+ *   Map a 1-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                                  1 0
+ *                                  | |
+ *                                  | |
+ *                                  | =E2=94=94---------------------=E2=94=
=90
+ *                                  =E2=94=94---------------------=E2=94=
=90 |
+ *                                                        | |
+ *                                                        | |
+ *                                                        | |
+ *                                                        | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instruction:
+ *
+ *     - MOVE.BALC
+ */
 uint64 NMD::decode_gpr_gpr1(uint64 d)
 {
     static uint64 register_list[] =3D {  4,  5 };
--=20
2.7.4
