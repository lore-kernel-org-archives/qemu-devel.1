Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiJ2c-0003WM-Je
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiJ2Z-0008NO-Kz
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:37:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fiJ2Z-0008LY-F3
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:37:15 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so13562342oie.7
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 05:37:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9n5Y9tghjR7VJcnH96-rzDWvhY4UCkPtFP9hNUh=LK=Q@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
	<CAKv+Gu9n5Y9tghjR7VJcnH96-rzDWvhY4UCkPtFP9hNUh=LK=Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jul 2018 13:36:54 +0100
Message-ID: <CAFEAcA8xvU6Xxzig=9rYRqT7w0cCw_D32Rw3Rk7jxp8FF8TQHg@mail.gmail.com>
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
Cc: Andrew Jones <drjones@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 25 July 2018 at 13:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> To prevent spending a disproportionate amount of time on inventing
> ways to parameterize these 'models', which includes interfaces not
> only between UEFI and QEMU but also between ARM-TF and QEMU (and
> potentially between UEFI and ARM-TF as well), could we please consider
> fixed configurations for the non-discoverable bits?

Yes, I had assumed that would be the way this would work. After
all for the hardware setup we're trying to be a "best practices/
reference" demonstration for, the firmware would consider all
the non-discoverable hardware to be basically fixed, right?

(Maybe we could have some sort of "board revision" register so the
firmware could figure out if it was looking at the equivalent
of board rev A/B/C and whether some of the fixed devices exist,
but I think we should only do that if it's the kind of thing
that we're expecting/recommending real h/w manufacturers do.)

thanks
-- PMM
