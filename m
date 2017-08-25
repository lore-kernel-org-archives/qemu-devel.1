Received: from eggs.gnu.org ([2001:4830:134:3::10]:56290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGab-0005j0-0a
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGaX-00017K-SE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dlGaX-00017B-IH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:32:01 -0400
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
	<20170825105913.4060-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b2a2be0-cf5f-29e4-b204-1da6b20539b7@redhat.com>
Date: Fri, 25 Aug 2017 10:31:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170825105913.4060-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HjsWJVWg2BIRDrbo4qf5OT8Lfhv9RJoG9"
Subject: Re: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HjsWJVWg2BIRDrbo4qf5OT8Lfhv9RJoG9
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b2a2be0-cf5f-29e4-b204-1da6b20539b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/14] qdict: add qdict_put_null() helper
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
 <20170825105913.4060-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 05:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> A step towards completeness.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qdict.h | 4 +++-
>  target/i386/cpu.c        | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Is it worth touching up scripts/coccinelle/qobject.cocci at the same time=
?

I guess we don't care about a qlist_append_null() variant?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HjsWJVWg2BIRDrbo4qf5OT8Lfhv9RJoG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgQuwACgkQp6FrSiUn
Q2o0Pwf8DIsx7u8Jgy2D1Es9qciLnq97911CBQx57JtkXKdtxI4E1lHY6oupbylt
asSGxgxpT83H8VCioJGnf94UiodP2y6CyE8+NT9Wo8YchvNvsti2O4F6TYheA5IN
N7lN1xIlz/VxL8RP23mDb1tHBLSVMqvjyrRgh7gd/emXimUr+x2w+0qAQWCogOJ9
gXpm+JWhHaQw4tpVE1lnugxASoXJvq5et5Se78B4M3Wo+e55q3VGkbdS0zgfL7oH
0zYhC1PDFu7appa5073YnGFEqa0w/GSu6H3XwRr6Ss35kuh64ts23upyPiTH+w0h
BsBTD2hbO1Y0+M34/8K7Ng5tFH5wCw==
=Vuqk
-----END PGP SIGNATURE-----

--HjsWJVWg2BIRDrbo4qf5OT8Lfhv9RJoG9--
