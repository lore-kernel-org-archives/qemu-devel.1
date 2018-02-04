Received: from eggs.gnu.org ([2001:4830:134:3::10]:35899)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eiRr2-0004bS-TH
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eiRqx-0002KK-Me
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:29:40 -0500
Received: from verein.lst.de ([213.95.11.211]:60195 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eiRqx-0002JJ-FG
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 16:29:35 -0500
Date: Sun, 4 Feb 2018 22:29:32 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180204212932.GB24905@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-12-git-send-email-mjc@sifive.com>
	<20180108143105.GC10273@lst.de>
	<CAHNT7Nss8ewkpgo2OTPpBV11WaisgU5a-h22-AbotyKdVqjxwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Nss8ewkpgo2OTPpBV11WaisgU5a-h22-AbotyKdVqjxwg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Mon, Feb 05, 2018 at 09:19:46AM +1300, Michael Clark wrote:
> BTW I've created branches in my own personal trees for Privileged ISA
> v1.9.1. These trees are what I use for v1.9.1 backward compatibility
> testing in QEMU:
> 
> - https://github.com/michaeljclark/riscv-linux/tree/riscv-linux-4.6.2
> - https://github.com/michaeljclark/riscv-pk/tree/bbl-1.9.1

What MMU-enabled chips that implement 1.9.1 are out there?  If there
is enough we should support this with a compile time option in the
Linux kernel as well.

> We need to be a little more disciplined with software releases, especially
> when there are backward incompatible changes in the specification. The
> repos need to be branched and tagged. It should be possible to somehow
> derive the conformance level. Perhaps the SBI should have an API for this.
> This is one of the driving reasons behind adding version conformance levels
> to QEMU. Previously we had repos in a state of flux and if you didn't have
> the magic commit ids you were out of luck. For example, when we have
> priv isa v1.11 released, we will still need a priv isa v1.10 mode which
> masks out all of the new features. Given there are no "feature bits"
> besides the extensions "IMAFDSU", all we have to go on presently is the
> privileged ISA spec version number.

As far as I can tell privileged ISA changes post 1.10 should be backwards
compatible and only implemement detectable optional CSRs and instructions.

That being said I started a thread on that on the privileged spec list
where I need to follow up on Andrews mail once I get back to my work
mail after a little vacation.
