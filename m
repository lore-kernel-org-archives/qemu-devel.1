Received: from eggs.gnu.org ([209.51.188.92]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1ne-00080j-Nu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1h6-00062H-6i
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1h4-0005vN-Eg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:44 -0500
References: <20190122181822.1505-1-peter.maydell@linaro.org>
	<20190122181822.1505-3-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a92c1461-9cb4-eec1-1dd8-10309d2592d2@redhat.com>
Date: Tue, 22 Jan 2019 13:26:32 -0600
MIME-Version: 1.0
In-Reply-To: <20190122181822.1505-3-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ICCUluEzG4Ri8aoPM8ajCyiNiZpOWcHlY"
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Don't mark struct ipq or struct
 ipasfrag as packed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ICCUluEzG4Ri8aoPM8ajCyiNiZpOWcHlY
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 patches@linaro.org
Message-ID: <a92c1461-9cb4-eec1-1dd8-10309d2592d2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Don't mark struct ipq or struct
 ipasfrag as packed
References: <20190122181822.1505-1-peter.maydell@linaro.org>
 <20190122181822.1505-3-peter.maydell@linaro.org>
In-Reply-To: <20190122181822.1505-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 12:18 PM, Peter Maydell wrote:
> There is no reason to mark the struct ipq and struct ipasfrag as
> packed: they are naturally aligned anyway, and are not representing
> any on-the-wire packet format.  Indeed they vary in size depending on
> the size of pointers on the host system, because the 'struct qlink'
> members include 'void *' fields.
>=20
> Dropping the 'packed' annotation fixes clang -Waddress-of-packed-member=

> warnings and probably lets the compiler generate better code too.
>=20
> The only thing we do care about in the layout of the struct is
> that the frag_link matches up with the ipf_link of the struct
> ipasfrag, as documented in the comment on that struct; assert
> at build time that this is the case.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  slirp/ip.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ICCUluEzG4Ri8aoPM8ajCyiNiZpOWcHlY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHbmgACgkQp6FrSiUn
Q2q8Sgf8DTo9n+AKo/K9QiIVGC8nrIL+Rh4H+Bqq+xSzPXHdHVsIEncGOsdZcxiO
nHh62b6IqcBcIwRDeAPPqNAxSBnlxLcEN5FVJrRULzVXH4uPJwTfpN14ghYPWQMi
/j+z4wX11qc56v6MMZBQleGLqL1S3hxkMYyRtY0EisedCJ/O4M7JQqr4hcm9zKb4
khckqLjxh/FYUJXKfC/VIoDfEdAqpIAXWMILmldRYSFXkDW6qssXoJLdC2jzqztD
gHrU2703WF+vpN/DdBpFDTRd1z2hNynw1DDSS9ZPKZnFen+c5VHdjYjdiE9KIgjB
CG52OKwKXLLBc8EUlcgiKyv4mHzD+Q==
=kUsZ
-----END PGP SIGNATURE-----

--ICCUluEzG4Ri8aoPM8ajCyiNiZpOWcHlY--
