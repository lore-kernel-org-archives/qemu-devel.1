Received: from eggs.gnu.org ([2001:4830:134:3::10]:48578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g00Pm-0003ek-4A
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g00Ph-0001lA-6z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:22:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1g00Ph-0001l0-1c
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:22:17 -0400
References: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <36edb90f-3ea0-e9d4-1f4c-6ea459fdbd57@redhat.com>
Date: Wed, 12 Sep 2018 16:22:08 +0800
MIME-Version: 1.0
In-Reply-To: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio-net sporadic error with QNX 7.0 guest:
 virtio-net ctrl missing headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio <claudio.fontana@gliwa.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org



On 2018=E5=B9=B409=E6=9C=8812=E6=97=A5 16:01, Claudio wrote:
> Hello Michael, Jason and all,
>
> I am currently using latest mainline QEMU on x86_64 to run a QNX 7 gues=
t.
>
> QNX 7 is not free software anymore unfortunately, with the
> the last open source versions in the 6.x range.
>
> I am using the official virtio-net guest driver from QNX 7.
>
> During initialization I sporadically get this error message:
>
> $ qemu-system-x86_64 -machine pc,accel=3Dkvm,kernel_irqchip=3Don -smp 2=
 -m 2048 -display none -nodefconfig -nodefaults -chardev stdio,mux=3Don,i=
d=3Dchar0 -serial chardev:char0 -monitor none -mon chardev=3Dchar0,mode=3D=
readline -netdev user,id=3Duser0,hostfwd=3Dudp::9004-:9004 -device virtio=
-net,netdev=3Duser0 qnx.img
>
> virtio-net ctrl missing headers
>
> and following that my host->guest UDP port forwarding does not work, th=
at is,
> the qemu process shows up as listening on the interface, but no packets=
 appear in the guest.
>
> This error during initialization does not appear every time I launch QE=
MU.
> It appears to be more or less random.
>
> Whenever the error does not appear, the interface works as expected, an=
d port forwarding works.
>
> Latest commit is
>
> 19b599f7664b ("Merge remote-tracking branch 'remotes/armbru/tags/pull-e=
rror-2018-08-27-v2'")
>
> Thanks a lot for any advice!
>
> Ciao,
>
> Claudio
>

Hi:

Please try some early qemu version to make sure it's not a regression of=20
qemu. And if 6.X works, it could be bug of guest driver.

Thanks
