Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxXb3-0000lQ-Jv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxXax-00080o-Br
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:07:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxXax-00080K-44
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:07:11 -0400
Date: Thu, 28 Sep 2017 14:07:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928140704.0cc18986.cohuck@redhat.com>
In-Reply-To: <dc15f576-8397-718d-0c75-0cba607c53b9@de.ibm.com>
References: <20170926162058.30772-1-cohuck@redhat.com>
	<20170926162058.30772-2-cohuck@redhat.com>
	<338c8565-691e-a8bc-d8a6-3637ce13701d@redhat.com>
	<20170927114717.72bd69f8.cohuck@redhat.com>
	<e8bef299-5501-a59d-aba3-5a338227966e@linux.vnet.ibm.com>
	<20170927125606.65dc514d.cohuck@redhat.com>
	<14df9ad6-f0e9-cd51-04dd-4fe994808433@de.ibm.com>
	<4681e677-9e5a-4c1c-8e22-dc5c51b7286d@redhat.com>
	<20170927142837.GB2108@work-vm>
	<20170927164644.42205e6f.cohuck@redhat.com>
	<20170927144927.GC2108@work-vm>
	<20170927170346.68ca0cd8.cohuck@redhat.com>
	<9c8c2596-c4cf-41ad-7228-0ed598cf65cd@de.ibm.com>
	<dc15f576-8397-718d-0c75-0cba607c53b9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: create a compat s390 phb for
 <=2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com

On Thu, 28 Sep 2017 12:41:54 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/28/2017 12:34 PM, Christian Borntraeger wrote:
> >=20
> >=20
> > On 09/27/2017 05:03 PM, Cornelia Huck wrote: =20
> >> On Wed, 27 Sep 2017 15:49:27 +0100
> >> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >> =20
> >>> * Cornelia Huck (cohuck@redhat.com) wrote: =20
> >>>> On Wed, 27 Sep 2017 15:28:38 +0100
> >>>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >>>>    =20
> >>>>> * David Hildenbrand (david@redhat.com) wrote:   =20
> >>>>>> On 27.09.2017 12:59, Christian Borntraeger wrote:     =20
> >>>>>>>
> >>>>>>>
> >>>>>>> On 09/27/2017 12:56 PM, Cornelia Huck wrote:     =20
> >>>>>>>> On Wed, 27 Sep 2017 18:25:00 +0800
> >>>>>>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
> >>>>>>>>     =20
> >>>>>>>>> =E5=9C=A8 2017/9/27 =E4=B8=8B=E5=8D=885:47, Cornelia Huck =E5=
=86=99=E9=81=93:     =20
> >>>>>>>>>> On Tue, 26 Sep 2017 20:40:25 +0200
> >>>>>>>>>> David Hildenbrand <david@redhat.com> wrote:     =20
> >>>>>>>>     =20
> >>>>>>>>>>> I'd really really really (did I mention really?) favor someth=
ing like a
> >>>>>>>>>>> dummy device, because we could easily handle the !CONFIG_PCI =
case then.
> >>>>>>>>>>>
> >>>>>>>>>>> All these compat options and conditions will kill us someday.=
.. we're
> >>>>>>>>>>> already patching around that whole stuff way too much.
> >>>>>>>>>>>
> >>>>>>>>>>> If we ever unconditionally created a device, we should keep d=
oing so.       =20
> >>>>>>>>>> Yes, that whole thing is horrible, especially interaction with=
 compat
> >>>>>>>>>> machines.
> >>>>>>>>>>
> >>>>>>>>>> Do you have an idea on how to create such a dummy device (with=
out
> >>>>>>>>>> having to effectively copy a lot of configured-out code)?
> >>>>>>>>>>
> >>>>>>>>>>       =20
> >>>>>>>>> How about in s390_pcihost_hot_plug() we check s390_has_feat(zpc=
i)?
> >>>>>>>>> If no zpci feature, we avoid plugging any pci device.
> >>>>>>>>> Then we could always create phb.
> >>>>>>>>> I think pcibus's vmstate is only data to migrate.     =20
> >>>>>>>>
> >>>>>>>> That's still problematic if CONFIG_PCI is off. I currently don't=
 have a
