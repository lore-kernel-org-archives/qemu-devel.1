Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLPCU-0005rR-Or
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dLPCT-0003ws-Q2
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:28:18 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170615043022.GF2767@localhost.localdomain> (Jeff Cody's
	message of "Thu, 15 Jun 2017 00:30:22 -0400")
References: <20170614215526.9218-1-jcody@redhat.com>
	<149747921115.2241.11634852803092743941@4a9a010726c0>
	<20170615043022.GF2767@localhost.localdomain>
Reply-To: quintela@redhat.com
Date: Thu, 15 Jun 2017 09:28:04 +0200
Message-ID: <87r2ylaewr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Jeff Cody <jcody@redhat.com> wrote:
> On Wed, Jun 14, 2017 at 03:26:52PM -0700, no-reply@patchew.org wrote:
>> Hi,
>>=20
>> This series failed automatic build test. Please find the testing command=
s and
>> their output below. If you have docker installed, you can probably repro=
duce it
>> locally.
>>=20
>> Type: series
>> Subject: [Qemu-devel] [PULL 0/2] Block patches
>> Message-id: 20170614215526.9218-1-jcody@redhat.com
>>=20
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> set -e
>> git submodule update --init dtc
>> # Let docker tests dump environment info
>> export SHOW_ENV=3D1
>> export J=3D8
>> # master is broken, skip centos6...
>> #time make docker-test-quick@centos6
>> time make docker-test-mingw@fedora
>> time make docker-test-build@min-glib
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>=20
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> From https://github.com/patchew-project/qemu
>>  * [new tag] patchew/20170614215526.9218-1-jcody@redhat.com ->
>> patchew/20170614215526.9218-1-jcody@redhat.com
>> Switched to a new branch 'test'
>> 2f0938b block/iscsi: enable filename option and parsing
>> e6b28ad block/rbd: enable filename option and parsing
>>
>
> [...]
>
>>   CC      hw/pci-bridge/pcie_root_port.o
>>   CC      hw/pci-bridge/gen_pcie_root_port.o
>>   CC      hw/pci-bridge/pci_expander_bridge.o
>> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
>> /tmp/qemu-test/src/include/migration/register.h:18: error:
>> redefinition of typedef =E2=80=98LoadStateHandler=E2=80=99
>> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous
>> declaration of =E2=80=98LoadStateHandler=E2=80=99 was here
>
> Just an FYI, this appears to be unrelated to the actual patches in the pu=
ll
> req.

It is, sorry.

I sent a PULL requset with the fix on my last PULL request.

Peter, should I do something to speed up that one?

Later, Juan.
