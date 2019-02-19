Received: from eggs.gnu.org ([209.51.188.92]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9s7-0001es-SW
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw9s5-0003k5-VH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:11:59 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw9s2-0003gL-9n
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:11:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id b3so35796157otp.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 10:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<15b742d6-18e9-dfd6-dac2-2613c0b93e76@redhat.com>
	<CAFEAcA84KnN4GVnNyw1V7r2-=DLdNJEzwMQEn8e5ZGV2Vr_RQA@mail.gmail.com>
	<8736ojpsv4.fsf@dusky.pond.sub.org>
In-Reply-To: <8736ojpsv4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 18:11:36 +0000
Message-ID: <CAFEAcA-C82npE4cYX+fv=C6nm7B7aD0Z4B6BriiJTScQ6-jWag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, 19 Feb 2019 at 17:53, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > What would this be, and when would you use it without a
> > /* FIXME this is not what the real hardware does */ ?
>
> For a purely virtual machine such as ARM virt, perhaps?
>
> Funnily, we use IDs 0x89, 0x18, 0x00, 0x00 there.

FWIW, this is "Manufacturer: Intel" and whatever device 0x18
is for Intel. IDs 2 and 3 are used by the pflash_cfi01 code
only if we're using the bogus backward-compatibility "act
like a bad emulation of two 16-bit devices making up a 32-bit
wide device", in which case they're the ID values for the
second of the two devices. (Or it might be that the ident
values then are "manuf-id manuf-id device-id device-id",
and with the not-bogus setup they're "manuf-id device-id
unused unused".)

I'm not sure whether the chips on any of these boards
really are Intel ones :-)

thanks
-- PMM
