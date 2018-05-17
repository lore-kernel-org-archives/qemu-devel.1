Received: from eggs.gnu.org ([2001:4830:134:3::10]:51028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJJHB-0005CH-Vs
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJJHB-0007gk-8w
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:49:02 -0400
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
	<0fac4939-20d0-b158-7279-fac31ff7baae@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <343bf957-869d-67b8-0e84-4eb30ca6c53e@redhat.com>
Date: Thu, 17 May 2018 08:48:55 -0500
MIME-Version: 1.0
In-Reply-To: <0fac4939-20d0-b158-7279-fac31ff7baae@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] NBD reconnect: preliminary refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 05/17/2018 04:54 AM, Vladimir Sementsov-Ogievskiy wrote:
> What about patches 1-4?

Still on my list to review (I'm first trying to post an updated proposal=20
on the libvirt list for managing incremental backups); but on first=20
glance, the idea of being able to reconnect instead of permanently=20
switching to EIO failures on first error seems reasonable.

>=20
> 07.05.2018 18:44, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here are some preliminary refactoring patches, before NBD reconnect
>> series.
>>
>> Vladimir Sementsov-Ogievskiy (5):
>> =C2=A0=C2=A0 block/nbd-client: split channel errors from export errors
>> =C2=A0=C2=A0 block/nbd: move connection code from block/nbd to block/n=
bd-client
>> =C2=A0=C2=A0 block/nbd-client: split connection from initialization
>> =C2=A0=C2=A0 block/nbd-client: fix nbd_reply_chunk_iter_receive
>> =C2=A0=C2=A0 block/nbd-client: don't check ioc
>>
>> =C2=A0 block/nbd-client.h |=C2=A0=C2=A0 2 +-
>> =C2=A0 block/nbd-client.c | 163=20
>> ++++++++++++++++++++++++++++++++++-------------------
>> =C2=A0 block/nbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
1 +-------------
>> =C2=A0 3 files changed, 107 insertions(+), 99 deletions(-)
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
