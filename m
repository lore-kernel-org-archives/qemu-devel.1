Received: from eggs.gnu.org ([2001:4830:134:3::10]:35043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcZyc-0002Xy-28
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcZyb-0003kh-AS
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:24:58 -0400
Date: Tue, 1 Aug 2017 17:14:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170801161445.GE22017@stefanha-x1.localdomain>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20170731095443.28211-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2017 at 12:54:41PM +0300, Manos Pitsidianakis wrote:
> +static int throttle_configure_tgm(BlockDriverState *bs,
> +                                  ThrottleGroupMember *tgm,
> +                                  QDict *options, Error **errp)
> +{
> +    int ret;
> +    ThrottleConfig cfg;
> +    const char *group_name = NULL;
> +    Error *local_err = NULL;
> +    QemuOpts *opts = qemu_opts_create(&throttle_opts, NULL, 0, &local_err);

If there is no scenario where this can fail please use error_abort.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgKj1AAoJEJykq7OBq3PIz5cIAIR/YO7UeAoE8keudFyvZ5vX
ey4NwZrFmG9+asGxe1pekcZhWItJ3EXq5APZtfUq5xLQgbQudnOoxDi7ZKDhhxgc
pieSXqokH/SbMNyD0Ez5ZcTXUYGAN4+m0cRVCR8+VuVosIJfZRdx63LeUCKopYqg
y60J6mSI+ozcfbX9H32xQCemzkn1zEvmA9rvRUXawgYTJUvA1kSkzv3ZGcpIsNIM
j6hl9FjibmoGLW48Ya6Lq0mSuKO4kDbv3v1lw99DGnWwrgNwKhV95LNqrbSNLwiA
f+6WYOhM0UXFYcaZPQxpnXEwVCs6Cn2HSyqYudS75KdoRTqe5Xj/P6HXu2JFqIU=
=cGvI
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
