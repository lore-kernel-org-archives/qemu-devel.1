Received: from eggs.gnu.org ([2001:4830:134:3::10]:57850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cslWR-0001dF-GJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cslWM-0004vm-JK
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:26:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45899
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cslWM-0004sz-CA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:26:26 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
	<d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
	<9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
	<25632d57-622c-e0b0-029a-28fdca0a427f@weilnetz.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <360a7047-6190-c006-e155-1166ab14b83a@ilande.co.uk>
Date: Tue, 28 Mar 2017 08:25:51 +0100
MIME-Version: 1.0
In-Reply-To: <25632d57-622c-e0b0-029a-28fdca0a427f@weilnetz.de>
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

On 27/03/17 21:19, Stefan Weil wrote:

> Am 27.03.2017 um 07:48 schrieb Mark Cave-Ayland:
>> Right, I see cygwin has a much newer version of glib available which
>> explains how the builds are produced.
>>
>> What was the exact issue with global symbols which prevents the
>> pre-built Win64 binaries from glib > 2.22 being used? Or is that
>> information now obsolete?
> 
> I remember a problem caused by a change in Mingw gcc name mangling,
> maybe that's what you a referring to. That does not apply to the
> libraries distributed with Cygwin.
> 
> There is a new problem with cross compiling on Cygwin caused by latest
> changes in configure. I have just sent a patch to fix that regression.

I ended up starting again from scratch last night and trying the build
with MSYS2 instead. MSYS2 has really improved since I last looked at it
a couple of years back, and I was able to get a working build
environment all set and working without any issues, i.e. set up the
build environment, run configure, make and make install.

I did make a few notes during installation so if people think it's
useful I can work through them again and come up with something suitable
for the wiki.


ATB,

Mark.
