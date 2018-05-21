Received: from eggs.gnu.org ([2001:4830:134:3::10]:50761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fKnsY-0005n6-D1
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fKnsX-0006G9-G9
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:41:46 -0400
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-3-ross.zwisler@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6332df7d-3588-9ecc-6220-2f40c1581fe6@redhat.com>
Date: Mon, 21 May 2018 11:41:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180521163203.26590-3-ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH v4 2/4] tests/.gitignore: add entry
 for generated file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, qemu block <qemu-block@nongnu.org>

On 05/21/2018 11:32 AM, Ross Zwisler wrote:
> After a "make check" we end up with the following:
> 
> $ git status
> On branch master
> Your branch is up-to-date with 'origin/master'.
> 
> Untracked files:
>    (use "git add <file>..." to include in what will be committed)
> 
> 	tests/test-block-backend
> 
> nothing added to commit but untracked files present (use "git add" to track)
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Fixes: commit ad0df3e0fdac ("block: test blk_aio_flush() with blk->root == NULL")
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/.gitignore | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index fb62d2299b..2bc61a9a58 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -21,6 +21,7 @@ test-base64
>   test-bdrv-drain
>   test-bitops
>   test-bitcnt
> +test-block-backend
>   test-blockjob
>   test-blockjob-txn
>   test-bufferiszero
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
