Received: from eggs.gnu.org ([2001:4830:134:3::10]:33575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duwDs-000720-VN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duwDr-0006XU-Ig
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:48:37 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:31767 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1duwDr-0006VT-6o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 03:48:35 -0400
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
	<cb6364bf-2a67-6eea-b69e-2c267a4de4fa@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1af98294-1ecf-484c-8995-e03948a0b912@virtuozzo.com>
Date: Thu, 21 Sep 2017 10:48:20 +0300
MIME-Version: 1.0
In-Reply-To: <cb6364bf-2a67-6eea-b69e-2c267a4de4fa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 0/3] nbd client refactoring and fixing
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

20.09.2017 20:22, Eric Blake wrote:
> On 09/20/2017 07:45 AM, Vladimir Sementsov-Ogievskiy wrote:
>> v3: dropped all controversial things. I'll try to implement minimal
>> structured reply and block status over this small residue.
>>
>> Vladimir Sementsov-Ogievskiy (3):
>>    block/nbd-client: refactor nbd_co_receive_reply
>>    block/nbd-client: simplify check in nbd_co_receive_reply
>>    block/nbd-client: nbd_co_send_request: fix return code
> Thanks; queued on my NBD tree, will send pull request after a bit more
> time to see if it collects further reviews:
> git://repo.or.cz/qemu/ericb.git nbd
>

Thank you, Eric!


-- 
Best regards,
Vladimir
