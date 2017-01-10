Received: from eggs.gnu.org ([2001:4830:134:3::10]:33715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cR46S-0006kG-5b
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cR46O-00063v-8k
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:37:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cR46N-00063T-WD
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:37:08 -0500
Date: Tue, 10 Jan 2017 23:37:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110233645-mutt-send-email-mst@kernel.org>
References: <1478772703-28185-7-git-send-email-thuth@redhat.com>
	<20170110053133-mutt-send-email-mst@kernel.org>
	<362c2ee4-b230-d407-c3eb-af80fbfafa96@redhat.com>
	<148406606920.24341.4122999103047828613@loki>
	<6d6c6198-10e1-f5a3-e436-f92e306e6833@redhat.com>
	<148406927879.24341.8983562873840557521@loki>
	<20170110194258-mutt-send-email-mst@kernel.org>
	<148407224651.24341.3951013177607226062@loki>
	<20170110212744-mutt-send-email-mst@kernel.org>
	<148407952558.24341.14693586273076341525@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148407952558.24341.14693586273076341525@loki>
Subject: Re: [Qemu-devel] [PULL 6/6] MAINTAINERS: Remove obsolete stable
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Jan 10, 2017 at 02:18:45PM -0600, Michael Roth wrote:
> Quoting Michael S. Tsirkin (2017-01-10 13:28:44)
> > On Tue, Jan 10, 2017 at 12:17:26PM -0600, Michael Roth wrote:
> > > Quoting Michael S. Tsirkin (2017-01-10 11:43:24)
> > > > On Tue, Jan 10, 2017 at 11:27:58AM -0600, Michael Roth wrote:
> > > > > Quoting Paolo Bonzini (2017-01-10 10:45:02)
> > > > > > 
> > > > > > 
> > > > > > On 10/01/2017 17:34, Michael Roth wrote:
> > > > > > > Quoting Thomas Huth (2017-01-10 01:54:40)
> > > > > > >> On 10.01.2017 04:32, Michael S. Tsirkin wrote:
> > > > > > >>> On Thu, Nov 10, 2016 at 11:11:43AM +0100, Thomas Huth wrote:
> > > > > > >>>> There are only very old and orphaned stable branches listed
> > > > > > >>>> in the MAINTAINERS file - so this section is pretty useless
> > > > > > >>>> nowadays. Let's remove it.
> > > > > > >>>>
> > > > > > >>>> Reviewed-by: John Snow <jsnow@redhat.com>
> > > > > > >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > > >>>
> > > > > > >>>
> > > > > > >>> Could you add some kind of entry for stable though?
> > > > > > >>> Otherwise people won't know which address to CC.
> > > > > > >>
> > > > > > >> I think that's a question to Michael Roth - whether such an entry should
> > > > > > >> be added and how it should look like.
> > > > > > > 
> > > > > > > Hmm, not sure how to make this very readable. Something like this
> > > > > > > perhaps?
> > > > > > > 
> > > > > > > Stable branches
> > > > > > > ---------------
> > > > > > > Current M.(N-1) Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.9.0)
> > > > > > > M: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > > > > L: qemu-stable@nongnu.org
> > > > > > > T: git git://git.qemu-project.org/qemu.git stable-M.(N-1)
> > > > > > > S: Supported
> > > > > > 
> > > > > > I would just say
> > > > > > 
> > > > > > Stable branches
> > > > > > ---------------
> > > > > > Current Stable Branch (e.g. v2.8 if latest M.N.0 release was v2.9.0)
> > > > > > M: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > > > L: qemu-stable@nongnu.org
> > > > > > S: Supported
> > > > > > 
> > > > > > Is the stable git tree used in practice, except in the days right before
> > > > > > a release?
> > > > > 
> > > > > Generally not on my end, but it's possible downstreams make use of them
> > > > > as a means to just grab the latest stable release (though I don't know if
> > > > > this is actually the case or not). I agree that having it in MAINTAINERS
> > > > > isprobably of limited usefulness though.
> > > > > 
> > > > > I *would* like to have a fairly consistent tree that's updated more regularly
> > > > > that people could target for backports and such, but that would probably
> > > > > be via my stable-N.M-staging tree on github. Perhaps I should point
> > > > > people there instead? Unfortunately that still requires some amount of
> > > > > variable substitution.
> > > > 
> > > > Do you need multiple trees? Why not have branches?
> > > 
> > > Sorry, by "tree" I meant branch, e.g.:
> > > 
> > >   https://github.com/mdroth/qemu/tree/stable-2.7-staging
> > >   https://github.com/mdroth/qemu/tree/stable-2.6-staging
> > 
> > I would say
> > 
> > T: git git://git.qemu-project.org/qemu.git stable-M.(N-1)
> > 
> > conveys that clearly.
> 
> Agreed as far as the formatting, but thinking more on Paolo's query I'm not
> sure the qemu.org branch is preferrable over my staging tree on github.
> 
> The main issue is that I generally only update the qemu.org branches as
> part of the actual releases, whereas my staging tree is updated a bit
> more regularly (and in that sense more akin to the various other
> development trees referenced in MAINTAINERS).
> 
> I don't use the git.qemu.org stable branches for staging because I regularly
> force-push prior to release to handle reverts/fixes to avoid diverting too
> much from x.y.0 with various fix-up patches from my end, and exposing that
> part of the process doesn't really sit well with me for an "official" stable
> branch where I think there's some implied expectation of stability (for both
> code and history). I also don't really like the idea of force-pushing anything
> to git.qemu.org in general as it seems like somewhat of a liability.
> 
> Would it be appropriate to reference 2 trees?
> 
> T: git git://git.qemu-project.org/qemu.git stable-M.N (releases only)
> T: git git://github.com/mdroth/qemu.git stable-M.N-staging

