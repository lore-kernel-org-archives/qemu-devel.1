Received: from eggs.gnu.org ([2001:4830:134:3::10]:48287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2CMU-0005eV-K5
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f2CMQ-0004go-Jx
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:59:46 -0400
Received: from mout.web.de ([212.227.17.11]:35937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f2CMQ-0004g8-7K
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 04:59:42 -0400
References: <152248152782.864.1806063787962449652@71c20359a636>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <75a4713c-ccae-07e7-ad34-800e87404cb8@web.de>
Date: Sat, 31 Mar 2018 10:59:30 +0200
MIME-Version: 1.0
In-Reply-To: <152248152782.864.1806063787962449652@71c20359a636>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="UURiWaRqdrqJV6As0OHMwheWTMr3aTmk1"
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD
 IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UURiWaRqdrqJV6As0OHMwheWTMr3aTmk1
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <75a4713c-ccae-07e7-ad34-800e87404cb8@web.de>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD IOMMU
References: <152248152782.864.1806063787962449652@71c20359a636>
In-Reply-To: <152248152782.864.1806063787962449652@71c20359a636>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-31 09:32, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed docker-quick@centos6 build test. Please find the tes=
ting commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.

Apparently, this test case is broken. Who is operating this?

Jan

>=20
> Type: series
> Message-id: f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de
> Subject: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD IO=
MMU
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> time make docker-test-quick@centos6
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 335e2a05e9 hw/i386: Fix IVHD entry length for AMD IOMMU
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-ooh2mz2y/src/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
>   BUILD   centos6
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-ooh2mz2y/src'
>   GEN     /var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-03-3=
1-03.31.12.17223/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-=
03-31-03.31.12.17223/qemu.tar.vroot'...
> done.
> Checking out files:  23% (1428/6066)  =20
> Checking out files:  24% (1456/6066)  =20
> Checking out files:  25% (1517/6066)  =20
> Checking out files:  26% (1578/6066)  =20
> Checking out files:  27% (1638/6066)  =20
> Checking out files:  27% (1664/6066)  =20
> Checking out files:  28% (1699/6066)  =20
> Checking out files:  29% (1760/6066)  =20
> Checking out files:  30% (1820/6066)  =20
> Checking out files:  31% (1881/6066)  =20
> Checking out files:  32% (1942/6066)  =20
> Checking out files:  33% (2002/6066)  =20
> Checking out files:  34% (2063/6066)  =20
> Checking out files:  35% (2124/6066)  =20
> Checking out files:  36% (2184/6066)  =20
> Checking out files:  37% (2245/6066)  =20
> Checking out files:  38% (2306/6066)  =20
> Checking out files:  39% (2366/6066)  =20
> Checking out files:  40% (2427/6066)  =20
> Checking out files:  41% (2488/6066)  =20
> Checking out files:  42% (2548/6066)  =20
> Checking out files:  43% (2609/6066)  =20
> Checking out files:  44% (2670/6066)  =20
> Checking out files:  45% (2730/6066)  =20
> Checking out files:  46% (2791/6066)  =20
> Checking out files:  47% (2852/6066)  =20
> Checking out files:  48% (2912/6066)  =20
> Checking out files:  49% (2973/6066)  =20
> Checking out files:  50% (3033/6066)  =20
> Checking out files:  51% (3094/6066)  =20
> Checking out files:  52% (3155/6066)  =20
> Checking out files:  53% (3215/6066)  =20
> Checking out files:  54% (3276/6066)  =20
> Checking out files:  55% (3337/6066)  =20
> Checking out files:  56% (3397/6066)  =20
> Checking out files:  57% (3458/6066)  =20
> Checking out files:  58% (3519/6066)  =20
> Checking out files:  59% (3579/6066)  =20
> Checking out files:  60% (3640/6066)  =20
> Checking out files:  61% (3701/6066)  =20
> Checking out files:  62% (3761/6066)  =20
> Checking out files:  63% (3822/6066)  =20
> Checking out files:  64% (3883/6066)  =20
> Checking out files:  65% (3943/6066)  =20
> Checking out files:  66% (4004/6066)  =20
> Checking out files:  67% (4065/6066)  =20
> Checking out files:  68% (4125/6066)  =20
> Checking out files:  69% (4186/6066)  =20
> Checking out files:  70% (4247/6066)  =20
> Checking out files:  71% (4307/6066)  =20
> Checking out files:  72% (4368/6066)  =20
> Checking out files:  73% (4429/6066)  =20
> Checking out files:  74% (4489/6066)  =20
> Checking out files:  75% (4550/6066)  =20
> Checking out files:  76% (4611/6066)  =20
> Checking out files:  77% (4671/6066)  =20
> Checking out files:  78% (4732/6066)  =20
> Checking out files:  79% (4793/6066)  =20
> Checking out files:  80% (4853/6066)  =20
> Checking out files:  81% (4914/6066)  =20
> Checking out files:  82% (4975/6066)  =20
> Checking out files:  83% (5035/6066)  =20
> Checking out files:  84% (5096/6066)  =20
> Checking out files:  85% (5157/6066)  =20
> Checking out files:  86% (5217/6066)  =20
> Checking out files:  87% (5278/6066)  =20
> Checking out files:  88% (5339/6066)  =20
> Checking out files:  88% (5393/6066)  =20
> Checking out files:  89% (5399/6066)  =20
> Checking out files:  90% (5460/6066)  =20
> Checking out files:  91% (5521/6066)  =20
> Checking out files:  92% (5581/6066)  =20
> Checking out files:  93% (5642/6066)  =20
> Checking out files:  94% (5703/6066)  =20
> Checking out files:  95% (5763/6066)  =20
> Checking out files:  96% (5824/6066)  =20
> Checking out files:  97% (5885/6066)  =20
> Checking out files:  98% (5945/6066)  =20
> Checking out files:  99% (6006/6066)  =20
> Checking out files: 100% (6066/6066)  =20
> Checking out files: 100% (6066/6066), done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-=
03-31-03.31.12.17223/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) regis=
tered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-=
03-31-03.31.12.17223/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d322=
0552280ef3d832ce'
> tar: /var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-03-31-03.=
31.12.17223/qemu.tar: Wrote only 2048 of 10240 bytes
> tar: Error is not recoverable: exiting now
> failed to create tar file
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6=20
> tar: Unexpected EOF in archive
> tar: Unexpected EOF in archive
> tar: Error is not recoverable: exiting now
> /var/tmp/qemu/run: line 32: prep_fail: command not found
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> bison-2.4.1-5.el6.x86_64
> bzip2-devel-1.0.5-7.el6_0.x86_64
> ccache-3.1.6-2.el6.x86_64
> csnappy-devel-0-6.20150729gitd7bc683.el6.x86_64
> flex-2.5.35-9.el6.x86_64
> gcc-4.4.7-18.el6.x86_64
> gettext-0.17-18.el6.x86_64
> git-1.7.1-9.el6_9.x86_64
> glib2-devel-2.28.8-9.el6.x86_64
> libepoxy-devel-1.2-3.el6.x86_64
> libfdt-devel-1.4.0-1.el6.x86_64
> librdmacm-devel-1.0.21-0.el6.x86_64
> lzo-devel-2.03-3.1.el6_5.1.x86_64
> make-3.81-23.el6.x86_64
> mesa-libEGL-devel-11.0.7-4.el6.x86_64
> mesa-libgbm-devel-11.0.7-4.el6.x86_64
> package g++ is not installed
> pixman-devel-0.32.8-1.el6.x86_64
> spice-glib-devel-0.26-8.el6.x86_64
> spice-server-devel-0.12.4-16.el6.x86_64
> tar-1.23-15.el6_8.x86_64
> vte-devel-0.25.1-9.el6.x86_64
> xen-devel-4.6.6-2.el6.x86_64
> zlib-devel-1.2.3-29.el6.x86_64
>=20
> Environment variables:
> PACKAGES=3Dbison     bzip2-devel     ccache     csnappy-devel     flex =
    g++     gcc     gettext     git     glib2-devel     libepoxy-devel   =
  libfdt-devel     librdmacm-devel     lzo-devel     make     mesa-libEGL=
-devel     mesa-libgbm-devel     pixman-devel     SDL-devel     spice-gli=
b-devel     spice-server-devel     tar     vte-devel     xen-devel     zl=
ib-devel
> HOSTNAME=3D3294c7b71f58
> MAKEFLAGS=3D -j8
> J=3D8
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=3D/
> TARGET_LIST=3D
> SHLVL=3D1
> HOME=3D/root
> TEST_DIR=3D/tmp/qemu-test
> FEATURES=3D dtc
> DEBUG=3D
> _=3D/usr/bin/env
>=20
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/tmp/qemu-test/install
>=20
> ERROR: DTC (libfdt) version >=3D 1.4.2 not present.
>        Please install the DTC (libfdt) devel package
>=20
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 407, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 404, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 261, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 229, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 147, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'c=
om.qemu.instance.uuid=3D8cdf8bca34b511e8817452540069c830', '-u', '0', '--=
security-opt', 'seccomp=3Dunconfined', '--rm', '--net=3Dnone', '-e', 'TAR=
GET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D8=
', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/c=
cache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', =
'/var/tmp/patchew-tester-tmp-ooh2mz2y/src/docker-src.2018-03-31-03.31.12.=
17223:/var/tmp/qemu:z,ro', 'qemu:centos6', '/var/tmp/qemu/run', 'test-qui=
ck']' returned non-zero exit status 1
> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-ooh2mz2y/src'
> make: *** [tests/docker/Makefile.include:163: docker-run-test-quick@cen=
tos6] Error 2
>=20
> real	1m0.294s
> user	0m9.404s
> sys	0m6.923s
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
>=20



--UURiWaRqdrqJV6As0OHMwheWTMr3aTmk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlq/TfUACgkQitSsb3rl5xSHzwCfXTrW5fgrFHQM9EPh9UxjmAb+
eA0AmwUFQnO+AJzjPt1Sg5R9vFcXxqw/
=xpEt
-----END PGP SIGNATURE-----

--UURiWaRqdrqJV6As0OHMwheWTMr3aTmk1--
