Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1e3gsN-0000fZ-B3
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 07:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1e3gsK-0002BS-3l
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 07:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1e3gsJ-0002Ak-RE
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 07:14:32 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <5548e41a5668ec0cba9543139327e035@hostfission.com>
Date: Sun, 15 Oct 2017 14:14:25 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Ladi Prosek <lprosek@redhat.com>

He Geoff,

The official virtio-win drivers upstream repository is here: =
https://github.com/virtio-win/kvm-guest-drivers-windows

1. There is no ivshmem Windows Driver for now as far as I know

2. We are signing the drivers for community usage =
https://fedoraproject.org/wiki/Windows_Virtio_Drivers from the same =
repository.=20
The process will be: submit the code for review with pull request =
(better use existing virtio library for virtio communication between the =
guest and the host), pass internal tests and at the least being able to =
pass MS HCK\HLK tests, later on the driver will be pulled into official =
build and release with rest of the drivers for community usage.
3. We are happy to cooperate on adding new functionality to current =
package of virtio drivers for Windows
4. As already mentioned: =
https://github.com/virtio-win/kvm-guest-drivers-windows

Thanks a lot!

If you have more questions, please don=E2=80=99t hesitate to talk to me, =
Ladi or anyone else from Red Hat involved with virtio-win development.

Best regards,
Yan.

> On 15 Oct 2017, at 12:32, geoff--- via Qemu-devel =
<qemu-devel@nongnu.org> wrote:
>=20
> Hi All,
>=20
> I am writing some code that needs to share a block of ram between a =
Windows guest and Linux host. For this I am using the ivshmem device and =
I have written a very primitive driver for windows that allows a single =
application to request to memory map the pci bar (shared memory) into =
the program's context using DeviceIoControl.
>=20
> This is all working fine, but the next problem is I need the driver to =
be signed. In it's current state I would not even suggest it be signed =
as it was just hacked together to test my concept, but now I know it's =
viable I would be willing to invest whatever time is required to write a =
driver that would be acceptable for signing.
>=20
> The ideal driver would be general purpose and could be leveraged for =
any user mode application use, not just my specific case. It would need =
to implement the IRQ/even features of ivshmem and possibly even some =
kind of security to prevent unauthorized use by rogue applications =
(shared secret configured on the chardev?).
>=20
> I have several qustions:
>=20
>  1) Has someone done this? I can't find any reference to a windows =
driver for this device anywhere.
>  2) If I was to pursue writing this driver, how would be the best way =
to go about it so as to ensure that it is in a state that it could be =
signed with the RedHat vendor key?
>  3) What is the likelihood of having such a driver signed?
>  4) Is there a preferred git host for such a driver?
>=20
> Kind Regards
> -Geoff
>=20
