Received: from eggs.gnu.org ([209.51.188.92]:38035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLCs-0000Cg-F2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghLCr-0003sD-P4
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghLCr-0003rx-HE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:16:09 -0500
References: <CAJSP0QVOnFchhTyJsVG5E=FrZ7Ti-_ve4t1WxqkFXO=XK-Sh6Q@mail.gmail.com>
	<alpine.BSF.2.21.9999.1901091919140.41593@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f4f974a-2bd9-bf08-eef1-d89d2cf6cfa5@redhat.com>
Date: Wed, 9 Jan 2019 22:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901091919140.41593@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Internship idea: I2C passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Jonathan Austin <jonny@microbit.org>

On 09/01/19 19:23, BALATON Zoltan wrote:
>> '''Summary:''' Implement I2C bus passthrough on Linux hosts so that
>> emulated Raspberry Pi or micro:bit boards can talk to real I2C
>> devices. 
>
> How about implementing USB for raspi boards instead? Or is there a
> project proposal (or even some code somewhere out of tree) for that
> already? Seems more useful to allow having emulated keyboard and mouse
> to use Raspbian for example or pass through USB devices. (I don't know
> anything about this was just reminded to a recent discussion by this
> message. If it's not relevant just disregard my comment and sorry for
> the noise.)

That's also a valid idea.  However, Stefan has misinterpreted the
reference to the raspi that I quickly made on IRC.  The idea of I2C
passthrough is that a single board computer like a Raspberry Pi can be
used to develop application for a microcontroller such as micro:bit,
without having to flash the firmware again and again, etc.

Real I2C devices---for example a GPIO extender, a temperature sensor or
a real-time clock---would be attached to the I2C bus on the single board
computer's GPIO headers, exposed as an I2C device through /dev/i2c, and
then driven by the emulated micro:bit through its own I2C controller (or
bitbanged).

(I've now updated the project idea).

Paolo
