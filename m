Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXn5-0000Kl-3C
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXn4-0007hK-65
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXn3-0007gj-Tx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:54:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4E9A81247
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:54:53 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbcd1552-e116-aa38-a1c6-c83057503f93@redhat.com>
Date: Fri, 6 Jan 2017 10:54:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XNmAQcOHdnClv2qDq4bSBf9A8iVNrBVik"
Subject: Re: [Qemu-devel] [PATCH 03/20] char: add qemu_chr_fe_add_watch()
 Returns description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XNmAQcOHdnClv2qDq4bSBf9A8iVNrBVik
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <bbcd1552-e116-aa38-a1c6-c83057503f93@redhat.com>
Subject: Re: [PATCH 03/20] char: add qemu_chr_fe_add_watch() Returns
 description
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 0a149428cf..b6e361860a 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -258,6 +258,8 @@ void qemu_chr_fe_printf(CharBackend *be, const char=
 *fmt, ...)
>   * @cond the condition to poll for
>   * @func the function to call when the condition happens
>   * @user_data the opaque pointer to pass to @func
> + *
> + * Returns: the source tag
>   */
>  guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
>                              GIOFunc func, void *user_data);
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XNmAQcOHdnClv2qDq4bSBf9A8iVNrBVik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8vbAAoJEKeha0olJ0Nq/PEH/j9tGb9JMJGCQZO0T8aO0cWh
SN07ckdL37mPkV8S5MwzOJ5XVXCur+tpfbaf/y/4R6Nxadmc1FU/u2ZdwJIcygEO
KdTfpM0D5g/3jKR4qycv/7N/lQmYPRp0o0idqb7i61xPrpfa10kBgQsS4ShonB+Y
/8XL9tgitXgdK5veQcuSS1iF4CtmYTLy/m7ZALTlK3sC2xaSBODEJ/QDDsNNbZSz
BV5Q67ulF62v5c2QsfWCVPvztCL1ozmsgeGsmU97ZvjI6AMONvKwgBlewacCiwEZ
qwnUvHkk9Nj8YDUqFjB1GnvAV2ThqbB0iLM9XS5+XbGb6UV1Foc9MQASmKuDNlc=
=jMQo
-----END PGP SIGNATURE-----

--XNmAQcOHdnClv2qDq4bSBf9A8iVNrBVik--
