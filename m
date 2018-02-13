Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbz7-00038d-Et
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elbz6-0005vy-Ln
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:55:05 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b1475c7-c0dc-b948-0c67-68578363cb96@redhat.com>
Date: Tue, 13 Feb 2018 08:54:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] gluster: Move glfs_close() to create's
 clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Liu Yuan <namei.unix@gmail.com>

On 02/13/2018 07:03 AM, Max Reitz wrote:
> glfs_close() is a classical clean-up operation, as can be seen by the
> fact that it is executed even if the truncation before it failed.
> Also, moving it to clean-up makes it more clear that if it fails, we do
> not want it to overwrite the current ret value if that signifies an
> error already.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/gluster.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
