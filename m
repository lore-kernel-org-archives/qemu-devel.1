Received: from eggs.gnu.org ([2001:4830:134:3::10]:55045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLMQV-0005SF-B4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLMQU-0005e3-18
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:30:35 -0400
Date: Thu, 15 Jun 2017 00:30:22 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170615043022.GF2767@localhost.localdomain>
References: <20170614215526.9218-1-jcody@redhat.com>
	<149747921115.2241.11634852803092743941@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149747921115.2241.11634852803092743941@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org, stefanha@redhat.com

On Wed, Jun 14, 2017 at 03:26:52PM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20
> Type: series
> Subject: [Qemu-devel] [PULL 0/2] Block patches
> Message-id: 20170614215526.9218-1-jcody@redhat.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D8
> # master is broken, skip centos6...
> #time make docker-test-quick@centos6
> time make docker-test-mingw@fedora
> time make docker-test-build@min-glib
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20170614215526.9218-1-jcody@redhat.com -> =
patchew/20170614215526.9218-1-jcody@redhat.com
> Switched to a new branch 'test'
> 2f0938b block/iscsi: enable filename option and parsing
> e6b28ad block/rbd: enable filename option and parsing
>

[...]

>   CC      hw/pci-bridge/pcie_root_port.o
>   CC      hw/pci-bridge/gen_pcie_root_port.o
>   CC      hw/pci-bridge/pci_expander_bridge.o
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here

Just an FYI, this appears to be unrelated to the actual patches in the pu=
ll
req.

> make: *** [hw/net/vmxnet3.o] Error 1
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' faile=
d
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-aceb4nxr/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-b=
uild@min-glib' failed
> make: *** [docker-run-test-build@min-glib] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
