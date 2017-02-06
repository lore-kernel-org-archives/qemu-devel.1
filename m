Received: from eggs.gnu.org ([2001:4830:134:3::10]:34124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cao7B-0000W9-Ex
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cao78-0001mK-Bw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:34:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cao78-0001m4-2q
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:34:10 -0500
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
	<20170206031921.14255.83819.launchpad@soybean.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41a3181b-3345-b280-afd1-6b90b51d260c@redhat.com>
Date: Mon, 6 Feb 2017 12:34:07 -0600
MIME-Version: 1.0
In-Reply-To: <20170206031921.14255.83819.launchpad@soybean.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XL8nkqhXUg1TJji9pj65d8S9n7P7DGSj2"
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1662050 <1662050@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XL8nkqhXUg1TJji9pj65d8S9n7P7DGSj2
From: Eric Blake <eblake@redhat.com>
To: Bug 1662050 <1662050@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <41a3181b-3345-b280-afd1-6b90b51d260c@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1662050] Re: qemu-img convert a overlay qcow2
 image into a entire image
References: <20170206024535.14624.3001.malonedeb@soybean.canonical.com>
 <20170206031921.14255.83819.launchpad@soybean.canonical.com>
In-Reply-To: <20170206031921.14255.83819.launchpad@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2017 09:19 PM, wayen wrote:
>=20
>   I have a base image file "base.qcow2" and a delta qcow2 image file
>   "delta.qcow2" whose backing file is "base.qcow2".
>  =20
>   Now I use qemu-img to convert "delta.qcow2" and will get a new image
> + file "new.qcow2" which is entire and equivalent to combination of
>   "base.qcow2" and "delta.qcow2".
>  =20
>   In fact, i just want to convert the delta qcow2 image file and get a =
new
>   delta overlay qcow2 image file. So the "new.qcow2" is not what i want=
=2E I
>   have to admit that this is not bug. Could you please take this as a n=
ew
>   feature and enable qemu-img to convert images in-place?

This feature already exists.  Use:

qemu-img rebase -F $backing_fmt -b '' -f qcow2 delta.qcow2

and now delta.qcow2 will be a complete image.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XL8nkqhXUg1TJji9pj65d8S9n7P7DGSj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmMGfAAoJEKeha0olJ0NqdX8H/R/cMNANURvNNKRKh8rjwP4J
MAjcVrNFn5eJOkz+AIJ64/CjLXSKNB8jY0XRBJZx4X8q9i1Iq3SsD4fIL+XihC0v
zg3ikwU8/Caj20bxSPiVRUD0C2o8w76iqpqwClS0PLE7NGCUqC2+G2ek5MFx0zcK
eLAIHXmAyfibZTfPoClKfmWZ07xWdTdvUDNBVORfIkgFcuAiu9LwpL7znEMkiRLD
Oc02fvRSzpwEryX51T9ApEbiJuovEDPm5LUrAQKZPjBdYEmZ+EbC49WwGrKCzrch
KZocH/jSvLgjqyxe6zT1UhfTOD8mXdkswOu2HNz2B0aFByU+I6HJoe4k742vS6M=
=LhMu
-----END PGP SIGNATURE-----

--XL8nkqhXUg1TJji9pj65d8S9n7P7DGSj2--
