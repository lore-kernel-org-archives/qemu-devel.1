Received: from eggs.gnu.org ([2001:4830:134:3::10]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKXP-0001oD-H4
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSKXO-0000NM-0m
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:54:31 -0400
Date: Tue, 4 Jul 2017 11:54:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704095418.GB4253@noname.str.redhat.com>
References: <20170704084059.6278-1-el13635@mail.ntua.gr>
	<20170704084059.6278-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704084059.6278-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] block: Use defaults of bdrv_*
 callbacks in raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>

Am 04.07.2017 um 10:40 hat Manos Pitsidianakis geschrieben:
> Now that passing the call to bs->file is the default for some bdrv_*
> callbacks, remove the duplicate implementations in block/raw-format.c
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

If you change patch 1 as suggested there, most of these functions will
have to stay.

The exception is .bdrv_has_zero_init, for which I suggested an
.is_filter check. However, raw isn't declared a filter currently. If we
want to declare it a filter, the definition I proposed in the other mail
doesn't work because raw can apply an offset - this why it needs its own
function for probing geometry, so with that changed definition checking
.is_filter might not be enough any more for all of the functions in
patch 1.

Maybe it turns out in the end that raw just is special enough that
having its own functions is okay.

Kevin
