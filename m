Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1edTCC-0006I5-7I
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1edTC9-0005Sd-6N
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:54:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1edTC8-0005Rg-WF
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:54:53 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<20180115135620.GG13238@stefanha-x1.localdomain>
	<9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
	<20180118105103.GC19831@stefanha-x1.localdomain>
	<78448708-8d53-70ca-d079-424caabc3a35@redhat.com>
	<20180119172049.GA29973@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c05c203-7d1f-dbea-5577-4d85c42e82ee@redhat.com>
Date: Mon, 22 Jan 2018 11:54:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180119172049.GA29973@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 2018=E5=B9=B401=E6=9C=8820=E6=97=A5 01:20, Stefan Hajnoczi wrote:
>> I don't propose any new idea. I just want to know what's the advantage=
 of
>> vhost-pci over zerocopy. Both needs one time of copy, the difference i=
s the
>> vhost-pci did it inside a guest but zerocopy did in on host.
> Exitless VM2VM communication is desirable if you cannot run software on
> the host or if both endpoints are already in VMs.  In that case running
> one thing in a VM and another on the host doesn't make sense.

Well, I must have missed anything, I don't see why we can not run=20
virtio-net backend on host. Especially it only does L2 stuffs, higher=20
level of service could be provided by another VM for sure. So it looks=20
to me virtio-vhost-user is just a split device implementation which is=20
irreverent to the service it could provide.

Maybe you can provide a concrete examples of virtio-vhost-user and its=20
advantages?

>
> The obvious environment where this applies is in the cloud where
> everything is a VM.

So a typical setup makes the VMs can already talk to each other through=20
ethernet(virtio-net). Virtio-vhost-user looks much less flexible than=20
exist stuffs. The only possible advantage of virtio-vhost-user is its=20
performance or security which still need to be proved.

Thanks
