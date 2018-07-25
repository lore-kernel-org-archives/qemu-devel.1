Received: from eggs.gnu.org ([2001:4830:134:3::10]:36511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiMCA-00059g-8w
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiMC7-0007ck-BX
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 11:59:22 -0400
Date: Wed, 25 Jul 2018 16:59:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180725155908.GI12855@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
	<32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
	<499d5d12-cdba-76e4-3b2e-122675ef9eec@janustech.com>
	<20180725133243.GC4879@localhost.localdomain>
	<dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd4a32bc-845c-f529-51a8-71c978f93861@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Jul 25, 2018 at 06:23:45PM +0300, Leonid Bloch wrote:
> On 07/25/2018 04:32 PM, Kevin Wolf wrote:
> > >          Another interesting question is whether 'full' shouldn't keep meaning
> > >          full throughout the lifetime of the BlockDriverState, i.e. should it
> > >          keep adapting to the new size when the image size changes?
> > > 
> > > 
> > >      Do we even resize the cache now for image size changes? If we use an enum,
> > >      we could have two different values depending on whether the chosen cache
> > >      size remains fixed or also tries to resize when the image grows.
> > 
> > We don't because we only support absolute cache sizes today. 'full'
> > would be the first one that is relative to the image size.
> > 
> > > Is it even possible to change the virtual disk image size online?
> > 
> > Yes, this is what qcow2_co_truncate() does (can be invoked, amongst
> > others, with the QMP command 'block_resize').
> 
> Cool! This does look like a good idea to resize the L2 cache accordingly,
> but maybe this is out of scope for now as well? The purpose of the current
> series is just to provide an option to automatically calculate the needed L2
> cache size for covering the entire image, instead of using an external
> script to do that and feed the output to l2-cache-size.

Personally if I saw the description of the option and then found it didn't
"do the right thing" when resizing I'd consider the option broken. So I
think we should make it deal with resizes right away rather than implementing
a known bug.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
