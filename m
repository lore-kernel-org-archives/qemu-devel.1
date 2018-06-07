Received: from eggs.gnu.org ([2001:4830:134:3::10]:38428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQs1C-00077m-JO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fQs1B-0007VF-LP
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:19:46 -0400
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
	<73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
	<a9939647-5c4e-9336-1121-eb821fe8eecc@virtuozzo.com>
	<20180607101046.GC19032@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2ddb8b13-650a-5bd7-8c77-3f2eca34efdf@virtuozzo.com>
Date: Thu, 7 Jun 2018 13:19:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180607101046.GC19032@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH V4] qemu-img: make convert
 async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Lieven <pl@kamp.de>, kwolf@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

07.06.2018 13:10, Stefan Hajnoczi wrote:
> On Fri, Jun 01, 2018 at 07:16:14PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> 20.02.2017 17:59, Peter Lieven wrote:
>>> Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
>>>> On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
>>>>> this is something I have been thinking about for almost 2 years now.
>>>>> we heavily have the following two use cases when using qemu-img
>>>>> convert.
>>>>>
>>>>>
>> [...]
>>
>>>> Does this patch work with compressed images?=A0 Especially the
>>>> out-of-order write mode may be problematic with a compressed qcow2
>>>> image.
>>> It does, but you are right, out-of-order writes and compression should
>>> be mutually exclusive.
>>
>> Sorry for being late, but can you please explain to me, why?
> There are image format-specific limitations on compressed writes.  For
> some reason I thought they were append-only in qcow2, but I was wrong.
>
> Stefan

And what are limitations for compressed writes in qcow2? We can't write=20
asynchronously? Why?

--=20
Best regards,
Vladimir
