Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db4Ff-0007Tm-OJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db4Fe-00049L-Us
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:20:19 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db4Fe-00048Q-NO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:20:18 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m85so116045896wma.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:20:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
	<06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 13:19:57 +0100
Message-ID: <CAFEAcA-oowaaK9Amn2Achj4a7X-HGOYgNF_7M=rmdOzbick3JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 28 July 2017 at 13:08, Eric Blake <eblake@redhat.com> wrote:
> On 07/28/2017 04:04 AM, Peter Maydell wrote:
>> On 28 July 2017 at 09:55, Vladimir Sementsov-Ogievskiy
>> <vsementsov@virtuozzo.com> wrote:
>>> To make logs more readable prefix all hex values with '0x' mark.
>>> This is needed for consistency too, as a lot of hex values are already
>>> prefixed with '0x'. Also, bring all hex outputs to the common form -
>>> use '%#', not '0x%'.
>>>
>>> This patch is done by two commands:
>>> find . -name trace-events | \
>>>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
>
> Why PRIx32 but not PRIX32?

As it happens none of our trace-events files use PRIX...

thanks
-- PMM
