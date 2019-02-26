Received: from eggs.gnu.org ([209.51.188.92]:34271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyg0g-0003Ez-61
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyg0c-00065M-FB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:55:12 -0500
References: <20190226153549.17867-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a8d76d1-1280-f3d9-3d72-1c662d1ad666@redhat.com>
Date: Tue, 26 Feb 2019 10:54:55 -0600
MIME-Version: 1.0
In-Reply-To: <20190226153549.17867-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Peter Krempa <pkrempa@redhat.com>

On 2/26/19 9:35 AM, Stefan Hajnoczi wrote:
> Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> implement bdrv_co_invalidate_cache() on Linux") introduced page cache
> invalidation so that cache.direct=off live migration is safe on Linux.
> 
> The invalidation takes a significant amount of time when the file is
> large and present in the page cache.  Normally this is not the case for
> cross-host live migration but it can happen when migrating between QEMU
> processes on the same host.
> 
> On same-host migration we don't need to invalidate pages for correctness
> anyway, so an option to skip page cache invalidation is useful.  I
> investigated optimizing invalidation and detecting same-host migration,
> but both are hard to achieve so a user-visible option will suffice.
> 
> As a bonus this option means that the cache invalidation feature will
> now be detectable by libvirt via QMP schema introspection.

Do you still want to pursue the QMP query-qemu-features command, or does
this delay that for another day?

> 
> Suggested-by: Neil Skrypuch <neil@tembosocial.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json |  5 +++++
>  block/file-posix.c   | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
