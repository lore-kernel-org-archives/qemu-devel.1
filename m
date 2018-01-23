Received: from eggs.gnu.org ([2001:4830:134:3::10]:44095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eerHH-0000om-D4
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eerHE-0008TG-8C
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eerHD-0008T4-Vz
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 18:49:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PNnRuj052048
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 18:49:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fqr62t2pc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 18:49:50 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 18:49:48 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180123193118.GA4298@localhost.localdomain>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
	<151673132716.4211.15090159170244596259@sif>
	<20180123193118.GA4298@localhost.localdomain>
Date: Tue, 23 Jan 2018 15:33:56 -0600
Message-Id: <151674323649.4211.10355855473647907818@sif>
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org

Quoting Eduardo Habkost (2018-01-23 13:31:18)
> On Tue, Jan 23, 2018 at 12:15:27PM -0600, Michael Roth wrote:
> > Quoting Christian Borntraeger (2018-01-23 03:59:39)
> > > =

> > > =

> > > On 01/23/2018 09:40 AM, Christian Ehrhardt wrote:
> > > > On Thu, Jan 18, 2018 at 2:51 PM, Peter Maydell <peter.maydell@linar=
o.org> wrote:
> > > >> On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
> > > >>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e=
42ae7ada7c:
> > > >>>
> > > >>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-2018011=
6' into staging (2018-01-16 17:36:39 +0000)
> > > >>>
> > > >>> are available in the Git repository at:
> > > >>>
> > > >>>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
> > > >>>
> > > >>> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040=
c144c1:
> > > >>>
> > > >>>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
> > > >>>
> > > >>> ----------------------------------------------------------------
> > > >>> x86 queue, 2018-01-17
> > > >>>
> > > >>> Highlight: new CPU models that expose CPU features that guests
> > > >>> can use to mitigate CVE-2017-5715 (Spectre variant #2).
> > > >>>
> > > >>
> > > >> Applied, thanks.
> > > >>
> > > >> -- PMM
> > > >>
> > > > =

> > > > Hi,
> > > > I was kind of clinging to [1] so far and had the expectation that a=
ll
> > > > those would be wrapped up in 2.11.1 once ready.
> > > > I see that the s390x changes are targeted to qemu-stable (well to
> > > > admit I suggested so referring the article above).
> > > > So I'd expected to see this series to show up on qemu-stable as well
> > > > but haven't seen it so far.
> > > > =

> > > > Therefore I wanted to ask if there was a change of plans in that
> > > > regard or if it needs just a few days more to see (part of) this
> > > > series on qemu-stable and on its way into 2.11.1?
> > > > =

> > > > [1]: https://www.qemu.org/2018/01/04/spectre/
> > > =

> > > Adding Michael,
> > > =

> > > Yes, I think it makes sense to have the guest enablement for the spec=
tre =

> > > mitigations available in 2.11.1 for all architectures that provide it=
. =

> > > (this queue for x86, Connies pending S390 patches, whatever Power
> > > and arm will do).
> > =

> > That's my plan as well, but IIUC the QEMU side of these patches rely on
> > a KVM flag that in turn relies on this series:
> > =

> >   https://lkml.org/lkml/2018/1/20/158
> =

> Actually it depends on:
> https://lkml.org/lkml/2018/1/9/329
> ([PATCH v2 0/8] KVM: x86: expose CVE-2017-5715 ("Spectre variant 2") miti=
gations to guest)
> =

> The ability to expose IBRS to guests doesn't seem to depend on
> the host kernel using IBRS to protect itself.  But I guess it
> will be easier to merge that code after Linux developers decide
> what they'll do.  Paolo, what's your take on this?
> =

> Note that there are released OSes that use IBRS (Windows and
> RHEL), so even if upstream Linux decide to not rely on IBRS,
> users will probably want to expose IBRS to VMs as soon as KVM
> becomes able to do that.

I didn't really consider that angle, but I think anyone supporting such
guests will tend to be relying on their host distros for the fixes, and
distros will want their own guest types covered as well (looks like RHEL
already has its bases covered in this regard, maybe Hyper-V too WRT to
Windows guests..)

> =

> BUT:
> =

> > =

> > But that's still in RFC and Linus seems to have reservations with the
> > current code. Since coordinating these all this to users/downstreams is
> > somewhat of a mess I was thinking we should accompany the 2.11.1 release
> > with a blog post on the various options/backports/microcode needed thro=
ughout
> > the stack to enable the fixes, but until there's a stable patchset on
> > the linux side I'm not sure there's much worth in putting out the 2.11.1
> > release (if I'm missing something here please let me know).
> =

> I'm inclined to agree.  I merged the -IBRS CPU models expecting
> that the fixes would be included quickly in upstream Linux too,
> but it was not the case.
> =

> To be honest, I don't think adding new CPU models are the proper
> solution for the problem.  They are just a quick solution that
> doesn't require intrusive changes in the management stack.
> =

> Meltdown & Spectre made us painfully aware of limitations of
> management stacks out there (esp. OpenStack): they normally don't
> have an easy mechanism to enable CPU features that are not part
> of an existing CPU model name.  A good management stack would be
> able to use, e.g., "-cpu Westmere,+spec-ctrl" instead of
> "Westmere-IBRS" if it knows all the hosts on a given
> cluster/migration-set/whatever-it-is-called support the feature.
> The same applies to other flags like ibpb and pcid.
> =

> There's work being done on OpenStack to fix this,
> e.g.: https://review.openstack.org/#/c/534384/
> =

> =

> That said, we will probably want to include MSR code and the CPU
> feature flag names (spec-ctrl and ibpb) on the stable branch as
> soon as possible.  This way, people will have the option to
> manually enable those features (or make them automatically
> available using "-cpu host") before a decision is made regarding
> CPU model names.
> =

> I can send a patch series to -stable including only those
> patches, if it makes the work easier.

Will these proposed patches be dropping the model names introduced here
in favor of those flags, or introducing them alongside?

> =

> =

> > =

> > There's also the testing aspect of this, which I'd at least like to cov=
er
> > on the x86 side. I've be doing some basic testing on top of early versi=
ons
> > of the IBRS patches and KVM patches, but I'd really like to make sure
> > everything is working on top of what's ultimately going upstream before
> > I commit the release.
> > =

> > In the meantime I've started a staging tree for 2.11.1 here:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> > =

> > it doesn't have these patches yet, and given the above I'm not sure it
> > makes sense to try to set a release date yet, but I'll update the tree
> > as we go and post a call-for-patches within a day or so where we can
> > coordinate what else should go in for other archs.
> > =

> > > =

> > > Not sure about a 2.10.3?
> > > =

> > =

> > Out of support as far as stable releases go; will have to leave that one
> > up to the downstreams.
> =

> -- =

> Eduardo
>=20
