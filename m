Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpkU-00081N-D8
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpkR-0006Ao-Ai
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dPpkR-0006AM-3y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:37:39 -0400
Date: Tue, 27 Jun 2017 13:37:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627123736.GD8555@stefanha-x1.localdomain>
References: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 03:28:00PM +0100, Peter Maydell wrote:
> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
> about the return value was changed to no longer use it. Drop the
> now-useless return value and make the function return void.
>=20
> We avoid the awkwardness of ifdeffery to handle the 'ret'
> variable in main_loop_wait() only being wanted if CONFIG_SLIRP
> by simply dropping all the ifdefs. There are stub implementations
> of slirp_pollfds_poll() and slirp_pollfds_fill() already in
> stubs/slirp.c which do nothing, as required.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This will coincidentally satisfy Coverity, which currently complains
> in CID 1372464 that we call main_loop_wait() in vl.c and ignore the
> return value which may be reporting a poll() syscall failure.
> Essentially we don't expect poll() to fail, except perhaps with
> a transient EINTR -- if it ever did we'd spin retrying endlessly
> I think.
> ---
>  include/qemu/main-loop.h | 2 +-
>  util/main-loop.c         | 8 ++------
>  2 files changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUlGQAAoJEJykq7OBq3PIzxwH/1kNsW9ssqdieWLxWWwCIWAZ
WG+ukPAgpvXjhwT5gY0UIgvNDSU+t1E3nksSSd3BSvzORcMr5kb8pCy6oxrYVuNf
3VQRF4SoDeygW3zLtzk3fn780BlU9nlMby0vssMf067y4qBKRN5nLTWw8EpyT3ni
o3p+b6RxieJjC+0krdqLbmuoqXNzmv+GCIyJrzXY+LR+oNzCC5R0TXFxRCzd/yFr
8X92K1bId5/nT6NYHG1yi75ZKAzOm6mlgPA0NscSjYe1aK21MoeWXhDKHBg7+o/f
bT7XOpvaBxVpWl8Gj0Tpq2q8gOKmpynr2xltsBcBYwe3Gx9DJYMHFz6SfjEFIy8=
=2a2x
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
