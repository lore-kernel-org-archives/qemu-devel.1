Received: from eggs.gnu.org ([2001:4830:134:3::10]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWQsV-0003CM-Ap
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWQsU-0001us-IR
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:06:03 -0500
Date: Mon, 10 Dec 2018 19:05:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181210190548.GB31743@stefanha-x1.localdomain>
References: <20181206101423.17344-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20181206101423.17344-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v2] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 11:14:23AM +0100, remy.noel@blade-group.com wrote:
> +        if (is_new) {
> +            new_node->pfd.fd = fd;
> +        } else {
> +            deleted = aio_remove_fd_handler(ctx, node);
> +            new_node->pfd = node->pfd;

Does this drop revents?  Imagine revents has bits set, then
aio_remove_fd_handler() will clear them and new_node->pfd = node->pfd is
too late to preserve them.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcDrkMAAoJEJykq7OBq3PItjMH/3fCz5fK8nkSaHlCFGa7jkSm
d1dJvT3hQlk1Cr/ErrroipfplD6BWNC5cFLPPKTBdI/DXrg8IHq+a4x5tQGPP+RV
qfuxe42B+MhOJ7X5fDrGReQnW+pmTaeUCvBI6JDKR61lntzynwUGc9rmK9ZRSll2
EhgLIistLR5+lo2BhD2CWWXzdjsyU01l+JmrhkNwvsTiIbG5vMe3n59H5aGI6et4
9bj7slubfUhFBVdX2sVxJUcZ1DA/Uq6OkKNQafIPHaNYR0w0P5xNq+Dc8Vqoxt+Z
FP51XQ5531h7RZ76G2uiE+j6ghWl2wlr3BsU9PeucdSkR9oTGIdYcjJ6NaG8kCw=
=fPAp
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
