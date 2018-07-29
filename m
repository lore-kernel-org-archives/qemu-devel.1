Received: from eggs.gnu.org ([2001:4830:134:3::10]:46128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1fjk7U-0002JB-1B
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yvugenfi@redhat.com>) id 1fjk7Q-0000Xm-UR
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:44:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yvugenfi@redhat.com>) id 1fjk7Q-0000XO-P0
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 07:44:12 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <CAHyh4xhOWbhs50jsT1_SzKqaGoiaZH3oLto_x7QE8UNfW+9M7g@mail.gmail.com>
Date: Sun, 29 Jul 2018 14:44:07 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6A12E36-F118-473C-B90A-B4F897334D1F@redhat.com>
References: <CAHyh4xjUmwHr7b=92y7YUwKGSW0o+FUMwJLSehdzuFc3R6eLTg@mail.gmail.com>
	<20180724055501.GA2479@xz-mi>
	<CAHyh4xhOWbhs50jsT1_SzKqaGoiaZH3oLto_x7QE8UNfW+9M7g@mail.gmail.com>
Subject: Re: [Qemu-devel] Virtual IOMMU + Virtio-net devices in a Windows VM
 doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>



> On 26 Jul 2018, at 05:53, Jintack Lim <jintack@cs.columbia.edu> wrote:
>=20
> Hi Peter,
>=20
> On Tue, Jul 24, 2018 at 1:55 AM Peter Xu <peterx@redhat.com> wrote:
>>=20
>> On Mon, Jul 23, 2018 at 04:13:18PM -0400, Jintack Lim wrote:
>>> Hi,
>>>=20
>>> I'm running a Windows VM on top of KVM on x86, and one of virtio-net
Hi,

What Windows OS are you using? Keep in mind that IOMMU support in =
Windows drivers will work in Windows 10 and Windows Server 2016.
What=E2=80=99s the version of the virtio-win drivers are you using =
(should be build 150 and up, or to include the following commit: =
https://github.com/virtio-win/kvm-guest-drivers-windows/commit/eac3270d109=
24903ff38a08fcdaa252604d2e4a9)?

Best regards,
Yan.

>>> device in the Windows VM doesn't seem to work. I provided virtual
>>> IOMMU and two virtio-net devices to the VM: one bypassing the =
virtual
>>> IOMMU and the other one behind the virtual IOMMU[1]. It turned out
>>> that the virtio-net device behind virtual IOMMU didn't work while =
the
>>> one bypassing the virtual IOMMU worked well. In a linux VM with the
>>> same configuration, both of virtio-net device worked well.
>>>=20
>>> I found that there is a subtle difference between virtio-net devices
>>> bypassing and behind virtual IOMMU in a Linux VM. The lscpu command =
in
>>> the Linux VM shows different device names for them; the first line =
is
>>> for the bypassing one, and the second line is for the one behind the
>>> virtual IOMMU
>>>=20
>>> 00:03.0 Ethernet controller: Red Hat, Inc Virtio network device
>>> 01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
>>>=20
>>> I wonder if this difference somehow caused the problem in the =
Windows
>>> VM. I've installed the latest virtio drivers (0.1.149) from the =
fedora
>>> project [2]
>>>=20
>>> Any thoughts?
>>>=20
>>> I'm using v4.15 Linux kernel as a host, and QEMU 2.11.0.
>>=20
>> Have you tried the latest QEMU?
>>=20
>=20
> I just tried the latest QEMU, but observed the same symptom.
>=20
>> Also CC Jason and Michael.
>=20
> Thanks!
>=20
>>=20
>>>=20
>>> Thanks,
>>> Jintack
>>>=20
>>> [1] https://wiki.qemu.org/Features/VT-d
>>> [2] =
https://docs.fedoraproject.org/quick-docs/en-US/creating-windows-virtual-m=
achines-using-virtio-drivers.html
>>>=20
>>>=20
>>=20
>> Regards,
>>=20
>> --
>> Peter Xu
>>=20
>=20
>=20
