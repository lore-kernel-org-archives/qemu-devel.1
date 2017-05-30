Received: from eggs.gnu.org ([2001:4830:134:3::10]:43856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFha3-0000De-1L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFhZz-0005Nw-UV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:53:03 -0400
Date: Tue, 30 May 2017 14:52:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530135256.GA3592@stefanha-x1.localdomain>
References: <20170522135704.842-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20170522135704.842-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] block: fix 'savevm'
 hang with -object iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 02:57:00PM +0100, Stefan Hajnoczi wrote:
> v3:
>  * Add missing bdrv_drain_all_end() in error code paths [Kevin]
> v2:
>  * New patch to use bdrv_drain_all_begin/end() in savevm/loadvm [Kevin]
>    (All other patches unchanged)
>=20
> The 'savevm' command hangs when -object iothread is used.  See patches for
> details, but basically the vmstate read/write code didn't conform to the =
latest
> block layer locking rules.
>=20
> Stefan Hajnoczi (4):
>   block: count bdrv_co_rw_vmstate() requests
>   block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
>   migration: avoid recursive AioContext locking in save_vmstate()
>   migration: use bdrv_drain_all_begin/end() instead bdrv_drain_all()
>=20
>  block/io.c         | 21 +++++++++++++--------
>  migration/savevm.c | 30 ++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 12 deletions(-)

Ping

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLXk4AAoJEJykq7OBq3PInosH/3QyfLNR+w2soik6E3xALmtj
zAWcOt7kXXjmW8pS5F1OiXco2QFqENb45OzrodtBBIH3zPBuyo5TYfVEUaYy2oiW
QPFm48t4K+Jtbdv8DvnZlcHUO85NpNyeeU/9YXdQM3KBREMn4783tvJf27iDZ5iP
AB8vKB8p4OAMHfNNA8nt+nu0JSvJr0FspoHLr/kL7a2trY5z8gMmbLS+IEGHYTUH
5lswRaJo55axi44SgSAPQFlFI9OHLO61QL/1L/njAYMP109ompf29gMkYLRJnxR/
veux8LLBnw0C61sEmwkWsqbjYb05hXHCPLXmrTPvvJCqoYJPUdrp/62hQAg0yCg=
=MH/1
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
