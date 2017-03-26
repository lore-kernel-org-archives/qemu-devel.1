Received: from eggs.gnu.org ([2001:4830:134:3::10]:52658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csEFX-0001Sk-Vr
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 15:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csEFU-00027U-Ta
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 15:54:52 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:41064
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1csEFU-00025Q-Mq
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 15:54:48 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
Date: Sun, 26 Mar 2017 21:54:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

Am 26.03.2017 um 14:57 schrieb Peter Maydell:
> On 26 March 2017 at 11:30, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> In order to do some testing on a Windows box, I've spent a bit of time
>> this weekend setting up a mingw-w64 build environment on Windows 10
>> using http://wiki.qemu-project.org/Hosts/W32 as a guideline.
>
> I think most people prefer to use the cross-compile.
> Stefan might do native compiles.

All installers on https://qemu.weilnetz.de/ are cross built
on Debian GNU Linux, but from time to time I also build on
Windows.

Setting up a build environment based on Cygwin works pretty
well because Cygwin includes most needed packages to cross
compile for Mingw-w64, both for 32 bit (mingw64-i686-*)
and 64 bit (mingw64-x86_64-*), see
https://cygwin.com/cgi-bin2/package-grep.cgi?grep=mingw64-&arch=x86_64.

I also use the Cygwin packages on Debian GNU Linux,
because Debian includes cross tools (compiler, linker)
for Mingw-w64, but nearly no libraries.

Stefan
