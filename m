Received: from eggs.gnu.org ([2001:4830:134:3::10]:48095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnMwp-0000MH-2n
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnMwk-0006rD-Ng
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808071051.30628-5-lbloch@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-5-lbloch@janustech.com>
Date: Wed, 08 Aug 2018 13:47:32 +0200
Message-ID: <w51in4lt6zv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qcow2: Set the default
 cache-clean-interval to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 09:10:50 AM CEST, Leonid Bloch wrote:
> The default cache-clean-interval is set to 30 seconds, in order to lower
> the overhead of the qcow2 caches (before the default was 0, i.e.
> disabled).
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> +#define DEFAULT_CACHE_CLEAN_INTERVAL 30  /* seconds */

I wonder if it shouldn't be a bit higher, though. Isn't 30 seconds too
low for a default?

Berto
