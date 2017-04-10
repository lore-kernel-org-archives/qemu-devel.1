Received: from eggs.gnu.org ([2001:4830:134:3::10]:34683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVc8-0007kq-6K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVc7-0006qw-EL
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:28:00 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVc7-0006qW-89
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:27:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id u18so20351016wrc.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:27:59 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:27:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410092756.GG2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] blockjob: remove iostatus_reset
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:20PM +0100, Paolo Bonzini wrote:
> This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus",
> 2016-05-19).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 3 ---
>  include/block/blockjob_int.h | 3 ---
>  2 files changed, 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61AcAAoJEJykq7OBq3PIPtsH/3JZ/giSxPzYG4u+5YDSKhXF
ZvQWwxr3vNKuEwoCkPt2gMHr9+pPRKmwDxLRd72UoYe8Frt6+ZiLKvn+nIiQDCOW
cGJ5NF7tZTxd+U01CKfwwHEHv/dDH2V0t6HJr5lTt29Loh9bJGPTAQ+P4HpK7qXU
tTZxxODy/pmuU/10aQ8akeVv7jCwJ6RzhzZ7aMGtjPNNjt9Ss9HrsBv5j6AtCkac
UcnRn7Sgu9Zbbx97AJIbgeFRWuDVj7Q+zVWc8wHdwzotuKIx0Zsz5JD5XCSrF5jK
c22+o/0FjQ9x+Uhu43/VclJP8/D0Bouo0bkQuJqYG05V+dqQbR/9tj19dcbw82U=
=TeEr
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
