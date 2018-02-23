Received: from eggs.gnu.org ([2001:4830:134:3::10]:37246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF0G-00054f-Ob
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epF0A-000701-SL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:11:16 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-18-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <50817c19-42cb-39e1-bcef-31abf87a6c59@redhat.com>
Date: Fri, 23 Feb 2018 09:10:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/36] gluster: Support .bdrv_co_create
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
> This adds the .bdrv_co_create driver callback to gluster, which enables
> image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  18 ++++++-
>   block/gluster.c      | 135 ++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 108 insertions(+), 45 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
