Received: from eggs.gnu.org ([209.51.188.92]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghIWJ-0004Sh-TX
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghIWI-0006Yo-1w
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:24:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:33356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ghIWH-0006X7-Ek
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:24:01 -0500
Date: Wed, 9 Jan 2019 19:23:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAJSP0QVOnFchhTyJsVG5E=FrZ7Ti-_ve4t1WxqkFXO=XK-Sh6Q@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1901091919140.41593@zero.eik.bme.hu>
References: <CAJSP0QVOnFchhTyJsVG5E=FrZ7Ti-_ve4t1WxqkFXO=XK-Sh6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Internship idea: I2C passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Jonathan Austin <jonny@microbit.org>

On Wed, 9 Jan 2019, Stefan Hajnoczi wrote:
> Hi folks,
> You may be interested in I2C passthrough support in QEMU.  Paolo and I
> brainstormed the idea and I've written up a rough project summary
> below.  It still needs some work to make this a solid internship
> project idea.
>
> Any thoughts?  Would you like to co-mentor this summer?
>
> === I2C Passthrough ===
>
> '''Summary:''' Implement I2C bus passthrough on Linux hosts so that
> emulated Raspberry Pi or micro:bit boards can talk to real I2C
> devices.

How about implementing USB for raspi boards instead? Or is there a project 
proposal (or even some code somewhere out of tree) for that already? Seems 
more useful to allow having emulated keyboard and mouse to use Raspbian 
for example or pass through USB devices. (I don't know anything about this 
was just reminded to a recent discussion by this message. If it's not 
relevant just disregard my comment and sorry for the noise.)

Regards,
BALATON Zoltan

> QEMU emulates I2C devices in software but currently cannot pass
> through real I2C devices from the host to the guest.  It would be
> useful to access real I2C devices from inside the guest, for example
> for developers writing and testing software under QEMU on their
> computer.
>
> The project consists of the following tasks:
> * Implement -object i2c-bus-passthrough,adapter=N,id=my-i2c-bus
> * Add i2c-bus-passthrough support to at least 1 existing emulated I2C controller
> * Implement micro:bit TWI controller emulation on the nRF51 system-on-chip
>
> This project will allow you to learn about the I2C bus and how to
> write device emulation code in QEMU.  You will enjoy it if you like
> working with physical hardware.
>
> '''Links:'''
> * [https://en.wikipedia.org/wiki/I%C2%B2C I2C wikipedia page]
> * [https://elinux.org/Interfacing_with_I2C_Devices Overview of Linux
> I2C programming interfaces]
> * [https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/i2c/dev-interface
> Linux I2C userspace interface documentation]
>
> '''Details:'''
> * Skill level: intermediate
> * Language: C
> * Mentor: Paolo Bonzini <pbonzini@redhat.com> ("bonzini" on IRC),
> Stefan Hajnoczi <stefanha@redhat.com> ("stefanha" on IRC)
>
>
