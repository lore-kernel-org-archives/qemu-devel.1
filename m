Received: from eggs.gnu.org ([2001:4830:134:3::10]:35896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJdcc-0002IK-SF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fJdcc-00019s-0W
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:32:30 -0400
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
	<0fac4939-20d0-b158-7279-fac31ff7baae@virtuozzo.com>
	<343bf957-869d-67b8-0e84-4eb30ca6c53e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <439d5bc1-c429-c208-b522-6cdefead9747@virtuozzo.com>
Date: Fri, 18 May 2018 14:32:17 +0300
MIME-Version: 1.0
In-Reply-To: <343bf957-869d-67b8-0e84-4eb30ca6c53e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5] NBD reconnect: preliminary refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

17.05.2018 16:48, Eric Blake wrote:
> On 05/17/2018 04:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>> What about patches 1-4?
>
> Still on my list to review (I'm first trying to post an updated=20
> proposal on the libvirt list for managing incremental backups); but on=20
> first glance, the idea of being able to reconnect instead of=20
> permanently switching to EIO failures on first error seems reasonable.

It relates to the same case as CMD_CACHE. We need to start guest over=20
new empty disk with backing =3D r-o nbd server (backup). Guest is already=20
running, disconnect will lead to data loss (not very significant, we can=20
retry, starting from the same backup), so ability to reconnect may help.



>
>>
>> 07.05.2018 18:44, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> Here are some preliminary refactoring patches, before NBD reconnect
>>> series.
>>>
>>> Vladimir Sementsov-Ogievskiy (5):
>>> =C2=A0=C2=A0 block/nbd-client: split channel errors from export errors
>>> =C2=A0=C2=A0 block/nbd: move connection code from block/nbd to block/nb=
d-client
>>> =C2=A0=C2=A0 block/nbd-client: split connection from initialization
>>> =C2=A0=C2=A0 block/nbd-client: fix nbd_reply_chunk_iter_receive
>>> =C2=A0=C2=A0 block/nbd-client: don't check ioc
>>>
>>> =C2=A0 block/nbd-client.h |=C2=A0=C2=A0 2 +-
>>> =C2=A0 block/nbd-client.c | 163=20
>>> ++++++++++++++++++++++++++++++++++-------------------
>>> =C2=A0 block/nbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 41=
 +-------------
>>> =C2=A0 3 files changed, 107 insertions(+), 99 deletions(-)
>>>
>>
>>
>


--=20
Best regards,
Vladimir
