Received: from eggs.gnu.org ([2001:4830:134:3::10]:55745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtjRO-0005gA-2e
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtjRN-00069H-3M
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:57:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-3-git-send-email-sundeep.lkml@gmail.com>
	<a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
Message-ID: <3618281c-b4f9-3a1a-8b6f-f87dfeb54e45@amsat.org>
Date: Sun, 17 Sep 2017 20:57:23 -0300
MIME-Version: 1.0
In-Reply-To: <a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alistair23@gmail.com, crosthwaite.peter@gmail.com

Hi Sundeep,

On 09/14/2017 01:36 AM, Philippe Mathieu-Daudé wrote:
> On 09/07/2017 04:24 PM, Subbaraya Sundeep wrote:
[...]
>> +static inline int msf2_divbits(uint32_t div)
> 
> Please directly use ctz32() instead of msf2_divbits()

It seems you missed this review comment in your v9.

> 
>> +{
>> +    int ret = 0;
>> +
>> +    switch (div) {
>> +    case 1:
>> +        ret = 0;
>> +        break;
>> +    case 2:
>> +        ret = 1;
>> +        break;
>> +    case 4:
>> +        ret = 2;
>> +        break;
>> +    case 8:
>> +        ret = 4;
>> +        break;
>> +    case 16:
>> +        ret = 5;
>> +        break;
>> +    case 32:
>> +        ret = 6;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
