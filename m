Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuK75-00045M-PB
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cuK72-0006QE-M8
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cuK72-0006Oq-DT
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:34:44 -0400
References: <CA+KKJYCHT1kyH0Ha+kRrK_G12m8ip7dxNiQEG+7mou5MavZY=w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efefc59e-2cc7-281b-4829-35ca7e02e17c@redhat.com>
Date: Sat, 1 Apr 2017 09:34:39 -0500
MIME-Version: 1.0
In-Reply-To: <CA+KKJYCHT1kyH0Ha+kRrK_G12m8ip7dxNiQEG+7mou5MavZY=w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="teoXSmn0Ol5621vVrmD6wR3WgncE8rsFM"
Subject: Re: [Qemu-devel] [PATCH 01/43] acpi: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--teoXSmn0Ol5621vVrmD6wR3WgncE8rsFM
From: Eric Blake <eblake@redhat.com>
To: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, mst@redhat.com
Message-ID: <efefc59e-2cc7-281b-4829-35ca7e02e17c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/43] acpi: made printf always compile in
 debug output
References: <CA+KKJYCHT1kyH0Ha+kRrK_G12m8ip7dxNiQEG+7mou5MavZY=w@mail.gmail.com>
In-Reply-To: <CA+KKJYCHT1kyH0Ha+kRrK_G12m8ip7dxNiQEG+7mou5MavZY=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2017 08:32 AM, Danil Antonov wrote:
>>From 8127ae68568b3c6876a5ee58a74e5ef0439f548a Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 01:59:37 +0300
> Subject: [PATCH 01/43] acpi: made printf always compile in debug output=

>=20
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.

When sending a 43-patch series, PLEASE be sure to use a 0/43 cover
letter ('git config format.coverletter auto' makes this automatic for
'git send-email'), where all the other mails are in-reply-to the cover
letter.  Otherwise, you are spawning 43 separate top-level threads, and
it gets very hard to follow the series in any sane manner in mail
clients that sort by threading.

Most commit messages use imperative present tense ("do this") instead of
past tense ("did this"); so your subject line might be better as:

acpi: make printf always compile in debug output

> This will ensure that printf function will always compile even if debug=

> output is turned off and, in turn, will prevent bitrot of the format
> strings.
>=20
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> ---
>  hw/acpi/pcihp.c | 15 +++++++++------
>  hw/acpi/piix4.c | 16 +++++++++-------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>=20

>=20
> -#ifdef DEBUG
> -# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_AR=
GS__)
> -#else
> -# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
> -#endif
> +#ifndef DEBUG
> +#define DEBUG 0
> +#endif
> +
> +#define ACPI_PCIHP_DPRINTF(fmt, ...) do {     \
> +    if (DEBUG) {                              \
> +        fprintf(stderr, fmt, ## __VA_ARGS__); \

You are changing the debug output from stdout to stderr.  While this is
probably a good change, you did not mention it in your commit message as
intentional, so that would be worth adding to the commit message.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--teoXSmn0Ol5621vVrmD6wR3WgncE8rsFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY37p/AAoJEKeha0olJ0NqE8gH/1igl5aCHtDQAsXbCIjVKFIz
Cf1ESDkfJ/zsv/ZFKF2zk9l0w8geCuuDhBwFnZOHQg0eivdWLlox+xO1AGh9rhrP
H3sUVQYeiLtczGavPZP2QWg2JpdM8O1+HgR26Q5OuP24k2gAJ9si3TRNMM23Gjyq
YrBECFjODQ0srVoenToZLoT2Ka460ndhlBurzQC664Wc1cwl+Exswl9RLSerj+/p
sxyK/IEspKf5OUPMf6iZlw0o/H7mzKcuBzL5K1XoIbFWo4qR8suToLWBKCgyuFhz
I21z6SgMnUzejvDiTG9PnZW9MP84ykpR45IB5SJ0GiFOkxhzICBtThGu/V7Ye20=
=HvzJ
-----END PGP SIGNATURE-----

--teoXSmn0Ol5621vVrmD6wR3WgncE8rsFM--
