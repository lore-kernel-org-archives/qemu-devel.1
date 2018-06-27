Received: from eggs.gnu.org ([2001:4830:134:3::10]:51698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYABB-0002OT-Cv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYAB7-0005wz-GK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:08:13 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYAB7-0005vC-8r
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:08:09 -0400
Received: by mail-wr0-x241.google.com with SMTP id k16-v6so1994641wro.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:08:09 -0700 (PDT)
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
	<20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
	<CAFEAcA-ZM-HS_BB4F3eS0VmPdXkaeDfTJ+R256BMujyt114mxw@mail.gmail.com>
	<20180627110912.GA2424@work-vm>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180627110912.GA2424@work-vm>
Date: Wed, 27 Jun 2018 14:08:06 +0100
Message-ID: <87bmbwwf61.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Martin Schrodt <martin@schrodt.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 27 June 2018 at 09:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >   Hi,
>> >
>> >> > Is QEMU still useful on 32-bit hosts?  Honest question!
>> >>
>> >> I guess it depends on what 32-bit hosts you consider. If you look at =
only
>> >> x86 vs. x86_64 then probably x86 is not that important any more but f=
or some
>> >> embedded systems/SoCs 32bit might still be common and QEMU useful for=
 those
>> >> (also as host not only emulated).
>>
>> I would generally agree with this. For x86 32-bit is probably
>> droppable, but for non-x86 the situation is much less clear.
>>
>> > Well.  I've used kvm with an 32bit arm soc (cubietruck).  It's very
>> > slow.  And all the arm architecture improvements to support kvm better
>> > are for aarch64 only.
>>
>> Cubietruck (a Cortex-A7) is a pretty slow 32-bit Arm core.
>>
>> Ask again in a couple of years :-)
>
> How about dropping support for 32 bit hosts that don't have
> 64bit atomics?
> That should be a much smaller set.

Seems a bit harsh - we don't support MTTCG if you don't have big enough
atomics, but we don't drop TCG support completely. And in fact in the
case in point I don't think you could trigger a bug with emulation being
single threaded and all.

>
> Dave
>
>> thanks
>> -- PMM
>>


--
Alex Benn=C3=A9e
