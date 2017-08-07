Received: from eggs.gnu.org ([2001:4830:134:3::10]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dehvH-0008St-5Q
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dehvC-0008M6-Dd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:18:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:39019 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dehvC-0008I1-2P
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 09:18:14 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-12-vsementsov@virtuozzo.com>
	<5b1406d2-603e-9862-197a-20f5e1eedd84@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a1ba2cf-560e-765f-0a53-7e97414e3b6a@virtuozzo.com>
Date: Mon, 7 Aug 2017 16:17:58 +0300
MIME-Version: 1.0
In-Reply-To: <5b1406d2-603e-9862-197a-20f5e1eedd84@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 11/17] block/nbd-client: fix
 nbd_co_request: set s->reply.handle to 0 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

07.08.2017 14:55, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We set s->reply.handle to 0 on one error path and don't set on another.
>> For consistancy and to avoid assert in nbd_read_reply_entry let's
>> set s->reply.handle to 0 in case of wrong handle too.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd-client.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> Can this assertion be triggered now (presumably, with a broken server)?
> I'm trying to figure out if this is 2.10 material.
>
> [Urgh. If a broken server is able to cause an assertion failure that
> causes a client to abort on an assertion failure, that probably deserves
> a CVE]
>
Hmm looks like I've mistaken, if handle is wrong than read_reply_co 
should be already finished, so it's impossible


-- 
Best regards,
Vladimir
