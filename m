Received: from eggs.gnu.org ([2001:4830:134:3::10]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGNYu-0005J9-P1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGNYt-0000v5-Sy
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 05:10:24 -0500
Date: Mon, 12 Dec 2016 11:10:10 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161212101010.eb74etmg6gjcx5ew@kamzik.brq.redhat.com>
References: <1481301020-21777-1-git-send-email-peter.maydell@linaro.org>
	<1481301020-21777-5-git-send-email-peter.maydell@linaro.org>
	<20161211163502.GB6352@cbox>
	<CAFEAcA_zvNvJ7K5GgPyeJ5EWRxO1XL2=rc6dv_nT6_h3qF=m6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zvNvJ7K5GgPyeJ5EWRxO1XL2=rc6dv_nT6_h3qF=m6A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/arm/virt: Don't incorrectly claim
 architectural timer to be edge-triggered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, Dec 11, 2016 at 10:52:25PM +0000, Peter Maydell wrote:
> On 11 December 2016 at 16:35, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Fri, Dec 09, 2016 at 04:30:20PM +0000, Peter Maydell wrote:
> >> +     * For backwards-compatibility, virt-2.8 and earlier will continue
> >> +     * to say these are edge-triggered, but later machines will report
> >> +     * the correct information.
> >>       */
> >
> > Is this really necessary?
> 
> It's being conservative -- from the guest's point of view
> (any guest, not necessarily just Linux) "virt-2.8" should behave
> like the "virt" machine in the 2.8 QEMU release, including bugs,
> not providing newer devices, and so on.
> 
> Andrew would be the expert on whether this is being unnecessarily
> conservative in this specific case.

I agree that all DT and ACPI (we need the equivalent change to the GTDT)
changes should require compatibility code. We should document a list of
mach-virt change types that require machine version consideration
somewhere. I can ask our migration experts to help me pull a list
together.

Thanks,
drew
