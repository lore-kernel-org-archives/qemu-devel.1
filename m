Received: from eggs.gnu.org ([2001:4830:134:3::10]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3i-0002eD-8s
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3h-0001mw-1N
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:37 +1000
Message-Id: <20180612064503.14282-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/33] prep: fix keyboard for the 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (8042)=
"
added an 8042 keyboard device to the PC87312 superio device to replace th=
at
being used by the prep machine.

Unfortunately this commit didn't do the same for the 40p machine which br=
oke
the keyboard by registering two 8042 keyboard devices at the same address=
.

Resolve this by similarly removing the 8042 keyboard from the 40p machine=
 as
done for the prep machine in commit 72d3d8f052.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index dbbe749bde..5ed0bcd862 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -770,7 +770,6 @@ static void ibm_40p_init(MachineState *machine)
=20
     /* add some more devices */
     if (defaults_enabled()) {
-        isa_create_simple(isa_bus, TYPE_I8042);
         m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
=20
         dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));
--=20
2.17.1
