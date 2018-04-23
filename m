Received: from eggs.gnu.org ([2001:4830:134:3::10]:40076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAXr6-0005iz-5E
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAXr0-0002B6-GX
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:33:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fAXr0-00028v-Bw
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:33:46 -0400
Date: Mon, 23 Apr 2018 10:33:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180423093334.GA4892@stefanha-x1.localdomain>
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
	<20180410020823.GB11203@stefanha-x1.localdomain>
	<fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <fefd54c0-d5f2-dc31-ff3c-24eb29fd2101@simark.ca>
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Marchi <simark@simark.ca>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, gdb@sourceware.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 09:37:52PM -0400, Simon Marchi wrote:
> On 2018-04-09 10:08 PM, Stefan Hajnoczi wrote:
> > I wonder what the point of select-frame is then...
> >=20
> > I have CCed the GDB mailing list.  Maybe someone can help us.  Context:
> >=20
> > QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
> > call stacks in GDB and have a script that works when a process is being
> > debugged (it sets the registers).
> >=20
> > Now we'd like to extend the script to work on core dumps where it's not
> > possible to set registers (since there is no process being debugged).
> >=20
> > Is there a way to backtrace an arbitrary call stack in a core dump?
>=20
> Not that I know of.  The "frame <stack-addr> <pc-addr>" form of the frame
> command sounds like it should be usable to achieve that, but it doesn't
> seem to work in that way.  I really wonder if it's working as it was
> intended initially.  I guess using that form of the frame command should
> override/mask the real current values of $sp and $pc?

Yes, that is what I was expecting.

Vladimir has a script to copy the coredump file and manipulate the
registers on disk, but it would be nicer to do stack-switching inside
the GDB session without needing to create another coredump file.

Vladimir: Would you like to write a GDB patch?  If GDB is fixed then
workaround won't be necessary.

Stefan

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa3ahuAAoJEJykq7OBq3PIuW8H/1yx3zAPxYSQ6//Huef03zxK
E5ewTnfJ17XpGtRPnZWycNHLHNpS2vxi8mWG84pDy2xwUldT1x5+6zZclX5F6EoV
w+CXdhlRN4UkezHFex2NyxTCscAMkU1TG5kgRni2PYV1LFVfI650+7WsnnaII+DL
M0/9q78YGlh3AX+2Pnh+hwpRpTrElIo2cLsR4Mn7hek9zynF2cAb5P4r6iS+AzLG
E+fNOyqjcKqOkgJzU650y0xipToNFWHHv4vADeLNm+Ud/EkJlY2aHTj/dCbWYj/d
ZQ/Rf26Li0pLJpS/nOhlYd+Z1iBJRnSiqYkqgwKb/SLHBNnabVxKBRXC45TFtdI=
=NA7j
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
