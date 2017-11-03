Received: from eggs.gnu.org ([2001:4830:134:3::10]:33365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYan-0004XV-Vo
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYak-000315-Sb
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:50 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:44367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eAYak-00030j-LC
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 05:48:46 -0400
Received: by mail-wm0-x236.google.com with SMTP id n74so2262596wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 02:48:46 -0700 (PDT)
Date: Fri, 3 Nov 2017 09:48:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103094843.GC5078@stefanha-x1.localdomain>
References: <150963549061.4171.11895725981979057755.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <150963549061.4171.11895725981979057755.malonedeb@gac.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1729623] [NEW] test-aio-multithread fails
 with 'Co-routine re-entered recursively'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1729623 <1729623@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 03:11:30PM -0000, R.Nageswara Sastry wrote:
> Public bug reported:
>=20
> git head is at fa73e146250181852c0915aa65df8d54d35485fa
>=20
> configure with the following
>=20
> ./configure --enable-attr --enable-bsd-user --enable-cap-ng\
>  --enable-coroutine-pool  --enable-crypto-afalg --enable-curl\
>  --enable-curses --enable-debug --enable-debug-info\
>  --enable-debug-tcg      --enable-fdt      --enable-gcrypt \
>  --enable-gnutls      --enable-gprof      --enable-gtk  \
>  --enable-guest-agent      --enable-kvm      --enable-libiscsi \
>  --enable-libssh2      --enable-linux-aio      --enable-linux-user \
>  --enable-live-block-migration      --enable-modules   \
>  --enable-numa      --enable-pie      --enable-profiler \
>  --enable-qom-cast-debug      --enable-rbd      --enable-replication  \
>  --enable-seccomp      --enable-smartcard      --enable-stack-protector \
>  --enable-system      --enable-tcg      --enable-tcg-interpreter  \
>  --enable-tools      --enable-tpm      --enable-trace-backend=3Dftrace \
>  --enable-user      --enable-vhost-net      --enable-vhost-scsi  \
>  --enable-vhost-user      --enable-vhost-vsock      --enable-virtfs  \=20
>  --enable-vnc      --enable-tpm      --enable-vnc-png   \
>  --enable-vnc-sasl      --enable-werror      --enable-xfsctl \
>  --enable-gcov --enable-debug-stack-usage
>=20
> make -j 32
>=20
> make test-aio-multithread V=3D1
>=20
> ...
> File '/home/nasastry/qemu/include/qapi/qmp/qobject.h'
> No executable lines
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gteste=
r -k --verbose -m=3Dquick tests/test-aio-multithread
> TEST: tests/test-aio-multithread... (pid=3D86877)
>   /aio/multi/lifecycle:                                                OK
>   /aio/multi/schedule:                                                 Co=
-routine re-entered recursively
> FAIL

I cannot reproduce it locally.

Please run with gdb tests/test-aio-multithread and post the backtrace
when the "Co-routine re-entered recursively" message is printed using
the "thread apply all bt" gdb command.

Stefan

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/Dt7AAoJEJykq7OBq3PIW0wH/jY+WTgP0qQHUVxgP55FyOVG
FgXYPDHBsGt1fFsHdNk7gmMLF1qalyyHWhBensVTeu9hgY0C+wrQb57yqGaIpeIF
pBOJXfekxtEZemKBLpGUwwMgXfCLCPOpkqvy3/T1EqyZ51HAp5IX3Ps797EMprlB
vToJPmtr7HHUHIZil5bguWJ+gE2MQD1/2IlE7uhzjjPfJ71KC/9ofGXtZZnZRrUZ
8MtXzhf5+gcX/DiybHdZckSDaEBQEMON+GrINLu5mIZwayp5PGVQNsmy2XppUugo
xWmcW9oCxFMD0ZpADscZ08T2mi16rU0FdpajVlESPr3q07ZaTrr++2WdAqsIA9A=
=Rd0O
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
