Received: from eggs.gnu.org ([2001:4830:134:3::10]:56771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVcmz-0006zI-4f
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVcmw-0004uq-0l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:27:57 -0500
Date: Mon, 23 Jan 2017 11:27:34 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123112734.GI29186@stefanha-x1.localdomain>
References: <20170120230359.4244-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poJSiGMzRSvrLGLs"
Content-Disposition: inline
In-Reply-To: <20170120230359.4244-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: fix block_set_io_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--poJSiGMzRSvrLGLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 05:03:59PM -0600, Eric Blake wrote:
> Commit 7a9877a made the 'device' parameter to BlockIOThrottle
> optional, favoring 'id' instead.  But it forgot to update the
> HMP usage to set has_device, which makes all attempts to change
> throttling via HMP fail with "Need exactly one of 'device' and 'id'"
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
>  hmp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--poJSiGMzRSvrLGLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYheimAAoJEJykq7OBq3PIqm4H/i8w9o0sDjhCHndjcp4CvlQK
No5r64EelOWT1nc4UPKBLDj4LY56bm3k5bqCWhCIMGujJIt3EXu+BG6uSmO3z2FM
CTXEJILh9C51skxhFsLddPl25WmqDeX7JK0ahST43M557DPijemt0VorhtGnL+54
/I1vqvfkwf42+G58zZFAcCeTMnX1llF56f+C9U8HFIMQY5paWuksKQYEu3Sb9NL/
0M8HK8wWqogDQr206B8JBSL2FseTg3Dmc+Ryxg83pjUSqTFGZZK1B9L0d6560qj6
k7H5o9Ro/DRqQD0neX5MKOOS45d4jQHyswZtu+nCWWr2dIfvEOxWgOvYzdzZjbg=
=KxLd
-----END PGP SIGNATURE-----

--poJSiGMzRSvrLGLs--
