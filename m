Received: from eggs.gnu.org ([2001:4830:134:3::10]:58677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sa4-0004pg-WE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7sZw-0002kM-Fr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:00:45 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-10-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0c4d068-3bc1-3611-df36-0f76b7717856@redhat.com>
Date: Mon, 8 May 2017 19:00:32 -0500
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-10-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AfEuGi6tvkB0KIo7Pd10DDoeMDpb3qlsX"
Subject: Re: [Qemu-devel] [PATCH 09/11] target/sparc: fix DEBUG_MMU
 DPRINTF() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AfEuGi6tvkB0KIo7Pd10DDoeMDpb3qlsX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Message-ID: <b0c4d068-3bc1-3611-df36-0f76b7717856@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/11] target/sparc: fix DEBUG_MMU DPRINTF()
 arguments
References: <20170508233918.9043-1-f4bug@amsat.org>
 <20170508233918.9043-10-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 06:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> invalid since 96df2bc99f9
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/sparc/ldst_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 57968d9143..aa83a49a88 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1631,7 +1631,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulo=
ng addr, target_ulong val,
> =20
>              if (oldreg !=3D env->immu.mmuregs[reg]) {
>                  DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> =
0x%016"
> -                            PRIx64 "\n", reg, oldreg, env->immuregs[re=
g]);
> +                            PRIx64 "\n", reg, oldreg, env->immu.mmureg=
s[reg]);

Please take this opportunity to fix the broken definitions of
DPRINTF_MMU() and friends so that they don't bit-rot when not defined.
There are plenty of other examples of re-writing broken #defines to
instead favor an if (0) { printf(...) } to benefit from -Wformat
checking even when the debugging is disabled.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AfEuGi6tvkB0KIo7Pd10DDoeMDpb3qlsX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEQagAAoJEKeha0olJ0NqnzAH/AsbLvyJh98voTASJGEyPJOu
4Nk3ZvPf1EVdorBumNLfGEas3jPmE1XKeIwfMWpoUyZVXLBovhlyG6XT20n8iKLs
A8/rJKGODK2ZSBaFCCOrAr0ptOg2EiJdqY1D3k7Q7uCnYWNx+ngZPdIVYkCXv+NR
1/L16FsvSGpzslRu7Z2FMfzjm7pOqU/HXQyEbbUv+Qv0qxX+7oUMT4TWJUdZZbeJ
hlMtIiQAbVBMqjOo3KH4qxUYKXyD+I6tfuch20qKx4fL5MfuBhD7XdHEPhbABtQc
gsszn0lpntPkFwfQ58a8h22oT6D8TvQPW/GdDfkM77YrRl8gxC/BtG/q05uAJTs=
=JWC1
-----END PGP SIGNATURE-----

--AfEuGi6tvkB0KIo7Pd10DDoeMDpb3qlsX--
