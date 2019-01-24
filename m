Received: from eggs.gnu.org ([209.51.188.92]:32789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfLk-0002b7-Kg
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfLj-0002Tb-P0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:47:20 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmfLj-0002RE-Hc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:47:19 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so5286703otl.0
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:47:19 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR01MB439558A3AEFF795A7072DB078E9A0@DM6PR01MB4395.prod.exchangelabs.com>
In-Reply-To: <DM6PR01MB439558A3AEFF795A7072DB078E9A0@DM6PR01MB4395.prod.exchangelabs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 13:47:06 +0000
Message-ID: <CAFEAcA95FQN2spkjnKstfjfrf61bh7FKdVpxeet6uJ1jMcMTKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unknown keycodes `(unnamed)',
 please report to qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Burgess, Alison E" <alison.burgess@wsu.edu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, 24 Jan 2019 at 13:30, Burgess, Alison E <alison.burgess@wsu.edu> wr=
ote:
> I am running Ubuntu 18.04 and I am sending this email because when I try =
to run these series of commands in an executable file in
>
>
> arm-none-eabi-as -mcpu=3Darm926ej-s -g ts.s -o ts.o
> arm-none-eabi-gcc -c -mcpu=3Darm926ej-s -g t.c -o t.o
> arm-none-eabi-ld -T t.ld ts.o t.o -o t.elf
> arm-none-eabi-objcopy -O binary t.elf t.bin
> arm-none-eabi-readelf -a t.elf
>
> rm *.o *.elf
>
> echo ready to go?
> read dummy
>
> qemu-system-arm -M realview-pbx-a9 -m 128M -kernel t.bin \
> -serial mon:stdio -serial /dev/pts/0 -serial /dev/pts/0 -serial /dev/pts/=
0
>
> (where the number in /dev/pts/# is the number I get when I run ps in the =
terminal)
>
> The qemu terminal appears, but once I press 'Enter' again so that my code=
 runs, I am faced with the unknown keycodes `(unnamed)', please report to q=
emu-devel@nongnu.org error message. After a couple of hours searching onlin=
e I have not been able to find a solution and I have download and reinstall=
ed qemu a couple of times.

Hi; this warning message (a) can usually be ignored and (b) doesn't
exist any more in new versions of QEMU. The chances are very high
that your problem is not related to the warning message. You might
also try using the latest version of QEMU (3.1).

Those -serial options look very weird. My guess is your problem
is either in those, or your guest binary simply is crashing
without sending anything to the terminal. Is the guest binary
known to work (eg on real hardware)?

thanks
-- PMM
