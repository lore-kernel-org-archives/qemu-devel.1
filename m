Received: from eggs.gnu.org ([2001:4830:134:3::10]:47971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2DDT-0003FS-Dl
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2DDS-0004Qu-HV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:22:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13051 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2DDS-0004N9-5h
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 05:22:14 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-18-vsementsov@virtuozzo.com>
	<24bd15b7-8119-4bb4-85f4-b5187a0339e2@redhat.com>
	<b76d7f71-914c-c059-0f08-4dc606db9533@virtuozzo.com>
	<6266e2aa-1a24-3e67-5652-3105ce2a7e7e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <91ecc907-8590-b5c8-5eaf-9ffed1c7e94e@virtuozzo.com>
Date: Wed, 11 Oct 2017 12:22:00 +0300
MIME-Version: 1.0
In-Reply-To: <6266e2aa-1a24-3e67-5652-3105ce2a7e7e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 10/10] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org

10.10.2017 18:00, Paolo Bonzini wrote:
> On 10/10/2017 16:55, Vladimir Sementsov-Ogievskiy wrote:
>> Hmm, would it be simpler just pass a function pointer, which should be
>> called on each loop iteration?
>> So, we will return to one common func nbd_co_receive_reply, but with two
>> additional parameters: func and opaque?
> Function pointers typically result in having to pass the state around in
> a structure, for all the callers.
>
> An iterator also has to package the state in a structure, but it is only
> done once.
>
> So function pointers would be simpler in the beginning, but would not
> scale as well.
>
> Paolo

Understand. OK, I'll try your suggestion.

-- 
Best regards,
Vladimir
