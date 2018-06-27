Received: from eggs.gnu.org ([2001:4830:134:3::10]:52136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYACg-0003nq-Ah
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYACa-0007cz-KE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:09:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYACa-0007c9-3l
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:09:40 -0400
Received: by mail-wm0-x243.google.com with SMTP id p11-v6so5413261wmc.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:09:40 -0700 (PDT)
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
	<87fu18ach6.fsf_-_@dusky.pond.sub.org>
	<alpine.BSF.2.21.1806271010080.90116@zero.eik.bme.hu>
	<20180627085217.blrsx5lmu4sau4fd@sirius.home.kraxel.org>
	<CAFEAcA-ZM-HS_BB4F3eS0VmPdXkaeDfTJ+R256BMujyt114mxw@mail.gmail.com>
	<20180627110912.GA2424@work-vm> <87bmbwwf61.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87bmbwwf61.fsf@linaro.org>
Date: Wed, 27 Jun 2018 14:09:37 +0100
Message-ID: <87a7rgwf3i.fsf@linaro.org>
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Dr. David Alan Gilbert <dgilbert@redhat.com> writes:
>
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> On 27 June 2018 at 09:52, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> >   Hi,
>>> >
>>> >> > Is QEMU still useful on 32-bit hosts?  Honest question!
>>> >>
>>> >> I guess it depends on what 32-bit hosts you consider. If you look at=
 only
>>> >> x86 vs. x86_64 then probably x86 is not that important any more but =
for some
>>> >> embedded systems/SoCs 32bit might still be common and QEMU useful fo=
r those
>>> >> (also as host not only emulated).
>>>
>>> I would generally agree with this. For x86 32-bit is probably
>>> droppable, but for non-x86 the situation is much less clear.
>>>
>>> > Well.  I've used kvm with an 32bit arm soc (cubietruck).  It's very
>>> > slow.  And all the arm architecture improvements to support kvm better
>>> > are for aarch64 only.
>>>
>>> Cubietruck (a Cortex-A7) is a pretty slow 32-bit Arm core.
>>>
>>> Ask again in a couple of years :-)
>>
>> How about dropping support for 32 bit hosts that don't have
>> 64bit atomics?
>> That should be a much smaller set.
>
> Seems a bit harsh - we don't support MTTCG if you don't have big enough
> atomics, but we don't drop TCG support completely. And in fact in the
> case in point I don't think you could trigger a bug with emulation being
> single threaded and all.

I should point out that is what TCG_OVERSIZED_GUEST is defined for.

--
Alex Benn=C3=A9e
