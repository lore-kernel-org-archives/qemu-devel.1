Received: from eggs.gnu.org ([2001:4830:134:3::10]:51152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1ee36i-0008SS-7c
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1ee36e-0000ip-7l
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:15:40 -0500
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
Message-ID: <151673132716.4211.15090159170244596259@sif>
Date: Tue, 23 Jan 2018 12:15:27 -0600
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org

Quoting Christian Borntraeger (2018-01-23 03:59:39)
> =

> =

> On 01/23/2018 09:40 AM, Christian Ehrhardt wrote:
> > On Thu, Jan 18, 2018 at 2:51 PM, Peter Maydell <peter.maydell@linaro.or=
g> wrote:
> >> On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae=
7ada7c:
> >>>
> >>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' i=
nto staging (2018-01-16 17:36:39 +0000)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
> >>>
> >>> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144=
c1:
> >>>
> >>>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> x86 queue, 2018-01-17
> >>>
> >>> Highlight: new CPU models that expose CPU features that guests
> >>> can use to mitigate CVE-2017-5715 (Spectre variant #2).
> >>>
> >>
> >> Applied, thanks.
> >>
> >> -- PMM
> >>
> > =

> > Hi,
> > I was kind of clinging to [1] so far and had the expectation that all
> > those would be wrapped up in 2.11.1 once ready.
> > I see that the s390x changes are targeted to qemu-stable (well to
> > admit I suggested so referring the article above).
> > So I'd expected to see this series to show up on qemu-stable as well
> > but haven't seen it so far.
> > =

> > Therefore I wanted to ask if there was a change of plans in that
> > regard or if it needs just a few days more to see (part of) this
> > series on qemu-stable and on its way into 2.11.1?
> > =

> > [1]: https://www.qemu.org/2018/01/04/spectre/
> =

> Adding Michael,
> =

> Yes, I think it makes sense to have the guest enablement for the spectre =

> mitigations available in 2.11.1 for all architectures that provide it. =

> (this queue for x86, Connies pending S390 patches, whatever Power
> and arm will do).

That's my plan as well, but IIUC the QEMU side of these patches rely on
a KVM flag that in turn relies on this series:

  https://lkml.org/lkml/2018/1/20/158

But that's still in RFC and Linus seems to have reservations with the
current code. Since coordinating these all this to users/downstreams is
somewhat of a mess I was thinking we should accompany the 2.11.1 release
with a blog post on the various options/backports/microcode needed througho=
ut
the stack to enable the fixes, but until there's a stable patchset on
the linux side I'm not sure there's much worth in putting out the 2.11.1
release (if I'm missing something here please let me know).

There's also the testing aspect of this, which I'd at least like to cover
on the x86 side. I've be doing some basic testing on top of early versions
of the IBRS patches and KVM patches, but I'd really like to make sure
everything is working on top of what's ultimately going upstream before
I commit the release.

In the meantime I've started a staging tree for 2.11.1 here:

  https://github.com/mdroth/qemu/commits/stable-2.11-staging

it doesn't have these patches yet, and given the above I'm not sure it
makes sense to try to set a release date yet, but I'll update the tree
as we go and post a call-for-patches within a day or so where we can
coordinate what else should go in for other archs.

> =

> Not sure about a 2.10.3?
> =


Out of support as far as stable releases go; will have to leave that one
up to the downstreams.
