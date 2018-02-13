Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc0s-0004hX-3I
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elc0r-00073A-Ab
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:56:54 -0500
References: <20180213130356.8885-1-mreitz@redhat.com>
	<20180213130356.8885-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fadfe050-5aea-8f90-6c84-2ec0cef4adc8@redhat.com>
Date: Tue, 13 Feb 2018 08:56:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180213130356.8885-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] gluster: Pull truncation from
 qemu_gluster_create
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
> Pull out the truncation code from the qemu_cluster_create() function so
> we can later reuse it in qemu_gluster_truncate().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/gluster.c | 74 +++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 40 insertions(+), 34 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
