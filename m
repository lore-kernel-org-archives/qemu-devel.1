Received: from eggs.gnu.org ([2001:4830:134:3::10]:52017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikam-0004f3-PW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikal-000722-RG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:25:36 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <979c1a7e-5cde-3958-81c9-362715ecf852@redhat.com>
Date: Tue, 28 Feb 2017 10:25:27 -0600
MIME-Version: 1.0
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SCLnoHnWB5e3QUqVAEaQiUmjjnAc1NiDK"
Subject: Re: [Qemu-devel] [PATCH 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SCLnoHnWB5e3QUqVAEaQiUmjjnAc1NiDK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com
Message-ID: <979c1a7e-5cde-3958-81c9-362715ecf852@redhat.com>
Subject: Re: [PATCH 00/24] block: Command line option -blockdev
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:20 AM, Markus Armbruster wrote:
> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser[*].  The latter part could be spun out in its own
> series, if that helps.  We'll see.
>=20
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>=20
> This series is based on "[PATCH v2 00/26] qapi: QMP dispatch and input
> visitor work".

which I've now reviewed; it has a couple issues that need fixing before
I can give R-b everywhere, but we should be able to get to a pull
request soon. (Wow - soft freeze comes faster than we want!)

>  Available as branch blockdev-cmdline in my public repo
> <http://repo.or.cz/w/qemu/armbru.git>, except that one still has a
> patch to add implied value sugar, followed by its revert.
>=20

It helped. Thanks for posting it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SCLnoHnWB5e3QUqVAEaQiUmjjnAc1NiDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaR3AAoJEKeha0olJ0Nq1AQH/jeQZ+yP75oWWijPRLQ1fgD/
TFAJTK4ldxNEKhuuSTZmk2qvAcxWSiVZK8eeKiatR2zQGpcMheaXsb/D2CVli9rl
KHW+8wOccEHRkP388Y0xyLhXYNNR0aKuLYpw2RcMGf1FmNnBeo6MLFMcIEQi/st2
Q/QY8KcEcVv3JCdViHyJ5CZU+UfFFkAdzVZ9zeVrcLa9gdeplB/AqyXJOklenfEH
bLNv5Q+0wrK82fIEu4NS6uLPvL6UPnQWX6nGgj8Af1yEgu3n5o83ncOe+gRYUrAg
a95B6LaPPm2wXyOvMWE5ZMMi1D6UDX85yMfsuoyGcnPKnmI2MRoDThNEjBQVLF8=
=Hqn6
-----END PGP SIGNATURE-----

--SCLnoHnWB5e3QUqVAEaQiUmjjnAc1NiDK--
