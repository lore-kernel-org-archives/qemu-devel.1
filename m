Received: from eggs.gnu.org ([209.51.188.92]:56951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpZZ7-0006Lf-62
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpZZ6-0003he-CV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:13:09 -0500
References: <20190131123810.10233-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eff25a89-1e3f-6746-b384-5673cedaaa68@redhat.com>
Date: Fri, 1 Feb 2019 15:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190131123810.10233-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ybDXXCZEYZnGcQydLc1GSnDsQSZpy197D"
Subject: Re: [Qemu-devel] [PATCH] qtest.py: Wait for the result of qtest
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Peter Xu <peterx@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ybDXXCZEYZnGcQydLc1GSnDsQSZpy197D
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Xu <peterx@redhat.com>
Message-ID: <eff25a89-1e3f-6746-b384-5673cedaaa68@redhat.com>
Subject: Re: [PATCH] qtest.py: Wait for the result of qtest commands
References: <20190131123810.10233-1-berto@igalia.com>
In-Reply-To: <20190131123810.10233-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 13:38, Alberto Garcia wrote:
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

Thanks a lot!

Max


--ybDXXCZEYZnGcQydLc1GSnDsQSZpy197D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxUU+cACgkQ9AfbAGHV
z0DkkAf+IG4E0qZxc7dh4tiMKanX1uK5W8m0LCGGaSWAjuqichTWhBk8ixPQpFCK
rLQT+i5t1gwPxCn3b+/xbnHaYkvqoOA2qJWOWmdGeSrFHWDR+AX2d3fMkZIiHNU7
cg2lLjWr0Fvi1ljnkFlUXeY936rsd1t0R7DUBLw6ev8F44vZPQ0NI5a4kZGP8F+Z
ljYHcu145hrRHuB0B/RTGdIy6R0szvhENAB/E0fTrGrOufTtaXJwx0NHJfK9TQh0
P250rAROQExEw9Jpi6PcR33CWJJct6BHm+TsR+tK/G2IhrWC6FSxE0x/Zi+I+bQU
ddygOijPa39JGFj3yrB+FY+GjrGt7w==
=ifhA
-----END PGP SIGNATURE-----

--ybDXXCZEYZnGcQydLc1GSnDsQSZpy197D--
