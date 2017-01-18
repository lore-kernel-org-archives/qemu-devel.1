Received: from eggs.gnu.org ([2001:4830:134:3::10]:50300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTmBo-0002Bh-Rn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTmBj-0007WZ-Qv
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:05:56 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cTmBj-0007Vx-Dr
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:05:51 -0500
Received: by mail-lf0-x241.google.com with SMTP id v186so765900lfa.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 01:05:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484556005-29701-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5356257-f98c-8d37-0da4-f2d95f957dc0@redhat.com>
Date: Wed, 18 Jan 2017 10:05:49 +0100
MIME-Version: 1.0
In-Reply-To: <1484556005-29701-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] memory: extend "info mtree" with
 flat view dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 16/01/2017 09:40, Peter Xu wrote:
> v4:
> - do unref of flatview when no view is there [Dave]
> 
> v3:
> - rather than dump flatview directly in "info mtree", provide a new
>   parameter "-f" for it. [Paolo]
> - replace "RW" chars with the type of memory region [Paolo]
> - (cc dave as well since it touches HMP interface)
> 
> v2:
> - fix a size error in patch 2
> - add r-b for Marc-André in patch 1
> 
> Each address space has its own flatview. It's another way to observe
> memory info besides the default memory region hierachy, for example,
> if we want to know which memory region will handle the write to
> specific address, a flatview will suite more here than the default
> hierachical dump.
> 
> Please review. Thanks,
> 
> Peter Xu (2):
>   memory: tune mtree_print_mr() to dump mr type
>   memory: hmp: add "-f" for "info mtree"
> 
>  hmp-commands-info.hx  |  6 ++--
>  include/exec/memory.h |  2 +-
>  memory.c              | 89 ++++++++++++++++++++++++++++++++++++++-------------
>  monitor.c             |  4 ++-
>  4 files changed, 74 insertions(+), 27 deletions(-)
> 

Queued, thanks.

Paolo
