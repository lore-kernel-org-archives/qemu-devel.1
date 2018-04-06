Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f4S8K-0004dJ-3Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1f4S8G-0001FF-WE
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:14:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45508
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1f4S8G-0001F6-Nh
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:14:24 -0400
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
	<CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
	<OFDC2B6138.CF2B5F15-ON88258266.00751F63-86258266.0075810C@ddci.com>
	<CAFEAcA_KDJ05q+Lnf3nk+TmvAYPp3R6d9svf7JdvKZ6DiHMmHA@mail.gmail.com>
	<OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cd9353a7-44bc-c43a-65ec-770c9afb61d4@ilande.co.uk>
Date: Fri, 6 Apr 2018 15:14:14 +0100
MIME-Version: 1.0
In-Reply-To: <OF82B90B05.E59E0B03-ON88258267.0044BF04-86258267.004A0756@ddci.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On 06/04/18 14:28, alarson@ddci.com wrote:

> I was not successful with the wiki instructions for "Native builds
> with MSYS2":
> 
>    ./qemu-2.12.0-rc2/configure --python=/usr/bin/python2 \
>        '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>        --prefix=/usr/local/qemu \
>        '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu'
>    make
>    ...
>    C:\msys2-x86_64_20161025\msys64\mingw64\bin\ar.exe: creating
> libfdt/libfdt.a
>    make[1]: *** No rule to make target ...build/capstone/capstone.lib'.
> Stop.
>    make: *** [Makefile:503: subdir-capstone] Error 2

Ah I believe those instructions were mine from when I had temporary 
access to a Windows VM for testing last year.

Since the instructions pre-dated the inclusion of capstone as a 
dependency, is it as simple as adding:

git submodule update --init capstone

before running configure and make?


ATB,

Mark.
