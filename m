Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU8ef-0001qS-5u
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cU8eb-0007FN-90
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:05:13 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-5-git-send-email-mst@redhat.com>
	<14ee35d6-3b41-31da-69d6-5d25da95548b@redhat.com>
	<20170118210535-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <209114d7-8884-5f15-948c-e8be674b8e95@redhat.com>
Date: Thu, 19 Jan 2017 10:05:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170118210535-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 04/41] virtio: convert to use DMA api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit.shah@redhat.com>



On 18/01/2017 20:10, Michael S. Tsirkin wrote:
>> Coverity reports that ARRAY_SIZE(elem->out_sg) (and all the others too)
>> is wrong because elem->out_sg is a pointer.
>>
>> However, the check is not in the right place and the max_size argument
>> of virtqueue_map_iovec can be removed.  The check on in_num/out_num can
>> be moved to qemu_get_virtqueue_element instead, before the call to
>> virtqueue_alloc_element.
>
> I guess the effect of this bug is basically false-positive asserts, correct?

Yes, migration is probably broken in the case where the stream includes
VirtQueueElements.

Paolo
