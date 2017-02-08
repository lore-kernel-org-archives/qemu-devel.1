Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cbN6r-0002ey-JY
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 02:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cbN6q-0001B3-HX
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 02:56:13 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:36112 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cbN6q-00019I-62
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 02:56:12 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-7-vsementsov@virtuozzo.com>
	<f9ddd60b-532a-2009-c1cc-edab0ca64458@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <950e5279-0d30-77a4-ca1c-f8543ae08248@virtuozzo.com>
Date: Wed, 8 Feb 2017 10:55:59 +0300
MIME-Version: 1.0
In-Reply-To: <f9ddd60b-532a-2009-c1cc-edab0ca64458@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] nbd/client: refactor drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

07.02.2017 02:19, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Return 0 on success to simplify success checking.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/client.c | 35 +++++++++++++++++++----------------
>>   1 file changed, 19 insertions(+), 16 deletions(-)
> I'm not sure that this simplifies anything.  You have a net addition in
> lines of code, so unless some later patch is improved because of this,
> I'm inclined to say this is needless churn.
>

I just dislike duplicating information like "drop_sync(ioc, 124) != 
124". In the code there is no place where positive and not equal to size 
return value actually handled. But it is not so important, if you are 
against i'll drop this, no problem.

One note: I don't have good understanding of the following: actually 
read can return positive value < queried size, which means that we 
should read again. But it is not handled in the code (handled, but just 
as an error), except drop_sync.. (With drop_sync it is side effect of 
using limited buffer size, yes?). Is it all ok?


-- 
Best regards,
Vladimir
