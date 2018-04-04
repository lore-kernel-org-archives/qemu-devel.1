Received: from eggs.gnu.org ([2001:4830:134:3::10]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3iiB-0000lP-BP
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3iiA-00053Z-II
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:44:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<20180319161556.16446-2-peter.maydell@linaro.org>
	<6431180d-fcaa-6a9c-de22-5ded33433be8@amsat.org>
	<CAFEAcA9sAsrcw-AwZU3QW5BQJfi2td3pi8zOS2iVK09D9qAH2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <388842e2-fe60-d034-0c43-3a967aa02688@amsat.org>
Date: Wed, 4 Apr 2018 10:44:15 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9sAsrcw-AwZU3QW5BQJfi2td3pi8zOS2iVK09D9qAH2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 1/2]
 hw/sd/bcm2835_sdhost: Add tracepoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Pekka Enberg <penberg@iki.fi>

On 04/04/2018 08:54 AM, Peter Maydell wrote:
> On 4 April 2018 at 12:42, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Peter,
>>
>> On 03/19/2018 01:15 PM, Peter Maydell wrote:
>>> Add some tracepoints to the bcm2835_sdhost driver, to assist
>>> debugging.
> 
>>> +# hw/sd/bcm2835_sdhost.c
>>> +bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>>> +bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>>
>> Can you use the more explicit "size_t" and "%zu" please?
> 
> The argument to the read/write functions which we're tracing
> here isn't a size_t, though (and since it's only ever 1/2/4/8
> it makes sense that it isn't a size_t). What would be the
> point in casting it to an size_t here?>
> A quick grep through hw/*/trace-events suggests we don't
> use size_t for tracing of mmio read/write functions
> in other devices.

Oh... I find using 'unsigned' confusing, but that's fine this way.

Regards,

Phil.
