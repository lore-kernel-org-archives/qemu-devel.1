Received: from eggs.gnu.org ([2001:4830:134:3::10]:58050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dagvS-0001aZ-0T
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dagvQ-0004Os-VP
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:25:54 -0400
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-5-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <517a5beb-b272-e114-3626-ba81be919a04@redhat.com>
Date: Thu, 27 Jul 2017 06:25:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-5-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NUQpvC4p68Vc82UwueII3bOcL2FXiIS5P"
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 04/20] nbd: fix memory leak in
 nbd_opt_go()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NUQpvC4p68Vc82UwueII3bOcL2FXiIS5P
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org
Message-ID: <517a5beb-b272-e114-3626-ba81be919a04@redhat.com>
Subject: Re: [PATCH for 2.10 v2 04/20] nbd: fix memory leak in nbd_opt_go()
References: <20170727024224.22900-1-f4bug@amsat.org>
 <20170727024224.22900-5-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 09:42 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> nbd/client.c:385:12: warning: Potential leak of memory pointed to by 'b=
uf'
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Thanks; queued on my NBD branch for rc1:
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NUQpvC4p68Vc82UwueII3bOcL2FXiIS5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5zbcACgkQp6FrSiUn
Q2pyRwgApuowZHXwntXwABVa0VQ8KbL4Xu2RM2lh0Fs49MW7V0s7JSveKh1x6ETi
e2fH+ELEN5QXeW1Q7RI130MvnYjHcBPFVfKXtnA1sb5TIDZ0an1zJdq3VqWq7/d8
/EQm9yJivnZOhFVJb6VwiOJiZfwoNgjrZFB6wqbALt1/4YccSVtu0Tk6jQ+b2s5S
3TUUXEp3r7/Vf81PBrhDJ9vnLpFB4bgN+V77+SsngOQt4LgTX7Oap+wE8PiGEGv3
kekKltZ8eWNx+DkNBz911PsTxUGxj21udt/U6iP9EStzlXWbX9Cpd93jcro9qgoL
Hj+jl+vLT3SgIkSJSkt3cMCi+ZtHUw==
=Ms6W
-----END PGP SIGNATURE-----

--NUQpvC4p68Vc82UwueII3bOcL2FXiIS5P--
