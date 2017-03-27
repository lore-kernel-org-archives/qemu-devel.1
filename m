Received: from eggs.gnu.org ([2001:4830:134:3::10]:34081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1csNWm-0004SV-40
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1csNWj-00065D-2N
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:49:16 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42763
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1csNWi-000654-R1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:49:12 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
	<d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
Date: Mon, 27 Mar 2017 06:48:46 +0100
MIME-Version: 1.0
In-Reply-To: <d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 26/03/17 20:54, Stefan Weil wrote:

> Am 26.03.2017 um 14:57 schrieb Peter Maydell:
>> On 26 March 2017 at 11:30, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>> In order to do some testing on a Windows box, I've spent a bit of time
>>> this weekend setting up a mingw-w64 build environment on Windows 10
>>> using http://wiki.qemu-project.org/Hosts/W32 as a guideline.
>>
>> I think most people prefer to use the cross-compile.
>> Stefan might do native compiles.
> 
> All installers on https://qemu.weilnetz.de/ are cross built
> on Debian GNU Linux, but from time to time I also build on
> Windows.
> 
> Setting up a build environment based on Cygwin works pretty
> well because Cygwin includes most needed packages to cross
> compile for Mingw-w64, both for 32 bit (mingw64-i686-*)
> and 64 bit (mingw64-x86_64-*), see
> https://cygwin.com/cgi-bin2/package-grep.cgi?grep=mingw64-&arch=x86_64.
> 
> I also use the Cygwin packages on Debian GNU Linux,
> because Debian includes cross tools (compiler, linker)
> for Mingw-w64, but nearly no libraries.

Right, I see cygwin has a much newer version of glib available which
explains how the builds are produced.

What was the exact issue with global symbols which prevents the
pre-built Win64 binaries from glib > 2.22 being used? Or is that
information now obsolete?


ATB,

Mark.
