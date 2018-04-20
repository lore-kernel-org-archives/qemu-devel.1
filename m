Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9Urd-0004JB-6J
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9Urc-0003jH-BY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:10:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180416165849.28864-6-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-6-mreitz@redhat.com>
Date: Fri, 20 Apr 2018 14:09:58 +0200
Message-ID: <w51r2naw02x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/9] block/quorum: Support
 BDRV_REQ_WRITE_UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 16 Apr 2018 06:58:45 PM CEST, Max Reitz wrote:
> We just need to forward it to quorum's children (except in case of a
> rewrite because of corruption), but for that we first have to support
> flags in child requests at all.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
