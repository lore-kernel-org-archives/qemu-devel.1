Received: from eggs.gnu.org ([2001:4830:134:3::10]:46122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYHr-0004TT-75
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYHq-00016o-2v
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:48:11 -0400
Date: Fri, 21 Jul 2017 14:47:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721134754.GP17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721115608.GC4228@noname.redhat.com>
	<f184e2a9-7832-c9f5-37c0-91b773ca1e33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f184e2a9-7832-c9f5-37c0-91b773ca1e33@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Do OFD lock check at runtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, jsnow@redhat.com, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, Jul 21, 2017 at 07:34:11AM -0500, Eric Blake wrote:
> On 07/21/2017 06:56 AM, Kevin Wolf wrote:
> >>
> >> Convert to runtime check to cope with that.
> > 
> > Fair enough in this specific case because we still support older Linux
> > kernels and we want to fail gracefully if the binary was built against
> > a newer kernel.
> 
> Or, more likely: if we are built against a newer glibc (that has the
> constants) but an older kernel (that lacks support for the constants).
> 
> > 
> > However, I think the real problem here is with the WSL ecosystem if qemu
> > is routinely built against a real Linux while WSL doesn't provide the
> > same functionality. WSL should provide kernel headers that match what
> > it can provide (i.e. either remove the unimplemnted constants or
> > implement them).
> 
> In other words, you're arguing that binaries built for WSL should be
> cross-compiled rather than native compiled (similar to how mingw
> binaries are built in a Cygwin environment), such that the
> cross-compiler picks up the correct altered headers for WSL limitations.
>  I agree - but I have no influence on how likely that is to come about.

IIUC, the core selling point of WSL was that you can take an existing
Ubuntu (or now various other Linux) distro  and just run it "as is",
without recompiling its specially.  So this really is best thought
of as the build with new glibc+kernel, but run on old kernel scenario.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
