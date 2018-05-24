Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fLqrW-0007SH-5T
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fLqrQ-0000fr-FV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:05:02 -0400
Date: Thu, 24 May 2018 15:04:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180524140453.GB28984@stefanha-x1.localdomain>
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-block] Problem with data miscompare using
 scsi-hd, cache=none and io=threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 06:25:46PM -0300, Daniel Henrique Barboza wrote:
> This means that the test executed a write at=A0 LBA 0x94fa and, after
> confirming that the write was completed, issue 2 reads in the same LBA to
> assert the written contents and found out a mismatch.

Have you confirmed this pattern at various levels in the stack:
1. Application inside the guest (strace)
2. Guest kernel block layer (blktrace)
3. QEMU (strace)
4. Host kernel block layer (blktrace)

The key thing is that the write completes before the 2 reads are
submitted.

Have you tried running the test on bare metal?

Stefan

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBsaFAAoJEJykq7OBq3PI3OkIAMIVtABzSHMf2gJ8abYDStIk
NCmbjfN5cV++Xptc94inBD8l/4rvEsIytvDY17WCTvOp8kqvPKBBm3QbSnAX3GmG
CiSGG5VGbAPO+OkmqHZwrzEdfPjfl1nd/4SGv5To8xo5uxRLAXWIFynw/jxhoR8X
GIZn7VsI3+V1lc2fLPJOxj16Q5RQkBpAcdAOGfFmE2FyqICjASIarBifP8qHWdcr
txdtKmWO70dhbkBc6qHcEX8PR2AHBnwrqijcK9N24BpNrZNKkTkvJ+yWOIYR4Wyq
OBPYMtM14cWIQVmu6fuIM2jc0v0aUiANsSqMfDhQuKb3xwv4VD3XMXVFJtFLdpE=
=Huvb
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
