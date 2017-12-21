Received: from eggs.gnu.org ([2001:4830:134:3::10]:55136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSACg-00089b-3y
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSACf-0002oE-B3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:24:42 -0500
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b57c9573-12b6-0346-38c3-99d9555a60b8@redhat.com>
Date: Thu, 21 Dec 2017 17:24:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171220103412.13048-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/19] block: Don't block_job_pause_all()
 in bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 12/20/2017 04:34 AM, Kevin Wolf wrote:
> Block jobs are already paused using the BdrvChildRole drain callbacks,
> so we don't need an additionall block_job_pause_all() call.

s/additionall/additional/

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c              |  4 ----
>   tests/test-bdrv-drain.c | 10 ++++------
>   2 files changed, 4 insertions(+), 10 deletions(-)
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
