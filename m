Received: from eggs.gnu.org ([2001:4830:134:3::10]:39502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsK-00060b-EA
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsJ-0001NN-EL
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:12 -0400
Date: Sat, 20 May 2017 16:40:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170520064036.GC30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518992406.24289.10624548011389715164.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <149518992406.24289.10624548011389715164.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] spapr_cpu_core: drop reference on
 ICP object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 12:32:04PM +0200, Greg Kurz wrote:
> When a piece of code allocates an object, it implicitely gets a reference
> on it. If it then makes that object a child property of another object, it
> should drop its own reference at some point otherwise the child object can
> never be finalized. The current code hence leaks one ICP object per CPU
> when hot-removing a core.
>=20
> Failing to add a newly allocated ICP object to the CPU is a bug. While he=
re,
> let's ensure QEMU aborts if this ever happens.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr_cpu_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 1df1404ea52d..ff7058ecc00e 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -143,7 +143,8 @@ static void spapr_cpu_core_realize_child(Object *chil=
d, Error **errp)
>      Object *obj;
> =20
>      obj =3D object_new(spapr->icp_type);
> -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> +    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> +    object_unref(obj);
>      object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZH+TkAAoJEGw4ysog2bOS4B0P/016+XWFbCN5JmH6TNmv+zUV
F911watyvP7R6d1HHpTsOz6KhokDyZT7TOW1Wvr1JGkLnmnHeqYtA0hzTHFM93mO
LByXWYibqzCcZqQprFi3HWv6mjnNxxn5gdX8BVoqG1WrqgjqLN1NQuolSkNm7MDR
1QVH+9xP8TJ+Gazees7x+Dp7gTlat26AWmhfSxbjKG0krMUyqDuJ+fZu9AYZUUeR
IB4GmdpAQ4ZNbHYEXWEyiU8vqlDhOwo7S8SzyiMV9W1Ekye3FnijQfZwFv0uXhmI
AAyL1FC0VSNIjR+xdJPaxWCt+8cSdv+gjofReRef4EvxnUOL14upJlnKakCSjUEk
Mq0n08In/6Jcl8EI5MO4qFqVLPG0umNjROL10iFZuxnaJNIz3Ll/VCufRP3yxkGG
zSOoh/Lx0fClttzJQ4YvpbpPPzDhtsXnZSUKuYlIJaAC53SqaAP7tjrE7YW3dB9O
MJOZnerCC8bhSDQdNU8IqwC0sheg7i2e8pYXdyRo4dDLR9o2kLmvCboY4yVJbRXG
2BPmsIZ8yHjo+4WPDV6w7/6Upe4diC9FrO4FsVNmK8435TAonp+oc4tkm7vLoQn2
1eHBk7zUjwiWhY62uu+Lip7UEV8qgbyg/WAsLOhFweDz6k7CPr4zSoztnso6o7bn
du9PscHSe4av8OPgHdTY
=ANfw
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
