Received: from eggs.gnu.org ([2001:4830:134:3::10]:39046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miqlas@gmail.com>) id 1emOXh-0006gJ-Q5
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miqlas@gmail.com>) id 1emOXc-0004C6-Tn
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:46:01 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <miqlas@gmail.com>) id 1emOXc-0004Bn-Mg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:45:56 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so2641435wmd.5
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:45:56 -0800 (PST)
References: <20180215173539.11033-1-f4bug@amsat.org>
	<20180215182153.3696ad5f@sf>
	<5247e0c1-a5f4-d918-50fd-ec13e06fd26f@amsat.org>
From: miqlas <miqlas@gmail.com>
Message-ID: <bef39271-e825-fefa-c882-041cad991074@gmail.com>
Date: Thu, 15 Feb 2018 19:45:53 +0100
MIME-Version: 1.0
In-Reply-To: <5247e0c1-a5f4-d918-50fd-ec13e06fd26f@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC PATCH] capstone: fix building using system
 package
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sergei Trofimovich <slyfox@gentoo.org>
Cc: Thomas Huth <thuth@redhat.com>, Mike Frysinger <vapier@gentoo.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi,

afaik (but not tested) pkgconfig --cflags reports /includes on linux, 
and it does the same on Haiku too.
I'm not against to change our capstone recipe, but please, if you can 
check it on Linux and report it back, as i don't want to break other 
software.
Thanks for the nice talk, guys!

--miqlas


2018-02-15 19:39 keltezéssel, Philippe Mathieu-Daudé írta:
> Hi Sergei,
>
> On 02/15/2018 03:21 PM, Sergei Trofimovich wrote:
>> On Thu, 15 Feb 2018 14:35:39 -0300
>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>>>   #else
>>> +#include <capstone/capstone.h>
>> I think it's incorrect. 'pkg-config' already reports 'capstone/' path:
>>      $ pkg-config --cflags capstone
>>      -I/usr/include/capstone
> Glad to hear feedback from a Gentoo developer!
>
> Ok so the problem Haiku only, which we don't support anymore.
>
>>      $ ls /usr/include/capstone/capstone.h
>>      /usr/include/capstone/capstone.h
>>
>> Thus I would guess
>>      #include <capstone.h>
>> is still correct for system include path as well (contradicts the example).
> My guess is the example is probabilisticly safer for people compiling
> without using 'pkg-config'.
>
>> qemu just needs to use 'pkg-config' to discover the include path and
>> libs. Maybe new capstone release has different pkgconfig setup?
> I think it is safer to drop this patch.
>
> Thanks for your review!
>
> Phil.
