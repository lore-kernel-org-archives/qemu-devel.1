Received: from eggs.gnu.org ([2001:4830:134:3::10]:41247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edwAI-0004W3-KT
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edwAF-00089I-Hs
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:50:54 -0500
Date: Tue, 23 Jan 2018 11:50:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180123115045.51963136.cohuck@redhat.com>
In-Reply-To: <CAATJJ0+swtq=6Q7U9fShDRvbm13YukdfXqOX0pcvf9=z-KR3ZQ@mail.gmail.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
	<CAATJJ0+swtq=6Q7U9fShDRvbm13YukdfXqOX0pcvf9=z-KR3ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x]  [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 23 Jan 2018 11:34:18 +0100
Christian Ehrhardt <christian.ehrhardt@canonical.com> wrote:

> On Tue, Jan 23, 2018 at 10:59 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> >
> >
> > On 01/23/2018 09:40 AM, Christian Ehrhardt wrote:  
> >> On Thu, Jan 18, 2018 at 2:51 PM, Peter Maydell <peter.maydell@linaro.org> wrote:  
> >>> On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> >>>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
> >>>>
> >>>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
> >>>>
> >>>> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144c1:
> >>>>
> >>>>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> x86 queue, 2018-01-17
> >>>>
> >>>> Highlight: new CPU models that expose CPU features that guests
> >>>> can use to mitigate CVE-2017-5715 (Spectre variant #2).
> >>>>  
> >>>
> >>> Applied, thanks.
> >>>
> >>> -- PMM
> >>>  
> >>
> >> Hi,
> >> I was kind of clinging to [1] so far and had the expectation that all
> >> those would be wrapped up in 2.11.1 once ready.
> >> I see that the s390x changes are targeted to qemu-stable (well to
> >> admit I suggested so referring the article above).
> >> So I'd expected to see this series to show up on qemu-stable as well
> >> but haven't seen it so far.
> >>
> >> Therefore I wanted to ask if there was a change of plans in that
> >> regard or if it needs just a few days more to see (part of) this
> >> series on qemu-stable and on its way into 2.11.1?
> >>
> >> [1]: https://www.qemu.org/2018/01/04/spectre/  
> >
> > Adding Michael,
> >
> > Yes, I think it makes sense to have the guest enablement for the spectre
> > mitigations available in 2.11.1 for all architectures that provide it.
> > (this queue for x86, Connies pending S390 patches, whatever Power
> > and arm will do).  
> 
> Also adding Suraj for a statement in this regard about his "[QEMU-PPC]
> [PATCH V5 0/7] target/ppc: Rework spapr_caps" series which I think is
> the PPC version of all of this right?
> Not sure who to add for Arm :-/
> 
> @Cornelia - the consumers of these stable changes in particular IMHO
> are Distributions for security updates.
> Seeing at least one backport into 2.11.1 would be very helpful to
> avoid issues that would not apply to a forward thinking 2.12 commit.
> Such a (even short distance) backport being done by the Author would
> have the lowest risk of such issues creeping in.
> I'm not so sure on 2.(<11).x  - but one backport at least into the
> latest release would be very nice to fulfill the [1] announcement
> referenced above and provide a first release of these important
> changes available earlier than full 2.12.

I agree that a backport unto 2.11.x is useful.

But I still think we should clarify the purpose of our stable tree --
not necessarily in this thread, though.
