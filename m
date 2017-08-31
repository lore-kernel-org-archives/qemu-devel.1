Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRDx-0003rW-EQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRDt-0005eQ-Fz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:17:41 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnRDt-0005d8-B4
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:17:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id g13so722553qta.4
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 08:17:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<CAFEAcA-NbySdJ3Y-_3x4kbLFOzMEkQ3z5PxGF-4iEfrvXsAVGw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63de867f-2cff-10b7-f056-864fd05f1665@amsat.org>
Date: Thu, 31 Aug 2017 12:17:32 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-NbySdJ3Y-_3x4kbLFOzMEkQ3z5PxGF-4iEfrvXsAVGw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/31/2017 07:28 AM, Peter Maydell wrote:
> On 31 August 2017 at 04:53, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/hw/char/serial.h |  1 +
>>   hw/char/serial.c         | 13 +++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
>> index c4daf11a14..96bccb39e1 100644
>> --- a/include/hw/char/serial.h
>> +++ b/include/hw/char/serial.h
>> @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
>>                               hwaddr base, int it_shift,
>>                               qemu_irq irq, int baudbase,
>>                               Chardev *chr, enum device_endian end);
>> +Chardev *serial_chr_nonnull(Chardev *chr);
> 
> For new globally-visible function declarations, can we
> have a doc-comment form comment that documents the
> function, please?

I was afraid someone asked that, but since this file has no other 
comment I tried :p

Good to know for future contributions, someone fluent with English 
should add this to CODING_STYLE.
