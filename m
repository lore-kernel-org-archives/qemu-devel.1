Received: from eggs.gnu.org ([2001:4830:134:3::10]:38376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzIV-0002Y6-Jj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVzIU-0000cm-Ka
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:29:59 -0500
Date: Tue, 24 Jan 2017 11:29:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124112946.GG14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <0bb184fe-d348-a1d4-ac14-0f02f070c287@kamp.de>
	<20170119163845.GC16641@redhat.com>
	<8e98321f-70ce-f86a-37d3-de2c1a5f45bd@kamp.de>
	<20170119170355.GF16641@redhat.com>
	<dde6f36e-e78a-1d93-54fb-1914eea9aee1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dde6f36e-e78a-1d93-54fb-1914eea9aee1@redhat.com>
Subject: Re: [Qemu-devel] qemu-img: complains about missing iscsi option
 group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Tue, Jan 24, 2017 at 12:24:02PM +0100, Paolo Bonzini wrote:
> 
> 
> On 19/01/2017 18:03, Daniel P. Berrange wrote:
> >>> Move the iscsi option registration out of vl.c and back into a shared file
> >>> in block/ such that all programs see the options, not just the emulators.
> >> Any preference which file? It seems no other block driver registers options.
> > ISCSI is somewhat bizarre in that it has a separate global -iscsi arg
> > instead of just accepting all args via the -drive spec like every other
> > block driver does, so there's no precedent to follow.
> > 
> > So suggest we just need a block/iscsi-global.c to deal with this.
> 
> Why not block/iscsi.c itself?

block/iscsi.c is a module, so not linked to qemu emulators by default.
You could still have the iscsi options in that file if you used a
conditional and built the same file twice with different content,
but it seems easier to just use a separate file


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
