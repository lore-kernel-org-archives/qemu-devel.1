Received: from eggs.gnu.org ([2001:4830:134:3::10]:60679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ficRJ-0003ui-F7
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ficRG-0004Ft-EW
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:20:05 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ficRF-0004Fj-Vy
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:20:02 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so1739841oie.7
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 02:20:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8qM=C=bJeDrUHxMEp3mZ-PYemRXK-Qttvwk9k+C2uz+Q@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725105330.GB2366@work-vm>
	<CAHmQWvCHBxdMy+Qocc1XfURx86RTZd72rnB5-R=5QA00R6fEqw@mail.gmail.com>
	<CAKv+Gu8qM=C=bJeDrUHxMEp3mZ-PYemRXK-Qttvwk9k+C2uz+Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jul 2018 10:19:40 +0100
Message-ID: <CAFEAcA_DL-Gfo3nJffaWquORaxkEdFU3hz0cndBq_zvVAL3vHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 26 July 2018 at 08:44, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Does that really matter? As I pointed out before, we are not
> interested in running the firmware on actual bare metal. What we do
> care about is not having code in the reference firmware stack that was
> added specifically to deal with the dynamic nature of our QEMU
> platform.

I think we also care in the sense that what we put in the reference
platform is an implicit recommendation. So if we (collectively) think
that good Arm server platforms are likely to or should use XHCI,
we should definitely consider going with that, rather than going with
what happens to be being used on currently shipping hardware.
(We should also consider whether we want to implicitly recommend
that the USB controller should be memory-mapped rather than
hanging off a PCI controller.)

thanks
-- PMM
