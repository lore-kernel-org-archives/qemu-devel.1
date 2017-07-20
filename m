Received: from eggs.gnu.org ([2001:4830:134:3::10]:38686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYFi9-0000df-4d
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYFi6-0007ER-4J
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 13:58:05 -0400
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ba1a0e2-3e15-189c-b66f-2128dfb61bad@redhat.com>
Date: Thu, 20 Jul 2017 12:57:52 -0500
MIME-Version: 1.0
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fttReTR1AOKOwKGEuFOXNi635VXj50GTX"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fttReTR1AOKOwKGEuFOXNi635VXj50GTX
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <2ba1a0e2-3e15-189c-b66f-2128dfb61bad@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 11:31 AM, Peter Maydell wrote:
> On NetBSD, where tolower() and toupper() are implemented using an
> array lookup, the compiler warns if you pass a plain 'char'
> to these functions:
>=20
> gdbstub.c:914:13: warning: array subscript has type 'char'
>=20
> This reflects the fact that toupper() and tolower() give
> undefined behaviour if they are passed a value that isn't
> a valid 'unsigned char' or EOF.
>=20
> We have qemu_tolower() and qemu_toupper() to avoid this problem;
> use them.
>=20
> (The use in scsi-generic.c does not trigger the warning because
> it passes a uint8_t; we switch it anyway, for consistency.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fttReTR1AOKOwKGEuFOXNi635VXj50GTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw7yAACgkQp6FrSiUn
Q2oowgf/TqIbkjwW7kDuvJklojbmdlHqw3+CpZm0QPdatq7tlCSrh7H5e/QGbFUb
aL5Dp9vFOjywUbIR6qCC5nK/+85lB+dW8LEJP0Jl7OY6YhenKPYO+z0RS2e/tx6Z
ekeL+1KAgf5u0JVpvqh9MwyUh74JHb6ihK/gBfRRvVlOwnTSuq0keaCRO9N+DuP+
xH+b/MdWSpO3joLR0fvharTv0+/jQIb33oasHSd34MT8wdZPiezUzW+ecZx7TOfz
DcSCuxN6UhaZgyNejLWIrdKPLFZqMyCfNJr2QYN63NhVDoXHcU+6qHFrhsHlS9wy
CwVX6GOb6Er0WWuUJikybaNwzS0BOg==
=l3lX
-----END PGP SIGNATURE-----

--fttReTR1AOKOwKGEuFOXNi635VXj50GTX--
