Received: from eggs.gnu.org ([2001:4830:134:3::10]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc1t-0005Zd-IX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc1s-0007Tk-Ol
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:57:57 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe30e8ce-817c-b205-5007-0f9eadbd2326@redhat.com>
Date: Tue, 13 Feb 2018 08:57:50 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] gluster: Query current size in
 do_truncate()
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
> Instead of expecting the current size to be 0, query it and allocate
> only the area [current_size, offset) if preallocation is requested.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/gluster.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 

I don't have a gluster setup handy to test this, but the concept matches 
file-posix and the change looks reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
