Received: from eggs.gnu.org ([2001:4830:134:3::10]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLlID-0007WT-HL
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fLlI6-0007h0-Qm
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:08:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fLlI6-0007gt-Hl
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29FEA7C6B3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:08:06 +0000 (UTC)
Date: Thu, 24 May 2018 09:08:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180524080804.GC20733@stefanha-x1.localdomain>
References: <20180524043952.11245-1-peterx@redhat.com>
	<20180524043952.11245-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <20180524043952.11245-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 12:39:51PM +0800, Peter Xu wrote:
> Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Aside from the checkpatch.pl error that needs to be fixed (I like to use
a git hook to check automatically, see
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html=
):

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBnLkAAoJEJykq7OBq3PIlaEIAKT/Po2sPdI3UR0I0zqb/Kme
A2MS/uqUe5W1W16J4VYKLLDNPfM3bNoAbpckBzkLyaHbYnmTsHLxgaDLeylUHdzq
U68ovgrt5KQVcNE+C6Yt76QIO6BXGPkzVRK0n5RIYmmaPMMM0jukfwp5ATrCQS7L
gIfxFi7dK/UrYvTWh+FCdN7PuWXXbrXpEGeAfJu84BmR4BQvfwC9UfC4T3r5np0L
pOwcZHny9oAAIboLBtI8VHewCDjKGdgsVB+qmZdv9PfnbhNO5Isc5kfZsM/285iV
SoDRrzFX3wRVekRJGYZWG9S+MrYZIVmTr6mzqUkDc9yekR6b4NOJreTteJVmcTM=
=M5Zc
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
