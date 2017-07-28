Received: from eggs.gnu.org ([2001:4830:134:3::10]:60171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db1QW-0005ey-Tp
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db1QS-0005LI-PK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:20 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16190 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1db1QS-0005KM-DL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:19:16 -0400
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dd2bc6c4-ecb9-26d6-de48-791930a60a66@virtuozzo.com>
Date: Fri, 28 Jul 2017 12:19:13 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

28.07.2017 12:04, Peter Maydell wrote:
> On 28 July 2017 at 09:55, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>> To make logs more readable prefix all hex values with '0x' mark.
>> This is needed for consistency too, as a lot of hex values are already
>> prefixed with '0x'. Also, bring all hex outputs to the common form -
>> use '%#', not '0x%'.
>>
>> This patch is done by two commands:
>> find . -name trace-events | \
>>   xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
>> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
> There seem to be an order of magnitude more trace format strings
> using 0x% rather than %#, so maybe converting in the other direction
> would be better? I think the patch would also be easier to review
> if the "no change to the printed value" switches between 0x% and %#
> were not in the same patch as "changing the printed value which
> didn't have an 0x before".
>
> thanks
> -- PMM


  I thought that '%#' is cooler as it uses a feature of printf. However 
this feature looks not very popular, therefore '0x%' is clearer. So if 
more people are comfortable with '0x%' let's use it.. One more vote here?

Will split into two patches anyway.


-- 
Best regards,
Vladimir
