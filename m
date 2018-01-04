Received: from eggs.gnu.org ([2001:4830:134:3::10]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX9Nq-0000f8-Mt
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX9NZ-0003wn-J2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:32:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:62961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX9NZ-0003ux-6j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:32:33 -0500
References: <mailman.16196.1515084191.27993.qemu-devel@nongnu.org>
	<AE31CFE4-27FD-40F8-81E3-0D7A8A9DE36E@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bee022ee-30de-586a-d892-68291159de77@vivier.eu>
Date: Thu, 4 Jan 2018 18:32:30 +0100
MIME-Version: 1.0
In-Reply-To: <AE31CFE4-27FD-40F8-81E3-0D7A8A9DE36E@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/17] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

Le 04/01/2018 à 18:09, Programmingkid a écrit :
> What operating systems boot with this patch set? Does any version of the Mac OS run in this 68k emulator? 
> 

For the moment you can't boot anything more than the coldfire linux
kernel with the semi-hosting patch.

The remaining patches I have in my git branch allows to boot a debian
etch-m68k with GNOME or a the latest debian unstable (without GNOME)

git clone -b q800-dev https://github.com/vivier/qemu-m68k.git

I'm working on booting MacOS...

I think we should also be able to boot NeXTSTEP , but the work of Bryce
Lanham (GSoC 2011) must be rebased on my branch and cleaned up.

Thanks,
Laurent
