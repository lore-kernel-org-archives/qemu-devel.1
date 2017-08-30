Received: from eggs.gnu.org ([2001:4830:134:3::10]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn91L-00037k-ER
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn91K-0003Uu-Gh
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:51:27 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<131d9e66f5046317565c7d17af65823ebebb4b50.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <541ece36-e015-22b9-7559-3e687717a0e9@redhat.com>
Date: Wed, 30 Aug 2017 14:51:18 -0500
MIME-Version: 1.0
In-Reply-To: <131d9e66f5046317565c7d17af65823ebebb4b50.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hi1Iik5StrqhVL7wNndF9hTsD0Q7scG5M"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hi1Iik5StrqhVL7wNndF9hTsD0Q7scG5M
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <541ece36-e015-22b9-7559-3e687717a0e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] block/curl: fix minor memory leaks
References: <cover.1504112061.git.jcody@redhat.com>
 <131d9e66f5046317565c7d17af65823ebebb4b50.1504112061.git.jcody@redhat.com>
In-Reply-To: <131d9e66f5046317565c7d17af65823ebebb4b50.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:57 AM, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/curl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20

> +++ b/block/curl.c
> @@ -857,6 +857,9 @@ out_noclean:
>      qemu_mutex_destroy(&s->mutex);
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);

Would it be any simpler to call curl_close(s) instead of open-coding it
here in this cleanup path?

> @@ -955,6 +958,9 @@ static void curl_close(BlockDriverState *bs)
> =20
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>  }

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hi1Iik5StrqhVL7wNndF9hTsD0Q7scG5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFzYACgkQp6FrSiUn
Q2olqgf/TECQ/hvywzjp70RbFfybNVdlOEhT47EwBols+qACHA3vNQnVzbHvOes+
Z7+WbzQg1QJZ1RMnl8kL3gSyTucRvu1UUBcEVAzNjmgfeJ6DGtgCk/10xTbje6lU
wVxjs6Wyz5xXzlh0gOtwB0EmjVBGne+2rS+/DAoQc4nRiJxkb4gVNqAt7wHFxH/s
cVol3IHAqx+oYNDsw2MIAeM6K8Ro9d2lQbHDvYQrU8XsLy+Q1YvDYGCI8Rpceq5C
0S9ho8SlFLRIPJFyGFdLRlkdVGaiwEo6tlfRXjh+4MyKErYwCZ0Bhdc2sJDpRqEV
IfbQQTSCp6UGi7igMMLhJKvxSD1OqQ==
=oTFt
-----END PGP SIGNATURE-----

--hi1Iik5StrqhVL7wNndF9hTsD0Q7scG5M--
