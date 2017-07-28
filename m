Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db1Lz-000114-Ty
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1db1Lx-0002lR-8j
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:14:39 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:21799 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1db1Lw-0002kF-To
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:14:37 -0400
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<20170728090637.GI31495@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cdd1b790-322f-b42a-acc1-79a9f8188000@virtuozzo.com>
Date: Fri, 28 Jul 2017 12:14:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170728090637.GI31495@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

28.07.2017 12:06, Daniel P. Berrange wrote:
> On Fri, Jul 28, 2017 at 11:55:47AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> To make logs more readable prefix all hex values with '0x' mark.
>> This is needed for consistency too, as a lot of hex values are already
>> prefixed with '0x'. Also, bring all hex outputs to the common form -
>> use '%#', not '0x%'.
>>
>> This patch is done by two commands:
>> find . -name trace-events | \
>>   xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
>> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
> I fear that despite your cleanup, these mistakes will be frequently
> re-introduced.  IOW, I think you should add to scripts/checkpatch.pl
> to re-validate any patch which touches a trace-events file, to
> prevent further regressions.

Good point, I'll try to do it.

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all!
>>
>> It is hard to read logs, when there are hex and dec numbers in one line, when
>> hex number doesn't contain any letters and don't have '0x' prefix. Hope I'm
>> not alone who is not comfortable with it, so, what about a patch like this?
>> May be regexp's should be improved but, I think, the common idea is clear.
> Yeah, I agree - mixing decimal & hex values with no 0x prefix is horribly
> misleading at best.

Thank you!

>
>
>
> Regards,
> Daniel


-- 
Best regards,
Vladimir
