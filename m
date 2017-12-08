Received: from eggs.gnu.org ([2001:4830:134:3::10]:49472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGPf-0006Mt-NN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGPc-0006MO-KQ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:01:51 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:43378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eNGPc-0006LF-Cz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:01:48 -0500
Received: by mail-wm0-x22c.google.com with SMTP id n138so2671356wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 03:01:48 -0800 (PST)
Date: Fri, 8 Dec 2017 11:01:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208110144.GI23880@stefanha-x1.localdomain>
References: <alpine.BSF.2.21.1712041954200.69360@zero.eik.bme.hu>
	<20171205135447.GA29422@stefanha-x1.localdomain>
	<alpine.BSF.2.21.1712051856040.96903@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1712051856040.96903@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Debugging io deadlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 07:35:36PM +0100, BALATON Zoltan wrote:
> On Tue, 5 Dec 2017, Stefan Hajnoczi wrote:
> > On Mon, Dec 04, 2017 at 08:22:48PM +0100, BALATON Zoltan wrote:
> I don't really know what to look for
> so if anyone has any more ideas then please share.

I don't have a specific idea, but two general techniques for debugging
guest hangs:

1. Enable tracing or add printfs to monitor hardware register writes and
   interrupts.  This way you can figure out which devices were most
   recently accessed.  They are probably involved in the hang.

2. Peek at QEMU device state from GDB.  For example, look at virtio
   device vrings to see which requests are currently in-flight.

Stefan

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKnEYAAoJEJykq7OBq3PIPoMH/3DEqDFlkVTHDEBnqKXnkqHu
iR0UVuEQx9T0iuTmQOMiXP4pPnoMagvIfjgkTNmpeWZNxiXWGJdxCXvogFaYZk+J
2GdgBmCCQP5lbce0z3yXUVtQTQJYB+tYSKE2bQwtrNndlv6LFugwVCRxRYigBc78
n/vBIVUOMcnftZu4mZNmfyUdgrCGOgA8jJW76TCMa5suIPltrZAQMOXhdRzl1xSq
IvZbHNAVEMXE9hCI+1iMRjGxaJeZ+xRYY2ZY9Pfx+B8OJoB6H3CawpyoChLt0Veg
5ig1bW3uwHsRF6sHhx39LLE+UKKsBkNohMzc4bMHWZLdpnGwkD7UjiNO5Wjg88M=
=p5+f
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
