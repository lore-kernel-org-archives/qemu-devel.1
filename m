Received: from eggs.gnu.org ([2001:4830:134:3::10]:49465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7f9Z-0008Ne-RB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7f9W-0008Nz-MY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:12:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59370
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7f9W-0008Nj-G5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:12:42 -0400
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <98d12504-4523-2a5c-aefa-4b01e1c6c7df@ilande.co.uk>
Date: Thu, 26 Oct 2017 11:12:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8DGeoNWxr9Y-vRXmtR5=7+EMQqfpt5cs7x2qTcfRZR4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Jason Wang <jasowang@redhat.com>

On 25/10/17 18:47, Peter Maydell wrote:

> On 25 October 2017 at 16:59, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> This enables them to be used outside of lance.c.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> CC: Jason Wang <jasowang@redhat.com>
> 
> 
>> diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
>> new file mode 100644
>> index 0000000..c112fbc
>> --- /dev/null
>> +++ b/include/hw/net/lance.h
>> @@ -0,0 +1,41 @@
>> +/*
>> + * QEMU AMD PC-Net II (Am79C970A) emulation
> 
> Filename says this is Lance ethernet, but the comment says it's PC-Net ?

According to the datasheet for Am79C970A, the original Lance is an
Am7990 device and the Am79C970A aka PCNet-PCI II as emulated by QEMU is
register-compatible with it.

I guess the comment above is more technically correct, but I'm happy to
adjust it in my local tree if you still feel it needs to change?

>> +#define TYPE_LANCE "lance"
>> +#define SYSBUS_PCNET(obj) \
>> +    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
> 
> It's a bit weird that the OBJECT_CHECK macro name
> and the state structure name don't line up with
> the device name, but this is just code motion so
> not a problem.

Yeah, same issue as above... :/

> Other than fixing the comment,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> (In an ideal world pcnet.h would be in include/.)
> 
> thanks
> -- PMM


ATB,

Mark.
