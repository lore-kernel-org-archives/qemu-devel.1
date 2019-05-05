Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJ9c-0003co-4c
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJ9b-0007BL-AI
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNJ9b-0007Ah-5o
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:34:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id v17so1299696otp.13
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
	<CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
	<97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
	<CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
In-Reply-To: <CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 May 2019 16:34:03 +0100
Message-ID: <CAFEAcA_0NpQRJnMx-1vUCD_=e1GsfTBhO3z1rrz99CY+GNmGhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sat, 4 May 2019 at 06:26, Alistair Francis <alistair23@gmail.com> wrote:
> Ah, it seems like -device loader doesn't work, it looks like not
> setting the thumb register causes this core dump:
>
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> R00=20000000 R01=00000574 R02=200015d0 R03=200015d0
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=0800cba4

Is the ELF file incorrectly setting the entry point address to not
be a Thumb one (ie low bit set), or is the loader device not honouring
that? (I thought that we'd fixed the latter of those recently...)

thanks
-- PMM
