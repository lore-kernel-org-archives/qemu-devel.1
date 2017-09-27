Received: from eggs.gnu.org ([2001:4830:134:3::10]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxB2A-0002V8-UR
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxB21-0001zM-EV
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxB21-0001yt-7j
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39E53C6563
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 12:01:36 +0000 (UTC)
Date: Wed, 27 Sep 2017 13:01:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927120106.GC12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170926111757.3628-1-kraxel@redhat.com>
	<7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
	<20170927091531.GA12223@redhat.com>
	<24f9a9d3-91d8-7828-4f00-ab0856e17415@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24f9a9d3-91d8-7828-4f00-ab0856e17415@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/1] qemu-firmware repo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Wed, Sep 27, 2017 at 01:34:12PM +0200, Paolo Bonzini wrote:
> On 27/09/2017 11:15, Daniel P. Berrange wrote:
> > On Wed, Sep 27, 2017 at 09:19:22AM +0200, Paolo Bonzini wrote:
> >> Are you planning to include only submodules, or also "QEMU-native"
> >> firmware such as linuxboot, kvmvapic, s390-ccw, spapr-rtas, etc.?
> > 
> > The submodules make sense to split out because distro vendors buld them
> > independently of QEMU, and would rather not have them in the tarballs,
> > so they have a clearer path to license compliance and legal export
> > certification.
> > 
> > The other bits of mention are all built normally as part of QEMU and
> > not subject to these problems, so I don't see a benefit to splitting
> > them out of QEMU.
> 
> They aren't rebuilt in general.  You end up with x86 builds of
> qemu-system-x86 rebuilding linuxboot, ppc builds of qemu-system-ppc
> rebuilding spapr-rtas, etc. (search configure for "roms=").  In fact,
> QEMU has a special exception in Fedora just because these are too hard
> to untangle.
> 
> So the advantage would be the ability to introduce better infrastructure
> for cross compilation, without complicating further the QEMU build system.

Ah I see.

> 
> > putting those bits in the qemu-firmware
> > repo would re-introduce the problem we're trying to solve because
> > distros would then need to get linuxboox, kvmvapi etc from a tarball
> > of qemu-firmware which would once again include all the bits they
> > don't want to have.
> 
> This is true.  We could distribute a qemu-firmware tarball with just the
> QEMU-specific bits, and a qemu-firmware-all tarball with also those that
> are built separately.

Yep, as long as there's a tarball for the QEMU bits that does not
contain the 3rd party bits, that would work.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
