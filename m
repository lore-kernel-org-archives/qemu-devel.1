Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IoH-0003iy-Jr
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IoG-0005MP-OS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:41:25 -0400
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
	<20180411122606.367301-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <75ae7684-99fb-6b8e-2fbf-0e5528c78165@redhat.com>
Date: Wed, 11 Apr 2018 18:41:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180411122606.367301-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com

On 2018-04-11 14:26, Vladimir Sementsov-Ogievskiy wrote:
> Improve and fix 169:
>     - use MIGRATION events instead of RESUME
>     - make a TODO: enable dirty-bitmaps capability for offline case
>     - recreate vm_b without -incoming near test end
> 
> This (likely) fixes racy faults at least of the following types:
> 
>     - timeout on waiting for RESUME event
>     - sha256 mismatch on line 136 (142 after this patch)
>     - fail to self.vm_b.launch() on line 135 (141 now after this patch)
> 
> And surely fixes cat processes, left after test finish.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 21 deletions(-)

Looks good, makes the test pass reliably (here) and doesn't result in
overly loud meowing due to an abundance of orphaned cats.  Thanks!

Reviewed-by: Max Reitz <mreitz@redhat.com>
