Received: from eggs.gnu.org ([209.51.188.92]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtr64-0005in-9p
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gtr63-0005j2-Gb
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:44:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gtr63-0005eJ-Ay
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:44:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so1649200wmh.3
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 01:44:46 -0800 (PST)
Date: Wed, 13 Feb 2019 10:44:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190213094441.tvmsyde5lyoehlyh@steredhat>
References: <20190208134950.187665-1-sgarzare@redhat.com>
	<20190212091845-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212091845-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 12, 2019 at 09:19:13AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 08, 2019 at 02:49:44PM +0100, Stefano Garzarella wrote:
> > This series adds the support of DISCARD and WRITE_ZEROES commands
> > and extends the virtio-blk-test to test WRITE_ZEROES command when
> > the feature is enabled.
> 
> Looking at how this wasn't merged yet, maybe it's not too late.
> 
> Series:
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 

It's not too late :), but I'll send a new version fixing an issue in the
test and rebasing on top of "[PATCH v4] virtio-blk: set correct config
size for the host driver"

Thanks,
Stefano
