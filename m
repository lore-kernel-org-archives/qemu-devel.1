Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEC3r-0006nA-4g
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEC3m-00078J-7z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:19 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEC3m-00077V-1U
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:29:14 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so28510714wjc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 01:29:13 -0800 (PST)
Date: Tue, 6 Dec 2016 09:28:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206092810.GC12630@stefanha-x1.localdomain>
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-5-stefanha@redhat.com>
	<20161205005459.GA21702@lemon>
	<20161205101452.GB22443@stefanha-x1.localdomain>
	<1548288582.1411113.1480935595505.JavaMail.zimbra@redhat.com>
	<20161205144615.GE30434@stefanha-x1.localdomain>
	<1637153950.1453448.1480951332566.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <1637153950.1453448.1480951332566.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/13] virtio: poll virtqueues for new
 buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, borntraeger@de.ibm.com, Karl Rister <krister@redhat.com>, qemu-devel@nongnu.org, v maffione <v.maffione@gmail.com>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:22:12AM -0500, Paolo Bonzini wrote:
> > Anyway, I'm glad the polling series on its own is already showing good
> > performance results.  I'd like to merge it at the beginning of QEMU 2.9
> > so we can work on further improvements that build on top of it.
>=20
> Yes, it would be great if you can stage the infrastructure bits, so that
> I can rebase my lockcnt patches on top.

I'll apply it to block-next as soon as Christian and Karl are happy with
the performance results.

Stefan

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRoSqAAoJEJykq7OBq3PIVGAH/2+PS4f85Nt/VBY3wDEh2WAI
WL96B3XDIziNqs2vWoFB/CVJKsREj7x4yONQ4ATDxOXXKnrxHQkdPcTZbSzeZS8c
S64ujHNBkmZO9LndyW1qPesRiMj/t1VyP9qQ9lrCMypM+m20sBXiuECq7Z/phm5y
IZgnLTURhYZKKlSxkaE+yVWlm7JIJ9pfrwQ8i7Vzmp2kCq+KRhJluMRn89BMeRfa
5hMRv1BUPt6zSj/U2pi0NFxZhfKixYq+ZsAl37e9zRdFHMJhBEEclK6s/oB/O3F0
SsECacD7m0PSlp8UEOszW9+9ZAnnvLUxKBAMPCikn/9qQD8Q7pMn/u5RDEMXndU=
=XZ6c
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
