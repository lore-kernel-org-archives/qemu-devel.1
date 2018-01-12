Received: from eggs.gnu.org ([2001:4830:134:3::10]:48977)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eZuOy-0002d5-Ee
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eZuOt-0002Su-Gg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:09:24 -0500
Received: from verein.lst.de ([213.95.11.211]:52902 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eZuOt-0002Pf-AC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 03:09:19 -0500
Date: Fri, 12 Jan 2018 09:09:16 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180112080916.GA23324@lst.de>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
	<20180111075812.GA32651@lst.de>
	<CAHNT7Ns+ye2djyqKqr2VmHkjgTLxqkkr6=JKL2B7HvnQm3xRGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7Ns+ye2djyqKqr2VmHkjgTLxqkkr6=JKL2B7HvnQm3xRGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches+subscribe@groups.riscv.org>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Fri, Jan 12, 2018 at 07:24:54AM +1300, Michael Clark wrote:
> I'm going to be restoring branches for bbl and riscv-linux that work again
> priv 1.9.1. There are still other emulators and RTL that support priv1.9.1.
> Folk will have silicon against different versions of spec going forward.
> Likewise going forward we are still going to need to support v1.10 behavior
> when v1.11 is published. i.e. priv v1.10 mode is going to have to hide any
> additions made in priv v1.11. I use priv v1.9.1 during my QEMU testing.
> Hopefully, future changes are additive vs breaking...

That was the plan for 1.10+.  And I thought that was because 1.10
is what people actually started implementing for real, but based on
the comment from Palmer that is not actually true.  Sigh..

I guess at least for Linux we'd then want to make sure 1.9.1 support
is in mainline as well, probably based off a config option.

And if someone has a a good contact to the RISC-V website admins
it would be very helpful to restore a link to the specification as well
so that things other than the direct link work.
