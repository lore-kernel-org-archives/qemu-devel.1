Received: from eggs.gnu.org ([2001:4830:134:3::10]:55234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8Voq-0003r4-OT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8Voq-0006Ed-39
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:54:36 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-8-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7214c202-730c-1c46-10ec-526284ad7956@redhat.com>
Date: Wed, 10 May 2017 19:54:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-8-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IFFbPwqI7hC62d3nUlX6p9AanGImeDDs8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] curl: do not do aio_poll
 when waiting for a free CURLState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IFFbPwqI7hC62d3nUlX6p9AanGImeDDs8
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <7214c202-730c-1c46-10ec-526284ad7956@redhat.com>
Subject: Re: [Qemu-block] [PATCH 7/7] curl: do not do aio_poll when waiting
 for a free CURLState
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-8-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:32, Paolo Bonzini wrote:
> Instead, put the CURLAIOCB on a wait list; curl_clean_state will
> wake the corresponding coroutine.
>=20
> Because of CURL's callback-based structure, we cannot easily convert
> everything to CoMutex/CoQueue; keeping the QemuMutex is simpler.
> However, CoQueue is a simple wrapper around a linked list, so we can
> use QSIMPLEQ easily to open-code a CoQueue that has a QemuMutex's
> protection instead of a CoMutex's.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--IFFbPwqI7hC62d3nUlX6p9AanGImeDDs8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTU9ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5BIIAIKeNro00XQRPuJDq8vo5pDXfx1d5cji
qq6kyRH0uU2+vNR6gQJaBKR1/5YVwpH508PQ6hszDFsB1MI2vZeNTnDo0mero1tl
owQefWSOJ8W0suwZQ/58yNS6gJqcIt1QRt9K1fDNlVWTJ40WsfCRQBXIsgyoSI7Q
yFeh9HGc12dp+28PhMCw98q/7KNdTbUbeMr0+7Cl6XBNlPWpuwARwk/fwvJNRNt4
ZeDii4CYqLOZWGik+FTIaE2iwikw85G6VEG0nGThRXmkgXfOkhUofe/9y4RmDnEb
h8Jbuj8n13oXqw64/E3oAWXj/3YlX2pwXo+gMHpFomn90Y97CCkYggo=
=nGsQ
-----END PGP SIGNATURE-----

--IFFbPwqI7hC62d3nUlX6p9AanGImeDDs8--
