Received: from eggs.gnu.org ([2001:4830:134:3::10]:42991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeY-0006rA-Vm
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpDeU-0008DX-47
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:12:30 -0400
Date: Tue, 5 Sep 2017 21:12:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905131208.GV22515@lemon.lan>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170905033501.GS22515@lemon.lan>
	<CAFEAcA9bDh7c5WtUb+2qCFk0baj+=M2VvkYr1HW+1w=jqFRN=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9bDh7c5WtUb+2qCFk0baj+=M2VvkYr1HW+1w=jqFRN=A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/6] arm: Make use of DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 09/05 11:43, Peter Maydell wrote:
> On 5 September 2017 at 04:35, Fam Zheng <famz@redhat.com> wrote:
> > Hi,
> >
> > Ping for 2.11.
> >
> > Peter, what do you think?
> >
> > On Mon, 07/17 10:38, Fam Zheng wrote:
> >> This is the arm part that was left out from:
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04006.html
> >>
> >> Make use of the new DEFINE_PROP_LINK, in favor of open coded the
> >> object_property_add_link. The advantage of it is the property now get reflected
> >> in the info qtree output, for a bit more introspectability.
> >>
> >> Fam Zheng (6):
> >>   armv7m: Convert bitband.source-mamory to DEFINE_PROP_LINK
> >>   armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
> >>   gicv3: Convert to DEFINE_PROP_LINK
> >>   xlnx_zynqmp: Convert to DEFINE_PROP_LINK
> >>   xilinx_axienet: Convert to DEFINE_PROP_LINK
> >>   xilinx_axidma: Convert to DEFINE_PROP_LINK
> 
> These look OK, but they've fallen out of the 'patches' cache.
> There's a typo in the subject of the bitband one: should
> be "memory", not "mamory". Can you fix that, add the reviewed-bys
> and resend the series, please, and I'll put it in my queue?

Sure, sent v6.

Fam
