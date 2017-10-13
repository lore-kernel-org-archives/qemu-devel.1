Received: from eggs.gnu.org ([2001:4830:134:3::10]:49605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2uqd-0005YI-Hh
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2uqb-0000hp-Uc
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:57:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:33765 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2uqb-0000fC-Iu
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:57:33 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<dd3bbcfd-b0e0-19a1-1b0a-dbe9ef6bb443@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <03cf2b9d-951c-337c-a8f4-a2456002d488@virtuozzo.com>
Date: Fri, 13 Oct 2017 10:57:22 +0300
MIME-Version: 1.0
In-Reply-To: <dd3bbcfd-b0e0-19a1-1b0a-dbe9ef6bb443@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 00/13] nbd minimal structured read
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

13.10.2017 01:39, Eric Blake wrote:
> On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimally implement nbd structured read extension.
>>
>> v3:
>>
>> clone: tag up-nbd-minimal-structured-read-v3 from https://src.openvz.org/scm/~vsementsov/qemu.git
>> online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=up-nbd-minimal-structured-read-v3
>>
>> 03: rename  nbd_co_send_reply here too, remove r-b
>> 04-07: splitted nbd server refactoring, with some changes
> English does not have 'splitted'; 'split' is one of those irregular
> verbs that is the same form for present, past, and past participle tenses.
>
> I've pushed 1-7 with tweaks to my NBD staging queue:
> http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/nbd
>
> Let me know if I need to redo any of the tweaks I made to your work.

I've checked, and I agree with all your changes, thank you for this work!

>
>> 08: add Eric's r-b
>> 13: rewrite receiving loops by Paolo's suggestion
>>
> and I will resume review of the rest tomorrow.
>


-- 
Best regards,
Vladimir
