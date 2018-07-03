Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faLk8-0001aA-3x
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faLk4-0002jh-P2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:53:20 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1faLk4-0002jR-IU
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:53:16 -0400
Received: by mail-pf0-x242.google.com with SMTP id s21-v6so1065225pfm.6
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 06:53:16 -0700 (PDT)
Date: Tue, 3 Jul 2018 22:53:13 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180703135313.GT24595@lianli.shorne-pla.net>
References: <20180702151023.24532-1-shorne@gmail.com>
	<CAFEAcA8EPj=-ExxZeitao_gN-7XPUGQ=eOj+Q0mBU-x0QTepPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8EPj=-ExxZeitao_gN-7XPUGQ=eOj+Q0mBU-x0QTepPQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>

On Mon, Jul 02, 2018 at 04:36:10PM +0100, Peter Maydell wrote:
> On 2 July 2018 at 16:09, Stafford Horne <shorne@gmail.com> wrote:
> > Hi Peter,
> >
> > Changes since v1:
> >  - Un"fixed" an incorrect checkpatch warning pointed out by Richard.
> >
> > Please consider for pull.
> >
> > The following changes since commit 646f34fa5482e495483de230b4cf0f2ae4fd2781:
> >
> >   tcg: Fix --disable-tcg build breakage (2018-07-02 13:42:05 +0100)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:stffrdhrn/qemu.git tags/pull-or-20180702
> >
> > for you to fetch changes up to 33e1acf437ce4f0b67c262fc93b436e2e306f278:
> >
> >   target/openrisc: Fix writes to interrupt mask register (2018-07-03 00:05:28 +0900)
> >
> > ----------------------------------------------------------------
> > OpenRISC cleanups and Fixes for QEMU 3.0
> >
> > Mostly patches from Richard Henderson fixing multiple things:
> >  * Fix singlestepping in GDB.
> >  * Use more TB linking.
> >  * Fixes to exit TB after updating SPRs to enable registering of state
> >    changes.
> >  * Significant optimizations and refactors to the TLB
> >  * Split out disassembly from translation.
> >  * Add qemu-or1k to qemu-binfmt-conf.sh.
> >  * Implement signal handling for linux-user.
> >
> > Then there are a few fixups from me:
> >  * Fix delay slot detections to match hardware, this was masking a bug
> >    in the linus kernel.
> >  * Fix stores to the PIC mask register
> >
> > ----------------------------------------------------------------
> 
> Compile failure, for the windows crossbuilds:
> 
[...]
> /home/petmay01/qemu-for-merges/target/openrisc/mmu.c:171:23: error:
> 'PROT_READ' undeclared (first use in this function)
>                      : PROT_READ);
>                        ^
> /home/petmay01/qemu-for-merges/rules.mak:69: recipe for target
> 'target/openrisc/mmu.o' failed
> 
> PROT_READ/WRITE/EXEC are the Posix flags for mmap().
> The flags for the 'prot' argument to tlb_set_page()
> and similar places are PAGE_READ/WRITE/EXEC.

Understood, this should be fixed now, after changing I see no differences.

> PS: for trivial respins of a pullreq you don't need to resend
> the whole thing, you can just resend the cover letter (and
> any individual patches which got major changes).

Thats good to know, I thought it might be annoying to resend the entire series
when all that is needed is the pr cover letter.

I have resent, I hope all is well.

-Stafford
