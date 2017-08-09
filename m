Received: from eggs.gnu.org ([2001:4830:134:3::10]:58052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfTMd-00073S-6S
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dfTMZ-0004Yp-8F
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:57:43 -0400
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
	<565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
	<93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bbc4083d-7a4c-2d93-d630-831fc0693161@virtuozzo.com>
Date: Wed, 9 Aug 2017 18:57:36 +0300
MIME-Version: 1.0
In-Reply-To: <93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com

09.08.2017 18:41, Eric Blake wrote:
> On 08/09/2017 10:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 09.08.2017 18:17, Vladimir Sementsov-Ogievskiy wrote:
>>> 185 can sometimes produce wrong output like this:
>>>
>>> This is because quite happens before first mirror request is done
>> s/quite/quit/
>>
>>> (and, in specified case, even before block-job len field is set).
>>> To prevent it let's just add a sleep for 0.3 seconds before quite.
> Here, as well.
>
> Maybe:
>
> This is because, under heavy load, the quit can happen before the first
> iteration of the mirror request has occurred.  To make sure we've had
> time to iterate, let's just add a sleep for 0.3 seconds before quitting.
>
>
>>>        "return"
>>>    +# If we don't sleep here 'quit' command may be handled before
>>> +# the first mirror iteration is done
>>> +sleep 0.5
> The commit message disagrees with the code (.3 vs. .5) - which one is
> correct?
>
Let it be .5, as I've tested it.


-- 
Best regards,
Vladimir
