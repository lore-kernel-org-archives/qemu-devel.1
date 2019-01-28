Received: from eggs.gnu.org ([209.51.188.92]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8CV-0004M0-0h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go8CU-0000sN-2X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:47:50 -0500
Date: Mon, 28 Jan 2019 15:41:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128144147.GA5756@localhost.localdomain>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190128085041.GA16630@andariel.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.01.2019 um 09:50 hat Peter Krempa geschrieben:
> On Fri, Jan 25, 2019 at 18:46:52 +0100, Kevin Wolf wrote:
> > The new device_id property specifies which value to use for the vendor
> > specific designator in the Device Identification VPD page.
> >=20
> > In particular, this is necessary for libvirt to maintain guest ABI
> > compatibility when no serial number is given and a VM is switched from
> > -drive (where the BlockBackend name is used) to -blockdev (where the
> > vendor specific designator is left out by default).
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/scsi/scsi-disk.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
> > @@ -2904,7 +2910,9 @@ static const TypeInfo scsi_disk_base_info =3D {
> >      DEFINE_PROP_STRING("ver", SCSIDiskState, version),               \
> >      DEFINE_PROP_STRING("serial", SCSIDiskState, serial),             \
> >      DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),             \
> > -    DEFINE_PROP_STRING("product", SCSIDiskState, product)
> > +    DEFINE_PROP_STRING("product", SCSIDiskState, product),           \
> > +    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)
>=20
> This adds the property only to 'scsi-disk', whereas libvirt will use
> 'scsi-cd' or 'scsi-hd' depending on the media type if the 'scsi-cd'
> device is detected.

I'm adding this to the macro DEFINE_SCSI_DISK_PROPERTIES(), which is
used for scsi-hd, scsi-cd and scsi-disk.

It is not added to scsi-block, but there we pass through the VPD page of
the real disk, so this looks correct to me.

> The following logic decides:
>=20
> https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_comma=
nd.c;h=3D3e46f3ced3c1e6a4865e98e2d0cdce3214c4a5d2;hb=3DHEAD#l1978
>=20
> This brings multiple questions:
>=20
> 1) Is this necssary also for scsi-cd/scsi-hd and if yes, the property
> does not seem to be present for those

Yes, but the property is added there.

> 2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
> 'scsi-disk'?

Yes, scsi-disk is a legacy device. Maybe we should formally deprecate
it.

> 3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd' is
> already supported there, can we assume that all newer versions support
> it? (Basically the question is whether it can be compiled out by
> upstream means).

I think so.

Kevin

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcTxSrAAoJEH8JsnLIjy/WjrkP/j6EATS1YiOtbcmich+jG0Sv
WuF87FIdgu+ydVFGeMMPUwNx6JgUV6K3IaFDrI/sFJi9mtUhTKc6LPPGBS5+3JKE
jIPnRSHSRerLAp3JfXiN6+v4T/eYvBrUs+WvDLhWlSLI8fnFxAMDsZPl98eqPot0
fPHwfPjRSXA40cZf9m8CI8vA21WtLB1abT8zmsil1OZVZJm5FY5WdxaeAXIMFj8X
T3O/bRHglmj/vOnIUFoXXYj+lapwEqQ0HZ/u8zjwMKJUMnZcLySCdWktYxr1HtQx
j7ETe7HfZ74w9M7e8MsWXN02Z8s3SDfbPKgKZwsi9rT/B+h7Wg26fk63KcO+AZjc
0ZfvVDZhIXSnGF094tD3dErAZyA4lpPvI1XeuRv2Ltu5IZ6SmIhx4pILjdudHfvw
upYCKE0mS9Nh2BwKuIgU0TpEcbTOVnqHKz/QOVrm7B7LOgRFZkUTX1oDAdvO7TvA
606A31TQj5cT5o7O5axUCQw01jwL/wxUo5EElxuTG/o8l5hKRlTuxFZLgB1kssJR
ktyHkB9q5opHslZjnrxnm2syEySdTaQr3E8lvNokBvIUWWw1+VpHI5l1u285S4xz
y3lVQNx7pWHJArYTnF5jWaNsU6CbkjzNOq3bADYb7Bd4RmHIIBgE7NnCGg7jYtZ2
vvDQKg2CZItkFq2T7ZE8
=ZI1Y
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
