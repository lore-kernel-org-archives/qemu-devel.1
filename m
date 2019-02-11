Received: from eggs.gnu.org ([209.51.188.92]:59914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJ2E-0007nz-Nz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtJ2D-0005hc-Et
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 16:22:38 -0500
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
	<20190211125601.86533-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b322a5f-147a-fe4b-e77a-08e57e535e1a@redhat.com>
Date: Mon, 11 Feb 2019 15:22:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190211125601.86533-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iDAW7LXURIrMDEkR4VYh9oYGU2UXp2CKh"
Subject: Re: [Qemu-devel] [PATCH 1/4] io/channel: add
 qio_channel_get_attached_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDAW7LXURIrMDEkR4VYh9oYGU2UXp2CKh
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <1b322a5f-147a-fe4b-e77a-08e57e535e1a@redhat.com>
Subject: Re: [PATCH 1/4] io/channel: add
 qio_channel_get_attached_aio_context()
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
 <20190211125601.86533-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 6:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> Expose attached aio context. It will be used in nbd code, to
> understand, in which aio context negotiation should be done.

s/, in/ in/

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/io/channel.h | 9 +++++++++
>  io/channel.c         | 5 +++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/include/io/channel.h b/include/io/channel.h
> index da2f138200..1a1e4a01b0 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -718,6 +718,15 @@ GSource *qio_channel_add_watch_source(QIOChannel *=
ioc,
>  void qio_channel_attach_aio_context(QIOChannel *ioc,
>                                      AioContext *ctx);
> =20
> +/*
> + * qio_channel_get_aio_context

Mismatch between comments...

> + * @ioc: the channel object
> + *
> + * Returns channel AioContext if any attached by
> + * qio_channel_attach_aio_context(), otherwise NULL.
> + */
> +AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc);

and function name.

Otherwise, looks straightforward, but I'd rather get Daniel's opinion on
whether we need it or if something else is better.

> +AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc)
> +{
> +    return ioc->ctx;
> +}
> +
>  void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>                                      GIOCondition condition)
>  {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iDAW7LXURIrMDEkR4VYh9oYGU2UXp2CKh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxh55cACgkQp6FrSiUn
Q2rJxwf+KCkig8fWQwx0hrZmtMTm2D8h/weYTWt9VZxS/0wJWsAAEcdGDVdTrea8
MDGMoSPI7VvKb2cb9DfHPQGcMA4Qcj9pcKM0XE3ojwerOK4TW6srbGvBLsbs7EaT
A2D8Ih9ydJ9K66lHCDpZ+2esp2e3yb/nZh4GlJbIHJhuP+U2R1tqggid1JJIgSP3
W0UV6sUzJhMcP3mNcRn9TuTRNaGt1sec3qDkixSLipRRe9DwlJxqT4jMAqUSUiLs
/mgAFVn+dMuZ3Sibgw93rOnp1QW/Qct9VCODI1m3PjKXYCRCez9RpkBOczkNO7XI
1UeN6klCwi5pSYB32xHafYZpJfxDOQ==
=Ubn4
-----END PGP SIGNATURE-----

--iDAW7LXURIrMDEkR4VYh9oYGU2UXp2CKh--