> >>>>>>>> better idea than either disallowing compat machines on builds wi=
thout
> >>>>>>>> pci, or using a dummy device...     =20
> >>>>>>>
> >>>>>>> For this particular case your initial patch might be less problem=
atic than
> >>>>>>> a dummy device, because the code that does the migration is NOT c=
ontained
> >>>>>>> in s390 specific code but in common PCI code instead. We would ne=
ed to keep
> >>>>>>> the dummy device always in a way that it will work with the commo=
n PCI
> >>>>>>> code.
> >>>>>>>      =20
> >>>>>>
> >>>>>> Interesting, so how is migration then handled for e.g. x86 or other
> >>>>>> architectures that can work without CONFIG_PCI? I assume their mig=
ration
> >>>>>> should also break?     =20
> >>>>>
> >>>>> It's tied to machine-type; the x86 i440fx and q35 machine types have
> >>>>> PCI; you can't disable PCI while still having those machine types.
> >>>>> (I don't know if you can disable PCI at all on x86)   =20
> >>>>
> >>>> Ugh, that sounds like we need two machine types on s390x as well
> >>>> (s390x-ccw-virtio and s390x-ccw-virtio-nopci or so), built
> >>>> conditionally. That whole zpci detanglement is looking worse and
> >>>> worse :(   =20
> >>>
> >>> Well fundamentally the migration expects to migrate something into
> >>> the same shaped hole on the destination;  if you've got a lump of PCI
> >>> config on the source there's got to be somewhere for it to fit on the
> >>> destination.
> >>> Now, if PCI is actually pretty rare; then you might be able to make
> >>> the host-pci bridge a normal device and not include it in any
> >>> machine type; that way those who want PCI can just instantiate
> >>> the host-pci bridge, and those who don't want it just stick with
> >>> the base machine type. =20
> >>
> >> I fear that ship has already sailed; the s390-ccw-virtio machine type
> >> has been instantiating a phb for quite some time, which means we have
> >> to drag this on in the compat machines... =20
> >=20
> > In the end that means that you should revert
> >=20
> > commit d32bd032d8fde41281aae34c16a4aa97e9acfeac
> > Author:     Cornelia Huck <cohuck@redhat.com>
> > AuthorDate: Thu Jul 6 17:21:52 2017 +0200
> > Commit:     Cornelia Huck <cohuck@redhat.com>
> > CommitDate: Wed Aug 30 18:23:25 2017 +0200
> >=20
> >     s390x/ccw: create s390 phb conditionally
> >=20
> > to keep s390-ccw-virtio clean proper.
> >=20
> > If you want to have PCI disabled, you can do you in a machine like  =20
> too quick                                     ^that^					=20
> > s390-rhelx.y.z or whatever.  =20
>=20
> I think we really must revert this commit.=20
>=20

A set of non-pci machines looks more attractive to me. I currently have
the following (not yet tested):

=46rom 5dd282bd6e12dca0ca8252019a4c4c58e729b2c5 Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 28 Sep 2017 14:00:48 +0200
Subject: [PATCH] s390x: set of -nopci machines for non-pci builds

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1bcb7000ab..e032857b6e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -266,7 +266,7 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
=20
-    if (s390_has_feat(S390_FEAT_ZPCI)) {
+    if (pci_available) {
         DeviceState *dev =3D qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
         object_property_add_child(qdev_get_machine(),
                                   TYPE_S390_PCI_HOST_BRIDGE,
@@ -596,9 +596,11 @@ bool css_migration_enabled(void)
     {                                                                     =
    \
         MachineClass *mc =3D MACHINE_CLASS(oc);                           =
      \
         ccw_machine_##suffix##_class_options(mc);                         =
    \
-        mc->desc =3D "VirtIO-ccw based S390 machine v" verstr;            =
      \
+        mc->desc =3D pci_available ? "VirtIO-ccw based S390 machine v" ver=
str : \
+            "VirtIO-ccw based S390 machine (no PCI) v" verstr;            =
    \
         if (latest) {                                                     =
    \
-            mc->alias =3D "s390-ccw-virtio";                              =
      \
+            mc->alias =3D pci_available ? "s390-ccw-virtio" :             =
      \
+                "s390-ccw-virtio-nopci";                                  =
    \
             mc->is_default =3D 1;                                         =
      \
         }                                                                 =
    \
     }                                                                     =
    \
@@ -609,14 +611,24 @@ bool css_migration_enabled(void)
         ccw_machine_##suffix##_instance_options(machine);                 =
    \
     }                                                                     =
    \
     static const TypeInfo ccw_machine_##suffix##_info =3D {               =
      \
-        .name =3D MACHINE_TYPE_NAME("s390-ccw-virtio-" verstr),           =
      \
+        .name =3D MACHINE_TYPE_NAME("s390-virtio-ccw-" verstr),           =
      \
+        .parent =3D TYPE_S390_CCW_MACHINE,                                =
      \
+        .class_init =3D ccw_machine_##suffix##_class_init,                =
      \
+        .instance_init =3D ccw_machine_##suffix##_instance_init,          =
      \
+    };                                                                    =
    \
+    static const TypeInfo ccw_machine_nopci_##suffix##_info =3D {         =
      \
+        .name =3D MACHINE_TYPE_NAME("s390-virtio-ccw-nopci-" verstr),     =
      \
         .parent =3D TYPE_S390_CCW_MACHINE,                                =
      \
         .class_init =3D ccw_machine_##suffix##_class_init,                =
      \
         .instance_init =3D ccw_machine_##suffix##_instance_init,          =
      \
     };                                                                    =
    \
     static void ccw_machine_register_##suffix(void)                       =
    \
     {                                                                     =
    \
-        type_register_static(&ccw_machine_##suffix##_info);               =
    \
+        if (pci_available) {                                              =
    \
+            type_register_static(&ccw_machine_##suffix##_info);           =
    \
+        } else {                                                          =
    \
+            type_register_static(&ccw_machine_nopci_##suffix##_info);     =
    \
+        }                                                                 =
    \
     }                                                                     =
    \
     type_init(ccw_machine_register_##suffix)
=20
--=20
2.13.5
