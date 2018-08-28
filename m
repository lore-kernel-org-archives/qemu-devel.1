Received: from eggs.gnu.org ([2001:4830:134:3::10]:34821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fue1R-0004fz-7n
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fue1Q-0007Pz-IR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:27:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-6-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-6-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 15:26:56 +0200
Message-ID: <w517ekasjtr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 05/31] block: Respect backing
 bs in bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:02 PM CEST, Max Reitz wrote:
> +    backing_overridden = bdrv_backing_overridden(bs);
> +
> +    if (bs->open_flags & BDRV_O_NO_IO) {
> +        /* Without I/O, the backing file does not change anything.
> +         * Therefore, in such a case (primarily qemu-img), we can
> +         * pretend the backing file has not been overridden even if
> +         * it technically has been. */
> +        backing_overridden = false;
> +    }

What is this for?

Berto
