Received: from eggs.gnu.org ([209.51.188.92]:57555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNBv-0003M1-Fz
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmNBu-0003ix-QO
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:23:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmNBu-0003hT-KM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 13:23:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so514255wmd.1
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 10:23:57 -0800 (PST)
References: <20190122162924.26491-1-stefanha@redhat.com>
	<a60dbcd8-df39-ebe9-a86b-92bc468b8ec2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <081eec1f-47d7-3fe0-0951-171383589e2f@redhat.com>
Date: Wed, 23 Jan 2019 19:23:54 +0100
MIME-Version: 1.0
In-Reply-To: <a60dbcd8-df39-ebe9-a86b-92bc468b8ec2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, jusual@mail.ru, contrib@steffen-goertz.de, joel@jms.id.au

On 1/23/19 7:19 AM, Thomas Huth wrote:
> On 2019-01-22 17:29, Stefan Hajnoczi wrote:
>> New source files were added without corresponding ./MAINTAINERS file
>> entries.  Let's get things up to date.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> This also includes the I2C/TWI stub which Peter has merged into his
>> target-arm.next tree but isn't in qemu.git/master yet.
>> ---
>>  MAINTAINERS | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index af339b86db..e3cb67e81d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -833,7 +833,19 @@ L: qemu-arm@nongnu.org
>>  S: Maintained
>>  F: hw/arm/nrf51_soc.c
>>  F: hw/arm/microbit.c
>> +F: hw/char/nrf51_uart.c
>> +F: hw/gpio/nrf51_gpio.c
>> +F: hw/i2c/microbit_i2c.c
>> +F: hw/misc/nrf51_rng.c
>> +F: hw/timer/nrf51_timer.c
>>  F: include/hw/arm/nrf51_soc.h
>> +F: include/hw/arm/nrf51.h
>> +F: include/hw/char/nrf51_uart.h
>> +F: include/hw/gpio/nrf51_gpio.h
>> +F: include/hw/i2c/microbit_i2c.h
>> +F: include/hw/misc/nrf51_rng.h
>> +F: include/hw/timer/nrf51_timer.h
>> +F: tests/microbit-test.c
> 
> Looks like using wildcards would be easier here:
> 
> F: hw/*/nrf51*.c
> F: hw/*/microbit*.c
> F: include/hw/*/nrf51*.h

Agreed :)

> ...
> 
> ?
> 
> Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
