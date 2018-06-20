Received: from eggs.gnu.org ([2001:4830:134:3::10]:46189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZZB-0006cY-9L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZZ8-0001GA-3V
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:38:17 -0400
References: <20180619183457.371081-1-vsementsov@virtuozzo.com>
	<20180619183457.371081-4-vsementsov@virtuozzo.com>
	<22f38c8e-8fbb-352e-ab15-b5e5f20ac03e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3c859dac-4da2-c9e3-3deb-ddda04761192@virtuozzo.com>
Date: Wed, 20 Jun 2018 12:37:57 +0300
MIME-Version: 1.0
In-Reply-To: <22f38c8e-8fbb-352e-ab15-b5e5f20ac03e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/7] block/qcow2-refcount:
 check_refcounts_l2: refactor compressed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

19.06.2018 21:50, Eric Blake wrote:
> On 06/19/2018 01:34 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Separate offset and size of compressed cluster.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 block/qcow2-refcount.c | 15 ++++++++++-----
>> =C2=A0 1 file changed, 10 insertions(+), 5 deletions(-)
>
> Hmm, I wonder if this duplicates my pending patch:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04542.html
>

hm which one? don't see.

--=20
Best regards,
Vladimir
