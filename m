Received: from eggs.gnu.org ([2001:4830:134:3::10]:38147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dah5D-0006UC-K5
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dah5C-0004vb-IH
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:35:59 -0400
References: <1501150174-19431-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d4584a14-ff65-b10e-03bf-417235065e9f@redhat.com>
Date: Thu, 27 Jul 2017 06:35:55 -0500
MIME-Version: 1.0
In-Reply-To: <1501150174-19431-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6TuasVrtnB22bbDeHU3rK7WS0CgJaj5Ac"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Improve the NetBSD regex
 pattern
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6TuasVrtnB22bbDeHU3rK7WS0CgJaj5Ac
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <d4584a14-ff65-b10e-03bf-417235065e9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Improve the NetBSD regex
 pattern
References: <1501150174-19431-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1501150174-19431-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 05:09 AM, Thomas Huth wrote:
> Currently get_maintainers.pl claims that the configure script is
> maintained by Kamil:
>=20
>  $ scripts/get_maintainer.pl -f configure
>  Kamil Rytarowski <kamil@netbsd.org> (maintainer:NETBSD)
>  qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> This happens because the regex pattern for the NETBSD entry triggers
> on everything that contains the keyword "NetBSD". Ease the situation
> a little bit by restricting this to "Subject:" lines only, like
> we do it in the "trivial patches" section already.
>=20
> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6TuasVrtnB22bbDeHU3rK7WS0CgJaj5Ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll50BsACgkQp6FrSiUn
Q2qqJAf9FS2sI0TSPaGTrd60ak2KGGiA3sbdOm01Cjgbc1kXJOWZt5ZU89J+0N40
wZTSpX62m7iDZion6ijpMQokKulQYg9p/324GtQPF116k7gorY/BksWv69j7EDAT
lnK8+TXg9GgnbiCBpvduZtITe8k2elW4RKq86qPdsvMPK+ryLmKTeeQ+oztxOZna
FUM5y+XQ4Zm5OgspRh3NjAxvNvKjStxTUnMNDnmu3yEqJkdcl6agd8PqdiF+FHmQ
uXSIyimHnQHADrS0gQXOuy4Uxzy2mRMy3PE7SL1790Z8MNdcG1YdV+vOx9bZ13Hx
or1+Kw1JBeUR0k0wgudJnkeLye5WiQ==
=DVq4
-----END PGP SIGNATURE-----

--6TuasVrtnB22bbDeHU3rK7WS0CgJaj5Ac--
