Received: from eggs.gnu.org ([2001:4830:134:3::10]:48996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo6wg-0000KZ-Gf
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo6wc-0001Hm-AU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:55:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180810062647.23211-3-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-3-lbloch@janustech.com>
Date: Fri, 10 Aug 2018 14:54:27 +0200
Message-ID: <w51zhxu756k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 2/9] qcow2: Cosmetic changes
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

On Fri 10 Aug 2018 08:26:40 AM CEST, Leonid Bloch wrote:
> Some refactoring for better readability is done here.
>
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>

> -    *l2_cache_entry_size = qemu_opt_get_size(
> -        opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
> +    *l2_cache_entry_size = qemu_opt_get_size(opts,
> +                                             QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
> +                                             s->cluster_size);

> -                *refcount_cache_size =
> -                    MIN(combined_cache_size, min_refcount_cache);
> +                *refcount_cache_size = MIN(combined_cache_size,
> +                                           min_refcount_cache);

I won't oppose these changes if more people think that they improve
readability, but it seems to me that this is just a matter of taste and
there's no big difference either way.

I'm personally fine with the way the code is now, and this coding style
is used in many other parts of QEMU:

$ git grep -A 1 '.* = .*($'
$ git grep -A 1 '.* =$'

Berto
