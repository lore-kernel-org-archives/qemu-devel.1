Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSFK8-0007SC-Fl
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSFK7-00059V-I9
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:48:12 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cSFK7-00059J-C7
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:48:11 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so125023pgf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:48:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170112114612.14520-1-stefanha@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7652aff-6366-e32d-5678-f949bad2f2d8@twiddle.net>
Date: Fri, 13 Jan 2017 19:48:08 -0800
MIME-Version: 1.0
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Doug Goldstein <cardoe@cardoe.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/2017 03:46 AM, Stefan Hajnoczi wrote:
> The virtio_queue_set_notification() nesting introduced for AioContext polling
> raised an assertion with virtio-net (even in non-polling mode).  Converting
> virtio-net and virtio-crypto to use virtio_queue_set_notification() in a
> nesting fashion would be invasive and isn't worth it.
>
> Patch 1 contains the revert to resolve the bug that Doug noticed.
>
> Patch 2 is a less efficient but safe alternative.
>
> Stefan Hajnoczi (2):
>   Revert "virtio: turn vq->notification into a nested counter"
>   virtio: disable notifications again after poll succeeded
>
>  hw/virtio/virtio.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Tested-by: Richard Henderson <rth@twiddle.net>

This problem affected Alpha as well.  I tested the two patches together.


r~
