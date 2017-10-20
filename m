Received: from eggs.gnu.org ([2001:4830:134:3::10]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e5fPf-0001Q4-VX
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e5fPb-0003I7-3G
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:07 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:51827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e5fPa-0003Hi-TX
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 18:05:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id n14so12858831pfh.8
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 15:05:02 -0700 (PDT)
Date: Sat, 21 Oct 2017 07:04:59 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171020220459.GD2694@lianli.shorne-pla.net>
References: <20171013145714.2740-1-shorne@gmail.com>
	<CAFEAcA-w9d1-FQ_E4Aes0dzdx_rNEm3XdKnkJDVrwAWq4ZxH9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-w9d1-FQ_E4Aes0dzdx_rNEm3XdKnkJDVrwAWq4ZxH9g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/5] OpenRISC SMP Support
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

On Fri, Oct 20, 2017 at 05:51:13PM +0100, Peter Maydell wrote:
> On 13 October 2017 at 15:57, Stafford Horne <shorne@gmail.com> wrote:
> > Hello,
> >
> > Please consider for pull.
> >
> > The following changes since commit 7851197b812b383ae1208c5d86391c5179c8209d:
> >
> >   Update version for 2.10.1 release (2017-10-02 12:42:58 -0500)
> >
> > are available in the git repository at:
> >
> >   git://github.com/stffrdhrn/qemu.git tags/openrisc-20171113-smp-pr
> >
> > for you to fetch changes up to 017a118ebed8757ccdce6fa217640963579aeb13:
> >
> >   openrisc: Only kick cpu on timeout, not on update (2017-10-13 23:31:22 +0900)
> >
> > ----------------------------------------------------------------
> > OpenRISC SMP patchset 20171113
> >
> > ----------------------------------------------------------------
> > Stafford Horne (5):
> >   openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
> >   target/openrisc: Make coreid and numcores variable
> >   openrisc/cputimer: Perparation for Multicore
> >   openrisc: Initial SMP support
> >   openrisc: Only kick cpu on timeout, not on update
> 
> Hi -- I'm afraid this pull request doesn't apply to master.
> Looking at it, that seems to be because you've based it on the
> 2.10.1 branch. All pull requests for master need to be based
> on master -- can you rebase to the right thing and resubmit,
> please?

Yes, sorry.  I didnt realize 2.10.1 was a branch, I will stick to master from
now on.

I have done the rebase and there was one minor conflict due to the
cpu_generic_init() changes.  I retested and everything looks good, please look
out for the v2 PULL series.

-Stafford
