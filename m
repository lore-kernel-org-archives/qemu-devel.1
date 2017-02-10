Received: from eggs.gnu.org ([2001:4830:134:3::10]:52541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cc9Is-0001QR-Ru
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cc9Ir-00089H-V1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:23:50 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:41417 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cc9Ir-00086r-Js
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 06:23:49 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-5-vsementsov@virtuozzo.com>
	<7b79d03c-0fba-ddb8-4295-b155cb26a206@redhat.com>
	<829007b8-d8a4-652c-7a23-59fbb5476cd2@virtuozzo.com>
	<de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e0ec9530-a87d-0f10-262d-4b2af4516eed@virtuozzo.com>
Date: Fri, 10 Feb 2017 14:23:36 +0300
MIME-Version: 1.0
In-Reply-To: <de548107-dbff-36ca-96ba-fead03589fde@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/18] nbd/client: refactor
 nbd_receive_starttls
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

09.02.2017 17:41, Eric Blake wrote:
> On 02/09/2017 12:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 07.02.2017 19:32, Eric Blake wrote:
>>> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Split out nbd_receive_simple_option to be reused for structured reply
>>>> option.
>>>> +    return "<unknown option>";
>>> Can you please consider making this include the %d representation of the
>>> unknown option; perhaps by snprintf'ing into static storage?  While it
>> Hmm.. The caller should free it in this case.
> Only if you print it into malloc'd space. I think that printing it into
> static storage may be sufficient (although then we have a race if more
> than one thread is trying to use that static storage at the same time -
> but do we ever have more than one thread trying to handle an error at
> the same time?).
>

This race would be if one thread decides to print two option names in 
one message. Or save one option in a var, then print other, then print var.



-- 
Best regards,
Vladimir
