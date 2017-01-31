Received: from eggs.gnu.org ([2001:4830:134:3::10]:57108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbwG-0003Ew-1d
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYbwC-0000Dp-1W
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:09:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYbwB-0000DS-RZ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:09:47 -0500
Date: Tue, 31 Jan 2017 17:09:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131170944.GA25011@stefanha-x1.localdomain>
References: <20170126170119.27876-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20170126170119.27876-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iothread: enable AioContext polling by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Karl Rister <krister@redhat.com>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 05:01:19PM +0000, Stefan Hajnoczi wrote:
> IOThread AioContexts are likely to consist only of event sources like
> virtqueue ioeventfds and LinuxAIO completion eventfds that are pollable
> from userspace (without system calls).
>=20
> We recently merged the AioContext polling feature but didn't enable it
> by default yet.  I have gone back over the performance data on the
> mailing list and picked a default polling value that gave good results.
>=20
> Let's enable AioContext polling by default so users don't have another
> switch they need to set manually.  If performance regressions are found
> we can still disable this for the QEMU 2.9 release.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Karl Rister <krister@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  iothread.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkMTYAAoJEJykq7OBq3PIV0QH/ig1BR8ewtte2WxYkxyUgazz
IRujG1g6h51w2KLE5i42fybTXQq0iWyrLQzaj2OYffYmMIqOQ+xbEAWP6wTxzHUf
ExZaF7f6qrUbPMxi4OmqDxLLvA2B8pO2A8gQXP9dBxv/V2+rGqq21wjAHdssrVdl
ux6YyCSuGTwLaJ+BxSjHrGpBCruftvyHPewMy58Buf3IAMsLuX1ughzNcvw4p/75
ZvEkrFiq8eJYxkN4wFAQyEV5uQ3/ONLDL1p0d35plvXUJd+JoSJff2eZahlDSCnk
woRdaBEwYvWXONRwPtiWEtTIJEtM6DoxjfjPIwJy7OKz9/EemsA+jKWHtz1A6OM=
=rcDw
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
