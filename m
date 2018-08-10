Received: from eggs.gnu.org ([2001:4830:134:3::10]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo5vm-0000wN-4a
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fo5vj-0005aI-36
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:50:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180810062647.23211-2-lbloch@janustech.com>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-2-lbloch@janustech.com>
Date: Fri, 10 Aug 2018 13:50:03 +0200
Message-ID: <w51600i8mqc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 1/9] qcow2: Options' documentation fixes
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

On Fri 10 Aug 2018 08:26:39 AM CEST, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  docs/qcow2-cache.txt | 16 +++++++++++-----
>  qemu-options.hx      |  9 ++++++---
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 8a09a5cc5f..0f157d859a 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -97,12 +97,15 @@ need:
>     l2_cache_size = disk_size_GB * 131072
>     refcount_cache_size = disk_size_GB * 32768
>  
> -QEMU has a default L2 cache of 1MB (1048576 bytes) and a refcount
> -cache of 256KB (262144 bytes), so using the formulas we've just seen
> -we have
> +With the default cluster size, to cover each 8 GB of the virtual image
> +size, 1MB of L2 cache is needed:
>  
> -   1048576 / 131072 = 8 GB of virtual disk covered by that cache
> -    262144 /  32768 = 8 GB
> +   65536 / 8 = 8192 = 8 GB / 1 MB

Where does this 65536 / 8 come from? The line that you changed follows
directly from the formula immediately before that paragraph:

     l2_cache_size = disk_size_GB * 131072

that is

     l2_cache_size / 131072 = disk_size_GB
           1048576 / 131072 = 8 GB

Berto
