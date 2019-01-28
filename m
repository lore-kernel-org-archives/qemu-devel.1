Received: from eggs.gnu.org ([209.51.188.92]:55159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1go2dC-0000U5-BV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1go2d9-0004HG-52
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:51:02 -0500
Date: Mon, 28 Jan 2019 09:50:41 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190128085041.GA16630@andariel.pipo.sk>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190125174653.4604-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com, eblake@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 18:46:52 +0100, Kevin Wolf wrote:
> The new device_id property specifies which value to use for the vendor
> specific designator in the Device Identification VPD page.
>=20
> In particular, this is necessary for libvirt to maintain guest ABI
> compatibility when no serial number is given and a VM is switched from
> -drive (where the BlockBackend name is used) to -blockdev (where the
> vendor specific designator is left out by default).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

[...]

> @@ -2904,7 +2910,9 @@ static const TypeInfo scsi_disk_base_info =3D {
>      DEFINE_PROP_STRING("ver", SCSIDiskState, version),               \
>      DEFINE_PROP_STRING("serial", SCSIDiskState, serial),             \
>      DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),             \
> -    DEFINE_PROP_STRING("product", SCSIDiskState, product)
> +    DEFINE_PROP_STRING("product", SCSIDiskState, product),           \
> +    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)

This adds the property only to 'scsi-disk', whereas libvirt will use
'scsi-cd' or 'scsi-hd' depending on the media type if the 'scsi-cd'
device is detected. The following logic decides:

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_command=
=2Ec;h=3D3e46f3ced3c1e6a4865e98e2d0cdce3214c4a5d2;hb=3DHEAD#l1978

This brings multiple questions:

1) Is this necssary also for scsi-cd/scsi-hd and if yes, the property
does not seem to be present for those

2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
'scsi-disk'?

3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd' is
already supported there, can we assume that all newer versions support
it? (Basically the question is whether it can be compiled out by
upstream means).



--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxOwl4ACgkQHGwCByjY
1GpzyQ//bIbnCAaV/g58tFb9Z2yjGUmXzaR0GtVOGbsWu1py0rswU7kREykpShmk
jwcBsUQzuW2BVVNlPHDeABdpODmH88RKyP/uwYZTr5xr3EjDqytEfD692D85F65+
LPUPiJUXnbRP2H0pEGSvBF9UNkkf53gI2LIkPpYuxPPsDUcUbb1b4hyKOy371ZLa
yuc43j978ZxRnEKVFXSKiztytdBaidzHgctFPbu1wr7xugMbZuP37IMOm5MsBdWC
wL7AbCOKjTDzo9TqGWz5vQhDWuDKrhNA3e3gCsa3cVJwbzbLUsVUXThIcrTLLZpx
o4V0q9OESAQo9JLz29ICs1OS2jdPx027D2YJXU+NlAQOEhYHnDnQk9m0wLOwsl7K
qEWQzK3ldU+Ueo6Uw/jan7OUy5wLq0YVM+bkwJVGuS2HbeDMPFPN0Ww9ZrxKPIal
PK8QyZBplcg8lkTFljpe9CNtgIkX4SQ97WdatIkVsF++wW48XYHVPGFyXI3KNKXT
fOo9MEQ1GuX7YQ6oMiroY1Lft415GYhwFDzzwCv32jaLbw6RlPYe9sAPrSy++9wn
eXnuwy8V6Pzxx7cgxqEhbbgEGclfNKcrN4CTNRGimOvmrptVaoUxv2Iyj9NkM7Sl
YfoCeW6nc7wVWi3061l/ZqPVyuITkTWyCLqZZIsjNCXIbqT+h34=
=OSsN
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
