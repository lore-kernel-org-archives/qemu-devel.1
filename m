Received: from eggs.gnu.org ([2001:4830:134:3::10]:45188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHsn-0001tv-RZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fpHsn-0003zK-1H
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 14:48:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 13 Aug 2018 19:46:20 +0100
Message-Id: <20180813184624.12071-3-stefanha@redhat.com>
In-Reply-To: <20180813184624.12071-1-stefanha@redhat.com>
References: <20180813184624.12071-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/6] target/arm: add "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ilg@livius.net, jusual@mail.ru, joel@jms.id.au, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, mail@steffen-goertz.de, qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, Su Hang <suhang16@mails.ucas.ac.cn>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Steffen Gortz <qemu.ml@steffen-goertz.de>, Stefan Hajnoczi <stefanha@redhat.com>

Define a "cortex-m0" ARMv6-M CPU model.

Most of the register reset values set by other CPU models are not
relevant for the cut-down ARMv6-M architecture.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/arm/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3848ef46aa..7e477c0d23 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1255,6 +1255,15 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->reset_auxcr =3D 1;
 }
=20
+static void cortex_m0_initfn(Object *obj)
+{
+    ARMCPU *cpu =3D ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+
+    cpu->midr =3D 0x410cc200;
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu =3D ARM_CPU(obj);
@@ -1845,6 +1854,8 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "arm1136",     .initfn =3D arm1136_initfn },
     { .name =3D "arm1176",     .initfn =3D arm1176_initfn },
     { .name =3D "arm11mpcore", .initfn =3D arm11mpcore_initfn },
+    { .name =3D "cortex-m0",   .initfn =3D cortex_m0_initfn,
+                             .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m3",   .initfn =3D cortex_m3_initfn,
                              .class_init =3D arm_v7m_class_init },
     { .name =3D "cortex-m4",   .initfn =3D cortex_m4_initfn,
--=20
2.17.1
