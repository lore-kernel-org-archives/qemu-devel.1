Received: from eggs.gnu.org ([2001:4830:134:3::10]:34951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUwQh-0003xH-Vy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUwQh-0008Mq-00
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:50:56 -0400
Date: Mon, 18 Jun 2018 16:50:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180618155045.GB9785@stefanha-x1.localdomain>
References: <1528759585-51780-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <1528759585-51780-1-git-send-email-wangjie88@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] util/async: avoid NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, eblake@redhat.com, eric.fangyi@huawei.com, wu.wubin@huawei.com


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 07:26:25AM +0800, Jie Wang wrote:
> if laio_init create linux_aio failed and return NULL, NULL pointer
> dereference will occur when laio_attach_aio_context dereference
> linux_aio in aio_get_linux_aio. Let's avoid it and report error.
>=20
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  block/file-posix.c | 19 +++++++++++++++++--
>  util/async.c       |  5 ++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)

If someone wants to split aio_get_linux_aio() into an initialization
function and a "get" function which doesn't return NULL if init
succeeded, then we can make this a bit cleaner.  But it doesn't matter
at the moment since there are few callers and duplicating the NULL check
isn't too bad.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbJ9TVAAoJEJykq7OBq3PIghgH/iQSZUVZbALYALiAhC7sf1ET
dCErzKxOTKHaDv1cwQpCXvPZetiQV68HzF9Xolp2XEc9XrHEAfF6abg5v30Sgx2W
Ktz1pgl8aP1e/cK475Vc9gZ5QuZRKGWLIzJvzMlIyZJjbn+l/uydin/m8s/q12w3
lCGsS2wqhFs5yg5UJLMViwB5Px1yvnGPPiHaUInupdfHOILOrDtwV7kOeDeU+SWv
/QswKnukayoARlb569aH7ZYYvezzeRmgxmBYPWCnRYgAnHAsaVraR9BXvC3u6/At
g1nlfEwZFbdodd9RHltSIcrXeWlJxXDpEEtQa88//ioea+gg8gDmguEe5lEKwwA=
=CvwY
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
