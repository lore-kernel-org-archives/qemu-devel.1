Received: from eggs.gnu.org ([2001:4830:134:3::10]:58397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etsgn-0006wZ-DV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etsgj-0006YG-D7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:22:21 -0500
Date: Thu, 8 Mar 2018 10:21:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308102153.GH4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307185946.29366-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307185946.29366-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/37] x-blockdev-create for protocols
 and qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, pkrempa@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, namei.unix@gmail.com

On Wed, Mar 07, 2018 at 07:59:09PM +0100, Kevin Wolf wrote:
> This series implements a minimal QMP command that allows to create an
> image file on the protocol level or an image format on a given block
> node.
> 
> Eventually, the interface is going to change to some kind of an async
> command (possibly a (non-)block job), but that will require more work on
> the job infrastructure first, so let's first QAPIfy image creation in
> the block drivers. In this series, I'm going for a synchronous command
> that is prefixed with x- for now.
> 
> This series converts qcow2 and all protocol drivers that allow an actual
> image creation. This means that drivers which only check if the already
> existing storage is good enough are not converted (e.g. host_device,
> iscsi). The old behaviour was useful because 'qemu-img create' wants to
> create both protocol and format layer, but with the separation in QMP,
> you can just leave out the protocol layer creation when the device
> already exists.

Are you going to convert the other format drivers in later versions of
this series, or leave it upto individual maintaniers to convert the
rest ? (personally thinking of the luks driver of course)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
