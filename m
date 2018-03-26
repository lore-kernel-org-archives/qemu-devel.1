Received: from eggs.gnu.org ([2001:4830:134:3::10]:36999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0NaO-00012p-BR
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0NaK-0006Z9-52
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:34:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f0NaK-0006Yu-0r
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:34:32 -0400
References: <152192928550.363.5497859547477813786@71c20359a636>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cca001a1-5fca-10d2-54d4-4cf07b69d8a9@redhat.com>
Date: Mon, 26 Mar 2018 10:34:27 +0200
MIME-Version: 1.0
In-Reply-To: <152192928550.363.5497859547477813786@71c20359a636>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Patchew failure ? (was: Re: [PATCH 00/14] Generalize
 Dallas/Maxim I2C RTC devices v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, mdavidsaver@gmail.com

On 24.03.2018 23:08, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed docker-build@min-glib build test. Please find the te=
sting commands and
> their output below. If you have Docker installed, you can probably repr=
oduce it
> locally.
>=20
> Type: series
> Message-id: 20180324192455.12254-1-mdavidsaver@gmail.com
> Subject: [Qemu-devel] [PATCH 00/14] Generalize Dallas/Maxim I2C RTC dev=
ices v2
[...]
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
>   BUILD   min-glib
> make[1]: Entering directory '/var/tmp/patchew-tester-tmp-8pwvp3st/src'
>   GEN     /var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-2=
4-18.07.16.7723/qemu.tar
> Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-=
03-24-18.07.16.7723/qemu.tar.vroot'...
> done.
> Your branch is up-to-date with 'origin/test'.
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-=
03-24-18.07.16.7723/qemu.tar.vroot/dtc'...
> Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9=
cc42'
> Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) regis=
tered for path 'ui/keycodemapdb'
> Cloning into '/var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-=
03-24-18.07.16.7723/qemu.tar.vroot/ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d322=
0552280ef3d832ce'
> tar: /var/tmp/patchew-tester-tmp-8pwvp3st/src/docker-src.2018-03-24-18.=
07.16.7723/qemu.tar: Wrote only 4096 of 10240 bytes
> tar: Error is not recoverable: exiting now
> failed to create tar file
>   COPY    RUNNER
>     RUN test-build in qemu:min-glib=20
> tar: Unexpected EOF in archive
> tar: Unexpected EOF in archive
> tar: Error is not recoverable: exiting now
> /var/tmp/qemu/run: line 32: prep_fail: command not found
> Environment variables:
> HOSTNAME=3D2ad891f2b17f
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

 Hi Fam,

sounds like there is currently something broken with patchew? Could you
please have a look why it fails to use libfdt?

 Thomas
