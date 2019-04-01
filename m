Received: from eggs.gnu.org ([209.51.188.92]:39212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1To-0003PL-GB
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hB1Tn-0002BE-Gq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:16:20 -0400
Date: Mon, 1 Apr 2019 19:16:21 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190401181621.GA31851@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Subject: [Qemu-devel]  [PATCH v3 3/3] Categorize devices: iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Set category and description for iommu devices.

Signed-off-by: Ernest Esene <eroken1@gmail.com>

---
v3:
  * set category and describe smmuv3 as suggested by Eric
v2:
  * split into separate patches
---
 hw/arm/smmuv3.c       | 2 ++
 hw/i386/amd_iommu.c   | 2 ++
 hw/i386/intel_iommu.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8c4e99fecc..d5a3df047d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1463,6 +1463,8 @@ static void smmuv3_class_init(ObjectClass *klass, voi=
d *data)
     device_class_set_parent_reset(dc, smmu_reset, &c->parent_reset);
     c->parent_realize =3D dc->realize;
     dc->realize =3D smmu_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc =3D "ARM IOMMU (SMMUv3) DMA Remapping device"
 }
=20
 static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6eabdf9917..4a4e2c7fd4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1601,6 +1601,8 @@ static void amdvi_class_init(ObjectClass *klass, void=
* data)
     dc_class->int_remap =3D amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable =3D true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc =3D "AMD IOMMU (AMD-Vi) DMA Remapping device";
 }
=20
 static const TypeInfo amdvi =3D {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 055a1e865d..f9781a5d20 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3727,6 +3727,8 @@ static void vtd_class_init(ObjectClass *klass, void *=
data)
     x86_class->int_remap =3D vtd_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable =3D true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc =3D "Intel IOMMU (VT-d) DMA Remapping device";
 }
=20
 static const TypeInfo vtd_info =3D {
--=20
2.14.2


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlyiVXQACgkQJZ4JoaCv
xKo5fhAAjefjbIaOLqRZ5RAF1ly2x3X/c7InbIQtQyqcRWn3CLulaZqqEmKvX2Bu
JMsQ9towcyVodOezH5PEgS08mQEgyXIPqRlK9lDRdjezgF3R3cir/KBmv4QA2mzF
cpJ4bF3fAazDEMX85bFfJ7Ro5d883/WpHlQj7p4sjfWlH1MOJndg7/kyrLK85U3z
oIxdIVtVPJYEP161uS3nbxjPK12PVWP+JorFH+mgCpzGi4xkLcrLpEFcbq3N5qd8
qUdAavZn5wGnIG+27ZxZ4ngQK3I++htJYU/usmzppokgG30fH0KIXi2p18PLwVsG
erE1o4SkYV0rqUcB3DlAI4Y12hTB1TV4/JOrgywOohPDUEyG4zbk/H17FFUXHMtW
ddYQJBDvm49qQclEmtQKVnLIOAcssictafLgBuqdqwcQ+B2fX0eJBdXT3qJ9eBRx
j06r4i4fK3mtNNAUBSSE1qGfuz06h39AnQsuJEjgmYgW/cERiLOQ4Eeq3m2xkP69
czx3luEvFBjK8Qb5sW2TxsLAPhAdm/yk3UTKC35kGa5ISs5SNXf4e6OIScnQagON
BYWHqFGc4NBrhl0YdcqtriVHikdM9nJh2s9ZQH9jtKmhRS4vsBZD/qTwxu9r7McQ
Tyx+Y7/Y63Wyh274Fb32MEXvUe6I7CrIoz9kmOc9G2vfvcwYrpk=
=Rbt8
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
