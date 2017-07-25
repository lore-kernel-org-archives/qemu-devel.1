Received: from eggs.gnu.org ([2001:4830:134:3::10]:38877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu7E-0003R1-87
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu79-0002sB-3X
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZu78-0002ru-Sm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:18:43 -0400
References: <20170725023611.9169-1-rth@twiddle.net>
	<20170725023611.9169-3-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1cc32ae6-5c7e-7452-d730-605fd68dd3a1@redhat.com>
Date: Tue, 25 Jul 2017 09:18:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170725023611.9169-3-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/s390x: Use ILEN_UNWIND in
 trivial cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org


>      /* FIXME: a) LAP
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 452b2bd902..376dbd68c2 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -57,7 +57,7 @@ void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
>  
>      cs->exception_index = EXCP_PGM;
>      env->int_pgm_code = excp;
> -    env->int_pgm_ilen = ILEN_AUTO;
> +    env->int_pgm_ilen = ILEN_UNWIND;

This is the only place where int_pgm_ilen is ever set to ILEN_UNWIND.

Think it would be better to drop setting int_pgm_ilen here completely.

>  
>      /* Use the (ultimate) callers address to find the insn that trapped.  */
>      cpu_restore_state(cs, retaddr);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
