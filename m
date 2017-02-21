Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgCqI-0006Q5-4Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgCqH-0001iT-2x
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:59:06 -0500
Date: Tue, 21 Feb 2017 12:58:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170221155856.GD2778@thinpad.lan.raisama.net>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA98V-3EMDS+o9HnAdY14JDoY4i8yYyFP=OiK8QXMSWvmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA98V-3EMDS+o9HnAdY14JDoY4i8yYyFP=OiK8QXMSWvmA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] cpu: Implement
 cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Thu, Feb 16, 2017 at 04:40:43PM +0000, Peter Maydell wrote:
> On 13 February 2017 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> > This patchset adds a new function cpu_generic_new()
> > which is similar to cpu_generic_init() except that it
> > does not realize the created CPU object. This means that
> > board code can do a "new cpu; set QOM properties; realize"
> > sequence without having to do all the work of splitting
> > the CPU model string and calling parse_features by hand.
> >
> > Patch 2 clarifies a TODO comment, hopefully correctly,
> > based on an email conversation I had with Eduardo a
> > little while back.
> >
> > Patches 3 and 4 change the ARM boards which currently
> > call parse_features by hand to use the new function.
> >
> >
> > If there's consensus that this is the right general
> > direction to go in, then I think that some other
> > architectures could also make cleanups to use this:
> >  * cpu_s390x_create() is almost exactly this function,
> >    give or take some fine detail of error handling
> >  * ppc_cpu_parse_features is almost the same thing,
> >    except that it doesn't actually create the CPU object,
> >    it only calls parse_features
> >  * hw/i386/pc.c does a manual parse_features
> >
> > I'm not strongly attached to this particular approach
> > (though it seems like a reasonable one, especially given
> > the proliferation of different arch-specific helpers
> > listed above and the bugs in boards which don't call
> > parse_features when they should), but I would like us to
> > figure out and document what the right way for a board
> > to create and configure its CPU objects is...
> 
> I know it's only been a few days, but I just wanted to
> say that I'd appreciate it if we could manage relatively
> quick review on this one, since I have a set of patches
> pending that depend on this and which it would be nice
> to get into 2.9 (softfreeze approaching rapidly).

I was away from work for the past 3 weeks and I am catching up on
e-mail, right now. Is this proposal still up, or is this series
obsoleted by something else?

-- 
Eduardo
