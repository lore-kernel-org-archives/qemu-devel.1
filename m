Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0ULB-0001M2-Ry
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0ULB-0003Aa-3L
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:42:49 -0400
References: <20170418143044.12187-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6daef888-8410-125c-a58c-3aebf21f552b@redhat.com>
Date: Tue, 18 Apr 2017 16:42:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170418143044.12187-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v4 0/2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com



On 18/04/2017 16:30, Fam Zheng wrote:
> v4: Split patch, and fix the unsafe bdrv_unref. [Paolo]
> 
> Fam Zheng (2):
>   block: Walk bs->children carefully in bdrv_drain_recurse
>   block: Drain BH in bdrv_drained_begin
> 
>  block/io.c            | 23 ++++++++++++++++++++---
>  include/block/block.h | 22 ++++++++++++++--------
>  2 files changed, 34 insertions(+), 11 deletions(-)
> 

Thanks, this looks good.

Paolo
