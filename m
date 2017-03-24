Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crSiF-0002Pt-4r
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crSiE-0006hc-BS
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:09:19 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crSiE-0006hI-4D
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:09:18 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l43so5821762wre.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 10:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3vur4qk.fsf@dusky.pond.sub.org>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 17:08:56 +0000
Message-ID: <CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2017 at 16:58, Markus Armbruster <armbru@redhat.com> wrote:
> "Sysbus" isn't a bus.  In qdev's original design, every device had to
> plug into a bus, period.  The ones that really didn't were made to plug
> into "sysbus".
>
> Pretty much the only thing "sysbus" devices had in common was that they
> couldn't be used with device_add and device_del.

This isn't really true. Sysbus devices support having MMIO regions
and IRQ lines and GPIO lines. If you need those you're a
sysbus device; otherwise you can probably just be a plain old Device.

> We fixed the design to permit bus-less devices, but we didn't get rid of
> "sysbus".

Call it what you want, but we should have some common code support
for "I want to have MMIOs and IRQs and GPIO lines". You could
argue for moving all that into Device I suppose.

> We got a "platform bus", which is really not the same as "sysbus", but
> we shoehorned it into "sysbus" anyway.

I agree 'platform bus' is a mess, and I'd rather it didn't exist.
Unfortunately people really really want to be able to do device
pass through of random memory-mapped devices :-(

thanks
-- PMM
