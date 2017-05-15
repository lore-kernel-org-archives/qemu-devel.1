Received: from eggs.gnu.org ([2001:4830:134:3::10]:41970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dACDU-0005Uk-KI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dACDR-0005s5-DP
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dACDR-0005rg-5p
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:22:57 -0400
Date: Mon, 15 May 2017 10:22:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515092251.GB2089@work-vm>
References: <20170511123639.GE2078@work-vm>
	<225AC0F4-5672-456F-9032-F2C1C86342E5@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <225AC0F4-5672-456F-9032-F2C1C86342E5@daynix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] e1000e migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org

* Dmitry Fleytman (dmitry@daynix.com) wrote:
> Hello Dave,

Hi Dmitry,
  Thanks for the reply.

> We are trying to reproduce this issue on our systems but with no luck s=
o far=E2=80=A6

Note our QE hit this with both a Win8.1 and a win2012r2 guest - although
the 2012r2 is reported to have recoverd after a few minutes.
2016 apparently works OK.

> From what you describe it looks like some bit in ICR is not being clear=
ed by the driver.
> This usually means that this bit should never be set in that specific i=
nterrupt mode.
>=20
> Could you please check which bit is not cleared and who sets it?

The full set of e1000e_irq_pending_interrupts after migration is:
23004@1494519346.673905:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
00 (ICR: 0x80100082, IMS: 0x1f00004)
23004@1494519346.674787:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x80100082, IMS: 0x1e00004)
23004@1494519346.674946:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x80100082, IMS: 0x1e00004)
23004@1494519346.675119:e1000e_irq_pending_interrupts ICR PENDING: 0x2000=
00 (ICR: 0x80300082, IMS: 0x1e00004)
23004@1494519346.675302:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x80100082, IMS: 0x1c00004)
  <repeated lots>
23004@1494519346.716279:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x80300082, IMS: 0x1c00004)
23004@1494519346.716380:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
000 (ICR: 0x813000c2, IMS: 0x1c00004)
23004@1494519346.717040:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
000 (ICR: 0x813000c2, IMS: 0x1400004)
23004@1494519346.717276:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
000 (ICR: 0x813000c2, IMS: 0x1000004)
23004@1494519346.717443:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.717567:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.717782:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.717918:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.718319:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.718523:e1000e_irq_pending_interrupts ICR PENDING: 0x2000=
00 (ICR: 0x813000c2, IMS: 0xa00004)
23004@1494519346.718684:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0x4)
23004@1494519346.718890:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0x4)
23004@1494519346.719034:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0xa00004)
23004@1494519346.719130:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0xa00004)
  <repeats>
23004@1494519346.722699:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0xa00004)
23004@1494519346.722868:e1000e_irq_pending_interrupts ICR PENDING: 0x2000=
00 (ICR: 0x813000c2, IMS: 0xa00004)
23004@1494519346.723068:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0x800004)
  <repeats>
23004@1494519346.731198:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x800004)
23004@1494519346.731422:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x813000c2, IMS: 0x4)
23004@1494519346.731930:e1000e_irq_pending_interrupts ICR PENDING: 0x2000=
00 (ICR: 0x813000c2, IMS: 0xa00004)
23004@1494519346.732082:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0x4)
23004@1494519346.732274:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0x4)
23004@1494519346.732404:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0xa00004)
23004@1494519346.732504:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x811000c2, IMS: 0xa00004)
23004@1494519346.784150:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.786506:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.786534:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.789644:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
000 (ICR: 0x815000c2, IMS: 0x1a00004)
23004@1494519346.789864:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.789992:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.790413:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.790539:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.792593:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.792620:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (I=
CR: 0x815000c2, IMS: 0xa00004)
23004@1494519346.795943:e1000e_irq_pending_interrupts ICR PENDING: 0x1000=
000 (ICR: 0x815000c2, IMS: 0x1a00004)

and then I think we get stuck in this cycle of this one always being the
one that fires repeatedly.  I think that's the 'other' firing, I think
because of the receive-overrun.  One thing I've not
figured out is why the receive overrun happens - is that because we
really have a very heavy packet rate or is it because something has
stopped receiving them.
The network I'm testing on does have a fair amount of broadcast traffic
on.

Dave

> Regards,
> Dmitry
>=20
> > On 11 May 2017, at 15:36 PM, Dr. David Alan Gilbert <dgilbert@redhat.=
com> wrote:
> >=20
> > Hi Dmitry,
> >  Have you seen any problems with e1000e migration under windows?
> > I've got a repeatable case where after migration with e1000e windows
> > hangs/almost hangs.
> >  I'm seeing the e1000e generate interrupts at a very very high
> > rate (maybe ~1000 second ish?) after migration.
> >=20
> >  Some versions of qemu do it and some dont, but my attempts
> > at bisection lead me to code that should be irrelevant.
> >=20
> > Prior to migration I see:
> >=20
> > 36461@1494504466.711929:e1000e_irq_pending_interrupts ICR PENDING: 0x=
100000 (ICR: 0x80100082, IMS: 0x1f00004)
> > 36461@1494504466.711992:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0 (ICR: 0x80000082, IMS: 0x1a00004)
> > 36461@1494504466.712076:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0 (ICR: 0x80000082, IMS: 0x1f00004)
> > 36461@1494504466.712245:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0 (ICR: 0x80000082, IMS: 0x1a00004)
> > 36461@1494504466.712332:e1000e_irq_pending_interrupts ICR PENDING: 0x=
0 (ICR: 0x80000082, IMS: 0x1f00004)
> >=20
> > which I think the ICR means:
> >      31 - int asserted
> >      20 - RxQ0 - receive queue 0 interrupt
> >      7  - RXT0 - receiver timer interrupt
> >      1  - TXQE - Transmit Queue empty
> >=20
> > after migration it varies more, I'm seeing mostly:
> > 21977@1494504516.320707:e1000e_irq_pending_interrupts ICR PENDING: 0x=
1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
> >      31 - int asserted
> >      24 - 'Other'
> >      22 - TxQ0 interrupt
> >      20 - RxQ0 interrupt
> >      07 - RXT0 Receiver timer interrupt
> >      06 - RX0 - Receiver overrun
> >      01 - TXQE - Transmit queue empty
> >=20
> > For reference this is https://bugzilla.redhat.com/show_bug.cgi?id=3D1=
447935
> >=20
> > Dave
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
