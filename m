Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dx8RT-00057M-G6
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dx8RP-0007BH-LD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dx8RP-0007A2-EI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E039C550B0
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 09:15:37 +0000 (UTC)
Date: Wed, 27 Sep 2017 10:15:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927091531.GA12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170926111757.3628-1-kraxel@redhat.com>
	<7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f50b7bb-bbf7-7e0e-754a-234d4244fb72@redhat.com>
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

On Wed, Sep 27, 2017 at 09:19:22AM +0200, Paolo Bonzini wrote:
> On 26/09/2017 13:17, Gerd Hoffmann wrote:
> > 
> > Ok, we want for varios reasons separate the firmware from the main
> > qemu repo.  Here is my attempt to create such a repo.  For starters
> > only seabios has been added here.
> > 
> > You can find the repo with currently three patches here:
> >     https://www.kraxel.org/cgit/qemu-firmware/
> > 
> > This "series" is only patch #2 of the repo.  Havn't found a way to
> > convince git-format-patch to include the initial commit of a repo.
> > But patch #1 (the initial commit) only adds the seabios submodule,
> > patch #3 adds the binary blobs, so patch #2 actually is the most
> > interesting one.
> 
> Are you planning to include only submodules, or also "QEMU-native"
> firmware such as linuxboot, kvmvapic, s390-ccw, spapr-rtas, etc.?

The submodules make sense to split out because distro vendors buld them
independently of QEMU, and would rather not have them in the tarballs,
so they have a clearer path to license compliance and legal export
certification.

The other bits of mention are all built normally as part of QEMU and
not subject to these problems, so I don't see a benefit to splitting
them out of QEMU. In fact putting those bits in the qemu-firmware
repo would re-introduce the problem we're trying to solve because
distros would then need to get linuxboox, kvmvapi etc from a tarball
of qemu-firmware which would once again include all the bits they
don't want to have.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
