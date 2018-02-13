Received: from eggs.gnu.org ([2001:4830:134:3::10]:39425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc2Y-0006AS-6J
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc2X-0007zS-Fl
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:58:38 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8dd32ac-c8d9-6a3a-ebc9-8bbc857b93f1@redhat.com>
Date: Tue, 13 Feb 2018 08:58:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] gluster: Add preallocated truncation
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
> By using qemu_do_cluster_truncate() in qemu_cluster_truncate(), we now
> automatically have preallocated truncation.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/gluster.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
