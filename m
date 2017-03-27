Received: from eggs.gnu.org ([2001:4830:134:3::10]:39061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csb76-0005u2-94
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csb71-000627-CI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:19:40 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:55136
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1csb71-00061s-5C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:19:35 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
	<d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
	<9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <25632d57-622c-e0b0-029a-28fdca0a427f@weilnetz.de>
Date: Mon, 27 Mar 2017 22:19:31 +0200
MIME-Version: 1.0
In-Reply-To: <9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

Am 27.03.2017 um 07:48 schrieb Mark Cave-Ayland:
> Right, I see cygwin has a much newer version of glib available which
> explains how the builds are produced.
>
> What was the exact issue with global symbols which prevents the
> pre-built Win64 binaries from glib > 2.22 being used? Or is that
> information now obsolete?

I remember a problem caused by a change in Mingw gcc name mangling,
maybe that's what you a referring to. That does not apply to the
libraries distributed with Cygwin.

There is a new problem with cross compiling on Cygwin caused by latest
changes in configure. I have just sent a patch to fix that regression.

Stefan
