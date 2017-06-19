Received: from eggs.gnu.org ([2001:4830:134:3::10]:57052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dMrGf-00051N-TQ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dMrGc-0002H1-Pu
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:38:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:44667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dMrGc-0002Er-FG
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:38:34 -0400
Message-ID: <59478003.6040709@intel.com>
Date: Mon, 19 Jun 2017 15:40:51 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
	<5943AE93.7020502@intel.com>
	<20170616181040-mutt-send-email-mst@kernel.org>
	<5944EA2E.9030608@intel.com>
	<20170618224025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170618224025-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v1] virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 06/19/2017 03:46 AM, Michael S. Tsirkin wrote:
>>>>
>>>> What do you have in mind about the protocol flag?
>>> Merely this: older clients might be confused if they get
>>> a s/g with 1024 entries.
>> I don't disagree to add that. But the client (i.e. vhost-user
>> slave) is a host userspace program, and it seems that users can
>> easily patch their host side applications if there is any issue,
>> maybe we also don't need to be too prudent about that, do we?
> I won't insist on this but it might not be easy. For example, are there
> clients that want to forward the packet to host kernel as a s/g?

Not sure about all the client implementation, but it sounds like a
strange and inefficient usage of vhost-user to pass packets to
the host kernel, given vhost kernel backend is already there
for the usage.

Best,
Wei
