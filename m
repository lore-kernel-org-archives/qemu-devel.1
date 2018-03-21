Received: from eggs.gnu.org ([2001:4830:134:3::10]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eya8X-00081k-MR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eya8S-0004BY-PS
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 05:34:25 -0400
Date: Wed, 21 Mar 2018 17:34:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180321093416.GF26017@lemon.usersys.redhat.com>
References: <20180319215335.1119213-1-eblake@redhat.com>
	<56ec7ba5-a6e1-2268-3313-8babc640c024@redhat.com>
	<20180321020709.GA16095@lemon.usersys.redhat.com>
	<56ff5d55-ad21-01b9-aa62-f7786aa9289d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ff5d55-ad21-01b9-aa62-f7786aa9289d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] rdma: Fix 32-bit compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>

On Wed, 03/21 11:20, Marcel Apfelbaum wrote:
> On 21/03/2018 4:07, Fam Zheng wrote:
> > On Tue, 03/20 12:30, Marcel Apfelbaum wrote:
> >> Hi Eric,
> >>
> >> On 19/03/2018 23:53, Eric Blake wrote:
> >>> Use the correct printf formats, so that a 32-bit compile doesn't
> >>> spit out lots of warnings about %lx being incompatible with uint64_t.
> >>> Broken since initial commit ef6d4ccd.
> >>>
> >>> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>> ---
> >>>
> >>> I don't know if 'make vm-build-ubuntu.i368' would catch this (it failed
> >>> for me for other reasons); I found it via a 32-bit rawhide VM.
> >>>
> >>
> >> I couldn't run 'make vm-build-ubuntu.i368' either. (Stuck on "Booting from Hard Disk...")
> > 
> > I tried this now and it works for me. Could you delete "$HOME/.cache/qemu-vm"
> > and do it again from a git tree, then pastbin the full log?
> > 
> 
> Hi Fam,
> I did that but it didn't help.
> 
> Here is the log: https://da.gd/8wJHj
> I try to run the same command line, and it still stuck in the boot process.
> Problem is, the command line looks fine, may be another issue with my PC...
> I'll continue to debug it.

Maybe we are using different QEMU/seabios. What I used is built from qemu.git.
The log has the QEMU arguments which you can try manually for debug.

Fam
