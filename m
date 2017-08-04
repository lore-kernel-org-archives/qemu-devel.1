Received: from eggs.gnu.org ([2001:4830:134:3::10]:39322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dde2F-0006vK-63
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dde2E-0008Lk-8u
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:57:07 -0400
References: <20170804144354.21985-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5af7c79e-130c-1010-e164-3989fd1c27fb@redhat.com>
Date: Fri, 4 Aug 2017 09:56:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170804144354.21985-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vGDWauchgaQc0EsWxLifuPJbTPL6MUXvp"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/null: Remove 'filename'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vGDWauchgaQc0EsWxLifuPJbTPL6MUXvp
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <5af7c79e-130c-1010-e164-3989fd1c27fb@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block/null: Remove 'filename' option
References: <20170804144354.21985-1-kwolf@redhat.com>
In-Reply-To: <20170804144354.21985-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 09:43 AM, Kevin Wolf wrote:
> This option was only added to allow 'null-co://' and 'null-aio://' as
> filenames, its value never served any actual purpose and was ignored.
> Nevertheless it was accepted as '-drive driver=3Dnull,filename=3Dfoo'.
>=20
> The correct way to enable the protocol prefixes (and that without addin=
g
> a useless -drive option) is implementing .bdrv_parse_filename. This is
> what this patch does.
>=20
> Technically, this is an incompatible change, but the null block driver
> is only used for benchmarking, testing and debugging, and an option
> without effect isn't likely to be used by anyone anyway, so no bad
> effects are to be expected.

Agreed with the analysis. Still, better to get it into 2.10 rather than
going yet another release with the option available.

>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/null.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vGDWauchgaQc0EsWxLifuPJbTPL6MUXvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEizoACgkQp6FrSiUn
Q2q8jwf/fXQXjFVePfpnl/vzIDFR5sBYyrjEn8ikNnxJZGFmyuhxOj1xujmigJ5a
80D67CnQJRn5yBISFG5cr4LvRsZIFYqI9YoRCRGMLB1t5d86Ym1pItE9vdDVfjPM
s5GgY4DPQLz5wecxq1K6MLldMviPRCFaRmU/7/D0Gvr+7nYOC2FAw5McdEL8ldFG
VXarUT/DtATp8HwGGVls9aWxnlKUq0fS3EvQ8XQc5GyLdVV9EB7RREQbUBpphmX8
GXuxDJ5eTLbEKine9FKokvnmikKpVE9PoGkcqM8K2mEbdlc0JkzBZuMmixfSQh9F
rTaXl2ZSP9J7cpNgqK9Nr+lYGgh83w==
=ZEbX
-----END PGP SIGNATURE-----

--vGDWauchgaQc0EsWxLifuPJbTPL6MUXvp--
