Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3v8w-0002vA-5G
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 21:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3v8t-0007tV-5D
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 21:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3v8s-0007rr-SM
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 21:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A66B664A4B
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 01:56:17 +0000 (UTC)
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
	<1490860207-8302-4-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5147de0-c60a-9406-830c-82b1c2f33689@redhat.com>
Date: Thu, 27 Apr 2017 20:56:09 -0500
MIME-Version: 1.0
In-Reply-To: <1490860207-8302-4-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7o8M0kX4vHi227t6iiU8ct6bjv1p6Wxv8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7o8M0kX4vHi227t6iiU8ct6bjv1p6Wxv8
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <b5147de0-c60a-9406-830c-82b1c2f33689@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests: Add a tester for HMP commands
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
 <1490860207-8302-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1490860207-8302-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 02:50 AM, Thomas Huth wrote:
> HMP commands do not get any automatic testing yet, so on certain
> QEMU machines, some HMP commands were causing crashes in the past.
> Thus we should test HMP commands in our test suite, too, to avoid
> that such problems creep in again in the future.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include |   2 +
>  tests/test-hmp.c       | 161 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 tests/test-hmp.c

We should also update tests/.gitignore to make sure tests/test-hmp
doesn't get accidentally committed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7o8M0kX4vHi227t6iiU8ct6bjv1p6Wxv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAqE5AAoJEKeha0olJ0NqK+kIAJoY/ggxEQt6RMFauffayuxE
IxDGY6MnLJ3DWo7tc4TvqymvGDFFnrHrs5PQUmbzVdZYpeeEdIkFxjwOCfgJVLtX
iIEgbR0E6BP86Ou7OJmD7UdzKhWLbBUd23P6RyrbScIJ8cZBT1yAFJXeb8nKYPI1
FtY5sgGUlbJGYDI6F8ez1Nw5+nWowsWCvaGaXk7PJzZIVrCq9GQJn7NCBbq9ezSp
OXXnA0ulzA2E+/3Q37zwiAU/X2N1IaiHitI8hAP/3GtxS5XzNAJvhFzin/IrAl7Z
sTXSxCX0tS9VJQGW8C1UaKOrael/gAHGHczYkYUZ4F5gYnNRO8SWkgjmASFZ27I=
=lY6Q
-----END PGP SIGNATURE-----

--7o8M0kX4vHi227t6iiU8ct6bjv1p6Wxv8--
