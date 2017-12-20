Received: from eggs.gnu.org ([2001:4830:134:3::10]:54946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVuv-00085N-BH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVus-00014t-66
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:23:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRVus-00014D-04
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:23:38 -0500
Date: Wed, 20 Dec 2017 06:23:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220061755-mutt-send-email-mst@kernel.org>
References: <1513350170-20168-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513350170-20168-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio: fix IO request length in
 virtio SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kraxel@redhat.com

On Fri, Dec 15, 2017 at 06:02:48PM +0300, Denis V. Lunev wrote:
> v2->v3
> - added 2.12 machine types
> - added compat properties for 2.11 machine type
> 
> v1->v2:
> - added max_segments property for virtblock device

I'm not applying this for now.

It seems too easy to create illegal configurations with it,
e.g. where max seg > queue size.

1022 also seems too aggressive - e.g. if a couple of segments
cross page boundaries, we'll exceed the iov length. around
500 seems more prudent.

Guerd, could you pls also take a look at whether seabios is
smart enough to downgrade if guest queue size is too big?

> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
