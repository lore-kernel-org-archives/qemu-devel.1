Received: from eggs.gnu.org ([209.51.188.92]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTjd-0005Bh-JD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTjW-0001A6-J7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:23:49 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2beb54f-97f5-e38b-1edf-c59011841e68@redhat.com>
Date: Wed, 6 Feb 2019 14:23:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-5-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZBi7LrxGB397YQuFXk3ww5eCfBSpDz9An"
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZBi7LrxGB397YQuFXk3ww5eCfBSpDz9An
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f2beb54f-97f5-e38b-1edf-c59011841e68@redhat.com>
Subject: Re: [PATCH v3 4/8] qapi: Formalize qcow2 encryption probing
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-5-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:
> Currently, you can give no encryption format for a qcow2 file while
> still passing a key-secret.  That does not conform to the schema, so
> this patch changes the schema to allow it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 31 ++++++++++++++++++++++++++++---
>  block/qcow2.c        |  3 +++
>  2 files changed, 31 insertions(+), 3 deletions(-)
>=20

> @@ -2961,10 +2964,30 @@
>  # @BlockdevQcow2EncryptionFormat:
>  # @aes: AES-CBC with plain64 initialization venctors

We should fix that typo.

>  #
> +# @auto:            Determine the encryption format from the image
> +#                   header.  This only allows the use of the
> +#                   key-secret option.  (Since: 4.0)
> +#
>  # Since: 2.10

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZBi7LrxGB397YQuFXk3ww5eCfBSpDz9An
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbQj8ACgkQp6FrSiUn
Q2qHjgf/WK0+bZ7BOFcxPlW/GgH3dUMNcEhnUmnW2rUiCHtAHa99jx3E2VlVg8RG
48TD8bbZIMaQQ0uAc3A9KGV59LnThwCF3vCYl0Gm1mVVDVIdHKgvRZEZ/ByRsa6T
tyf/VlfS5e4YYEZS9mPh9/05YNuiDqbRFCWanxn72hk4h/Hg+Awl2Eye0oceGRfQ
jveWR9scAsg3fWcAgDgSC3x/aAKO0G7gKNf5UD0Jo+kuaRCt+bVqvkGHZ92VOXZu
rwXxRi7n0QV+nMh7UGHRl3YMYMoPmPff0H2Zgw3Gya0c+C0jTxhVOVBT4VYA2fMA
3Uua8f8cVFJgwSLgd33CckF9i+eDVQ==
=jWCN
-----END PGP SIGNATURE-----

--ZBi7LrxGB397YQuFXk3ww5eCfBSpDz9An--
