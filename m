Received: from eggs.gnu.org ([209.51.188.92]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLCj-0006YK-37
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCLCh-0006BL-E4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCLCf-00064s-FD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:32:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7142763wre.7
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:32:05 -0700 (PDT)
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-2-philmd@redhat.com>
	<ef95f30c-38e0-d7bd-533f-d8b9831bc62a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26ccb60f-d80e-e309-7b53-718076678c78@redhat.com>
Date: Fri, 5 Apr 2019 11:32:02 +0200
MIME-Version: 1.0
In-Reply-To: <ef95f30c-38e0-d7bd-533f-d8b9831bc62a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/4] hw/isa/superio: Rename a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/5/19 6:14 AM, Thomas Huth wrote:
> On 05/04/2019 00.12, Philippe Mathieu-Daudé wrote:
>> This patch is purely cosmetic. No functional change.
>> This will ease the next patch where we re-indent an if() statement.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/isa/isa-superio.c | 69 ++++++++++++++++++++++----------------------
>>  1 file changed, 34 insertions(+), 35 deletions(-)
>>
>> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
>> index d54463bf035..c6845eaf578 100644
>> --- a/hw/isa/isa-superio.c
>> +++ b/hw/isa/isa-superio.c
>> @@ -22,8 +22,8 @@
>>  
>>  static void isa_superio_realize(DeviceState *dev, Error **errp)
>>  {
>> -    ISASuperIODevice *sio = ISA_SUPERIO(dev);
>> -    ISASuperIOClass *k = ISA_SUPERIO_GET_CLASS(sio);
>> +    ISASuperIODevice *s = ISA_SUPERIO(dev);
>> +    ISASuperIOClass *k = ISA_SUPERIO_GET_CLASS(s);
> 
> Sorry, but I have to say that I normally really don't like single-letter
> variable names. They are much harder to search for, and way less
> self-describing.

Me too ;) But sometimes I find the 80 chars/line limit generate
indentation harder to review. But here I have no excuse :)

> If you get problems with the line length in a later patch, what about
> refactoring the related code into a separate function? So that you'd
> only have something like this in the realize function:
> 
>     for (i = 0, j = 0; i < bus_count; i++, j += MAX_IDE_DEVS) {
>         if (!k->ide.is_enabled || k->ide.is_enabled(s, j)) {
>             isa_superio_init_ide(...);
>         }
>     }

Yes, fair enough. Note you used the shortened variables in your example! :P

Regards,

Phil.