I don't think it matters, just reference what's the most
updated one.

> > 
> > 
> > > etc. Or were you suggesting something else?
> > > 
> > > I don't think I can do something like a single stable-current-staging
> > > branch since there's often some overlap between stable releases for N
> > > and N-1 cycles, and the N branches aren't direct descendants of N-1
> > > (not sure if that's what you were suggesting).
> > > 
> > > > 
> > > > > > 
> > > > > > Paolo
> > > > > > 
> > > > > > >>
> > > > > > >>  Thomas
> > > > > > >>
> > > > > > >>
> > > > > > >>>> ---
> > > > > > >>>>  MAINTAINERS | 22 ----------------------
> > > > > > >>>>  1 file changed, 22 deletions(-)
> > > > > > >>>>
> > > > > > >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > >>>> index d8575ab..4a60579 100644
> > > > > > >>>> --- a/MAINTAINERS
> > > > > > >>>> +++ b/MAINTAINERS
> > > > > > >>>> @@ -1574,28 +1574,6 @@ F: tcg/tci/
> > > > > > >>>>  F: tci.c
> > > > > > >>>>  F: disas/tci.c
> > > > > > >>>>  
> > > > > > >>>> -Stable branches
> > > > > > >>>> ----------------
> > > > > > >>>> -Stable 1.0
> > > > > > >>>> -L: qemu-stable@nongnu.org
> > > > > > >>>> -T: git git://git.qemu-project.org/qemu-stable-1.0.git
> > > > > > >>>> -S: Orphan
> > > > > > >>>> -
> > > > > > >>>> -Stable 0.15
> > > > > > >>>> -L: qemu-stable@nongnu.org
> > > > > > >>>> -T: git git://git.qemu-project.org/qemu-stable-0.15.git
> > > > > > >>>> -S: Orphan
> > > > > > >>>> -
> > > > > > >>>> -Stable 0.14
> > > > > > >>>> -L: qemu-stable@nongnu.org
> > > > > > >>>> -T: git git://git.qemu-project.org/qemu-stable-0.14.git
> > > > > > >>>> -S: Orphan
> > > > > > >>>> -
> > > > > > >>>> -Stable 0.10
> > > > > > >>>> -L: qemu-stable@nongnu.org
> > > > > > >>>> -T: git git://git.qemu-project.org/qemu-stable-0.10.git
> > > > > > >>>> -S: Orphan
> > > > > > >>>> -
> > > > > > >>>>  Block drivers
> > > > > > >>>>  -------------
> > > > > > >>>>  VMDK
> > > > > > >>>> -- 
> > > > > > >>>> 1.8.3.1
> > > > > > >>>>
> > > > > > >>
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > 
> > 
