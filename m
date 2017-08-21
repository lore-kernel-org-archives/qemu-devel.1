Received: from eggs.gnu.org ([2001:4830:134:3::10]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djnwf-0003Z8-Cm
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djnwc-00027h-PT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:44:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170815135012.2kjflh6z2b6pdw44@postretch>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-2-el13635@mail.ntua.gr>
	<w51fuctyne1.fsf@maestria.local.igalia.com>
	<20170815135012.2kjflh6z2b6pdw44@postretch>
Date: Mon, 21 Aug 2017 16:44:43 +0200
Message-ID: <w51378lnfok.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: skip implicit nodes in
 snapshots, blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Tue 15 Aug 2017 03:50:12 PM CEST, Manos Pitsidianakis wrote:
>>> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
>>> +{
>>> +    BdrvChild *child = QLIST_FIRST(&bs->children);
>>> +    assert(child && !QLIST_NEXT(child, next));
>>> +    return child->bs;
>>> +}
>>
>>This aborts if the bs has a number of children != 1. That's not
>>something that I would expect from a function named like that.
>>
>>Considering that you're only using it in bdrv_get_first_explicit(),
>>why don't you simply move the code there?
>
> It felt useful to have a function that also returns file->bs (we have 
> backing_bs() already) instead of doing backing_bs(bs) ? : file_bs(bs)
>>
>>The other question is of course whether we can rely for the future on
>>the assumption that implicit nodes only have one children.
>
> This is only to get either bs->backing or bs->file (we can't have both
> anyway).

You can have other children (see Quorum for example).

Berto
