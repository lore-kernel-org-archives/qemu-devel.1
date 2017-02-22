Received: from eggs.gnu.org ([2001:4830:134:3::10]:46738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgOGd-0004r3-UJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 23:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgOGa-0004PN-OV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 23:11:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cgOGa-0004PE-IL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 23:11:00 -0500
Date: Wed, 22 Feb 2017 12:10:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170222041055.GC17314@pxdev.xzpeter.org>
References: <20170221214228.12515.79751.stgit@gimli.home>
	<20170222030851.GA17314@pxdev.xzpeter.org>
	<20170221205431.6e7f3757@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170221205431.6e7f3757@t450s.home>
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Improve extended capability
 comments, skip masked caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Tue, Feb 21, 2017 at 08:54:31PM -0700, Alex Williamson wrote:

[...]

> I prefer the existing code.  I don't really see why you consider it a
> hack.  I think it's pretty elegant that we can ignore the header
> through the course of iterating through the capabilities, that we drop
> other masked capabilities out of the chain, and that we can so easily
> and transparently insert a zero ID at the end to serve the dual purpose
> of replacing the temporary ID and nullifying the list if nothing was
> added.  The 0xffff capability ID is a perfectly safe assumption, not
> only are we ridiculously far from allocating that ID, but it's arguably
> a reserved value due to its use in the root complex register block.  I
> also don't see any evidence that it's error prone, the entire point is
> that we can arbitrarily skip capability IDs in the body of the loop and
> the result is a correct, minimal capability chain.  OTOH, leaving
> masked capabilities in the chain with an arbitrary version number seems
> messy.

I see. Then please also pick this one:

Tested-by: Peter Xu <peterx@redhat.com>

> 
> The real question is why are you sneaking the virtual channel
> capability into the list of masked capabilities?  Thanks,

Oooops. I should remove that line. It's for my testing purpose (I need
to "fake" a device that with 0x100 masked to test my patch, while my
SD card reader did has this VC cap at 0x100 :-). Since we now have a
choice already, please just ignore that line along with the whole
patch. ;)

Thanks,

-- peterx
