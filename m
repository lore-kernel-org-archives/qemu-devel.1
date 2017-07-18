Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaKV-0002TK-IY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXaKS-0002AM-Fs
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXaKS-00029u-78
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:46:52 -0400
References: <20170718045540.16322-1-f4bug@amsat.org>
	<20170718045540.16322-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dee35ac6-a0b1-cf91-3b73-17655d655a93@redhat.com>
Date: Tue, 18 Jul 2017 16:46:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170718045540.16322-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9QrS0Kt7P4CuxQ1IQwDuXlVBqbkxF6AwU"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] coccinelle: ignore ASTs
 pre-parsed cached C files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9QrS0Kt7P4CuxQ1IQwDuXlVBqbkxF6AwU
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <dee35ac6-a0b1-cf91-3b73-17655d655a93@redhat.com>
Subject: Re: [PATCH v5 01/10] coccinelle: ignore ASTs pre-parsed cached C
 files
References: <20170718045540.16322-1-f4bug@amsat.org>
 <20170718045540.16322-2-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 11:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> files generated using coccinelle tool: 'spatch --use-cache'
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/.gitignore b/.gitignore
> index 09c2363acf..cf65316863 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -116,6 +116,8 @@ tags
>  TAGS
>  docker-src.*
>  *~
> +*.ast_raw
> +*.depend_raw
>  trace.h
>  trace.c
>  trace-ust.h
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9QrS0Kt7P4CuxQ1IQwDuXlVBqbkxF6AwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllugcgACgkQp6FrSiUn
Q2pn4Qf+N9eKbnD4zcVAGtuQK7qlFoZnmAFnN6PJUkArCpPBsetmRNai8Y0zkINZ
h7nvzlIzkAtcelJK5kvYDnWMsSfev733empGyb1K+B02EoYFYYR1xf5kq/JUGB8j
Obt5vvoQzc8jPxgmuPtGdNe6YyCkpm8I1IEoV7LKwmgCP2mIwNSqZKP6jDzlaqrM
G27mKHzefy6hS1Ql0ZU3bAbp4tQoN20ur8L9JUIRKI6LHEd3VyrHqD/wFk7kyxxM
XdtG/zCqNnM5wQ2LcrMoViaW+jAocTZr4epjT4axYjQy5Grt/siMy//nlU/jiKoB
jVJuiVZmMZHsnA4wFx9OEQWlnOWvaw==
=IJMe
-----END PGP SIGNATURE-----

--9QrS0Kt7P4CuxQ1IQwDuXlVBqbkxF6AwU--
