Received: from eggs.gnu.org ([2001:4830:134:3::10]:37614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dMiTl-0005Np-TI
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 18:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dMiTh-0000Bu-RV
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 18:15:33 -0400
In-Reply-To: <B89DC65F-3BF3-4140-9467-5E0921E100FE@gmail.com>
References: <mailman.79275.1497783014.22739.qemu-devel@nongnu.org>
	<AF8C3FA5-35D0-4391-8F3B-C9723FBEE2BE@gmail.com>
	<OFEB04B3D4.4F8B4FD7-ON86258143.0070FC87-86258143.00713D4F@ddci.com>
	<B89DC65F-3BF3-4140-9467-5E0921E100FE@gmail.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF36F22934.4BC8491E-ON86258143.0079D711-86258143.007A42F7@ddci.com>
Date: Sun, 18 Jun 2017 17:15:26 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] [PATCH v3] target-ppc: Enable open-pic timers to
 count and generate interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>

G 3 <programmingkidx@gmail.com> wrote on 06/18/2017 03:38:29 PM:
> >>>>> From: Aaron Larson <alarson@ddci.com>
> >>>>> Date: 06/05/2017 12:22 PM
> >>>>> Subject: [PATCH v3] target-ppc: Enable open-pic timers to count 
> >>>>> and generate interrupts
> >>>>>
> >>>>> Previously QEMU open-pic implemented the 4 open-pic timers
> >>>>> including all timer registers, but the timers did not "count"
> >>>>> or generate any interrupts.  The patch makes the timers both
> >>>>> count and generate interrupts.  The timer clock frequency is
> >>>>> fixed at 25MHZ.
> >
> > G3> Does QEMU behave differently after this patch is implemented?
> >
> > If the open-pic timers are programmed, then QEMU behaves
> > differently, otherwise there should be no difference.
> 
> I guess I should have asked what differences did you see in QEMU's 
> behavior?

In the past, the open-pic timers were, effectively, unimplemented.
They allowed a write to the timer registers, e.g., to enable a
counter, but the counter never "counted", instead just returning
whatever was most recently programmed.

Now the timers are, well, timers.  Given the previous implementation,
it was highly unlikely any software running on QEMU actually used the
timers, so in general I would expect there would be no difference at
all.
