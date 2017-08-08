Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfApn-0003wQ-Aq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfApl-0000rm-WF
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:10:35 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23640b58-68ad-52f7-c004-64661f994f93@redhat.com>
Date: Tue, 8 Aug 2017 15:10:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Otdm2Ig1xm7IucM3tLJlFCQnfq0bw5csx"
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Otdm2Ig1xm7IucM3tLJlFCQnfq0bw5csx
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <23640b58-68ad-52f7-c004-64661f994f93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
References: <20170808183306.27474-1-jsnow@redhat.com>
 <20170808183306.27474-4-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 01:33 PM, John Snow wrote:
> To be used sparingly, but still interesting in the case of small
> firmwares designed to reproduce bugs in QEMU IDE.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 6235bdf..29848ff 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2251,6 +2251,8 @@ void ide_data_writew(void *opaque, uint32_t addr,=
 uint32_t val)
>      IDEState *s =3D idebus_active_if(bus);
>      uint8_t *p;
> =20
> +    trace_ide_data_writew(addr, val, bus, s);

Umm, where's the trace-events addition for this?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Otdm2Ig1xm7IucM3tLJlFCQnfq0bw5csx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKGq4ACgkQp6FrSiUn
Q2pdxAf/aY2nH5pl3OKiuRNgE+LdOgnSrJvlbOSEpcIBjg5+u+o2znnpjxOKdWCC
oteoxnqRlq9FwJ5eGnWVvzfTmlkEV0eMla14+ElkEf/Wmm23po5yBDXF7AG1Ysiz
2twRACRQCKC6/a21rmOijDqG4TsTFn1NaaRWGSxD21sdm91MtRcrjpl5gPvO4kMD
YLQV9Ei5CDTF3KhBn16IqVv2FQ753sQmMb/VX0DVI0g+VLBTBrEjtKHuPEMx98gG
v4Qejt8DD0eBOQVphEsfJZrasGm4psfGS6wCouK0Yx9gXuiph0hp+30teKLZlIz6
mc6rgimLeAeOrVEo7ImuH+tXQCjhyQ==
=IULw
-----END PGP SIGNATURE-----

--Otdm2Ig1xm7IucM3tLJlFCQnfq0bw5csx--
