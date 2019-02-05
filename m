Received: from eggs.gnu.org ([209.51.188.92]:56584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gr18g-0004lb-6c
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gr18f-0003Lo-86
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:51:50 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Tue, 5 Feb 2019 13:51:40 +0000
Message-ID: <20190205135129.19338-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] target/arm: Fix CRn to be 14 for
 PMEVTYPER/PMEVCNTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aaron Lindsay OS <aaron@os.amperecomputing.com>

This bug was introduced in:
    commit 5ecdd3e47cadae83a62dc92b472f1fe163b56f59
    target/arm: Finish implementation of PM[X]EVCNTR and PM[X]EVTYPER

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d070879894..ec2d17093c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5855,25 +5855,25 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             char *pmevtyper_name =3D g_strdup_printf("PMEVTYPER%d", i);
             char *pmevtyper_el0_name =3D g_strdup_printf("PMEVTYPER%d_EL0"=
, i);
             ARMCPRegInfo pmev_regs[] =3D {
-                { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 15,
+                { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 14,
                   .crm =3D 8 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i & =
7,
                   .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
                   .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_write=
fn,
                   .accessfn =3D pmreg_access },
                 { .name =3D pmevcntr_el0_name, .state =3D ARM_CP_STATE_AA6=
4,
-                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 8 | (3 &=
 (i >> 3)),
+                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 8 | (3 &=
 (i >> 3)),
                   .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg=
_access,
                   .type =3D ARM_CP_IO,
                   .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_write=
fn,
                   .raw_readfn =3D pmevcntr_rawread,
                   .raw_writefn =3D pmevcntr_rawwrite },
-                { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 15,
+                { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 14,
                   .crm =3D 12 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i &=
 7,
                   .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
                   .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_wri=
tefn,
                   .accessfn =3D pmreg_access },
                 { .name =3D pmevtyper_el0_name, .state =3D ARM_CP_STATE_AA=
64,
-                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 12 | (3 =
& (i >> 3)),
+                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 12 | (3 =
& (i >> 3)),
                   .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg=
_access,
                   .type =3D ARM_CP_IO,
                   .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_wri=
tefn,
--=20
2.20.1
