Received: from eggs.gnu.org ([209.51.188.92]:38341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1PP-0008N9-I0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1PO-0007nI-I5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:11:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hB1PO-0007mu-6b
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:11:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so13240215wre.7
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 11:11:46 -0700 (PDT)
Date: Mon, 1 Apr 2019 19:11:50 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190401181150.GA31786@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Subject: [Qemu-devel]  [PATCH v3 1/3] Categorize devices: DIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Set category and describe DIMM devices

Signed-off-by: Ernest Esene <eroken1@gmail.com>

---
v3:
  * add MEMORY device category
  * set category to MEMORY
v2:
  * split into separate patches
---
 hw/mem/nvdimm.c        | 1 +
 hw/mem/pc-dimm.c       | 1 +
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index bf2adf5e16..a334dbe1f5 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -200,6 +200,7 @@ static void nvdimm_class_init(ObjectClass *oc, void *da=
ta)
     ddc->realize =3D nvdimm_realize;
     mdc->get_memory_region =3D nvdimm_md_get_memory_region;
     dc->props =3D nvdimm_properties;
+    dc->desc =3D "NVDIMM memory module";
=20
     nvc->read_label_data =3D nvdimm_read_label_data;
     nvc->write_label_data =3D nvdimm_write_label_data;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..3ace8077b5 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -259,6 +259,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *d=
ata)
     dc->unrealize =3D pc_dimm_unrealize;
     dc->props =3D pc_dimm_properties;
     dc->desc =3D "DIMM memory module";
+    set_bit(DEVICE_CATEGORY_MEMORY, dc->categories);
=20
     ddc->get_vmstate_memory_region =3D pc_dimm_get_memory_region;
=20
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8dde..a7d9ea1fbe 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -26,6 +26,7 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_SOUND,
     DEVICE_CATEGORY_MISC,
     DEVICE_CATEGORY_CPU,
+    DEVICE_CATEGORY_MEMORY,
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
=20
diff --git a/qdev-monitor.c b/qdev-monitor.c
index d4320986a2..5318df205b 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -143,6 +143,7 @@ static void qdev_print_devinfos(bool show_no_user)
         [DEVICE_CATEGORY_SOUND]   =3D "Sound",
         [DEVICE_CATEGORY_MISC]    =3D "Misc",
         [DEVICE_CATEGORY_CPU]     =3D "CPU",
+        [DEVICE_CATEGORY_MEMORY]  =3D "Memory",
         [DEVICE_CATEGORY_MAX]     =3D "Uncategorized",
     };
     GSList *list, *elt;
--=20
2.14.2


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlyiVGEACgkQJZ4JoaCv
xKoM5Q//TBfMuPLblb8zOWXcoZponvmlzGpWkX8h29kNE451NhaDaaZLSsZk+RVi
YCKQ2VdbKjd9+MP2ibz78/31dBHO3ffcPpJ97RcgMW49aW5h+KqSY5f4xWprOiQm
V+IUUqjmNWb6a7BA4Sg9+DiwASj/eTfXq0a2z+B4fzILPAKsz4HVJevXcBKkbHrn
Q00RA4L+E4aqh+lb+wwEJ0stBwgKG/u1QCN38WMHlHc5gTOrFCPb64/uZLwPT0YB
L3fY6jiaAKiD28J16p6P0BcQTP97N90FFRWAchpAzIm33aG7Qd5zIhhbi69iwNDJ
HqRAQRGAx10HsiwWOEKFI4DPhzbXe3gEaaVzNEPHrHckGOgRsheowu3r+YmKUfZf
WCG0NQFYDi8upSVDmMCyp4fytQ+fAgFXlgmIrBTq0O0glsSrZca5IkhYizTPrMdj
2Jp0/POV755EA6ISaE1RcHfPBUxx7sA/NpktyDw2CdBUXRgylNZftOS4+kRqIjKJ
YzK1dVuLQL6Xec/xn41UwmMNaG/Q1CLVRWBW8Izgs4K71qUD8QkcUfkyTJK7f/LS
CmTy1Ho3G3lECbe5pEPOIqTf3um5lcnmsKRt9c6epwszMRdnRrPeh2Uo+izo8ylr
IZimZcEvDIVGmpc6/oI831aKvHXNQ2EndZLSYLPKTCibZZrxXqo=
=Hikk
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
