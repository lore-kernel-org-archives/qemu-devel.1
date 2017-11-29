Received: from eggs.gnu.org ([2001:4830:134:3::10]:57086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6Jq-0000io-2r
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6Jm-0002Di-TO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:38:46 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-7-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2631fa24-62a9-3dc0-acde-7aeb2af06a7f@twiddle.net>
Date: Wed, 29 Nov 2017 17:38:39 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 06/15] s390x/diag: pass the
 retaddr into handle_diag_308()
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
> Needed to later drop potential_page_fault() from the diag TCG translate
> function.
> 
> Convert program_interrupt() to program_interrupt_ra() directly, making
> use of the passed address.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c        | 14 +++++++-------
>  target/s390x/internal.h    |  3 ++-
>  target/s390x/kvm.c         |  2 +-
>  target/s390x/misc_helper.c |  2 +-
>  4 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Likewise wrt RA_IGNORED.

r~
