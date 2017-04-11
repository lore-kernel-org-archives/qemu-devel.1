Received: from eggs.gnu.org ([2001:4830:134:3::10]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxt4N-0006nr-7j
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxt4M-0003we-8U
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:30:43 -0400
Date: Tue, 11 Apr 2017 11:30:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411103031.GC17943@stefanha-x1.localdomain>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 02/10] block: Quiesce old aio
 context during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 11:05:34PM +0800, Fam Zheng wrote:
> The fact that the bs->aio_context is changing can confuse the dataplane
> iothread, because of the now fine granularity aio context lock.
> bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
> bs->aio_context is changing, we can just use aio_disable_external and
> bdrv_parent_drained_begin.
>=20
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7LBHAAoJEJykq7OBq3PIC3UH/j3SGvmUQ29+qzhezTKMpTcI
wafdt6zugVmZX7LDXjttkrE2fERqNHgsFnqk/ItlfBB6io8bnzR7bAc3+ngXOpGD
YWQcAh0JzuSY2NNyhvPENbllOvGlsM8Mj2anf5x5uHgYAsiDMwPpmUg1u24VgRj7
3BG+4YJAmPbA64yarAGt+qs5lhsJO8GDn9qRs3TlymL9Fw62RZPvLCWZL5JuJKtU
yGmcdcXKd+lKaq0pbamTdZPVxp9lwSQQZ23jwEpKX5lXJG7FMMlau9ZH2SCIOhzc
Cd6Hdw+r1lbADdf7/fiKLaBqfH8CkEoyBggtUH2tiwpiTLy2m83TgoHdOANone4=
=r9+g
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
