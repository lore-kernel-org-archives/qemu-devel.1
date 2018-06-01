Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiYk-0005sM-5g
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiYf-0002my-82
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:49:30 -0400
Date: Fri, 1 Jun 2018 12:49:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601114922.GK8687@stefanha-x1.localdomain>
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
	<20180524140453.GB28984@stefanha-x1.localdomain>
	<a30a4e06-4028-4cad-ebae-e7bd3be7359a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
In-Reply-To: <a30a4e06-4028-4cad-ebae-e7bd3be7359a@linux.ibm.com>
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


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 06:30:10PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/24/2018 11:04 AM, Stefan Hajnoczi wrote:
> > On Tue, May 15, 2018 at 06:25:46PM -0300, Daniel Henrique Barboza wrote:
> > > This means that the test executed a write at=A0 LBA 0x94fa and, after
> > > confirming that the write was completed, issue 2 reads in the same LB=
A to
> > > assert the written contents and found out a mismatch.
> > Have you confirmed this pattern at various levels in the stack:
> > 1. Application inside the guest (strace)
> > 2. Guest kernel block layer (blktrace)
> > 3. QEMU (strace)
> > 4. Host kernel block layer (blktrace)
>=20
> Tested (3). In this case the bug stop reproducing. Not sure if there is
> anything related with strace adding a delay back and forth the
> preadv/pwritev calls, but the act of attaching strace to the QEMU
> process changed the behavior.
>=20
> Haven't tried the other 3 scenarios. (2) and (4) are definitely worth try=
ing
> it
> out, specially (4).

Yes, host blktrace is probably the most important piece of evidence.

> > The key thing is that the write completes before the 2 reads are
> > submitted.
> >=20
> > Have you tried running the test on bare metal?
>=20
> Yes. The stress test does not reproduce the miscompare issue when
> running on bare metal.

Great.

Stefan

--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETLCAAoJEJykq7OBq3PIqOUH/iGyBE8Ue8g5WWPmaRYbL17K
6dT4pS4BLkjN66h/5ssCfCI8NzfUDmLXT6hz7HypvpgHvi4vEwXQ5+J+Db1k4McM
XRdpb8zylDYLDrEh/sef6pVaVGrhGKBZq12UtDMioem1gSOAZeHg3er2RwhWyqbU
bvhcj6A8EOgPiLlNMWZ5MXPmsRjRtP/ZNYzmHno9GWfbm7SZd5bHqn/XOG50mx4j
U45JtNgBBjVDGM6Gy788es8A5BOQ2dGSZAMHmqkatFCjEADC3TvbIMhumnCQX3bd
2/+zniZtkr+gp9joNcDdYq7tCn7wVPgobPdeSSJ8fCnmVmIQ+tmmRduXMa+QJF8=
=0CYs
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--
