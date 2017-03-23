Received: from eggs.gnu.org ([2001:4830:134:3::10]:38265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr32i-00082X-9P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr32d-0003J2-E5
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:44:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr32d-0003Ik-6P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:44:39 -0400
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
	<20170316145045.10840-1-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2d42061-116f-15fd-f40d-a9b2b7f7865f@redhat.com>
Date: Thu, 23 Mar 2017 08:44:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170316145045.10840-1-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fAp5xGlj33qtJbG2cSHiwg60qpLOSl6F4"
Subject: Re: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fAp5xGlj33qtJbG2cSHiwg60qpLOSl6F4
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <d2d42061-116f-15fd-f40d-a9b2b7f7865f@redhat.com>
Subject: Re:
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
 <20170316145045.10840-1-vfeenstr@redhat.com>
In-Reply-To: <20170316145045.10840-1-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 09:50 AM, Vinzenz 'evilissimo' Feenstra wrote:
> In this version:

When sending a v2, it's best to send it as a new top-level thread
instead of burying it in-reply-to an older thread. Also, don't forget
the subject line on the header message.

>=20
> - Changed the use of strdup to g_strdup and the use of sprintf with a l=
ocal
>   buffer to use g_strdup_printf instead.
> - Made the majority of fields in the GuestOSInfo optional to allow 0 va=
lues
> - Used the right target version in the schema (2.10 vs 2.8 before)
> - Refactored the code for deciding which release/version file to use to=
 use a
>   configuration struct and a while loop to iterate over the options.
>=20
> I was looking into the usage of uname, as suggested by eric, however af=
ter
> looking into this I realized that there's no additional information to =
be
> gained from this. Therefore I decided that this is still a feasible app=
roach.
> In most cases the code will break out of the loop after accessing the s=
econd
> file. For older systems there are some supported fallbacks available, b=
ut
> /etc/os-release and /usr/lib/os-release are already quite established.
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fAp5xGlj33qtJbG2cSHiwg60qpLOSl6F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09FEAAoJEKeha0olJ0NqjnoH/iYDUo0YOuaoBhfL/RrowttI
tcq/vZ5q1aHBApG8z0Egn2CFhg8h/0iPNKZPVtD1PQlOBuduK1GvftBcmpVx79ms
AZsByUh8h1XTOPTqYyNDiDD7YrSdj2MCRDwvojF/pl+iGVii/hVm+vIicDVXAipr
VJAs19ux7900edmFFpLDFH0tI6/oYFrZjZYkSDxVXOpAGWGBNKQmbcw33/4szRw6
PIcCnfdHdJOt6scYpthquQPZxZLELltqTU3TCYLB3MKdWInhKV2Nm80zyMqVkwa9
metObRRJul2a1x2C566VBB/9unjqVKukSjipf5IWdCUrI/jNSLfDgcbCs1I+4F4=
=WO3i
-----END PGP SIGNATURE-----

--fAp5xGlj33qtJbG2cSHiwg60qpLOSl6F4--
