Received: from eggs.gnu.org ([2001:4830:134:3::10]:32803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmIPb-0003K7-4K
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmIPY-00020x-39
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:40:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825132332.6734-2-el13635@mail.ntua.gr>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-2-el13635@mail.ntua.gr>
Date: Mon, 28 Aug 2017 13:40:52 +0200
Message-ID: <w51shgbvs1n.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/7] block: skip implicit nodes in
 snapshots, blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 25 Aug 2017 03:23:26 PM CEST, Manos Pitsidianakis wrote:

> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
> +{
> +    BlockDriverState *backing = backing_bs(bs);
> +    BlockDriverState *file = file_bs(bs);
> +    assert(!(file && backing));
> +    return backing ?: file;
> +}

I'm still not sure how useful it is to have a separate function for
this, instead of putting it inside bdrv_get_first_explicit(), but anyway

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
