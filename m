Received: from eggs.gnu.org ([2001:4830:134:3::10]:57391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWM8l-0005WW-K3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWM8k-0007gi-Hs
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:30:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180606144706.29732-1-f4bug@amsat.org>
	<1160f838-5625-b9bf-6c34-3071ed185074@redhat.com>
	<0c5018d5-7e87-bba1-7522-c8020277bde0@amsat.org>
Message-ID: <c7077a71-6f01-b3f2-cc0b-4d845b967ef3@amsat.org>
Date: Fri, 22 Jun 2018 10:30:03 -0300
MIME-Version: 1.0
In-Reply-To: <0c5018d5-7e87-bba1-7522-c8020277bde0@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Adopt the Gumstix
 computers-on-module machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi Peter,

On 06/06/2018 12:02 PM, Philippe Mathieu-Daudé wrote:
> On 06/06/2018 11:53 AM, Thomas Huth wrote:
>> On 06.06.2018 16:47, Philippe Mathieu-Daudé wrote:
>>> These COMs are hard to find, and the companie dropped the support
> 
> "company" :/
> 
>>> few years ago.
>>>
>>> Per the "Gumstix Product Changes, Known Issues, and EOL" pdf:
>>>
>>> - Phasing out: PXA270-based Verdex product line
>>>   September 2012
>>>
>>> - Phasing out: PXA255-based Basix & Connex
>>>   September 2009
>>>
>>> However there are still booting SD card image availables, very
>>> convenient to stress test the QEMU SD card implementation.
>>> Therefore I volunteer to keep an eye on this file, while it
>>> is useful for testing.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  MAINTAINERS | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 41cd3736a9..1825deb762 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -491,9 +491,10 @@ F: include/hw/arm/digic.h
>>>  F: hw/*/digic*
>>>  
>>>  Gumstix
>>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>  L: qemu-devel@nongnu.org
>>>  L: qemu-arm@nongnu.org
>>> -S: Orphan
>>> +S: Odd Fixes
>>>  F: hw/arm/gumstix.c
>>
>> Great! So we can also remove the Gumstix entries from
>> https://wiki.qemu.org/Features/LegacyRemoval ?
> 
> I'll remove these now, eventually adding a new Gumstix COMs
> wiki entry when Avocados tests are merged, although reading
> the tests should be enough.

Do you agree with this patch? This is mostly to avoid removing these 2
boards in 2 releases from now. The datasheets are public so I can keep
an eye on them.
I already removed them from the "Future deprecated candidates" entry in
the Wiki.

Regards,

Phil.
