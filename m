Received: from eggs.gnu.org ([2001:4830:134:3::10]:46821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBqA-0001s1-5M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBq6-0006GA-0b
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLBq5-0006Fx-Q3
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:12:17 -0400
References: <149745954462.1611.12282014261512444009@4a9a010726c0>
	<F0D8D81A-19F6-4311-95C6-B30B38FCB2BC@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd443e75-eec3-b5fc-1acc-3d4a152db655@redhat.com>
Date: Wed, 14 Jun 2017 19:12:13 +0200
MIME-Version: 1.0
In-Reply-To: <F0D8D81A-19F6-4311-95C6-B30B38FCB2BC@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: support cross-endianess
 negatiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>, QEMU Developers <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>
Cc: Mike Cui <cui@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>



On 14/06/2017 19:02, Felipe Franciosi wrote:
>=20
>> On 14 Jun 2017, at 17:59, no-reply@patchew.org wrote:
>>
>> Hi,
>>
>> This series failed automatic build test. Please find the testing comma=
nds and
>> their output below. If you have docker installed, you can probably rep=
roduce it
>> locally.
>>
>> Message-id: 1497458486-15673-1-git-send-email-felipe@nutanix.com
>> Type: series
>> Subject: [Qemu-devel] [PATCH] vhost-user: support cross-endianess nega=
tiation
>>
> ...
>>
>>  CC      hw/pci-bridge/pci_expander_bridge.o
>> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
>> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinitio=
n of typedef =E2=80=98LoadStateHandler=E2=80=99
>> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decl=
aration of =E2=80=98LoadStateHandler=E2=80=99 was here
>> make: *** [hw/net/vmxnet3.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> tests/docker/Makefile.include:118: recipe for target 'docker-run' fail=
ed
>> make[1]: *** [docker-run] Error 2
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-enl3ixyr/src'
>> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-=
build@min-glib' failed
>> make: *** [docker-run-test-build@min-glib] Error 2
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
>> Test command exited with code: 2
>=20
> That seems completely unrelated to what our patch touched... I'm gonna =
guess this is a known issue and I can safely ignore it?

Yes.

Juan, can you take a look?  Just removing the typedef from
VMStateDescription, and instead just using int(*load_state_old)(etc...)
should do it.

Paolo
