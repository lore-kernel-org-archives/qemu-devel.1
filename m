Received: from eggs.gnu.org ([2001:4830:134:3::10]:58660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1ehCQ2-00021H-RW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1ehCPy-00046G-TA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:48:38 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:39403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christoffer.dall@linaro.org>)
	id 1ehCPy-00045i-IJ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:48:34 -0500
Received: by mail-wm0-x22d.google.com with SMTP id b21so4720774wme.4
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 02:48:34 -0800 (PST)
Date: Thu, 1 Feb 2018 11:48:31 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
Message-ID: <20180201104831.GB21802@cbox>
References: <CAMJs5B8jctfTEEhui3XRCTW1La2HCoVd1Jzaz4p7jy=8vqw=0A@mail.gmail.com>
	<CAKv+Gu80p5G_gWp0Dg7HJ2SAgc3WCQe+g9ear9oM44bt-KmSFA@mail.gmail.com>
	<CAMJs5B_S0fO32=uh7iavn=BN1BC3=7qZAh1YcpVJFZoRC+GgOA@mail.gmail.com>
	<CAKv+Gu-dmNOnZbfJzuJ8BauGKktO_TaDRS29PuAftccfySw6ig@mail.gmail.com>
	<CAMJs5B8CWm2bj-Be_j4p9Y_3wXr=W2K7zE8593ke-97QR20qcA@mail.gmail.com>
	<CAKv+Gu935vi1wCRAKqC-nscXa+=CKX6P=HPO-3dNA4fx0Fm-NA@mail.gmail.com>
	<CAMJs5B-S=qVWYP2eTN1qsOQctmfUR8jCXBaz2DKyaKRT7LrAyA@mail.gmail.com>
	<CAKv+Gu-7d5jbt9V8bORkrZXxNmshMNjsqg+EiwhA-CYrNLFotA@mail.gmail.com>
	<CAMJs5B8W7-yfco1qkWBY0FU4hiner05jp1jBycWwT6wCTegBfA@mail.gmail.com>
	<20180201104222.bwbrsfp2kmkwd7zp@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201104222.bwbrsfp2kmkwd7zp@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On Thu, Feb 01, 2018 at 11:42:22AM +0100, Andrew Jones wrote:
