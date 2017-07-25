Received: from eggs.gnu.org ([2001:4830:134:3::10]:54410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1vK-0004RC-Sv
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1vG-00029E-TB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:39:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1da1vG-00028b-MP
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:38:58 -0400
Date: Tue, 25 Jul 2017 17:38:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170725173839.3624e814@gondolin>
In-Reply-To: <20170721125609.11117-2-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/6] target/s390x: fix pgm irq ilen for
 stsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, borntraeger@de.ibm.com

On Fri, 21 Jul 2017 14:56:04 +0200
David Hildenbrand <david@redhat.com> wrote:

> The instruction is 4 bytes long.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index b508101..2ec49c9 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -385,7 +385,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
>      if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
>          ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
>          /* valid function code, invalid reserved bits */
> -        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        program_interrupt(env, PGM_SPECIFICATION, 4);
>      }
>  
>      sel1 = r0 & STSI_R0_SEL1_MASK;

Thanks, applied.
