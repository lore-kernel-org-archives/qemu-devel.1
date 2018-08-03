Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flYFU-0008VR-SJ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flYFQ-00063N-HR
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 07:28:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180729212744.23709-4-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-4-lbloch@janustech.com>
Date: Fri, 03 Aug 2018 13:27:51 +0200
Message-ID: <w51ftzvlmfc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/6 for-3.0] qcow2: Options'
 documentation fixes
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

On Sun 29 Jul 2018 11:27:41 PM CEST, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  docs/qcow2-cache.txt |  9 ++++++---
>  qapi/block-core.json |  6 +++---
>  qemu-options.hx      | 15 +++++++++------
>  3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index 8a09a5cc5f..fd9a6911cc 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -112,9 +112,9 @@ command-line, or the 'blockdev-add' QMP command.
>  
>  There are three options available, and all of them take bytes:
>  
> -"l2-cache-size":         maximum size of the L2 table cache
> -"refcount-cache-size":   maximum size of the refcount block cache
> -"cache-size":            maximum size of both caches combined
> +"l2-cache-size":         maximal size of the L2 table cache
> +"refcount-cache-size":   maximal size of the refcount block cache
> +"cache-size":            maximal size of both caches combined

Why is 'maximum' not clear in this context?

Otherwise the patch looks good to me.

Berto
