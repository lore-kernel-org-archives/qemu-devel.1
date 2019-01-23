Received: from eggs.gnu.org ([209.51.188.92]:51553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gmJvF-000607-EA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gmJvB-0006jM-Ku
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:54:31 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:23637 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gmJv7-0006Tn-9V
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:54:25 -0500
References: <20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
From: Brad Smith <brad@comstyle.com>
Message-ID: <ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
Date: Wed, 23 Jan 2019 09:54:13 -0500
MIME-Version: 1.0
In-Reply-To: <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 1/23/2019 8:59 AM, Gerd Hoffmann wrote:

>    Hi,
>
>>> What is the native sound interface for openbsd btw?  oss doesn't
>>> compile (missing sys/soundcard.h header).
>> OpenBSD uses sndio, a similar audio daemon to pulseaudio and it's
>> enforced for all [well integrated] audio applications.
> Hmm.  Yet another audio daemon.  /me wonders why people keep reinventing
> the wheel.

The wheel wouldn't be reinvented if there were viable options. There 
were none.

>> SDL is an optional intermediate layer kept for practical/compatibility
>> purposes, but all software shall use sndio natively.
> Is pulseaudio supported?  The package is at least in the package
> collection.  If so, then we can choose between pulse and sdl as middle
> man, due to the lack of a sndio backend.  Which of the two should be
> preferred?

Very much SDL. PulseAudio is avoided like the plague.
