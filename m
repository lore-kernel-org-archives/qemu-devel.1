Received: from eggs.gnu.org ([2001:4830:134:3::10]:58427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csPZt-0007S5-2w
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1csPZq-0006RB-3K
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1csPZp-0006Qo-Tp
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:00:34 -0400
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
	<877f3emu7w.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <479099e3-614d-42d3-31f2-f61a624a2844@redhat.com>
Date: Mon, 27 Mar 2017 10:00:27 +0200
MIME-Version: 1.0
In-Reply-To: <877f3emu7w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24.03.2017 18:59, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On 24 March 2017 at 16:58, Markus Armbruster <armbru@redhat.com> wrote:
>>> "Sysbus" isn't a bus.  In qdev's original design, every device had to
>>> plug into a bus, period.  The ones that really didn't were made to plug
>>> into "sysbus".
>>>
>>> Pretty much the only thing "sysbus" devices had in common was that they
>>> couldn't be used with device_add and device_del.
>>
>> This isn't really true. Sysbus devices support having MMIO regions
>> and IRQ lines and GPIO lines. If you need those you're a
>> sysbus device; otherwise you can probably just be a plain old Device.
> 
> Well, "device has MMIO regions, IRQ lines and GPIO lines" is about as
> "device contains virtual silicon".  What would a device without any of
> these *do*?

On ppc64, we've got for a example pseudo-devices that takes care of
certain hypercalls, e.g. the spapr-rng or the spapr-rtc devices (well,
the latter is still a TYPE_SYS_BUS_DEVICE ... we should convert it to
TYPE_DEVICE instead one day...). These devices do not have any MMIO, IRQ
or GPIO lines at all, so I think the differentiation between a very
generic TYPE_DEVICE class and a "SYS_BUS_DEVICE" (with MMIO/IRQ/GPIO)
class still makes sense.

 Thomas
