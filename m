Received: from eggs.gnu.org ([2001:4830:134:3::10]:53799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKlT-0004VY-12
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKlN-00066O-5T
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:04:15 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5f290e8e-9808-988f-f8ba-8e9071a00537@redhat.com>
Date: Thu, 30 Nov 2017 10:04:01 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 01/16] s390x/tcg: introduce and
 use s390_program_interrupt()
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
> Allows to easily convert more callers of program_interrupt() and to
> easily introduce new exceptions without forgetting about the cpu state
> reset.
> 
> Use s390_program_interrupt() in places where we already had the same
> pattern. We will later get rid of program_interrupt().
> 
> RA != 0 checks are already done behind the scenes.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h           |  2 ++
>  target/s390x/crypto_helper.c |  7 ++-----
>  target/s390x/excp_helper.c   |  5 +----
>  target/s390x/interrupt.c     | 13 +++++++++++++
>  target/s390x/mem_helper.c    | 35 +++++++++++------------------------
>  target/s390x/misc_helper.c   |  3 +--
>  6 files changed, 30 insertions(+), 35 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
