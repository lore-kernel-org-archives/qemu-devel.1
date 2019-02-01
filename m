Received: from eggs.gnu.org ([209.51.188.92]:46856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRk4-0001JM-GN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gpRk3-00032g-PZ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:51:56 -0500
Date: Fri, 1 Feb 2019 13:51:51 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190201055151.GI23131@stefanha-x1.localdomain>
References: <20190131123810.10233-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <20190131123810.10233-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qtest.py: Wait for the result
 of qtest commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2019 at 02:38:10PM +0200, Alberto Garcia wrote:
> The cmd() method of the QEMUQtestProtocol class sends a qtest command
> to QEMU but doesn't wait for the return message ("OK", "FAIL", "ERR").
> Because of this, it can return control to the caller before the
> command has actually finished.
>=20
> In cases like clock_step or clock_set this means that cmd() can return
> before all the timers triggered by the clock change have been fired.
> This can be fixed by making cmd() wait for the output of the qtest
> command.
>=20
> This fixes iotests 093 and 136, which are flaky since commit
> 8258292e18c39480b64eba9f3551 when the machine is under heavy workload.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  scripts/qtest.py | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU953AAoJEJykq7OBq3PIksIH/iwH0Kmsa/221tCJCln8LsTm
vgJ+81hFSaNIDRf+TBxKWf83PpPRkcTbEYldRnqUwiAN8umf4aCz5UPvPEF8LhOl
KCtRXPxy+gPdSZknOiOAedmiOdmx+xENpultvoCLYa3EMJxMUbGxTkf46YguvBQV
av88OebDGykS6RXuYZHnAMTebxN3tApH9Wrnuj77RrZLihdvM+LDvejOERKB7W2g
Kl7uCzUH7kXjiJnYTQHm59bjFPtpVVznGOxqKBdpfruXAKMR6S2p7T3HBo75H/mK
yE9+QCAQ2h/KnVE6HsbY9qF+5W1u5T0mdJKPUY1YOOlaleJtwiqoU7U4zKRrQFo=
=F+i7
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
