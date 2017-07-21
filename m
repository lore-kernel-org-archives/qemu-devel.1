Received: from eggs.gnu.org ([2001:4830:134:3::10]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYYAh-0000ln-Rp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYYAd-0005mS-T5
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dYYAd-0005ku-FX
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:40:43 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500533554.6553.1.camel@redhat.com>
	<3e0f92ea-58ce-abfb-1aed-4d56c1fa68b2@redhat.com>
	<1500631461.12926.5.camel@redhat.com>
	<eeba9fcf-4b52-2c24-af03-d88333cd2dc6@redhat.com>
	<1500640952.12926.9.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b1a62908-c925-3dde-583b-71e3967539a6@redhat.com>
Date: Fri, 21 Jul 2017 16:40:34 +0300
MIME-Version: 1.0
In-Reply-To: <1500640952.12926.9.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>

On 21/07/2017 15:42, Gerd Hoffmann wrote:
> On Fri, 2017-07-21 at 15:15 +0300, Marcel Apfelbaum wrote:
>> On 21/07/2017 13:04, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>>> What about window sizes?  IIRC there was a plan to provide
>>>>> allocation
>>>>> hints for them too ...
>>>>
>>>> Yes, is in my TODO list, however not as part of Aleksandr's
>>>> series
>>>> which aims to provide PCIe-PCI bridge hotplug support.
>>>
>>> I'd prefer to have a single vendor capability for all resource
>>> allocation hints provided by qemu.
>>>
>>
>> [Adding Laszlo]
>>
>>
>> Sure, the capability looking something like:
>>
>>      [flags: reserve-buses|reserve-IO|reserve-MEM|...]
>>      [extra-buses][IO-size][MEM-size]
>>
>>      if reserve-buses -> use 'extra-buses' value and so on
> 
> Do we need the flags?  We can use "value == 0 -> no hint for you".

Maybe we don't want to allocate IO at all,
So value 0 would say do not allocate.

But we can disable IO by other means.

> Also what about prefetchable vs. non-prefetchable memory?  I guess we
> want a size hint for both memory windows?


Good point, thanks!
Marcel

> 
> cheers,
>    Gerd
> 
