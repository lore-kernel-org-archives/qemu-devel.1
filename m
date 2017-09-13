Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds8bp-0000tA-5K
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds8bn-0007JS-QP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:25:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ds8bn-0007J6-FN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:25:43 -0400
References: <20170913135418.GA14243@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97125ad2-4f25-2624-52e7-f0a9e499ca33@redhat.com>
Date: Wed, 13 Sep 2017 09:25:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170913135418.GA14243@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GokkQcFCdagFt8Oedp8GGvQlvDeG3qfoc"
Subject: Re: [Qemu-devel] [libvirt] QEMU -M nvdimm=on and hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, mprivozn@redhat.com
Cc: libvir-list@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GokkQcFCdagFt8Oedp8GGvQlvDeG3qfoc
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, mprivozn@redhat.com
Cc: libvir-list@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu-devel@nongnu.org
Message-ID: <97125ad2-4f25-2624-52e7-f0a9e499ca33@redhat.com>
Subject: Re: [libvirt] QEMU -M nvdimm=on and hotplug
References: <20170913135418.GA14243@stefanha-x1.localdomain>
In-Reply-To: <20170913135418.GA14243@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 08:54 AM, Stefan Hajnoczi wrote:
> Hi Michal,
> You asked how NVDIMM hotplug should work if the domain was launched
> without -M nvdimm=3Don.  I'm not very familiar with ACPI so this may be=

> incorrect.
>=20
> Hotplug relies on the presence of ACPI tables (SSDT Device=3DNVDR
> _HID=3DACPI0012) added by -M nvdimm=3Don.  The ACPI tables contain the
> interface needed to handle hotplug events.
>=20
> The device_add command fails with the following message if -M nvdimm=3D=
on
> is missing:
>=20
>   nvdimm is not enabled: missing 'nvdimm' in '-M'
>=20
> I'm not sure if ACPI allows SSDT tables to be dynamically added but in
> any case the current QEMU code doesn't support that.
>=20
> Options for libvirt:
>=20
> 1. Rely on QEMU's device_add error.
>    Pro: If QEMU behavior ever changes then libvirt will also start
>         working without code changes.
>    Cons: Does libvirt interpret QMP error strings?

In general, we don't want to parse the human-readable portion of an
error; if management software MUST be able to distinguish between two
different types of errors in order to react differently according to
type, then we have a scenario where we want actual differing error
classes (most errors use the generic class, via error_setg(); but it is
still possible to set other error classes where it makes sense).

>=20
> 2. Only allow NVDIMM hotplug if the domain was started with -M
>    nvdimm=3Don.
>=20
> I think QEMU will not add -M nvdimm=3Don to the "pc" machine type by
> default since it adds the NVDIMM DSM hardware interface that increases
> the security attack surface.
>=20
> Stefan

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GokkQcFCdagFt8Oedp8GGvQlvDeG3qfoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5P+AACgkQp6FrSiUn
Q2q8Mwf/W+UEznm7IPhYamKVbAaY1aXCQ3xH88s3EYd5AM1Ik16DpZo39L9G6Skv
QczQPutXzR8XMsMxOAZ8UM4DQSZOoYwuJm10xp+ygn3PkssdR31S/hyvnwunszWb
7K7cSEkFxJ0GmTOMNvi+Zr39Of5R0d59zunfu8rSuM1PkOV0BVFA7Q26CvXGJp5m
ypPr5w2lbuSIi12OEoJciqxpahdQUz0jduYICeEnVYoWQsmxOlmai7bd+vZSS5Qd
WDWR68kE3SOIgah5CzZC3WIwtT1Qc0F8JOPQUU9Yw4844vhCtcKgZIK1UgV0M+rC
z3/rxiGY++VY0X6xNQRP0GCKsI2lrA==
=W0x7
-----END PGP SIGNATURE-----

--GokkQcFCdagFt8Oedp8GGvQlvDeG3qfoc--
