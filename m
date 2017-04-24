Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2aZt-0002VC-SB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2aZs-0006kZ-RP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:46:41 -0400
Date: Mon, 24 Apr 2017 10:46:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424094628.GG20809@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170424091659.26708-1-berrange@redhat.com>
	<20170424091659.26708-4-berrange@redhat.com>
	<20170424094512.GC14416@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170424094512.GC14416@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Apr 24, 2017 at 05:45:12PM +0800, Fam Zheng wrote:
> On Mon, 04/24 10:16, Daniel P. Berrange wrote:
> > The '--image-opts' flags indicates whether the source filename
> 
> s/flags/flag/ or s/indicates/indicate/, I think?

Yes to the first, no to the second

> > includes options. The target filename has to remain in the
> > plain filename format though, since it needs to be passed to
> > bdrv_create().  When using --skip-create though, it would be
> > possible to use image-opts syntax. This adds --target-image-opts
> > to indicate that the target filename includes options. Currently
> > this mandates use of the --skip-create flag too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
