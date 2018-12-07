Received: from eggs.gnu.org ([2001:4830:134:3::10]:46823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVHWh-000057-Vm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gVHWd-0002PS-3t
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:54:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <92eb1acf-62f0-9a0b-eb55-f347fa80c2ac@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-4-anton.nefedov@virtuozzo.com>
	<w51pnudv221.fsf@maestria.local.igalia.com>
	<92eb1acf-62f0-9a0b-eb55-f347fa80c2ac@virtuozzo.com>
Date: Fri, 07 Dec 2018 15:54:39 +0100
Message-ID: <w51muphv13k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 3/9] quorum: set supported write flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Fri 07 Dec 2018 03:46:13 PM CET, Anton Nefedov wrote:
>>> +static void quorum_set_supported_flags(BlockDriverState *bs)
>>> +{
>>> +    BDRVQuorumState *s = bs->opaque;
>>> +    int i;
>>> +
>>> +    bs->supported_write_flags = BDRV_REQ_FUA;
>>> +    for (i = 0; i < s->num_children; i++) {
>>> +        bs->supported_write_flags &= s->children[i]->bs->supported_write_flags;
>>> +    }
>>> +
>>> +    bs->supported_write_flags |= BDRV_REQ_WRITE_UNCHANGED;
>>> +}
>> 
>> You don't set supported_zero_flags here anymore ?
>
> Yes, I noticed (that late) that quorum doesn't actually implement
> write_zeroes(). bdrv_co_do_pwrite_zeroes() specifically checks that
> there must be no supported flags set in such case.

Oh, I see.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
