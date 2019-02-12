Received: from eggs.gnu.org ([209.51.188.92]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtS2V-0008RG-NF
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtS2U-0000Pw-NR
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:59:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gtS2U-0000Da-Ea
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:59:30 -0500
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
	<20190211095049-mutt-send-email-mst@kernel.org>
	<20190212035505.GE28401@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <983efa73-16e3-65e1-ee4e-8df1d8591979@redhat.com>
Date: Tue, 12 Feb 2019 14:59:02 +0800
MIME-Version: 1.0
In-Reply-To: <20190212035505.GE28401@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Kuchin <antonkuchin@yandex-team.ru>


On 2019/2/12 =E4=B8=8A=E5=8D=8811:55, Stefan Hajnoczi wrote:
> On Mon, Feb 11, 2019 at 09:52:01AM -0500, Michael S. Tsirkin wrote:
>> On Mon, Feb 11, 2019 at 04:40:44PM +0300, Anton Kuchin wrote:
>>> As far as I can see currently IOThread offloading is used only for bl=
ock
>>> devices and all others are emulated by main thread.
>>>
>>> I expect that network devices can also benefit from processing in sep=
arate
>>> thread but I couldn't find any recent work in this direction. I'm goi=
ng to
>>> implement a PoC but I want to ask if you know any previous attempts a=
nd do
>>> you know why it can be a total waste of time. Are there fundamental
>>> obstacles that prevent network emulation handling in IOThread?
>> No but vhost-net is there. Unlike block where you gain lots of
>> functionality such as snapshots there seems to be little to
>> be gained by doing it in userspace.
> Anthony Liguori tried virtio-net in a dedicated thread a long time ago
> but it was never completed/merged.
>
> I think the argument for vhost-net in the kernel is that userspace
> doesn't offer the same APIs as the kernel.  For example, is zero copy
> possible from userspace?


Actually, it will be simpler than doing it at kernel somehow. E.g=20
technically, you can write a userspace NIC driver in qemu to achieve=20
that or doing it through dpdk pmd.

Thanks


>
> Anton: If you want to do virtio-net in userspace, QEMU has
> vhost-user-net support so you can perform emulation in a separate
> process.
>
> Stefan
