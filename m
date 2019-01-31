Received: from eggs.gnu.org ([209.51.188.92]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpGIj-0004qV-Bk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpGIi-0004Lq-HG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:38:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gpGIi-0004LC-A5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:38:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so4321783wrp.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:38:56 -0800 (PST)
Date: Thu, 31 Jan 2019 18:38:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190131173852.dxv44lcv2ql2mbam@steredhat>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131121412-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131121412-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org

On Thu, Jan 31, 2019 at 12:15:17PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2019 at 04:19:09PM +0100, Stefano Garzarella wrote:
> > This series adds the support of DISCARD and WRITE ZEROES commands
> > and extends the virtio-blk-test to test WRITE_ZEROES command when
> > the feature is enabled.
> > 
> > v2:
> > - added patch 1 to use virtio_blk_handle_rw_error() with discard operation
> > - added patch 2 to make those new features machine-type dependent (thanks David)
> > - fixed patch 3 (previously patch 1/2) adding more checks, block_acct_start()
> >                 for WRITE_ZEROES requests, and configurable parameters to
> >                 initialize the limits (max_sectors, wzeroes_may_unmap).
> >                 (thanks Stefan)
> >                 I moved in a new function the code to handle a single segment,
> >                 in order to simplify the support of multiple segments in the
> >                 future.
> > - added patch 4 to change the assert on data_size following the discussion with
> >                 Thomas, Changpeng, Michael, and Stefan (thanks all)
> > - fixed patch 5 (previously patch 2/2) using local dwz_hdr variable instead of
> >                 dynamic allocation (thanks Thomas)
> > 
> > This series requires the new virtio headers from linux v5.0-rc1
> > already imported by Paolo:
> > 
> > Based-on: <20190104082731.24967-1-pbonzini@redhat.com>
> > 
> > Thanks,
> > Stefano
> 
> series:
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> merge through block tree I guess?
> 

I guess too.

Thanks for the review!

Stefano
