Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK5zL-0007fk-Pk
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK5zK-0003A6-GA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:17:35 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-3-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9a3c4da2-4424-814e-7129-d037d319b48f@twiddle.net>
Date: Wed, 29 Nov 2017 17:17:30 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 02/15] s390x/tcg: get rid of
 runtime_exception()
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
> Let's use program_interrupt_ra() instead.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c  |  2 +-
>  target/s390x/int_helper.c  | 14 +++++++-------
>  target/s390x/internal.h    |  2 --
>  target/s390x/misc_helper.c | 16 ----------------
>  4 files changed, 8 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
