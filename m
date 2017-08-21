Received: from eggs.gnu.org ([2001:4830:134:3::10]:60510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djnh6-0004PB-LZ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djnh3-0005Dr-DQ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:28:44 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170821093150.6783-6-el13635@mail.ntua.gr>
References: <20170821093150.6783-1-el13635@mail.ntua.gr>
	<20170821093150.6783-6-el13635@mail.ntua.gr>
Date: Mon, 21 Aug 2017 15:29:45 +0200
Message-ID: <w5160dhnj5i.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 5/6] block: add throttle block filter
 driver
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

On Mon 21 Aug 2017 11:31:49 AM CEST, Manos Pitsidianakis wrote:
> block/throttle.c uses existing I/O throttle infrastructure inside a
> block filter driver. I/O operations are intercepted in the filter's
> read/write coroutines, and referred to block/throttle-groups.c
>
> The driver can be used with the syntax
> -drive driver=throttle,file.filename=foo.qcow2, \
>         limits.iops-total=...
>
> which creates an anonymous group with the specified limits, or

Weren't we going to forbid anonymous groups? :-?

Berto
