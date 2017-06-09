Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJQhC-0000Rp-A3
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJQh9-0006yr-6A
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:39:50 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJQh9-0006yF-23
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:39:47 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so17589061qtg.3
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 13:39:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609142156.18767-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1c3c85af-4712-a7f3-1024-3bfc225c852d@twiddle.net>
Date: Fri, 9 Jun 2017 13:39:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170609142156.18767-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] PGM injection fix/rework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 06/09/2017 07:21 AM, David Hildenbrand wrote:
> We have various places where we inject suppressing PGM exceptions,
> but don't forward the PSW. Let's fix that by detecting whether to
> forward the PSW using the interception code.
> 
> We can now get rid of ILEN_LATER/ILEN_LATER_INC and replace it by
> ILEN_AUTO, to automatically detect the instruction length using the
> current PSW.
> 
> ILEN_AUTO is also used with program_interrupt(), so let's add it at the
> right place.
> 
> To correctly identify nullifying PER events (and also that the guest can
> identify them), we have to set the PER flag PER_CODE_EVENT_NULLIFICATION
> accordingly.
> 
> This e.g. fixes TB (TEST BLOCK) program interrupts in Thomas' interception
> handler kvm-unit-test.
> 
> David Hildenbrand (2):
>    target/s390x: correctly indicate PER nullification
>    target/s390x: rework PGM interrupt psw.addr handling
> 
>   target/s390x/cpu.h         |  7 ++-----
>   target/s390x/helper.c      | 46 +++++++++++++++++++++++++++++++++++-----------
>   target/s390x/misc_helper.c | 22 +++++++++-------------
>   target/s390x/mmu_helper.c  |  6 +++---
>   target/s390x/translate.c   |  3 +--
>   5 files changed, 50 insertions(+), 34 deletions(-)
> 

Applied, thanks.


r~
