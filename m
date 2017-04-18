Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0Ty1-0005Fo-8T
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0Txy-0000RL-JM
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:18:53 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0Txy-0000RF-E5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:18:50 -0400
Received: by mail-pf0-x241.google.com with SMTP id c198so30872384pfc.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:18:50 -0700 (PDT)
Date: Tue, 18 Apr 2017 23:18:46 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170418141846.GA2599@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<575d21dff52df4fa53d17e77728018453f82e8e5.1492384862.git.shorne@gmail.com>
	<382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382ab324-39c0-5549-ff01-3fe7cc1319de@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 1/7] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 12:47:30AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > When debugging in gdb you might want to inspect instructions in mapped
> > pages or in exception vectors like 0x800 etc.  This was previously not
> > possible in qemu since the *get_phys_page_debug() routine only looked
> > into the data tlb.
> > 
> > Change to fall back to look into instruction tlb and plain physical
> > pages.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Oh the horrors of a software managed TLB.
> 
> You might do well to architecturally define an SPR that holds the page table
> base, even if for real hardware that's only used by the software refill to
> load up the address.
> 
> That would give qemu the option of performing a real page table walk.  This
> would fix this debug hook properly (so that you can examine pages that
> aren't in the TLB at all).  It would also optionally allow QEMU to skip the
> software refill, which *significantly* speeds up emulation.

Understood, I guess we would also need a way to represent which paging
model we are using (1 level, 2 level etc)?

> That said,
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Thanks for the review.

-Stafford

> 
> r~
