Received: from eggs.gnu.org ([2001:4830:134:3::10]:45197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eO68X-00020e-FA
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eO68W-0002HN-EG
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:15:37 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eO68W-0002Gl-8q
	for qemu-devel@nongnu.org; Sun, 10 Dec 2017 13:15:36 -0500
Received: by mail-ot0-x244.google.com with SMTP id o23so13024663otd.1
	for <qemu-devel@nongnu.org>; Sun, 10 Dec 2017 10:15:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHmME9rSEtwg=n1gtqOVh=Et5yn45Yveh3LEFj357aqRZXwwcQ@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
	<CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
	<CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
	<CAHmME9pE79krWx-zD=VGiScT4c=4TZ1wVxYFiF3m+8wsx9Fqeg@mail.gmail.com>
	<CAFEAcA9XoeXDCQCmRBehntWSo0WGRBsaMDmC8QCqgU1K8jAF_A@mail.gmail.com>
	<CAHmME9qSJSPjANce_cWN6nm=qJsncfczgk7PoPa0xkOHmZjLUA@mail.gmail.com>
	<CAFEAcA-bKPNwJpcny=1azScO8bzHsi0Ou+m3rYPq-=v52Gf26g@mail.gmail.com>
	<CAHmME9qNnqYEbW_m8LG0E0HBKUE38YjUodbBihnSi2k0FrZJtw@mail.gmail.com>
	<CAFEAcA-5F2GMx9UNoH=LJAa-m1DXg2HW8PJZ47kurjx5x3NhWA@mail.gmail.com>
	<CAHmME9rSEtwg=n1gtqOVh=Et5yn45Yveh3LEFj357aqRZXwwcQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Dec 2017 18:15:14 +0000
Message-ID: <CAFEAcA9R4=+aTuvrkkOBTTFnu5jnOKaVWLY9t+2Hj+dQrtdaHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 December 2017 at 18:39, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Fri, Dec 8, 2017 at 12:49 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> My suggestion is that we should add a second non-secure UART
>> to the virt board, so if you're using secure=no then you
>> get serial 1 and 2, and for secure=yes serial 1 is the first
>> NS uart, serial 2 is the secure uart and serial 3 is the
>> 2nd NS uart. (I don't really want to add a 4th uart unless
>> there's some good reason to -- maybe we would turn out to
>> want it for the secure side, for instance.)

> I'm curious why you don't want to add a 4th UART. It seems trivial to
> do, and the more the merrier? Or that's a silly attitude? Mostly just
> curious about that, as having two personally suits my needs.

As I say, if we add it for the non-secure world we can't
make it a secure uart later if that turns out to be what we need.
The "4 uarts max" limit is a compile time one.
(Also it uses physical address space in a region which is
relatively small and which we might want for a different device.)

thanks
-- PMM
