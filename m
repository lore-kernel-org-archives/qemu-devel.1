Received: from eggs.gnu.org ([2001:4830:134:3::10]:36389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOj91-0004l0-Tn
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOj8y-00045B-Lq
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:26:59 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOj8y-00044U-EF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:26:56 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 94-v6so36145598wrf.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:26:56 -0700 (PDT)
Date: Fri, 1 Jun 2018 13:26:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601122653.GO8687@stefanha-x1.localdomain>
References: <CA+6CiVCSPCQ-3iBa=ivJtqsbsV2G9MxTndDFXkMBk2AgWHxPOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCFQJunhLz1tFGpX"
Content-Disposition: inline
In-Reply-To: <CA+6CiVCSPCQ-3iBa=ivJtqsbsV2G9MxTndDFXkMBk2AgWHxPOA@mail.gmail.com>
Subject: Re: [Qemu-devel] Live viewing qemu running image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olga Levy <olgalevy91@gmail.com>
Cc: qemu-devel@nongnu.org


--lCFQJunhLz1tFGpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:33:40PM +0300, Olga Levy wrote:
> Hi,
>=20
> Nice to meet you. I'm a new security engineer and working on a prototype
> using QEMU.
>=20
> What I need is to collect running image internal data (like running
> processes, netstat, files modification, etc.) but without running any
> process inside. I mean, doing it from "outside" (I need Qemu support).
>=20
> For example,
>=20
> How can I live view FS of a running image?

You might be interested in http://libvmi.com/ and
https://github.com/KVM-VMI.

In general these mechanisms are problematic because they go against the
philosophy that the guest is a black box.  They are invasive, difficult
to maintain, and reduce performance.

But if they are useful to enough people, then eventually they will
mature and be integrated into QEMU/KVM after enough effort is invested
into them.

Stefan

--lCFQJunhLz1tFGpX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETuNAAoJEJykq7OBq3PImnwIAL69zFm63lnJhjnQQtxH3VJW
3qAGBC7/6ALpqkZqFcHaMllsQsxnP9OB3Drn+JgRlyM49t0FIgFc7BZmy1Txs9wf
jPwW45uGWrTtzTayiZWVtiE+CSTLR/k8d47S9ekaF7oASwxtrjq+9giav3/qzHLT
P6X0cpBT7n4fycs24u6ToZB02fo15ZSF9TtHn8NjXekxgLJLJd7Uz3zyJ/atz/vM
8mJVQO2CUR6O6l0Pnz7xprZQWT2D9Ca2lq7qnubSElRk/nRIy0TccmeVkrkhtPEG
bf+vPw9SuJ69Td1cdS+CRSmvNBGeqBAG2LfCK73ikyNkL6cDt8KoueJ7UII3xss=
=Fe9h
-----END PGP SIGNATURE-----

--lCFQJunhLz1tFGpX--
