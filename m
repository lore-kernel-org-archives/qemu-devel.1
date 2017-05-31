Received: from eggs.gnu.org ([2001:4830:134:3::10]:59288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG30L-0004RO-IS
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG30K-0005w2-L2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:45:37 -0400
Date: Wed, 31 May 2017 13:45:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124529.GW16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-23-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ngiTnHdmUEG79yp6"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-23-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 22/29] qed: Add return value
 to qed_aio_read/write_data()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--ngiTnHdmUEG79yp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:03PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 72 ++++++++++++++++++++++++++-----------------------------=
------
>  block/qed.h | 21 ------------------
>  2 files changed, 31 insertions(+), 62 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ngiTnHdmUEG79yp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrrpAAoJEJykq7OBq3PIC0wH/iteKELT7tj3AzxETZ0wAG4Y
6RC98t5r0WoxAXL8Aw7K/YmvH0Jlr31Kdzrf+DIRSi+gexfXq27T1TmvHLip9T0s
heDYU8GPGOoJGP511AUDrgNoXic8J4o2eaMI+HjxxOj+6e2gz3Da4VJJ/9Kdeu8I
MvZaghum/oMq1Um/4M5FQDKzJnU8980ZsfCS8OehV33kF+ZRjI6KFbfggYoaXE5C
z5//+tbgHCqAgTfMpQDPvVWNeMJHM6uD/X7jCsgl5PUeX+aMk+TxemsE1n540CxC
UpjRto3ho4oov2PcReU+w95urVKqMLy6iziwqsVRtGdMunh8ujFxYKLXR897vNo=
=7bP0
-----END PGP SIGNATURE-----

--ngiTnHdmUEG79yp6--
