Received: from eggs.gnu.org ([2001:4830:134:3::10]:33826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGQpY-0005s0-CS
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGQpV-0004kF-2H
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:12:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGQpU-0004k4-Q8
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:12:01 -0400
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5e4a325-8330-8edc-4f5c-0b33d744357a@redhat.com>
Date: Thu, 1 Jun 2017 09:11:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170601124143.10915-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TAtXQsu4QrOAuvlb9E8Koj3MHb2VejAR0"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] scripts: use build_ prefix for
 string not piped through cgen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TAtXQsu4QrOAuvlb9E8Koj3MHb2VejAR0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <a5e4a325-8330-8edc-4f5c-0b33d744357a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] scripts: use build_ prefix for string
 not piped through cgen()
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170601124143.10915-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:

No 0/2 cover letter?

> Suggested by Markus Armbruster:
>=20
> The gen_ prefix is awkward.  Generated C should go through cgen()
> exactly once (see commit 1f9a7a1).  The common way to get this wrong is=

> passing a foo=3Dgen_foo() keyword argument to mcgen().  I'd like us to
> adopt a naming convention where gen_ means "something that's been piped=

> through cgen(), and thus must not be passed to cgen() or mcgen()".
> Requires renaming gen_params(), gen_marshal_proto() and
> gen_event_send_proto().
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py          |  2 +-
>  scripts/qapi-commands.py |  8 ++++----
>  scripts/qapi-event.py    | 12 ++++++------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TAtXQsu4QrOAuvlb9E8Koj3MHb2VejAR0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMCCrAAoJEKeha0olJ0NqDjAH/Ru4VfKTFDTpa2onEaYBMGHd
JSvEqRNkdtgZPCY/I7HMCpUJ8uAj895M4azI56PP50c3SzQCHI1H42MJL25Q9vVU
Kp4xjhfZg2Y7QoORFPi6jyvRi3LqundlJcUYz8EJjy0zAPMPZDL90G9wSieJWSao
12+9gwXzkq7No81zP4coEoD9bbbnASdIuAmH0YO/8qevEI7roq93xvYsz29ePL4k
Srvs/9Td1hNMNuuHHj4iYHTbCNPV82neVbjSkE5MceDwfGCp8k0IMqhakWGm586m
JI+vZAFFMGJXeVxGb3GU3w2wQUGyfemcXdPxdJqnbnUQMD4GTsOcSQlu3n2Zbgo=
=R02O
-----END PGP SIGNATURE-----

--TAtXQsu4QrOAuvlb9E8Koj3MHb2VejAR0--
