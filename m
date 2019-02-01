Received: from eggs.gnu.org ([209.51.188.92]:37677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpe7S-0006Gn-SJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpe7P-0002f5-10
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:04:52 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
Date: Fri, 1 Feb 2019 13:04:12 -0600
MIME-Version: 1.0
In-Reply-To: <87pnsbxsi7.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MDR9K7I14D8BfURN1p3SOQqnD08YLu53D"
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MDR9K7I14D8BfURN1p3SOQqnD08YLu53D
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Message-ID: <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnsbxsi7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 12:39 PM, Markus Armbruster wrote:
> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
>=20

>> =20
>>  ##
>> +# @Qcow2BitmapInfoFlags:
>> +#
>> +# An enumeration of flags that a bitmap can report to the user.
>> +#
>> +# @in-use: The bitmap was not saved correctly and may be inconsistent=
=2E
>=20
> I doubt the casual reader could guess the meaning from the name.  What
> about @dirty?

I like it.  The existing name was chosen to match
docs/interop/qcow2.txt, which uses in_use, but I don't see a problem in
making the UI nicer than the specs (and/or rewording the specs, as the
field name doesn't matter there, only the layout).


>> +# @unknown-flags: any remaining flags not recognized by the current q=
emu version
>=20
> Intended use cases for @unknown-flags?

The qcow2 spec defines bit 2 extra_data_compatible; and also leaves the
door open for future extensions that may define other bits. If a new
version of qemu (or some non-qemu qcow2 creation app) creates an image
with additional feature bits set, THIS version of qemu doesn't know what
name to give those bits, but can still inform the user that those bits
are set via this field. It will be omitted for all images created by
this version of qemu.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MDR9K7I14D8BfURN1p3SOQqnD08YLu53D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUmCwACgkQp6FrSiUn
Q2r9Kgf9GbSUBjCffXbzebBICMJtLICRl5jJXgbJZ+fGQbDxIRmhVGyRNZq3a4q8
qSc1E/4q5JTxhJZVxUwMLUVoUeE5YZRGACPv2kkgxDaTqtvCa+aNA8czrVhHpFIw
pAdudmOy3cai8uUELa/ppRLp4dnkOgDpgKRuyYsG1Aj/+gRdFwstmd4BUhnWAJU6
WebrXWoLHTefNwBiR7XUbQ44v8A/NmfX8p3Ur1Y2uUEuCO5z9JRVkFXiGx6WGyAR
uXyKvr1KVa1t4b7FdGvuzYyE0k//PZVQg+uhh8B0GLBHttgbvbBP4yQR+tJQVsxv
mzlH7x7VodpGsQf3CrWI4Gt8h041+A==
=R2nF
-----END PGP SIGNATURE-----

--MDR9K7I14D8BfURN1p3SOQqnD08YLu53D--
