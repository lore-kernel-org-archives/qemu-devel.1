Received: from eggs.gnu.org ([2001:4830:134:3::10]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO4B-0000d2-Ke
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO4A-0000mI-5O
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnO49-0000ly-V5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9AA44A6E5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 11:55:20 +0000 (UTC)
Date: Thu, 31 Aug 2017 12:26:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170831112657.GN13619@stefanha-x1.localdomain>
References: <20170824072202.26818-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170824072202.26818-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: clean up resources using
 context managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>

On Thu, Aug 24, 2017 at 08:21:59AM +0100, Stefan Hajnoczi wrote:
> This series introduces context managers for the two most commonly used
> resources: files and VMs.  Context managers eliminate the need to call a
> cleanup function explicitly.
> 
> Tests should declare resources upfront in a with statement.  Resources are
> automatically cleaned up whether the test passes or fails:
> 
>   with FilePath('test.img') as img_path,
>        VM() as vm:
>       ...test...
>   # img_path is deleted and vm is shut down automatically
> 
> The final patch converts 194 to use context managers instead of
> atexit.register().  This makes the code shorter and easier to read.
> 
> Stefan Hajnoczi (3):
>   qemu.py: make VM() a context manager
>   iotests.py: add FilePath context manager
>   qemu-iotests: use context managers for resource cleanup in 194
> 
>  scripts/qemu.py               | 16 ++++++++-
>  tests/qemu-iotests/194        | 83 +++++++++++++++++++++----------------------
>  tests/qemu-iotests/iotests.py | 26 ++++++++++++++
>  3 files changed, 82 insertions(+), 43 deletions(-)
> 
> -- 
> 2.13.5
> 

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
