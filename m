Received: from eggs.gnu.org ([208.118.235.92]:50757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehdku-00005T-Pc
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehdiw-0004Ku-4N
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:00:00 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-4-vsementsov@virtuozzo.com>
	<887a889a-e5bc-1a38-7fc9-87bf5d7a6e1b@redhat.com>
	<d838bf06-3198-79b4-53d0-1c729e9ce580@virtuozzo.com>
	<b6e71cfa-19f6-8b98-4e6a-a5d230129f62@redhat.com>
	<f99445cc-4f70-ca06-4831-b042c1dd30d7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <71a3c8a1-b614-1000-66bd-c5360719a402@virtuozzo.com>
Date: Fri, 2 Feb 2018 18:37:03 +0300
MIME-Version: 1.0
In-Reply-To: <f99445cc-4f70-ca06-4831-b042c1dd30d7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

22.01.2018 22:56, John Snow wrote:
>
> On 01/22/2018 02:51 PM, Eric Blake wrote:
>> On 01/22/2018 03:09 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>> I have to admit exposing this interface still makes me nervous, but :)
>>>>
>>>> Mechanically correct, and with suggesting phrasing changes:
>>>>
>>>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Should we go with an x- prefix for now, and let things settle for a
>> release before promoting it to fully supported, just in case we find
>> something that justifies your nervousness in accepting the interface?
>>
> I proposed as much in a reply to the cover letter; I'm willing to take
> patch one now for the sake of migration; the rest of this series I want
> a test suite that helps document the anticipated use case, or otherwise
> an x- prefix for the command names.

Give me a try with test, and if it will still be unclear, then let's add 
x- prefix for first steps.
(of course, my aim is to push the api without x- prefixes =)

-- 
Best regards,
Vladimir
