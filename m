Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVnM-0001IX-Bg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEVnJ-0006xQ-79
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:10:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEVnI-0006wj-Rd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:10:20 -0400
Date: Fri, 4 May 2018 09:10:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180504081011.GB18897@stefanha-x1.localdomain>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-7-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <1525376963-79623-7-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/67] trace: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 10:50:28PM +0300, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  trace/control.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa7BVjAAoJEJykq7OBq3PIvAAIAICfs/NUfZnK57k7EBKWJ0Nf
ihmzSxZYZwT3l+HBmedKak8zlCQHjk5r82oXI7JvG/QmS7vhrt0lbChse+1jubYN
Pzw5iVf7jQZYStCFp/HcIcqt0rra//vICVQYeT3tySH4/1mR9rSwjXHlRiNZ47hN
sJ8k/MVI4C2VQKYouJ/blhGBmLvoBFwMsZUkWJudBW1kbszr0tTLfEsyaiZx+aCG
IYf7AXc4cQgX4J8g0YJ5DN0lmAkatWz6QwW9knhMfrfRzqm/FPdL+lDoZmzUvxHq
bum0UE126UeIKSDMezTH0v1PhdHn/KwWoQ7IJCRPEwKxbDio47EX4UZ9sS1ZsAY=
=Mv9e
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
