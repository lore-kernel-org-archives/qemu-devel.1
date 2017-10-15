Received: from eggs.gnu.org ([2001:4830:134:3::10]:57795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3hvQ-00017v-13
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 08:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3hvM-0003OD-S7
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 08:21:48 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:45398)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e3hvM-0003Nv-FR
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 08:21:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 15 Oct 2017 23:21:41 +1100
From: geoff@hostfission.com
In-Reply-To: <3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
Message-ID: <286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ladi Prosek <lprosek@redhat.com>

Hi Yan,

Thank you for the information. I am rather new to Windows Driver=20
development and learning as I go, so this may take some time, but since=20
the driver only needs to perform very basic functions I do not see this=20
as being too much of a challenge.

-Geoff

On 2017-10-15 22:14, Yan Vugenfirer wrote:
> He Geoff,
>=20
> The official virtio-win drivers upstream repository is here:
> https://github.com/virtio-win/kvm-guest-drivers-windows
>=20
> 1. There is no ivshmem Windows Driver for now as far as I know
>=20
> 2. We are signing the drivers for community usage
> https://fedoraproject.org/wiki/Windows_Virtio_Drivers from the same
> repository.
> The process will be: submit the code for review with pull request
> (better use existing virtio library for virtio communication between
> the guest and the host), pass internal tests and at the least being
> able to pass MS HCK\HLK tests, later on the driver will be pulled into
> official build and release with rest of the drivers for community
> usage.
> 3. We are happy to cooperate on adding new functionality to current
> package of virtio drivers for Windows
> 4. As already mentioned:=20
> https://github.com/virtio-win/kvm-guest-drivers-windows
>=20
> Thanks a lot!
>=20
> If you have more questions, please don=E2=80=99t hesitate to talk to me=
, Ladi
> or anyone else from Red Hat involved with virtio-win development.
>=20
> Best regards,
> Yan.
>=20
>> On 15 Oct 2017, at 12:32, geoff--- via Qemu-devel=20
>> <qemu-devel@nongnu.org> wrote:
>>=20
>> Hi All,
>>=20
>> I am writing some code that needs to share a block of ram between a=20
>> Windows guest and Linux host. For this I am using the ivshmem device=20
>> and I have written a very primitive driver for windows that allows a=20
>> single application to request to memory map the pci bar (shared=20
>> memory) into the program's context using DeviceIoControl.
>>=20
>> This is all working fine, but the next problem is I need the driver to=
=20
>> be signed. In it's current state I would not even suggest it be signed=
=20
>> as it was just hacked together to test my concept, but now I know it's=
=20
>> viable I would be willing to invest whatever time is required to write=
=20
>> a driver that would be acceptable for signing.
>>=20
>> The ideal driver would be general purpose and could be leveraged for=20
>> any user mode application use, not just my specific case. It would=20
>> need to implement the IRQ/even features of ivshmem and possibly even=20
>> some kind of security to prevent unauthorized use by rogue=20
>> applications (shared secret configured on the chardev?).
>>=20
>> I have several qustions:
>>=20
>>  1) Has someone done this? I can't find any reference to a windows=20
>> driver for this device anywhere.
>>  2) If I was to pursue writing this driver, how would be the best way=20
>> to go about it so as to ensure that it is in a state that it could be=20
>> signed with the RedHat vendor key?
>>  3) What is the likelihood of having such a driver signed?
>>  4) Is there a preferred git host for such a driver?
>>=20
>> Kind Regards
>> -Geoff
>>=20
