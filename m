Received: from eggs.gnu.org ([2001:4830:134:3::10]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dALfV-0007i5-8h
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dALfU-0000GP-GJ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:28:33 -0400
References: <20170515100059.15795-1-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd8c0dcf-57c5-998d-e5ff-a028e0048968@redhat.com>
Date: Mon, 15 May 2017 21:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SGCXTcBLa7bQoiQja8Rw9KWrTlUHNj4BW"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/7] curl: locking
 cleanups/fixes, coroutine conversion, remove aio_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SGCXTcBLa7bQoiQja8Rw9KWrTlUHNj4BW
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <fd8c0dcf-57c5-998d-e5ff-a028e0048968@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 0/7] curl: locking cleanups/fixes,
 coroutine conversion, remove aio_poll
References: <20170515100059.15795-1-pbonzini@redhat.com>
In-Reply-To: <20170515100059.15795-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 12:00, Paolo Bonzini wrote:
> Compared to v2, this silences checkpatch and correctly destroy the mute=
x on
> exiting from curl_open with an error.
>=20
> Paolo
>=20
> Paolo Bonzini (7):
>   curl: strengthen assertion in curl_clean_state
>   curl: never invoke callbacks with s->mutex held
>   curl: avoid recursive locking of BDRVCURLState mutex
>   curl: split curl_find_state/curl_init_state
>   curl: convert CURLAIOCB to byte values
>   curl: convert readv to coroutines
>   curl: do not do aio_poll when waiting for a free CURLState
>=20
>  block/curl.c | 217 +++++++++++++++++++++++++++++++++------------------=
--------
>  1 file changed, 121 insertions(+), 96 deletions(-)

Modulo checkpatch:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--SGCXTcBLa7bQoiQja8Rw9KWrTlUHNj4BW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGgFXEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPEF
B/9K6mj0PA/xxw0/0nGgkNPadUZvreX5DnF0J2ESWRgS4rf1aGyJKOfZm8tw25zJ
vWJwpq5wKtPjKu4Lqn99Kl7UiJdDgKYxR/gZqJyrucxj5PE6hiYqGnFEKdfXPox1
Ci4kWpJYqfFpnFghq+DYnNLsMVNbv3nGjn8+oL78jtw6GbAqgXfaeXLkPvM05euD
ssby97yp9xsIEgRtSAKgE3gwdxNA6/KRqjfDZ9v9mYply/5WAsqRcMqbB7tdTN5z
ZOtIISRay1lzUeFqyoLkRkmRf972sbLVKptIac09o9cirv7G/ViYQdjRF3S/4qu9
0KPsdVRO3NOVrhG8RHFnEkTe
=2VpG
-----END PGP SIGNATURE-----

--SGCXTcBLa7bQoiQja8Rw9KWrTlUHNj4BW--
