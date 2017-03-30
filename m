Received: from eggs.gnu.org ([2001:4830:134:3::10]:34020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctcee-0007fN-Fz
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctcea-0005FM-GS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ctcea-0005Dx-7f
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:10:28 -0400
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
	<1482502027-5544-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0c03a26-78d1-3a3e-bbc3-705c7f5d503a@redhat.com>
Date: Thu, 30 Mar 2017 11:10:25 -0500
MIME-Version: 1.0
In-Reply-To: <1482502027-5544-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5A3kko7lGnLlRuBURf1hKbvPn9lB4F40M"
Subject: Re: [Qemu-devel] [PATCH for-2.9? v3] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5A3kko7lGnLlRuBURf1hKbvPn9lB4F40M
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>,
 qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Message-ID: <e0c03a26-78d1-3a3e-bbc3-705c7f5d503a@redhat.com>
Subject: Re: [PATCH for-2.9? v3] ipmi: Fix macro issues
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
 <1482502027-5544-1-git-send-email-minyard@acm.org>
In-Reply-To: <1482502027-5544-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping - did this ever get applied?

On 12/23/2016 08:07 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Macro parameters should almost always have () around them when used.
> llvm reported an error on this.
>=20
> Remove redundant parenthesis and put parenthesis around the entire
> macros with assignments in case they are used in an expression.
>=20
> Remove some unused macros.
>=20
> Reported in https://bugs.launchpad.net/bugs/1651167
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>=20
> Changed in v3:
>   * Add Eric's reviewed-by.  Thanks!
>=20
> Changes in v2:
>   * Put parenthesis around macros that had assignment in them.
>   * Removed some redundant parenthesis.
>   * Removed some macros that were not used.
>=20
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index f036617..68bf5cd 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -37,40 +37,30 @@
>  #define IPMI_BT_HBUSY_BIT          6
>  #define IPMI_BT_BBUSY_BIT          7
> =20
> -#define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
>  #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)=

> -#define IPMI_BT_SET_CLR_WR(d, v)   (d) =3D (((d) & ~IPMI_BT_CLR_WR_MAS=
K) | \
> -                                       (((v & 1) << IPMI_BT_CLR_WR_BIT=
)))
> =20
> -#define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
>  #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)=

> -#define IPMI_BT_SET_CLR_RD(d, v)   (d) =3D (((d) & ~IPMI_BT_CLR_RD_MAS=
K) | \
> -                                       (((v & 1) << IPMI_BT_CLR_RD_BIT=
)))
> =20
> -#define IPMI_BT_H2B_ATN_MASK       (1 << IPMI_BT_H2B_ATN_BIT)
>  #define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1=
)
> -#define IPMI_BT_SET_H2B_ATN(d, v)  (d) =3D (((d) & ~IPMI_BT_H2B_ATN_MA=
SK) | \
> -                                        (((v & 1) << IPMI_BT_H2B_ATN_B=
IT)))
> =20
>  #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
>  #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1=
)
> -#define IPMI_BT_SET_B2H_ATN(d, v)  (d) =3D (((d) & ~IPMI_BT_B2H_ATN_MA=
SK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_ATN_B=
IT)))
> +#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_B2H_ATN_M=
ASK) | \
> +                                        (((v) & 1) << IPMI_BT_B2H_ATN_=
BIT)))
> =20
>  #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
>  #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1=
)
> -#define IPMI_BT_SET_SMS_ATN(d, v)  (d) =3D (((d) & ~IPMI_BT_SMS_ATN_MA=
SK) | \
> -                                        (((v & 1) << IPMI_BT_SMS_ATN_B=
IT)))
> +#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_SMS_ATN_M=
ASK) | \
> +                                        (((v) & 1) << IPMI_BT_SMS_ATN_=
BIT)))
> =20
>  #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
>  #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
> -#define IPMI_BT_SET_HBUSY(d, v)    (d) =3D (((d) & ~IPMI_BT_HBUSY_MASK=
) | \
> -                                       (((v & 1) << IPMI_BT_HBUSY_BIT)=
))
> +#define IPMI_BT_SET_HBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_HBUSY_MAS=
K) | \
> +                                       (((v) & 1) << IPMI_BT_HBUSY_BIT=
)))
> =20
>  #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
> -#define IPMI_BT_GET_BBUSY(d)       (((d) >> IPMI_BT_BBUSY_BIT) & 0x1)
> -#define IPMI_BT_SET_BBUSY(d, v)    (d) =3D (((d) & ~IPMI_BT_BBUSY_MASK=
) | \
> -                                       (((v & 1) << IPMI_BT_BBUSY_BIT)=
))
> +#define IPMI_BT_SET_BBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_BBUSY_MAS=
K) | \
> +                                       (((v) & 1) << IPMI_BT_BBUSY_BIT=
)))
> =20
> =20
>  /* Mask register */
> @@ -79,13 +69,13 @@
> =20
>  #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
>  #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) =
& 0x1)
> -#define IPMI_BT_SET_B2H_IRQ_EN(d, v) (d) =3D (((d) & ~IPMI_BT_B2H_IRQ_=
EN_MASK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_IRQ_E=
N_BIT)))
> +#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_EN_MASK) |\
> +                                        (((v) & 1) << IPMI_BT_B2H_IRQ_=
EN_BIT)))
> =20
>  #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
>  #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0=
x1)
> -#define IPMI_BT_SET_B2H_IRQ(d, v)    (d) =3D (((d) & ~IPMI_BT_B2H_IRQ_=
MASK) | \
> -                                        (((v & 1) << IPMI_BT_B2H_IRQ_B=
IT)))
> +#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_MASK) | \
> +                                        (((v) & 1) << IPMI_BT_B2H_IRQ_=
BIT)))
> =20
>  typedef struct IPMIBT {
>      IPMIBmc *bmc;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5A3kko7lGnLlRuBURf1hKbvPn9lB4F40M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3S3xAAoJEKeha0olJ0NqFqEH+QESsUB58BbMDq1ilTQyltQc
kFZUEo7MYewxuhAoeMqvleIRRvYNk5wr4mGSKeb7uFkEQ/WXqSspT8Sv34zdkeIN
Xbo9uJqf2GhcFXDGezqRXOzmRu9/rhuHEmV8ybGMscyjdic81E9TMoat1LYNQ9FK
sg/HCCVNZD6f6sazZNbxJ13URbvWCkCHlUJAOgCSfDFU8OVFI3i5ytztOzF/sC1D
i203l4fcVcTEbUIDEcGTsxEfyARvJr8yJ0d5sl9aBzgzttOxEzb9kWqHE4F92C7P
biWlXUhzt/ChtTtxjVdD5kEORfUvKleOkprsLeSwt2SOaQgsjj3FgwDk89904jw=
=Jkt6
-----END PGP SIGNATURE-----

--5A3kko7lGnLlRuBURf1hKbvPn9lB4F40M--
