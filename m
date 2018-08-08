Received: from eggs.gnu.org ([2001:4830:134:3::10]:57088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnQWh-00071R-0i
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnQWd-00076x-Nf
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:37:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w517el1t0yd.fsf@maestria.local.igalia.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-3-lbloch@janustech.com>
	<w51d0utt4kk.fsf@maestria.local.igalia.com>
	<f1197908-f00f-1c2b-b63c-3339e39488c5@janustech.com>
	<w517el1t0yd.fsf@maestria.local.igalia.com>
Date: Wed, 08 Aug 2018 17:37:23 +0200
Message-ID: <w51y3dgswcs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qcow2: Make the default L2 cache
 sufficient to cover the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 08 Aug 2018 03:58:02 PM CEST, Alberto Garcia wrote:
>  1) If l2-cache-size > l2_metadata_size, then make l2-cache-size =
>     l2_metadata_size. This is already useful on its own, even with the
>     current default of 1MB.
>
>  2) Increase the default to 32MB. This won't waste additional memory for
>     small images because of the previous patch, and will cover images up
>     to 256GB. If you have larger images you would need to increase
>     l2-cache-size manually if you want to cache all the L2 metadata.

Let's try this way: we had many users requesting us to add a new option
to set l2-cache-size=100%, but we never agreed on a good API. Patch (1)
would do precisely that (l2-cache-size=1T). Patch (2) changes the
default, which may be better and probably enough for many users, but
it's not what solves the problem.

Berto
