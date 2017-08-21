Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djmDv-0004gJ-Gj
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djmDs-0005dN-Fm
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:54:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170821093150.6783-5-el13635@mail.ntua.gr>
References: <20170821093150.6783-1-el13635@mail.ntua.gr>
	<20170821093150.6783-5-el13635@mail.ntua.gr>
Date: Mon, 21 Aug 2017 14:54:24 +0200
Message-ID: <w518tidnksf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 4/6] block: convert ThrottleGroup to
 object with QOM
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

On Mon 21 Aug 2017 11:31:48 AM CEST, Manos Pitsidianakis wrote:

> +    switch (info->data_type) {
> +    case UINT64:
> +        {
> +            uint64_t *field = (void *)&cfg.buckets[info->type] + info->offset;
> +            *field = value;
> +        }
> +        break;

The rest of the patch looks good, but I still think that these pointer
casts here are a bad idea (plus, pointer arithmetic is not allowed on
void pointers).

If the field ever becomes a 32-bit integer you'd be overwriting someone
else's memory.

Berto
