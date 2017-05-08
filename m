Received: from eggs.gnu.org ([2001:4830:134:3::10]:39716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lhT-0000No-6f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lhQ-0003d0-4h
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7lhP-0003cp-Rb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:39:52 -0400
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
	<CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
	<0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
	<CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
Date: Mon, 8 May 2017 11:39:46 -0500
MIME-Version: 1.0
In-Reply-To: <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7rqjCgVC7VnaigNdNjPXmSwT4TjoHc1LW"
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rqjCgVC7VnaigNdNjPXmSwT4TjoHc1LW
From: Eric Blake <eblake@redhat.com>
To: Carl Karsten <carl@personnelware.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
Subject: Re: [Qemu-devel] format=raw,readonly errors
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
 <87wp9r689l.fsf@dusky.pond.sub.org>
 <CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
 <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
 <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
 <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
 <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
In-Reply-To: <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 11:33 AM, Carl Karsten wrote:
> according to the warning: "Specify the 'raw' format explicitly to remov=
e
> the restrictions."
>=20
> I want the restriction.
>=20
> format=3Draw, (write operations on block 0)=3Drestricted

Then omit format=3Draw.  (It's an unusual request, though).  Or, as other=
s
mentioned in this thread, you can use -snapshot or any other form of
overlay image to keep the original image read-only while still providing
a read-write image that the guest requires for faithful hardware
emulation; and you can always check your overlay after the fact to learn
whether sector 0 was changed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7rqjCgVC7VnaigNdNjPXmSwT4TjoHc1LW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEJ9SAAoJEKeha0olJ0NqZiYH/RVQjYYSMMfTspGtdiGaCW9U
t+x4/r7hjfdGaGV0BLexhT0NcOYW91svYW9Hq1Adx31VLn2T37XkDrdAU4z+C0VU
jhAGQyArCswe2MVJeZbcCz8WIILHs/2y3baEeMfB4d9ksqtYRlZPRDM+87V64sWz
7PF3U06fD3ZLiwXw4p3kXixpETFaeBus+cgJijJkfC/M1e1y/BgVbUbfM45PAOXF
4lH128H5ohvBnvvSC6nlY4c+XAKCYcHF+003lj8A+n16wUNQkIubFHPnBvEQ/Dlf
X8Q2naedJ3Dxpz8uT373C4ruIJdqebgWkBaslQpalkXLsSnWU3ksMJjuDf+dQoc=
=jiBA
-----END PGP SIGNATURE-----

--7rqjCgVC7VnaigNdNjPXmSwT4TjoHc1LW--
