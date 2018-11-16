Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNe3P-0007sI-KT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNe3H-00043f-LV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:20:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNe3E-00040w-AI
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:20:49 -0500
Received: by mail-oi1-x242.google.com with SMTP id g188-v6so19592250oif.8
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 05:20:48 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-2-minyard@acm.org>
	<8add8514-f353-b914-78e8-e9f3e9be840d@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <c0c4051d-fe57-7399-9904-65425c6efc26@acm.org>
Date: Fri, 16 Nov 2018 07:20:44 -0600
MIME-Version: 1.0
In-Reply-To: <8add8514-f353-b914-78e8-e9f3e9be840d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 01/12] i2c: Split smbus into parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/15/18 4:22 PM, Philippe Mathieu-Daudé wrote:
> On 15/11/18 20:24, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> smbus.c and smbus.h had device side code, master side code, and
>> smbus.h has some smbus_eeprom.c definitions.  Split them into
>> separate files.
>
> Lovely cleanup!
>
Yes, this really needed to be done.  It took me a while to understand
this code originally because it was all mixed up.

I've fixed the things you pointed out.  One thing, though:


>>
>> diff --git a/include/hw/i2c/smbus_eeprom.h 
>> b/include/hw/i2c/smbus_eeprom.h
>> new file mode 100644
>> index 0000000000..2f56e5dc4e
>> --- /dev/null
>> +++ b/include/hw/i2c/smbus_eeprom.h
>> @@ -0,0 +1,11 @@
>
> You missed the copyright notice here.

Other files don't have copyright notices (i2c.h, for instance), and for
the smbus.[ch] case the copyrights are kind of mixed up, the include
files had the big header with a copyright by one company and the C
file had a different copyright notice by a different company.

Not a huge deal, but I didn't include it in that file because I didn't
think it was necessary.  I'm wondering if it would be best to
establish a style like Linux has, with the // SPDX... thing on the
first line.

Thanks,

-corey
