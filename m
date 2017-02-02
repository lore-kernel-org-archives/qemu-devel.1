Received: from eggs.gnu.org ([2001:4830:134:3::10]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNwX-0003hV-LI
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNwT-00012S-HA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:25:21 -0500
References: <20170202195601.11286-1-sw@weilnetz.de>
	<bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
	<a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <508ce64c-800d-bfdc-ba88-19b425edab64@redhat.com>
Date: Thu, 2 Feb 2017 14:25:14 -0600
MIME-Version: 1.0
In-Reply-To: <a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oOGbnEEPLEnlQJmWFJ5PsSmTfG76gNA5L"
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oOGbnEEPLEnlQJmWFJ5PsSmTfG76gNA5L
From: Eric Blake <eblake@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <508ce64c-800d-bfdc-ba88-19b425edab64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
References: <20170202195601.11286-1-sw@weilnetz.de>
 <bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
 <a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
In-Reply-To: <a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 02:10 PM, Stefan Weil wrote:
> Am 02.02.2017 um 21:00 schrieb Eric Blake:
>> On 02/02/2017 01:56 PM, Stefan Weil wrote:
>>> tb_jmp_insn_offset and tb_jmp_reset_offset are pointers
>>> and cannot be used with ARRAY_SIZE.
>>>

>> mst posted an alternative patch:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00551.html
>=20
>=20
> Yes, I noticed that, too. It's not obvious that this new
> assertion will be correct, and none of the other targets
> has that kind of assertion. Only two targets use an
> assertion which detects NULL pointers, but NULL pointers
> will result in an abort anyway.
>=20
> Do you think that there are reasons why TCI should use
> the assertion suggested by Michael?

I don't have any strong opinions on which patch is better, so much as
just pointing out that alternative proposals exist so that we have good
threading in making the decision on which one to go with.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oOGbnEEPLEnlQJmWFJ5PsSmTfG76gNA5L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk5WqAAoJEKeha0olJ0NqKwoH/Rum2+tFQJSW29+TyF5Z8At4
MO6GW5YSWtE+osHS2YdC56hVdlGExx17Er/Cm2uj8yD2roankDW4YSux8ADjacIC
mh4vxZXxGoGDMnr5etj1H8Wo1eOmQDQK3fNwv17i1lDrt8mXgPrtbvusgDT7eLCm
7a+imsNrqzpvrJAy5czEvDmpyoEsyx0zvgxgPiTB+zWyy9aoRRoVG1z7jzzyVUPp
q3xBTsEdHNga/cpdFu34F+Ei3NOrfiGHg7dDiXL1qdFF9MAk20FR/WM1fCgY0+Nc
4NeD5v38w1xs5b3l+UpU8j6VQCGsiSCGYB2dnJ+wr6PQLJcGrlmwAgY0qqMgHJ8=
=lJAI
-----END PGP SIGNATURE-----

--oOGbnEEPLEnlQJmWFJ5PsSmTfG76gNA5L--
