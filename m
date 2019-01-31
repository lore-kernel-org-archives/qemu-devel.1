Received: from eggs.gnu.org ([209.51.188.92]:35853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpB6D-0008DX-2s
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpB6A-0005Lt-DV
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:05:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
	<75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
	<CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
	<877eeldx9p.fsf@dusky.pond.sub.org>
	<CAFEAcA-AYVgigihO5LF3EgfOo5=uaB5Gx3b8Eh3it2QvZkomYg@mail.gmail.com>
	<87bm3xazv3.fsf@dusky.pond.sub.org>
	<CAFEAcA_hsh+tAUhUX+xD4KDLFBZszmcnu=rrxVYfumHPsz5Wow@mail.gmail.com>
Date: Thu, 31 Jan 2019 13:05:11 +0100
In-Reply-To: <CAFEAcA_hsh+tAUhUX+xD4KDLFBZszmcnu=rrxVYfumHPsz5Wow@mail.gmail.com>
	(Peter Maydell's message of "Thu, 31 Jan 2019 10:34:32 +0000")
Message-ID: <87sgx99gnc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 31 Jan 2019 at 10:24, Markus Armbruster <armbru@redhat.com> wrote:
>> 1. Make the device model default to some "correct" configuration, even
>> if that setting is kind of arbitrary.  That way, any code using new
>> style gets an "incorrect" configuration only if it actively selects one.
>
> I don't think that's much better, because it will still
> probably be wrong for the board. People writing board models
> should define what their pflash device is, not plug in something
> that's not what the hardware is.

If you want to force people to select a sane configuration, set the
default to some suitable nonsense the realize() method rejects.
