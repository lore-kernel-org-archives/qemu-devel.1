Received: from eggs.gnu.org ([209.51.188.92]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gotbS-0002EJ-7K
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gotbR-0002tV-BB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:24:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gotbR-0002sL-2Z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:24:45 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so279973oth.7
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:24:44 -0800 (PST)
MIME-Version: 1.0
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<871s4uobf0.fsf@dusky.pond.sub.org>
	<CAFEAcA_t2707yp5cz+rbMVE3nhLk288iFgK=vUgzFyCw79uX5g@mail.gmail.com>
	<75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
In-Reply-To: <75629302-84bb-ba19-cb2c-5edc34cffadb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Jan 2019 17:24:32 +0000
Message-ID: <CAFEAcA-jp=k5-jHeY_ziMbgYBo5U7-ZKSRtU8nfPyAFh9jYUQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Wed, 30 Jan 2019 at 16:44, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 01/30/19 16:24, Peter Maydell wrote:
>
> > Well, nobody who does anything with x86 has cared enough to
> > make the pflash implementation actually correct.
>
> I feel sort of included under this umbrella, so:
>
> I haven't been aware of any particular pflash implementation errors. I
> "didn't care" because it "worked fine" as much as I could tell.

It depends entirely on what the guest code that's accessing
the flash devices does. If you stick to what Linux and
presumably UEFI have always done then you don't notice
anything wrong. Some things that are in spec for hardware
don't work right, though.

Commits 4b6fedcac0f51157e through a0289b8af3b05fe4 are
where we fixed these bugs.

Updating other platforms should mostly be a matter of
(a) figuring out what the actual hardware config is
and setting the device properties accordingly
(b) testing that guest software still works
(c) checking that migration compat remains working

thanks
-- PMM
