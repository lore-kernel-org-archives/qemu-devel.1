Received: from eggs.gnu.org ([2001:4830:134:3::10]:45412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTRQk-0003Ax-73
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTRQh-0003al-4D
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:55:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTRQg-0003aL-TN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:55:55 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so21138955wmd.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 02:55:54 -0800 (PST)
Date: Tue, 17 Jan 2017 10:55:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170117105550.GF4265@stefanha-x1.localdomain>
References: <1484621964-187372-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <1484621964-187372-1-git-send-email-longpeng2@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] qtest: virtio: zeroed last vring_desc
 after allocate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: stefanha@redhat.com, lvivier@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, groug@kaod.org, arei.gonglei@huawei.com, qemu-devel@nongnu.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 10:59:24AM +0800, Longpeng(Mike) wrote:
> As qvring_indirect_desc_setup() wouldn't initialize last vring_desc,
> so it's filled with dirty data, this might cause virtio backend broken.
>=20
> For example, the last bit of this vring_desc's flags might be 1, so
> virtqueue_read_next_desc() would report "Desc next is ***".
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>=20
> ---
> Changes since v1:
>     - use writel() for @len as it's 32 bits long. [Stefan]
>=20
> ---
>  tests/libqos/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYffg2AAoJEJykq7OBq3PISL4IAImFjU46J1bNZ2gkIXJE5Yrq
Nxz2MbPyZ1ShzhgZT9caXLBglzA70kjwKwW9l7uVtdP/iCSnupI8hha8TjJ0LOf6
JcLavBFKDHacKktAHXQ9FiOMUoIaAuMF2XHAyskfzQUeNc6dL0QK3vC9Lfgd8ARH
HFlUIagT9Bls3I1kpXy0pMwxEQGw1XAaxwcOhriCMo5fuLley2ffY7voexzAbRNE
ZwYUKYdXVXfm8ZXIDBP6MKeJdMqHTZBkH6rSAg3wRyl7xxbcTMSeB8ZnVH2uP9S5
JtAGI9WQY5vbQhnJ/u+9OIjo3JhK8XahLG1ps6M/orVm1QS2YJmk0jyVj6pip9s=
=l8w8
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
