Received: from eggs.gnu.org ([2001:4830:134:3::10]:38329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crUo3-0005df-Oj
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1crUnz-0003Z9-RR
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1crUnz-0003Z0-ML
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:23:23 -0400
Date: Fri, 24 Mar 2017 16:23:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170324192318.GG28530@thinpad.lan.raisama.net>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 24, 2017 at 05:08:56PM +0000, Peter Maydell wrote:
> On 24 March 2017 at 16:58, Markus Armbruster <armbru@redhat.com> wrote:
> > "Sysbus" isn't a bus.  In qdev's original design, every device had to
> > plug into a bus, period.  The ones that really didn't were made to plug
> > into "sysbus".
> >
> > Pretty much the only thing "sysbus" devices had in common was that they
> > couldn't be used with device_add and device_del.
> 
> This isn't really true. Sysbus devices support having MMIO regions
> and IRQ lines and GPIO lines. If you need those you're a
> sysbus device; otherwise you can probably just be a plain old Device.
> 
> > We fixed the design to permit bus-less devices, but we didn't get rid of
> > "sysbus".
> 
> Call it what you want, but we should have some common code support
> for "I want to have MMIOs and IRQs and GPIO lines". You could
> argue for moving all that into Device I suppose.

Even if we don't move all that into Device, this sounds like an
argument for the existence of struct SysBusDevice. But I still
don't understand the reason TYPE_SYSTEM_BUS still exists.

-- 
Eduardo
