Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvKbH-0004qv-Hu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvKbG-0002S6-NI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:50:23 -0400
Date: Fri, 22 Sep 2017 10:50:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170922095007.GI12725@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Truncate the tail of the image file
 in qcow2 shrinking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

On Fri, Sep 22, 2017 at 12:39:24PM +0300, Pavel Butsykin wrote:
> Now after shrinking the qcow2 image, at the end of the image file, there might
> be a tail that probably will never be used. Although it will not bring any
> tangible benefit, we can cut the tail if it is. Yes, it will not free up disk
> space, but if the blocks were be allocated sequentially and the image is not
> heavily fragmented then the virtual size of the image file will be commensurate
> with the real size. It also doesn't look like a great plus.. Well, at least we
> can discuss it.

If the block backend has discard support enabled, can't we get the tail
to be discarded rather than merely truncated ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
