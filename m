Received: from eggs.gnu.org ([2001:4830:134:3::10]:44871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcDkX-0002TI-EV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcDkU-0002Ku-Q4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:40:57 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:30478 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcDkU-0002JZ-E4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:40:54 -0400
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
	<20170731160135.12101-3-vsementsov@virtuozzo.com>
	<2af88b8d-9d59-72bf-bd25-b83fbba726f4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <31288dd3-99ed-ab32-0fbf-b790b4a2b31d@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:40:44 +0300
MIME-Version: 1.0
In-Reply-To: <2af88b8d-9d59-72bf-bd25-b83fbba726f4@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/4] trace-events: fix code style: %# ->
 0x%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com

31.07.2017 19:15, Eric Blake wrote:
> On 07/31/2017 11:01 AM, Vladimir Sementsov-Ogievskiy wrote:
>> In trace format '#' flag of printf is forbidden. Fix it to '0x%'.
>>
>> This patch is created by the following:
>>
>> check that we have a problem
>>> find . -name trace-events | xargs grep '%#' | wc -l
>> 56
>>
>> check that there are no cases with additional printf flags before '#'
>>> find . -name trace-events | xargs grep '%[-+ 0'I]+#' | wc -l
> That's not the actual command you used; maintainer can fix the typo by
> using "%[-+ 0'I]+#" instead.

Aha yes, you are right. I've checked out the previous commit, checked it 
by a command with "%[-+ 0'I]+#"
and then separately fixed the commit message, forgotten to s/'/"/.

Yes, if a new version will not be required, fix this inflight please.

>
>> 0
>>
>> check that there are no wrong usage of '#' and '0x' together
>>> find . -name trace-events | xargs grep '0x%#' | wc -l
>> 0
>>
>> fix the problem
>>> find . -name trace-events | xargs sed -i 's/%#/0x%/g'
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---


-- 
Best regards,
Vladimir