> On Thu, Feb 01, 2018 at 10:59:54AM +0100, Christoffer Dall wrote:
> > On Thu, Feb 1, 2018 at 10:33 AM, Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > On 1 February 2018 at 09:17, Christoffer Dall
> > > <christoffer.dall@linaro.org> wrote:
> > >> On Wed, Jan 31, 2018 at 9:15 PM, Ard Biesheuvel
> > >> <ard.biesheuvel@linaro.org> wrote:
> > >>> On 31 January 2018 at 19:12, Christoffer Dall
> > >>> <christoffer.dall@linaro.org> wrote:
> > >>>> On Wed, Jan 31, 2018 at 7:00 PM, Ard Biesheuvel
> > >>>> <ard.biesheuvel@linaro.org> wrote:
> > >>>>> On 31 January 2018 at 17:39, Christoffer Dall
> > >>>>> <christoffer.dall@linaro.org> wrote:
> > >>>>>> On Wed, Jan 31, 2018 at 5:59 PM, Ard Biesheuvel
> > >>>>>> <ard.biesheuvel@linaro.org> wrote:
> > >>>>>>> On 31 January 2018 at 16:53, Christoffer Dall
> > >>>>>>> <christoffer.dall@linaro.org> wrote:
> > >>>>>>>> On Wed, Jan 31, 2018 at 4:18 PM, Ard Biesheuvel
> > >>>>>>>> <ard.biesheuvel@linaro.org> wrote:
> > >>>>>>>>> On 31 January 2018 at 09:53, Christoffer Dall
> > >>>>>>>>> <christoffer.dall@linaro.org> wrote:
> > >>>>>>>>>> On Mon, Jan 29, 2018 at 10:32:12AM +0000, Marc Zyngier wrote:
> > >>>>>>>>>>> On 29/01/18 10:04, Peter Maydell wrote:
> > >>>>>>>>>>> > On 29 January 2018 at 09:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > >>>>>>>>>>> >> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > >>>>>>>>>>> >>> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > >>>>>>>>>>> >>>> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > >>>>>>>>>>> >>>>> I think the correct fix here is that your test code should turn
> > >>>>>>>>>>> >>>>> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
> > >>>>>>>>>>> >>>>> for Arm KVM guests (for the same reason that VGA device video memory
> > >>>>>>>>>>> >>>>> doesn't work). If it's RAM your guest has to arrange to map it as
> > >>>>>>>>>>> >>>>> Normal Cacheable, and then everything should work fine.
> > >>>>>>>>>>> >>>>
> > >>>>>>>>>>> >>>> Does this cause problems with migrating at just the wrong point during
> > >>>>>>>>>>> >>>> a VM boot?
> > >>>>>>>>>>> >>>
> > >>>>>>>>>>> >>> It wouldn't surprise me if it did, but I don't think I've ever
> > >>>>>>>>>>> >>> tried to provoke that problem...
> > >>>>>>>>>>> >>
> > >>>>>>>>>>> >> If you think it'll get the RAM contents wrong, it might be best to fail
> > >>>>>>>>>>> >> the migration if you can detect the cache is disabled in the guest.
> > >>>>>>>>>>> >
> > >>>>>>>>>>> > I guess QEMU could look at the value of the "MMU disabled/enabled" bit
> > >>>>>>>>>>> > in the guest's system registers, and refuse migration if it's off...
> > >>>>>>>>>>> >
> > >>>>>>>>>>> > (cc'd Marc, Christoffer to check that I don't have the wrong end
> > >>>>>>>>>>> > of the stick about how thin the ice is in the period before the
> > >>>>>>>>>>> > guest turns on its MMU...)
> > >>>>>>>>>>>
> > >>>>>>>>>>> Once MMU and caches are on, we should be in a reasonable place for QEMU
> > >>>>>>>>>>> to have a consistent view of the memory. The trick is to prevent the
> > >>>>>>>>>>> vcpus from changing that. A guest could perfectly turn off its MMU at
> > >>>>>>>>>>> any given time if it needs to (and it is actually required on some HW if
> > >>>>>>>>>>> you want to mitigate headlining CVEs), and KVM won't know about that.
> > >>>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> (Clarification: KVM can detect this is it bother to check the VCPU's
> > >>>>>>>>>> system registers, but we don't trap to KVM when the VCPU turns off its
> > >>>>>>>>>> caches, right?)
> > >>>>>>>>>>
> > >>>>>>>>>>> You may have to pause the vcpus before starting the migration, or
> > >>>>>>>>>>> introduce a new KVM feature that would automatically pause a vcpu that
> > >>>>>>>>>>> is trying to disable its MMU while the migration is on. This would
> > >>>>>>>>>>> involve trapping all the virtual memory related system registers, with
> > >>>>>>>>>>> an obvious cost. But that cost would be limited to the time it takes to
> > >>>>>>>>>>> migrate the memory, so maybe that's acceptable.
> > >>>>>>>>>>>
> > >>>>>>>>>> Is that even sufficient?
> > >>>>>>>>>>
> > >>>>>>>>>> What if the following happened. (1) guest turns off MMU, (2) guest
> > >>>>>>>>>> writes some data directly to ram (3) qemu stops the vcpu (4) qemu reads
> > >>>>>>>>>> guest ram.  QEMU's view of guest ram is now incorrect (stale,
> > >>>>>>>>>> incoherent, ...).
> > >>>>>>>>>>
> > >>>>>>>>>> I'm also not really sure if pausing one VCPU because it turned off its
> > >>>>>>>>>> MMU will go very well when trying to migrate a large VM (wouldn't this
> > >>>>>>>>>> ask for all the other VCPUs beginning to complain that the stopped VCPU
> > >>>>>>>>>> appears to be dead?).  As a short-term 'fix' it's probably better to
> > >>>>>>>>>> refuse migration if you detect that a VCPU had begun turning off its
> > >>>>>>>>>> MMU.
> > >>>>>>>>>>
> > >>>>>>>>>> On the larger scale of thins; this appears to me to be another case of
> > >>>>>>>>>> us really needing some way to coherently access memory between QEMU and
> > >>>>>>>>>> the VM, but in the case of the VCPU turning off the MMU prior to
> > >>>>>>>>>> migration, we don't even know where it may have written data, and I'm
> > >>>>>>>>>> therefore not really sure what the 'proper' solution would be.
> > >>>>>>>>>>
> > >>>>>>>>>> (cc'ing Ard who has has thought about this problem before in the context
> > >>>>>>>>>> of UEFI and VGA.)
> > >>>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Actually, the VGA case is much simpler because the host is not
> > >>>>>>>>> expected to write to the framebuffer, only read from it, and the guest
> > >>>>>>>>> is not expected to create a cacheable mapping for it, so any
> > >>>>>>>>> incoherency can be trivially solved by cache invalidation on the host
> > >>>>>>>>> side. (Note that this has nothing to do with DMA coherency, but only
> > >>>>>>>>> with PCI MMIO BARs that are backed by DRAM in the host)
> > >>>>>>>>
> > >>>>>>>> In case of the running guest, the host will also only read from the
> > >>>>>>>> cached mapping.  Of course, at restore, the host will also write
> > >>>>>>>> through a cached mapping, but shouldn't the latter case be solvable by
> > >>>>>>>> having KVM clean the cache lines when faulting in any page?
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>> We are still talking about the contents of the framebuffer, right? In
> > >>>>>>> that case, yes, afaict
> > >>>>>>>
> > >>>>>>
> > >>>>>> I was talking about normal RAM actually... not sure if that changes anything?
> > >>>>>>
> > >>>>>
> > >>>>> The main difference is that with a framebuffer BAR, it is pointless
> > >>>>> for the guest to map it cacheable, given that the purpose of a
> > >>>>> framebuffer is its side effects, which are not guaranteed to occur
> > >>>>> timely if the mapping is cacheable.
> > >>>>>
> > >>>>> If we are talking about normal RAM, then why are we discussing it here
> > >>>>> and not down there?
> > >>>>>
> > >>>>
> > >>>> Because I was trying to figure out how the challenge of accessing the
> > >>>> VGA framebuffer differs from the challenge of accessing guest RAM
> > >>>> which may have been written by the guest with the MMU off.
> > >>>>
> > >>>> First approximation, they are extremely similar because the guest is
> > >>>> writing uncached to memory, which the host now has to access via a
> > >>>> cached mapping.
> > >>>>
> > >>>> But I'm guessing that a "clean+invalidate before read on the host"
> > >>>> solution will result in terrible performance for a framebuffer and
> > >>>> therefore isn't a good solution for that problem...
> > >>>>
> > >>>
> > >>> That highly depends on where 'not working' resides on the performance
> > >>> scale. Currently, VGA on KVM simply does not work at all, and so
> > >>> working but slow would be a huge improvement over the current
> > >>> situation.
> > >>>
> > >>> Also, the performance hit is caused by the fact that the data needs to
> > >>> make a round trip to memory, and the invalidation (without cleaning)
> > >>> performed by the host shouldn't make that much worse than it
> > >>> fundamentally is to begin with.
> > >>>
> > >>
> > >> True, but Marc pointed out (on IRC) that the cache maintenance
> > >> instructions are broadcast across all CPUs and may therefore adversely
> > >> affect the performance of your entire system by running an emulated
> > >> VGA framebuffer on a subset of the host CPUs.  However, he also
> > >> pointed out that the necessary cache maintenance can be done in EL0
> 
> I had some memory of this not being the case, but I just checked and
> indeed 'dc civac' will work from el0 with sctlr_el1.uci=1. Note, I
> see that the gcc builtin __builtin___clear_cache() does not use that
> instruction (it uses 'dc cvau'), so we'd need to implement a wrapper
> ourselves (maybe that's why I thought it wasn't available...)
> 
> > >> and we wouldn't even need a new ioctl or anything else from KVM or the
> > >> kernel to do this.  I think we should measure the effect of this
> > >> before dismissing it though.
> > >>
> > >
> > > If you could use dirty page tracking to only perform the cache
> > > invalidation when the framebuffer memory has been updated, you can at
> > > least limit the impact to cases where the framebuffer is actually
> > > used, rather than sitting idle with a nice wallpaper image.
> 
> Yes, this is the exact approach I took back when I experimented with
> this. I must have screwed up my PoC in some way (like using the gcc
> builtin), because it wasn't working for me...
> 
Does that mean you have some code you feel like reviving and use to send
out an RFC based on? ;)

-Christoffer
