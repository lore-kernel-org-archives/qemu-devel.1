Received: from eggs.gnu.org ([2001:4830:134:3::10]:48254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJhY3-0001BU-2l
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJhY2-00025y-8F
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:07:15 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161129113245.32724-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f948687-3169-c304-3ef8-31347f08857f@redhat.com>
Date: Wed, 21 Dec 2016 15:07:07 +0100
MIME-Version: 1.0
In-Reply-To: <20161129113245.32724-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/5] Sheepdog cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, jcody@redhat.com, qemu-block@nongnu.org



On 29/11/2016 12:32, Paolo Bonzini wrote:
> Cleaning up the code and removing duplication makes it simpler to
> later adapt it for the multiqueue work.
> 
> Tested against sheepdog 1.0.  I also tested taking snapshots and reverting
> to older snapshots, but the latter only worked with "dog vdi rollback".
> Neither loadvm nor qemu-img worked for me.
> 
> Paolo
> 
>         v1->v2: placate patchew
>         v2->v3: rebase
> 
> Paolo Bonzini (5):
>   sheepdog: remove unused cancellation support
>   sheepdog: reorganize coroutine flow
>   sheepdog: do not use BlockAIOCB
>   sheepdog: simplify inflight_aio_head management
>   sheepdog: reorganize check for overlapping requests
> 
>  block/sheepdog.c | 289 ++++++++++++++++---------------------------------------
>  1 file changed, 83 insertions(+), 206 deletions(-)
> 

2.8 is now out, so ping.

Paolo
