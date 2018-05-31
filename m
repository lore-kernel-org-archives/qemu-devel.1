Received: from eggs.gnu.org ([2001:4830:134:3::10]:44244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOMnu-00044q-IS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOMnp-0002v6-LW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:35:42 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOMnp-0002uC-DN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 08:35:37 -0400
Received: by mail-wr0-x22b.google.com with SMTP id i14-v6so32841948wre.2
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 05:35:37 -0700 (PDT)
Date: Thu, 31 May 2018 13:35:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180531123534.GH27838@stefanha-x1.localdomain>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-3-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <1525918138-6189-3-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 2/9 V5] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 10:08:51AM +0800, junyan.he@gmx.com wrote:
> diff --git a/exec.c b/exec.c
> index fa33c29..dedeb4d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -52,6 +52,9 @@
>  #include <linux/falloc.h>
>  #endif
> =20
> +/* RAM is backed by the persistent memory. */
> +#define RAM_PMEM       (1 << 3)

Please define this next to the other RAM_* flags.

Besides that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD+wWAAoJEJykq7OBq3PInLwH/1TIy91skNi3pugCrclrI1ed
pdcx44839g5RHP0wpZw4kNPv4tJRCMO15cqmd3y33hckbyBSHEIZn+7pua5UIGOF
1n+b864oEJWMo6eST35AwGeUKqiCENbcfvfnzuz8wC5uXn6jsgI9aYm/qaWGado8
02FCG7bTOjzeOB23jf/PsJGWdiNLKfxJY4xJ6ysoMWa+Ks4oT/IReilysk1ZZVxd
7gn0i97097eUzE4enlcyy6xEVZsVh5myRPvmj7BMA/ITas9d08ubLHUf1plJQnWD
QRkEQgb/Ko0PQlItrnq+d3wKMBX1A7WpsBFd/eUiBv9cGOAjC7l5l5Ne8kIoMKQ=
=sbT1
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
