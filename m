Received: from eggs.gnu.org ([2001:4830:134:3::10]:37880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3h0A-0006pJ-3a
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3h09-0001wo-F9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:54:54 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3h09-0001wJ-9J
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:54:53 -0400
Received: by mail-oi0-x244.google.com with SMTP id c3-v6so18966944oib.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 04:54:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6431180d-fcaa-6a9c-de22-5ded33433be8@amsat.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<20180319161556.16446-2-peter.maydell@linaro.org>
	<6431180d-fcaa-6a9c-de22-5ded33433be8@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 12:54:32 +0100
Message-ID: <CAFEAcA9sAsrcw-AwZU3QW5BQJfi2td3pi8zOS2iVK09D9qAH2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] hw/sd/bcm2835_sdhost: Add
 tracepoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Pekka Enberg <penberg@iki.fi>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 4 April 2018 at 12:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> On 03/19/2018 01:15 PM, Peter Maydell wrote:
>> Add some tracepoints to the bcm2835_sdhost driver, to assist
>> debugging.

>> +# hw/sd/bcm2835_sdhost.c
>> +bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "off=
set 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>> +bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "of=
fset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>
> Can you use the more explicit "size_t" and "%zu" please?

The argument to the read/write functions which we're tracing
here isn't a size_t, though (and since it's only ever 1/2/4/8
it makes sense that it isn't a size_t). What would be the
point in casting it to an size_t here?

A quick grep through hw/*/trace-events suggests we don't
use size_t for tracing of mmio read/write functions
in other devices.

thanks
-- PMM
