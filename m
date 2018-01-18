Received: from eggs.gnu.org ([2001:4830:134:3::10]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBWe-00082q-2u
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBWd-0002fm-DD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:50:44 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:41129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecBWd-0002fV-8P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 09:50:43 -0500
Received: by mail-oi0-x22b.google.com with SMTP id n81so15845914oig.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 06:50:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <85686228-03dd-a7fc-1477-f27d09de5007@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
	<20180112125854.18261-11-kraxel@redhat.com>
	<CAFEAcA8UAbOvZuhxwjD2zAA7GBGucD8MAf5E0h05tb3NXKdGqw@mail.gmail.com>
	<20180118133643.GP19695@redhat.com>
	<b56b41f6-f048-00bf-d5fb-a1ed20ddeb09@redhat.com>
	<20180118141256.GS19695@redhat.com>
	<85686228-03dd-a7fc-1477-f27d09de5007@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 14:50:21 +0000
Message-ID: <CAFEAcA9sFenca+n37VOjQ3tUJLV_Vt0A7iwNdj=WbOvrMP6Pbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/14] ui: fix VNC client throttling when
 audio capture is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 January 2018 at 14:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 18/01/2018 15:12, Daniel P. Berrange wrote:
>>> In addition to that, do we support a >= 2 GiB framebuffer at all? (Even
>>> with unsigned ints, Coverity would rightly complain about a truncated
>>> 32-bit multiplication being assigned to a 64-bit value).
>> client_width/client_height are values that are initialized from the
>> graphics card frontend config, and thus limited by amount of video
>> RAM QEMU allows.   bytes_per_pixel is limited to 8/16/32.
>>
>> So I think we're safe from 2GB overflow in any normal case.
>>
>> That said, VGA RAM size is configurable, so I'm curious what would happen
>> if someone configured an insanely large VGA RAM and asked for a big frame
>> buffer in guest.
>>
>> VNC is protocol limited to uint16 for width/height size, and so is X11
>> so I imagine some exploding behavour would follow :-)
>
> Indeed, and even 2^16 x 2^16 * 32bpp is already 34 bits.  So perhaps we
> should limit VNC to 16384 pixels on each axis (maximum frame buffer size
> 1 GiB).

Google says you can already get graphics cards that can do 15360x8640,
which is really quite close to that 16384 limit...

thanks
-- PMM
