Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbBJf-0006l9-KT
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbBJb-0003uu-Hz
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:52:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dbBJb-0003sq-84
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:52:51 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-48-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <319ee394-c1e2-894b-4f0c-980b1000587d@redhat.com>
Date: Fri, 28 Jul 2017 14:52:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-48-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OdNenUWp3dCGcIXRUDldLSRT74SGuIBdM"
Subject: Re: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OdNenUWp3dCGcIXRUDldLSRT74SGuIBdM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Message-ID: <319ee394-c1e2-894b-4f0c-980b1000587d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
References: <20170728053610.15770-1-f4bug@amsat.org>
 <20170728053610.15770-48-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-48-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 12:36 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/check_maintainer.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 scripts/check_maintainer.sh
>=20

> +echo "Incorrect MAINTAINERS paths:" 1>&2
> +egrep ^F: MAINTAINERS | cut -d\  -f2 | while read p; do
> +    ls -ld $p 1>/dev/null
> +done

Ah, you uses this in a cover letter of your other series, where I
responded without thinking it was going into git.  But now that I see we
are trying to commit it, I really think that one 'ls -l >/dev/null' per
filename is inefficient; this should be

egrep ^F: MAINTAINERS | cut -d\  -f2 | xargs ls -d >/dev/null

if we really like the side effect of ls writing to stdout as the way to
identify globs that no longer map anywhere, or even something like:

for glob in $(egrep ... | cut ...); do
    set - $glob
    if test -n "$2" && ! test -e "$1"; then
        echo "glob $glob no longer resolves" 2>&1
    fi
done

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OdNenUWp3dCGcIXRUDldLSRT74SGuIBdM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7lhAACgkQp6FrSiUn
Q2rteAf/crPN3PErlDBL4mF3CLN3LegrFUv54QCkY8F61rCZrbdeoaQKjsW/Tjml
f+9fcYuIoUBu9OLFgLecQ/fmZSTf4lz4Oy4+qys1yQglqsF6l47X6crsx2DROTmU
41x3TibNyr8oT/3+21Q7chWOg54UDimLqTYEH3BtKxsh8Ins4tNYB7AN5CnX7X4y
/6WTE6RznxTuCUYbrLapguZjJnwE2xQlS8wZ0uoDsDhcILQCvQobcQrEgchCVKPw
PBX0K23HW4n9n6rE+UtLlwkz2HHbo2mzSXVc6m8hQ4h0qV0pNwCiGGiW/rCIgV10
KRlkBcrPy6AyYNu2hlUilSecErVazA==
=BrRI
-----END PGP SIGNATURE-----

--OdNenUWp3dCGcIXRUDldLSRT74SGuIBdM--
