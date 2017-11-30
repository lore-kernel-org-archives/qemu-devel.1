Received: from eggs.gnu.org ([2001:4830:134:3::10]:45495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKLVj-0006Un-Sm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKLVj-00053Y-2N
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:52:03 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2fec1e40-eb03-5dfd-c090-b4b9c2674d09@redhat.com>
Date: Thu, 30 Nov 2017 10:51:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 04/16] s390x/ioinst: pass the
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 21:26, David Hildenbrand wrote:
> TCG needs the retaddr when injecting an interrupt. Let's just pass it
> along and use RA_IGNORED for KVM. The value will be completely ignored for
> KVM.
> 
> Convert program_interrupt() to s390_program_interrupt() directly, making
> use of the passed address.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         |  1 +
>  target/s390x/internal.h    | 29 +++++++++++---------
>  target/s390x/ioinst.c      | 67 +++++++++++++++++++++++-----------------------
>  target/s390x/kvm.c         | 27 ++++++++++---------
>  target/s390x/misc_helper.c | 20 +++++++-------
>  5 files changed, 75 insertions(+), 69 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
