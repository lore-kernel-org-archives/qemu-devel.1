Received: from eggs.gnu.org ([2001:4830:134:3::10]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK5ye-0006zR-Gs
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK5ya-0002w8-JE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:16:52 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-2-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ef21873d-6b2b-f6d8-9005-563a89e7913c@twiddle.net>
Date: Wed, 29 Nov 2017 17:16:44 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 01/15] s390x/tcg: introduce and
 use program_interrupt_ra()
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
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +
> +#ifdef CONFIG_TCG
> +    if (tcg_enabled() && ra) {
> +        cpu_restore_state(CPU(cpu), ra);
> +    }
> +#endif

FWIW, I have a patch queued for 2.12 that removes the RA != 0 check protecting
calls to cpu_restore_state.  That condition is already handled inside and we
don't need to duplicate it.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
