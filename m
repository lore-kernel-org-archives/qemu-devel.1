Received: from eggs.gnu.org ([2001:4830:134:3::10]:34453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRKD-0007f5-7c
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRK9-0007y5-9c
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:09 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRK9-0007xx-4T
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:05 -0400
Received: by mail-qk0-x244.google.com with SMTP id l65so734272qkc.3
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:24:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
	<CAJ+F1C+sdOFyNT9-HMEkaSTbt4diPEA-m=+Do2x7GObyyxb7fQ@mail.gmail.com>
	<6847dc61-6097-33b4-b3af-5b8da52442d1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aba01f86-e031-407f-fddd-48fe387a7f3d@amsat.org>
Date: Thu, 31 Aug 2017 12:24:01 -0300
MIME-Version: 1.0
In-Reply-To: <6847dc61-6097-33b4-b3af-5b8da52442d1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 08/31/2017 06:43 AM, Thomas Huth wrote:
> On 31.08.2017 11:36, Marc-André Lureau wrote:
>> Hi
>>
>> On Thu, Aug 31, 2017 at 7:20 AM Thomas Huth <thuth@redhat.com
>> <mailto:thuth@redhat.com>> wrote:
>>
>>      On 31.08.2017 05:53, Philippe Mathieu-Daudé wrote:
>>      > Suggested-by: Peter Maydell <peter.maydell@linaro.org
>>      <mailto:peter.maydell@linaro.org>>
>>      > Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>>      <mailto:f4bug@amsat.org>>
>>      > ---
>>      >  include/hw/char/serial.h |  1 +
>>      >  hw/char/serial.c         | 13 +++++++++++++
>>      >  2 files changed, 14 insertions(+)
>>      >
>>      > diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
>>      > index c4daf11a14..96bccb39e1 100644
>>      > --- a/include/hw/char/serial.h
>>      > +++ b/include/hw/char/serial.h
>>      > @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion
>>      *address_space,
>>      >                              hwaddr base, int it_shift,
>>      >                              qemu_irq irq, int baudbase,
>>      >                              Chardev *chr, enum device_endian end);
>>      > +Chardev *serial_chr_nonnull(Chardev *chr);
>>
>>      Why do you need the prototype? Please make the function static if
>>      possible (otherwise please add some rationale in the patch description).
>>
>> It's being used from other units in following patches
> 
> Ah, well, right. I was only on CC: in the first two patches, so I missed
> the other ones at the first glance. So never mind my comment, the
> prototype is fine here.

Is it better/easier to use the same list for the cover and all the patches?
I try to shorten the it to help overloaded reviewer to focus on the 
patches I think they can help. But this case show it's not that useful.
