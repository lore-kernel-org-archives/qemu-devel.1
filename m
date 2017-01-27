Received: from eggs.gnu.org ([2001:4830:134:3::10]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cX8DN-0005bD-BI
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cX8DK-0007lC-6I
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:13:25 -0500
Date: Fri, 27 Jan 2017 16:13:07 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170127151307.meioko5vsz7otxfn@hawk.localdomain>
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
	<20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
	<CAFEAcA_OBx2ADDOU6Z6_27+EdbWS-1QJde5mB+sKrv0wYrKG1Q@mail.gmail.com>
	<CAFEAcA8dDcMowqa5NO_NpN7+V-_=VqRSH_9rQGpXKSvYuh4Teg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8dDcMowqa5NO_NpN7+V-_=VqRSH_9rQGpXKSvYuh4Teg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] pflash_cfi01: fix per device sector length
 in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Engraf <david.engraf@sysgo.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 27, 2017 at 02:54:20PM +0000, Peter Maydell wrote:
> On 27 January 2017 at 14:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 12 January 2017 at 11:36, Andrew Jones <drjones@redhat.com> wrote:
> >> On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
> >>> Thanks for the patch. I haven't checked against the pflash spec yet,
> >>> but this looks like it's probably the right thing.
> >>>
> >>> The only two machines which use a setup with multiple devices (ie
> >>> which specify device_width to the pflash_cfi01) are vexpress and virt.
> >>> For all other machines this patch leaves the behaviour unchanged.
> >>>
> >>> Q: do we need to have some kind of nasty hack so that pre-2.9 virt
> >>> still gets the old broken values in the CFI table, for version and
> >>> migration compatibility? Ccing Drew for an opinion...
> >>>
> >>
> >> I'm pretty sure we need the nasty hack, but I'm also Ccing David for
> >> his opinion.
> >
> > So given our decision about not needing the back-compat property
> > for the UEFI table entry, do we still agree that we need one here?
> 
> Looking more closely at the patch, changing writeblock underneath
> a guest's feet is probably not very polite, so let's take the safe
> path of making it version-dependent.

Right, and I think ACPI generation is getting a bit of special treatment
due to its status as "part of firmware". Hardware should probably never
change.

> 
> I've applied David's patch to target-arm.next (with some tweaks to
> the commit message).
> 
> thanks
> -- PMM

Thanks,
drew
