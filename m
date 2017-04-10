Received: from eggs.gnu.org ([2001:4830:134:3::10]:48955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxWTN-0003LG-On
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxWTK-0000Av-IG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:23:01 -0400
Date: Mon, 10 Apr 2017 11:22:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410102254.GA20072@stefanha-x1.localdomain>
References: <1491629987-6826-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1491629987-6826-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH] Removed trailing newline from
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 08, 2017 at 11:09:47AM +0530, Ishani Chugh wrote:
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  target/arm/kvm64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch!

I have CCed Peter Maydell who maintains this source file.  I also added
the trivial patches mailing list - a patch queue for small patches.

Conventially QEMU commit messages are written like this:

  target-arm: remove trailing newline from error_report()

The "target-arm:" prefix names the subsystem that is affected.  It makes
it easier for maintainer or people searching through patches to find
relevant results.

The commit message is written in the present imperative - "remove X"
instead of "removed X".

You do not need to resend the patch.  The maintainer can fix up the
commit message if they like.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61z+AAoJEJykq7OBq3PIMycH/0W7MSXkoBWJeDMP5S1PU6Yz
cPU+eMtUdfaTCbyVSa7A0jePO12x5q1htYZYE0DzxnfQQrKcD90WWuvQFLbP9tc2
/ja1O8h3WPUbLdq6gxCwMy6Uu7qTQ2B9IsSNZkAJQvFdgXyFMd8W8Q+y5oEJBpd8
WKSJfOKtuTR4uwC9OOUyux+O1J7VcJ38ycEwjgtosdMwhH8CEPvKiyF2m6wPIDCs
eXO11YLaV7RPPhCssBQDY954eyBBjPhyj1mL1P5+fYtG6BiU/4ULPrj/WFGXvLyS
KqwnC4XAxkrxhmeLJNT28tzgMk3LkYO2pyYJS/uK1hZOcs5lzWF1UjJYKAVn9U4=
=BhTu
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
