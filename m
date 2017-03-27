Received: from eggs.gnu.org ([2001:4830:134:3::10]:39932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csQGl-0007yj-E9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csQGi-0003dI-4L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49799
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1csQGh-0003bu-V2
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:44:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2R8i6k5068495
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:44:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29dn4uu8fm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:44:49 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Mar 2017 09:44:47 +0100
Date: Mon, 27 Mar 2017 10:44:40 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170324192318.GG28530@thinpad.lan.raisama.net>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
	<20170324192318.GG28530@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170327104440.4f58ec26.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 24 Mar 2017 16:23:18 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Mar 24, 2017 at 05:08:56PM +0000, Peter Maydell wrote:
> > On 24 March 2017 at 16:58, Markus Armbruster <armbru@redhat.com> wrote:
> > > "Sysbus" isn't a bus.  In qdev's original design, every device had to
> > > plug into a bus, period.  The ones that really didn't were made to plug
> > > into "sysbus".
> > >
> > > Pretty much the only thing "sysbus" devices had in common was that they
> > > couldn't be used with device_add and device_del.
> > 
> > This isn't really true. Sysbus devices support having MMIO regions
> > and IRQ lines and GPIO lines. If you need those you're a
> > sysbus device; otherwise you can probably just be a plain old Device.
> > 
> > > We fixed the design to permit bus-less devices, but we didn't get rid of
> > > "sysbus".
> > 
> > Call it what you want, but we should have some common code support
> > for "I want to have MMIOs and IRQs and GPIO lines". You could
> > argue for moving all that into Device I suppose.
> 
> Even if we don't move all that into Device, this sounds like an
> argument for the existence of struct SysBusDevice. But I still
> don't understand the reason TYPE_SYSTEM_BUS still exists.

ISTR some surprises that reset (or some other) callbacks were not
called as expected if there wasn't a sysbus device among the ancestors.
Don't know if that's still true.
