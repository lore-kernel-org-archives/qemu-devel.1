Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXTt3-0001CY-5e
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXTsz-0007m9-3N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXTsy-0007le-Tl
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:54:05 -0400
Date: Tue, 18 Jul 2017 15:53:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170718145358.GB2106@work-vm>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA_HQFtNr82QqE0+j8_SUGm_8-1JLavBnXYTmRvTVb+vYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_HQFtNr82QqE0+j8_SUGm_8-1JLavBnXYTmRvTVb+vYQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <frederic.konrad@adacore.com>, Juan Quintela <quintela@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 17 July 2017 at 19:58, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Edgar E. Iglesias (edgar.iglesias@gmail.com) wrote:
> >> Is there a way we can prevent migration of the RAMBlock?
> >
> > Not yet, I think we'd have to:
> >    a) Add a flag to the RAMBlock
> >    b) Set it/clear it on registration
> >    c) Have a RAMBLOCK_FOREACH_MIGRATABLE macro
> >    d) Replace all of the RAMBLOCK_FOREACH (and the couple of hand coded
> >    cases) with the RAMBLOCK_FOREACH_MIGRATABLE
> >    e) Worry about the corner cases!
> >
> > I've got a few worries about what happens when the kernel tries to
> > do dirty yncing - I'm not sure if we have to change anything on that
> > interface to skip those RAMBlocks.
> 
> Why would we need to skip those RAM blocks? We get correct
> behaviour whether the memory is sync'd with the kernel
> or not, because we're not going to migrate it anywhere.

We have to make sure the count of dirty pages doesn't include the dirty
pages from those blocks, or migration will never finish.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
