Received: from eggs.gnu.org ([2001:4830:134:3::10]:46013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6Ij-0003vn-MC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6If-0005N9-1W
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX6Ie-0005Mw-O1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:00 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
Date: Mon, 17 Jul 2017 08:42:58 -0500
MIME-Version: 1.0
In-Reply-To: <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AgKbXNvHvmGHmwtnOLB818DlD1t6QwFth"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AgKbXNvHvmGHmwtnOLB818DlD1t6QwFth
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
In-Reply-To: <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 08:07 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 04/07/2017 04:21 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Dave,
>>
>> On 04/07/2017 11:38 AM, Dr. David Alan Gilbert wrote:
>>> Hi,
>>>    Fedora 26 has gcc 7.0.1 which has the normal compliment
>>> of new fussy warnings; so far I've posted :
>>>
>>> tests/check-qdict: Fix missing brackets
>>> slirp/smb: Replace constant strings by glib string
>>>
>>> that fix one actual mistake and work around something it's being
>>> fussy over.
>>>
>>> But I've also got a pile of hacks, attached below that I'm
>>> not too sure what I'll do with them yet, but they're attached
>=20
> ping ... What do we do with them?

Well, now that I've upgraded to the just-released Fedora 26, it is now
mainline gcc and affecting my builds.  So we should really try and find
patches that silence the warnings (although it counts as bug fixes, so
it won't hurt if it doesn't make tomorrow's freeze deadline).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AgKbXNvHvmGHmwtnOLB818DlD1t6QwFth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllsvuIACgkQp6FrSiUn
Q2pvZAf7Bv7Mu/5RZiO/f9IyXt4QFq47UAadBM3oHkd1BNYW9sTgAb9R2eGs24Yy
M4CjEFOGDhuiTZr0GP5rzRrOVV96Nf4pk49x1j2msQ+bUerTXtcBqn9bPAqc9NdL
QQZ+zu9z7NxCD1HfyJ2KS9q+/k/xRbOPxCbx+JFzyxWoIXoeOdx141VBsUmORDzY
iuH7pS7HuCn+LzAqMY3SFpcceKMOBRHBmcZZyEhVXq7e/beyDPMg3oEtZgy3ECJ+
JeWZtplE5qFQ4wdIYXEjheYkcbUu/11XjJdfL4ZtBWc6ldJI0l+oh3WPavb7FWGY
guEhGR1jG6TliWlSumIu5uPMzUlZiQ==
=qkR+
-----END PGP SIGNATURE-----

--AgKbXNvHvmGHmwtnOLB818DlD1t6QwFth--
