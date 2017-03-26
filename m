Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1cs4I6-0000ZE-HW
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1cs4I3-0005X2-Bx
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:16:50 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:22932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1cs4I3-0005U1-3J
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 05:16:47 -0400
Message-ID: <1490519798.11328.113.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Sun, 26 Mar 2017 11:16:38 +0200
In-Reply-To: <CAFEAcA-BaDtJyNk0pB7AwyJNXtZ8V9LgJzcuAfPbN65b7OFsSw@mail.gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<1490474958.11328.86.camel@oracle.com>
	<CAFEAcA-BaDtJyNk0pB7AwyJNXtZ8V9LgJzcuAfPbN65b7OFsSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sat, 2017-03-25 at 21:15 +0000, Peter Maydell wrote:
> On 25 March 2017 at 20:49, Knut Omang <knut.omang@oracle.com> wrote:
> > 
> > Can we please keep the Sparc support in for a while still?
> 
> Yes, John Paul Adrian Glaubitz and the Debian Project have
> kindly provided me with access to a Sparc box. I'm planning
> to send a patch that puts sparc into the 'supported'
> category before 2.9 release.

good to hear!

> I would note that so far I've found a couple of TCG
> bugs of the "this just doesn't work at all" level, so
> it doesn't look like anybody using sparc has been
> doing any testing against git master...

No, I tried a while ago myself without much success so there's awareness
about this sad state. Hopefully we can get some momentum on it soon.

> > 
> > When it comes to build platforms, a legitimate need to be able to keep
> > anything
> > running, I don't have any authority to promise away hardware or other forms
> > of
> > Sparc access, but I have been told that that part can be worked out in some
> > way
> > if we get enough support for this internally.
> 
> I'd recommend trying to get a machine into the gcc compile
> farm (assuming they'd be willing to take it) -- that way
> it's accessible to developers for a range of open
> source projects.

I'll bring that suggestion forward,

Thanks,
Knut

> 
> thanks
> -- PMM
