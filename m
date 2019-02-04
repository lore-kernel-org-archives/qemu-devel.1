Received: from eggs.gnu.org ([209.51.188.92]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqh2E-0007S6-3E
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqgsH-0004oM-6p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:13:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gqgs9-0004fM-Rm
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:13:27 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Mon,  4 Feb 2019 17:03:25 +0100
Message-Id: <20190204160325.4914-6-lersek@redhat.com>
In-Reply-To: <20190204160325.4914-1-lersek@redhat.com>
References: <20190204160325.4914-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/5] tests/data: introduce
 "uefi-boot-images" with the "bios-tables-test" ISOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Add UEFI-bootable qcow2-compressed ISO images built from:

  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v3:
    - refresh the images (should only differ in internal timestamps etc)
   =20
    v2:
    - refresh the images (should only differ in internal timestamps etc)
   =20
    v1:
    - Again, if needed, I'd be happy to be designated as Maintainer for t=
he
      files being added in this patch; please let me know the right spot =
in
      "MAINTAINERS".

 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2 | Bin 0 -=
> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2     | Bin 0 -=
> 11776 bytes
 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2    | Bin 0 -=
> 12800 bytes
 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2  | Bin 0 -=
> 13312 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qco=
w2 b/tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..ac0b7b1b8f8977977afcb1d43=
f6870d863fd3777
GIT binary patch
literal 11776
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
c
zok-aZ!PJHBX%20g^57?CCdN8ZX3vV60z`|y=3DDej1v4!$^z~M(fquAe~ruVW7$FD`0
zbP5rDD@^z5sZGadtu5CFMz)R&7-&t7VeX`O!~%nBDQ8ri8PWB1V90e;%7-(Khn7Y?
ztujT`1=3Dcq=3D+yhoa9tJV%!)Bmd8#|xGg-Uhat@IWn6UV9IHaN}MQnx|FOhYS*HhFU-
zIW{FWW_d-`5zwcJXFrHZt+^W3ix^kmF*R7M7jnH^PoY~kFJ`=3D?T`x+bFMh`*u(3ga
zx3*zP0Mu-zO{L|E3C>3ZaF1l)G)Y~2T4Lo4N8Ub1^g}f^ck}gi(RGT$k?M5Ld@a-F
zmooU`yInSadfR+{TdOrPkT?)Ik{{?C1%$g1BqpI8*s)sOcr1Bn=3D{E>>2np$S(g^U<
z@QUcyw+V~aQ@7I!3DWR((u#{Mwu94~=3D&r5=3DyRVgsG6b2f^TkK8@*qe$gWZ!%6Cw-q
z)6*J@qnv%yor7?i65<|BpVck>oxzWHHrR54iLz1oU=3D&q2=3Doli%j4>Z?Xx{6{#}QY-
zlODzGCX`mi``<^$XPQ?9jK7WpkQtkFVwPJRl<_H<C=3D3-gCo&VUAUqvDFFG5!2oRSW
em4#Fok%5pOlM9-4MUd`KaRmF1zgGXh!2bol4?f!f

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2 b=
/tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..d20fa7c819257943577c9b08f=
a52109f0195343f
GIT binary patch
literal 11776
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
Y**D2boP32rga7T<&wqKl`p-}Q4R4P{o&W#<

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2 =
b/tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..26c882baeababeda291d5aa0c=
b8b254d3e3af261
GIT binary patch
literal 12800
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
e
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

literal 0
HcmV?d00001

diff --git a/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow=
2 b/tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..9ec3c1f20bb2d9d0573a58719=
b47c2d3389425e0
GIT binary patch
literal 13312
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
P
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

literal 0
HcmV?d00001

--=20
2.19.1.3.g30247aa5d201
