Received: from eggs.gnu.org ([2001:4830:134:3::10]:57490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0AC-0000EE-UW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep09K-0002QD-Gg
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:20:32 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-14-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0a4df84-1157-753a-0cbd-8b74e29e80b6@redhat.com>
Date: Thu, 22 Feb 2018 17:17:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/36] block: Make bdrv_is_whitelisted()
 public
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

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> We'll use a separate source file for image creation, and we need to
> check there whether the requested driver is whitelisted.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/block.h | 1 +
>   block.c               | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
