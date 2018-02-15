Received: from eggs.gnu.org ([2001:4830:134:3::10]:37042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emORO-0008Uy-RP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emORJ-0006Lt-UK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:39:30 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emORJ-0006Ll-OJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:39:25 -0500
Received: by mail-qk0-x243.google.com with SMTP id 15so804089qkl.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:39:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215173539.11033-1-f4bug@amsat.org>
	<20180215182153.3696ad5f@sf>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5247e0c1-a5f4-d918-50fd-ec13e06fd26f@amsat.org>
Date: Thu, 15 Feb 2018 15:39:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180215182153.3696ad5f@sf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Thomas Huth <thuth@redhat.com>, Mike Frysinger <vapier@gentoo.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Zolt=c3=a1n_Mizsei?= <miqlas@gmail.com>

Hi Sergei,

On 02/15/2018 03:21 PM, Sergei Trofimovich wrote:
> On Thu, 15 Feb 2018 14:35:39 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>>  #else
>> +#include <capstone/capstone.h>
> 
> I think it's incorrect. 'pkg-config' already reports 'capstone/' path:
>     $ pkg-config --cflags capstone
>     -I/usr/include/capstone

Glad to hear feedback from a Gentoo developer!

Ok so the problem Haiku only, which we don't support anymore.

> 
>     $ ls /usr/include/capstone/capstone.h
>     /usr/include/capstone/capstone.h
> 
> Thus I would guess
>     #include <capstone.h>
> is still correct for system include path as well (contradicts the example).

My guess is the example is probabilisticly safer for people compiling
without using 'pkg-config'.

> qemu just needs to use 'pkg-config' to discover the include path and
> libs. Maybe new capstone release has different pkgconfig setup?

I think it is safer to drop this patch.

Thanks for your review!

Phil.
