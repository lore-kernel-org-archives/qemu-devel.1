Received: from eggs.gnu.org ([2001:4830:134:3::10]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs50f-0001QA-0X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs50e-0003Rb-AV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:39:40 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs50e-0003RH-2I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:39:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id q204-v6so2210182oig.9
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:39:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5adf2f78-0e4f-7c02-a5df-a2770ab4920d@isystem.si>
References: <2edf4dc3-5cc2-c3f3-fd40-7901e2c06413@isystem.si>
	<CAFEAcA-gbG0xF3faXZYpkg_OyOyNcPyviDBhytzi1AkUj3FL4w@mail.gmail.com>
	<5adf2f78-0e4f-7c02-a5df-a2770ab4920d@isystem.si>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 12:39:19 +0100
Message-ID: <CAFEAcA__5+nCEbb9-B+fWKhB3c=HP_5N7tnw7i1uvD7rWPY0uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm: fix reset operation on
 netduino2 board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marko Klopcic <marko.klopcic@isystem.si>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>

On 21 August 2018 at 12:37, Marko Klopcic <marko.klopcic@isystem.si> wrote:
> Thanks for the review. I agree that this fix is more a workaround, but it is
> local to
> the only currently existing board with STM32 (AFAIK), so I couldn't break
> other targets.
> I'll try to implement one of your proposals.

It's a pretty nasty issue to try to fix. You might want to
send a proposed design for a fix to the mailing list before
you write too much code...

thanks
-- PMM
