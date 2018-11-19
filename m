Received: from eggs.gnu.org ([2001:4830:134:3::10]:55955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1gOZKO-0007Zf-8x
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 21:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1gOZKL-0001Xd-3P
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 21:30:20 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1gOZKK-0001XP-Tg
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 21:30:17 -0500
Received: by mail-io1-xd41.google.com with SMTP id g8so4407674iop.10
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 18:30:16 -0800 (PST)
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
	<5c41b46c-70e3-33a0-76cf-ba2fd8155d33@ilande.co.uk>
	<393eca98-a092-80aa-2016-f14cd2e02d45@vivier.eu>
	<3b1f8942-d8c7-04db-45bc-a7c30de9d769@ilande.co.uk>
	<ad444bbf-0606-2b80-7f7d-389a6df29cfe@vivier.eu>
	<49e0547c-0112-c610-6755-5d6a82b1e105@posteo.de>
	<7787c5d5-598a-65e2-7d40-d580551704ca@vivier.eu>
From: Rob Landley <rob@landley.net>
Message-ID: <ab6b11b1-4a34-2243-cb73-253de281f785@landley.net>
Date: Sun, 18 Nov 2018 20:30:14 -0600
MIME-Version: 1.0
In-Reply-To: <7787c5d5-598a-65e2-7d40-d580551704ca@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/11] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <th.huth@posteo.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, hpoussin@reactos.org, aurelien@aurel32.net

On 11/2/18 6:25 AM, Laurent Vivier wrote:
>> If that does not work, I'm also fine if we simply deprecate the simcalls
>> (if possible).
> 
> I have a patch to deprecate the interface. I will send it once the
> release will be done.

Did I ever point out that I got m68k running under your q800 emulation in my
https://github.com/landley/mkroot project?

Now that m68k is in musl-libc, you can build
https://github.com/richfelker/musl-cross-make or grab a prebuilt binary a
toolchain from http://b.zv.io/mcm/bin/m68k-linux-musl-cross.tar.gz and then:

  CROSS_COMPILE=/path/to/m68k-linux-musl-cross/bin/m68k-linux-musl- \
    ./mkroot.sh kernel

And then:

  cd output/m68k
  ./qemu-m68k.sh -hda log.txt

The -hda is just so you have a hard drive image you can play with. Cat /dev/?da
should show you the log.txt contents. The network interface works too, although
I haven't got wget in toybox yet but:

  echo GET / | netcat landley.net /

Works. :)

When does this go upstream?

P.S. to build a current kernel:

  cd download
  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
  cd ..

And then mkroot.sh again. I tested with 4.20-rc1 and m68k worked fine.

> Thanks,
> Laurent

Rob
