Received: from eggs.gnu.org ([2001:4830:134:3::10]:41351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAas-0001qR-AK
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAao-0001IP-WB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:18:46 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:4551
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dcAao-0001Ho-K5
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:18:42 -0400
Date: Mon, 31 Jul 2017 14:18:40 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170731131840.GB6973@jhogan-linux.le.imgtec.org>
References: <4053c89eefa69e2b4aa3e1072a6ae975b8d87734.1500477656.git-series.james.hogan@imgtec.com>
	<150047888562.93.7391881979986874204@5d477a5b5989>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dN72Vk/q4pSfSeuV"
Content-Disposition: inline
In-Reply-To: <150047888562.93.7391881979986874204@5d477a5b5989>
Subject: Re: [Qemu-devel] [PATCH] target/mips: Fix microMIPS jumps in 128MB
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, yongbok.kim@imgtec.com, froydnj@codesourcery.com, aurelien@aurel32.net

--dN72Vk/q4pSfSeuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 08:41:26AM -0700, no-reply@patchew.org wrote:
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:78:fixture_setup: assertion fai=
led (fixture->fd !=3D -1): (-1 !=3D -1)
> GTester: last random seed: R02Sdc111f0781db4246a37f87a06bb4b260
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 382, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 379, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 237, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 205, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 123, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com=
=2Eqemu.instance.uuid=3Dc15f627c6c9611e79e0b525400c803e1', '-u', '0', '-t',=
 '--rm', '--net=3Dnone', '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPT=
S=3D', '-e', 'V=3D', '-e', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1',=
 '-e', 'CCACHE_DIR=3D/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-s=
0w6saox/src/docker-src.2017-07-19-11.27.16.20592:/var/tmp/qemu:z,ro', '-v',=
 '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:centos6', '/var=
/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> tests/docker/Makefile.include:124: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-s0w6saox/src'
> tests/docker/Makefile.include:156: recipe for target 'docker-run-test-qui=
ck@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

Erm, I don't think these errors could have anything to do with my patch.

Cheers
James

--dN72Vk/q4pSfSeuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll/LiUACgkQbAtpk944
dno9CQ//V3K99PANLkYCSUHCaRF8NZEk/hsg8E2VvKrv8MlL5zfpWWLTXqnfB4jP
DpFmmXwbb2OnDd06hjJK00lNb4mHVScgdln+GvUMhtCP0LVW4aWKjXBpK/5zAUmn
m7ljFTLrqTV1o+9RZs1IUFl8tqrGDSNPrGC0wb6BtO1iKb2K7HnHyZwiZss+HqSm
1ScEBv3JvoH+egH9JjJf3W0WN21RTCOpP5F3WqiVy669TopEa2OGacs2CrhYO+Uf
sf+aLfcZ+AgoYytsLJFSvUcn1uwifFD8Dmry8YndQOrdn++8jRs8srxuyRF3O9SP
RXLxHCe3O/w2G3wcBtHXNdtF6P2gS6/BtdyHHOUl6WXZrYwSivVGdUbaFRgdEVyt
jVIWFj1IqxF7rAEIPA81CHmAkv+6HsQoHYiS1vI7N1YdkKYfJ4JoTc6IPnbZJxg3
amksieQ7EyEfCwDtoDURH0yR5cMmczcIoSefO3CN00hMsesKmrkQtVyeLcXITFas
NER5p4YDhLwuAvxtfJg1Jjh8os+K28y927jRNllDvcnlx13P1OGpFf19V9bhleuQ
zQ8KlRgZD9tczV5Wz3PHAyB1ERpatBPlk9AobFLi65zlkiK3WhxqI/+y5ziZSS6R
tq40Mpw+6qboQD7pGD9BZPWx6SRRX+3TBLTPnlz9yeKAenidWu4=
=mahr
-----END PGP SIGNATURE-----

--dN72Vk/q4pSfSeuV--
