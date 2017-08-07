Received: from eggs.gnu.org ([2001:4830:134:3::10]:34159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1debz7-0007Ts-5a
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1debz4-00065G-OS
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:53 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:9498 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1debz4-000615-Cm
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 02:57:50 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-6-vsementsov@virtuozzo.com>
	<20170804161135.GJ14504@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b102b503-ff2f-db95-330f-9780ab4aaeb2@virtuozzo.com>
Date: Mon, 7 Aug 2017 09:57:30 +0300
MIME-Version: 1.0
In-Reply-To: <20170804161135.GJ14504@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 05/17] block/nbd-client: get rid of ssize_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

04.08.2017 19:11, Daniel P. Berrange wrote:
> On Fri, Aug 04, 2017 at 06:14:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use int variable for nbd_co_send_request return value (as
>> nbd_co_send_request returns int).
> Hmm, nbd_co_send_request() propagates return value of nbd_send_request,
> which returns ssize_t.

See patch 04, nbd_send_request fixed in it to return int. It propagates 
return
value of nbd_write which is int.

> to also return ssize_t, rather than changing callers to use int.
>
>
> Regards,
> Daniel


-- 
Best regards,
Vladimir
