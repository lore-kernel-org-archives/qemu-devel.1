Received: from eggs.gnu.org ([2001:4830:134:3::10]:40050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF9y-0001qG-Cs
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF9x-0000IF-Iy
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:21:18 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-34-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af3ba830-6b01-23e3-b678-77a23869ed8a@redhat.com>
Date: Fri, 23 Feb 2018 09:21:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-34-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 33/36] file-posix: Fix no-op
 bdrv_truncate() with falloc preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:54 AM, Kevin Wolf wrote:
> If bdrv_truncate() is called, but the requested size is the same as
> before, don't call posix_fallocate(), which returns -EINVAL for length
> zero and would therefore make bdrv_truncate() fail.
> 
> The problem can be triggered by creating a zero-sized raw image with
> 'falloc' preallocation mode.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/file-posix.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
