Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCE0M-0001ZN-3m
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 19:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCE0L-0005fl-5Z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 19:14:06 -0500
References: <cover.1510093478.git.jcody@redhat.com>
	<facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <494bb3c2-03c9-20b1-6214-be004ad846e6@redhat.com>
Date: Tue, 7 Nov 2017 18:13:57 -0600
MIME-Version: 1.0
In-Reply-To: <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ibMdeltUOMMn0AKxsbTtXFmxEtsWiBRC6"
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibMdeltUOMMn0AKxsbTtXFmxEtsWiBRC6
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com
Message-ID: <494bb3c2-03c9-20b1-6214-be004ad846e6@redhat.com>
Subject: Re: [PATCH v3 6/7] block/curl: fix minor memory leaks
References: <cover.1510093478.git.jcody@redhat.com>
 <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
In-Reply-To: <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 04:27 PM, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/curl.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/curl.c b/block/curl.c
> index 00a9879..35cf417 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -857,6 +857,9 @@ out_noclean:
>      qemu_mutex_destroy(&s->mutex);
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>      qemu_opts_del(opts);
>      return -EINVAL;
>  }
> @@ -955,6 +958,9 @@ static void curl_close(BlockDriverState *bs)
> =20
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>  }
> =20
>  static int64_t curl_getlength(BlockDriverState *bs)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ibMdeltUOMMn0AKxsbTtXFmxEtsWiBRC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCTEUACgkQp6FrSiUn
Q2qNHQf+P4WR7tV3kzbABbO7HkxLMxfxI+ev3bjTIKrY0UxMQxVZYT4DzaBEilc8
+HS6kn8OJsMWhGCumiVZQrhf1icYuJKxQqZOf29OD7XrWM9y7DaNWas2MYsb5Brk
D0wHCWZWdzyUBAbm6jFlw1o6zA2wuilNnjcmOKWzqqlfDdjjKf95UCRBbOlMdw2d
8nNVyOIb6qTzpz8YTDhVkx758+vSRnQspEcsLpy8S39k6Ru9BbyxsLRixOqEcr5t
uy7taRenHZR3qs0QWdZeTehKmFz17TKGjp97mG/ekT7yDRSawf3OkT5T9N8U/W/D
JITBQzyCf79VTtsepvaYgK/a4vv8IA==
=Ks60
-----END PGP SIGNATURE-----

--ibMdeltUOMMn0AKxsbTtXFmxEtsWiBRC6--
