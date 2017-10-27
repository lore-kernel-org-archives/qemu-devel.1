Received: from eggs.gnu.org ([2001:4830:134:3::10]:47653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87Rc-0004ws-03
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87RY-0000z6-Hf
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:25:15 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:52074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87RY-0000yj-DA
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:25:12 -0400
Received: by mail-qk0-x22f.google.com with SMTP id 17so8980377qkq.8
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:25:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<318e5572-0ad0-0ae3-f26e-61c6a9c3aa93@amsat.org>
	<0d9cd7df-69b5-0920-263e-c105501d07e4@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ab0b955-079b-288c-bb0e-e99bde95a5a4@amsat.org>
Date: Fri, 27 Oct 2017 13:25:03 -0300
MIME-Version: 1.0
In-Reply-To: <0d9cd7df-69b5-0920-263e-c105501d07e4@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 01/13] sparc32_dma: rename SPARC32_DMA
 type to SPARC32_DMA_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/20/2017 09:39 AM, Mark Cave-Ayland wrote:
>>> Also update the function names to match as appropriate. While we're
>>> here rename the type from sparc32_dma to sparc32-dma in order to
>>> match the current QOM convention.
>>
>> Where can I read on the QOM convention?
> 
> The relevant documentation is in include/qom/object.h on line 937: "In
> general, you should use hyphens '-' instead of underscores '_' when
> naming properties.". Note that while the type name isn't strictly a
> property, I have been asked previously to change type names to use
> hyphens on submitted patches.

OK, thanks.

>>> -#define TYPE_SPARC32_DMA "sparc32_dma"
>>> -#define SPARC32_DMA(obj) OBJECT_CHECK(DMAState, (obj), TYPE_SPARC32_DMA)
>>> +#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
>>> +#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
>>
>> not sure this is an improvement.
> 
> Can you clarify this further? The patchset introduces a common
> SPARC32_DMA_DEVICE superclass which is intended to be the superclass for
> the le/esp devices. Later on in the patchset, the previous SPARC32_DMA
> object becomes a container effectively representing the memory region
> holding the DMA registers for these devices.

Fine :)

> 
>>> +                                             TYPE_SPARC32_DMA_DEVICE)
[...]
>>> -    dev = qdev_create(NULL, "sparc32_dma");
>>> +    dev = qdev_create(NULL, "sparc32-dma-device");
>>
>> Can you use TYPE_SPARC32_DMA_DEVICE instead here?
> 
> No not at this point (you'll see I change this later in the patchset)
> because the type is still currently defined in sparc32_dma.c and hasn't
> (yet) been moved to sparc32_dma.h.

OK!
