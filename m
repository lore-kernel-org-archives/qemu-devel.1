Received: from eggs.gnu.org ([2001:4830:134:3::10]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etYGy-0003PJ-0h
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etYGu-0002V9-UM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:34:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1etYGu-0002Uz-Q6
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:34:16 -0500
Date: Wed, 7 Mar 2018 12:34:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180307123414.GE16861@stefanha-x1.localdomain>
References: <20180306172250.3049-1-stefanha@redhat.com>
	<4593aa24-49cb-aeb9-aea6-f620ebac937c@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <4593aa24-49cb-aeb9-aea6-f620ebac937c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] trace: fix ARM TrustZone PPC hwaddr type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 03:40:23PM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/06/2018 02:22 PM, Stefan Hajnoczi wrote:
> > Commit 9eb8040c2d2b ("hw/misc/tz-ppc: Model TrustZone peripheral
> > protection controller") added trace events with hwaddr type arguments.
> >=20
> > This is not allowed and leads to the following compiler errors when
> > building with ./configure --enable-trace-backends=3Dust:
> >=20
> >   trace-ust-all.h:11847:20: error: unknown type name =E2=80=98hwaddr=E2=
=80=99; did you mean =E2=80=98h_addr=E2=80=99?
> >     TP_ARGS(int, n, hwaddr, offset, bool, secure, bool, user),
> >=20
> > Generated LTTng UST tracepoint definitions cannot include declarations
> > for all QEMU types and therefore docs/devel/tracing.txt requires using
> > only primitive or stdint.h types.
>=20
> Maybe the trace generator script can check for legal/forbidden types?

Yes, good idea.  I'll add it to my todo list.

Stefan

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJan9xGAAoJEJykq7OBq3PIL0IIAKfRtrt2ADFHF0Y614Zw2ERm
K2hgiugZrc6vYb/k1j3z4KAGhSr55vbSd8uNsuO1SJTdPI70XhepFv+HRMJWKhAj
kRkB2BDx0jPUYNdSTRnP1bFNXZFOnkKa4HUj/iBS07LvGlLIjJZDQqePc1uIQPdo
SgQsPQuAWhtWQQvqDqeELJwyZGcHHzY7gIRXEWDC8PIO4xn+VCqk0UDfziwkbjZF
OemevhkhrooLRb6YdsnMC3TG+KfRs+JCbi/v74iACU5eRoHV/mq4vOwshTuQLnEa
z2OZyoBF0TOWexYbCET1R2Kwcr3tEXvwB4A0sWrRelcS2ceGhl5PLLCh77OW0qI=
=MAxL
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
