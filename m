Received: from eggs.gnu.org ([2001:4830:134:3::10]:34991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYAnE-0000Sv-NQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYAnA-0000N4-0R
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:47:32 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYAn9-0000MH-Qp
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:47:27 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so993704pfm.10
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:47:27 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-36-f4bug@amsat.org>
	<3c5eef2f-115c-9c6d-2dba-0407fcebcdc4@linaro.org>
	<45330ee3-4dcf-3c9c-6781-2db11ff4e8c5@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c487ad94-5a1c-64da-5e26-61202e0e6d69@linaro.org>
Date: Wed, 27 Jun 2018 06:47:23 -0700
MIME-Version: 1.0
In-Reply-To: <45330ee3-4dcf-3c9c-6781-2db11ff4e8c5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 35/46] hw/usb: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 06:03 AM, Philippe Mathieu-Daudé wrote:
> On 06/27/2018 04:04 AM, Richard Henderson wrote:
>> On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
>>> -#define VSCARD_IN_SIZE 65536
>>> +#define VSCARD_IN_SIZE      (64 * KiB)
>>>  
>>>  /* maximum size of ATR - from 7816-3 */
>>>  #define MAX_ATR_SIZE        40
>>> @@ -276,7 +277,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
>>>  
>>>      if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
>>>          error_report(
>>> -            "no room for data: pos %d +  size %d > %d. dropping connection.",
>>> +            "no room for data: pos %u +  size %d > %ld. dropping connection.",
>>>              card->vscard_in_pos, size, VSCARD_IN_SIZE);
>>
>> Did you test this with i686 host?  %ld doesn't look right.
> 
> Yes...
> 
> $ uname -m
> x86_64
> $ make hw/usb/ccid-card-passthru.o
>   CC      hw/usb/ccid-card-passthru.o
> $

Ah, no, I mean 32-bit i686, not x86_64.


r~
