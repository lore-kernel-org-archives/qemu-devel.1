Received: from eggs.gnu.org ([2001:4830:134:3::10]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg87t-0006rW-1u
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg87o-0000O7-6Z
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:13 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dg87o-0000Nx-1O
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:29:08 -0400
Received: by mail-qt0-x234.google.com with SMTP id s6so19360150qtc.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 04:29:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e23401d-0c39-feb1-13e8-0f3b4cc3b960@amsat.org>
Date: Fri, 11 Aug 2017 08:29:04 -0300
MIME-Version: 1.0
In-Reply-To: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, Peter Maydell <peter.maydell@linaro.org>, crosthwaite.peter@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Frederic,

I'm slowly working on Hercules MCU peripherals and use a R4F core.

> It seems that when I try to load a big endian image on a
> Cortex-R5 it gets confused:
>   * the instructions are fine it executes some code.

So far no problem here

>   * GDB address / insns are wrong endianness.

Maybe I didn't hit this problem since I use the same setup than with 
openocd/real cpu with the following .gdbinit:

     set architecture armv5te
     set arm fpu vfp
     set endian big
     set remote hardware-breakpoint-limit 6
     set breakpoint auto-hw on
     set displaced-stepping on

>   * in monitor x command is good endianness.
>   * the data order seems to be wrong endianness:
>     Here is my Hello World: lleHlroW

Indeed I hit a similar problem and found that 
memory::access_with_adjusted_size() has some issues, I could never 
finish the unit-tests but this is the first entry on my 2.11 TODO.

I'll send as RFC.

Regards,

Phil.
