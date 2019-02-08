Received: from eggs.gnu.org ([209.51.188.92]:58478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gs19g-0000Ec-Ko
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gs19c-0004GF-My
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:04:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gs19R-00047v-Vg
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 03:04:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6158647wmd.1
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 00:04:44 -0800 (PST)
Date: Fri, 8 Feb 2019 09:04:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190208080439.t4faukc4wcgb7fvp@steredhat>
References: <20190206112729.37761-1-sgarzare@redhat.com>
	<20190208060618.GE16257@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208060618.GE16257@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Fri, Feb 08, 2019 at 02:06:18PM +0800, Stefan Hajnoczi wrote:
> On Wed, Feb 06, 2019 at 12:27:23PM +0100, Stefano Garzarella wrote:
> > This series adds the support of DISCARD and WRITE_ZEROES commands
> > and extends the virtio-blk-test to test WRITE_ZEROES command when
> > the feature is enabled.
> > 
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks Stefan!

I'll send a v4 to fix the error with mingw compiler.

Cheers,
Stefano
