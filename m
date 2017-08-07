Received: from eggs.gnu.org ([2001:4830:134:3::10]:54460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dedqr-0001XF-Je
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dedqq-0007JF-Fh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15726 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dedqq-0007Gm-5B
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:28 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-5-vsementsov@virtuozzo.com>
	<20170807082320.GB18259@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
Date: Mon, 7 Aug 2017 11:57:12 +0300
MIME-Version: 1.0
In-Reply-To: <20170807082320.GB18259@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
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

07.08.2017 11:23, Daniel P. Berrange wrote:
> On Fri, Aug 04, 2017 at 06:14:27PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Fix nbd_send_request to return int, as it returns a return value
>> of nbd_write (which is int), and the only user of nbd_send_request's
>> return value (nbd_co_send_request) consider it as int too.
> The real problem here is the return value of nbd_write() - it should be
> a ssize_t, not an int, since it is propagating the return value of
> nbd_rwv() which is ssize_t.

It was changed in f5d406fe86bb (sent in May)
The discussion actually was started half a year ago:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00825.html


> Basically all functions that do I/O and
> return the number of bytes read/written should be ssize_t - any use of
> int is a bug.
>
> Regards,
> Daniel


-- 
Best regards,
Vladimir
