Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6HE-0006la-MP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6HB-0007nG-H2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:36:04 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-5-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <206dd504-543c-a386-be78-4b8da8908637@twiddle.net>
Date: Wed, 29 Nov 2017 17:35:57 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 04/15] s390x/ioinst: pass the
 retaddr to all IO instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
> TCG needs the retaddr when injecting an interrupt. Let's just pass it
> along and use 0 for KVM. The value will be completely ignored for KVM.
> 
> Convert program_interrupt() to program_interrupt_ra() directly, making
> use of the passed address.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h    | 29 +++++++++++---------
>  target/s390x/ioinst.c      | 67 +++++++++++++++++++++++-----------------------
>  target/s390x/kvm.c         | 26 +++++++++---------
>  target/s390x/misc_helper.c | 20 +++++++-------
>  4 files changed, 73 insertions(+), 69 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

... with or without RA_IGNORED.  ;-)

r~
