Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fOmj4-0004AO-Cb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fOmj3-0001Uo-J0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:16:26 -0400
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
	<73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a9939647-5c4e-9336-1121-eb821fe8eecc@virtuozzo.com>
Date: Fri, 1 Jun 2018 19:16:14 +0300
MIME-Version: 1.0
In-Reply-To: <73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
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
To: Peter Lieven <pl@kamp.de>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Hi!

20.02.2017 17:59, Peter Lieven wrote:
> Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
>> On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
>>> this is something I have been thinking about for almost 2 years now.
>>> we heavily have the following two use cases when using qemu-img=20
>>> convert.
>>>
>>>

[...]

>> Does this patch work with compressed images?=A0 Especially the
>> out-of-order write mode may be problematic with a compressed qcow2=20
>> image.
>
> It does, but you are right, out-of-order writes and compression should
> be mutually exclusive.


Sorry for being late, but can you please explain to me, why?


--=20
Best regards,
Vladimir
