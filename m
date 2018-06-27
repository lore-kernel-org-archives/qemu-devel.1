Received: from eggs.gnu.org ([2001:4830:134:3::10]:33095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fY5bb-0008Jt-Rx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fY5bX-00078o-Q5
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:15:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:45059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fY5bX-000786-FL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:15:07 -0400
Date: Wed, 27 Jun 2018 10:15:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <87fu18ach6.fsf_-_@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL
 1/6] audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 27 Jun 2018, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>> On 27.06.2018 08:51, Gerd Hoffmann wrote:
> [...]
>>> Drop support for 32bit hosts in qemu?
>>
>> I guess the only way to answer that question reliably is to send a patch
>> to mark 32-bit hosts as deprecated...
>>
>> Anyway, you still have got to fix that problem with -m32 now somehow
>> since we certainly can not drop 32-bit immediately.
>
> We certainly can if we want to.
>
> Our formal deprecation policy codifies our compromise between the need
> to evolve QEMU and the need of its users for stable external interfaces.
>
> "Compiles on host X" is also a need, but it's a different one.
> Evidence: "Supported build platforms" has its own appendix, separate
> from "Deprecated features".  It's mum on 32-bit hosts.
>
> I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
> feature deprecation policy does not apply.
>
> Is QEMU still useful on 32-bit hosts?  Honest question!

I guess it depends on what 32-bit hosts you consider. If you look at only 
x86 vs. x86_64 then probably x86 is not that important any more but for 
some embedded systems/SoCs 32bit might still be common and QEMU useful for 
those (also as host not only emulated).

Another option might be to not support audio/hda on 32bit hosts. It's not 
nice either but a lot nicer than dropping support for 32bit hosts 
alltogether to fix a problem in device emulation. The nicest would of 
course be fixing the device emulation to work on all supported platform.

Regards,
BALATON Zoltan
