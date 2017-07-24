Received: from eggs.gnu.org ([2001:4830:134:3::10]:43340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZeH3-0005cI-HK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZeH0-0006wi-7g
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZeH0-0006w0-15
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:23:50 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12f67f28-4b57-062b-ce39-9891416c6631@redhat.com>
Date: Mon, 24 Jul 2017 16:23:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170721125609.11117-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 21.07.2017 14:56, David Hildenbrand wrote:
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
