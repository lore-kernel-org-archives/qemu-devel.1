Received: from eggs.gnu.org ([2001:4830:134:3::10]:42214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOjPQ-0006V2-EY
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOjPP-0000k5-EV
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:43:56 -0400
Date: Fri, 1 Jun 2018 13:43:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601124345.GC3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601091835.21620-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
> When hot-plugging a block device fails due to image locking errors,
> users won't see the helpful 'Is another process using the image?'
> message in QMP because currently the error hint is not carried over
> there.
> 
> Even though extending QMP to include hint is a conceivably easy task,
> Libvirt will need some change to consume that data.
> 
> Before that is fully sorted out, let's just do the easy fix by joining
> the two lines.

There are many places in QEMU which uses error hints and these are all
invisible to libvirt. Arbitrarily picking one hint to remove, while
leaving everything else unfixed is not a very satisfactory approach.

If QEMU passes the hint in QMP, it is trivial for libvirt to be changed
to append the hint when reporting its own error message, so can we just
focus on fixing the root cause instead of special casing file-posix.c


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
