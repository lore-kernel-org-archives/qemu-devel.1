Received: from eggs.gnu.org ([209.51.188.92]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gyvyX-0004yM-Fn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gyvyW-0007lH-CA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:58:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gyvyW-0007h2-37
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 04:58:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so17153146wrs.13
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 01:57:59 -0800 (PST)
Date: Wed, 27 Feb 2019 10:57:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190227095755.y4mlmwv6cmresezd@steredhat>
References: <20190226153549.17867-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226153549.17867-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Neil Skrypuch <neil@tembosocial.com>

On Tue, Feb 26, 2019 at 03:35:49PM +0000, Stefan Hajnoczi wrote:
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
> 
> Suggested-by: Neil Skrypuch <neil@tembosocial.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json |  5 +++++
>  block/file-posix.c   | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
