Received: from eggs.gnu.org ([209.51.188.92]:52028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2d86-0005Qt-58
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2d85-0002g8-EZ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:39:14 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2d84-0002cz-TP
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:39:13 -0500
Received: by mail-oi1-x242.google.com with SMTP id b4so374906oif.6
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:39:12 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9UzFdyAFkAuWzcV5x1JDBCTVr=okdLN-MpiduvACt4tw@mail.gmail.com>
	<CADYoBw3yj9yuxUSFuwCqKbTZNFFDF7Je4Kgxt-Rvd71x3JusQA@mail.gmail.com>
	<CAFEAcA_N83yo8xV3hCpVPFOhQj+R95+8fVePjEXgxKZtQPUP3w@mail.gmail.com>
	<CADYoBw00Li2G4srfLvtG4pvBMfyEuDh0AU47wj5BcKOUkfWhKw@mail.gmail.com>
	<CAFEAcA9Ycm43h8ekoc1uP_K7eLT98Qg+EFqE3Lvu66cjU5c5_A@mail.gmail.com>
	<CADYoBw1QFQxicJJ9tQa2Ok7PAdWvgtD4MQncdJ0zi4E2vktVhQ@mail.gmail.com>
	<CAFEAcA-+U75+EQzcpV4kZHw+4xMSbMv3UJ0CV_Q3DVbNx5RbNg@mail.gmail.com>
	<CADYoBw2XWeDUqBHVJBWxJAzQ4f0imosEeLHHoG9AfHfdavOTrA@mail.gmail.com>
In-Reply-To: <CADYoBw2XWeDUqBHVJBWxJAzQ4f0imosEeLHHoG9AfHfdavOTrA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:39:00 +0000
Message-ID: <CAFEAcA8YT4oLWK7gQB44p5UQVHEUR6bFdHy6VcGnGAxFxhWdiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 9 Mar 2019 at 01:03, bzt <bztemail@gmail.com> wrote:
> Thanks for your answers. If I don't clear the INTENABLE flag, then the
> IRQ would keep firing constantly. This is not how the real hardware
> works: it triggers the IRQ once, and then it inhibits. The timer won't
> trigger the IRQ again until you acknowledge it by writing the INTFLAG
> into the ack register. My solution emulates this behaviour. That's
> what the triggered flag was for in my original patch. Should I bring
> that flag back or is the current solution acceptable knowing this?

Huh. The QA7 spec doc is pretty clear that the IRQ is kept high
until the guest acknowledges it (and that is how in general
IRQ/FIQ works for Arm -- it is level triggered and it stays high
until the guest silences the device):
"An interrupt is generated as long as the interrupt flag is set
and the interrupt-enable bit is set" and "The user must clear the
interrupt flag".


thanks
-- PMM
