Received: from eggs.gnu.org ([2001:4830:134:3::10]:54931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eNKKF-0007gi-Sr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eNKKC-0007xR-My
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:12:31 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-9-david@redhat.com>
	<a4725e2c-3b8c-eee7-1587-0a22d24aa5f2@twiddle.net>
	<be257229-3723-7144-fffb-2206cab23e79@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d5f4cef3-f940-d376-2768-c13adc9b7288@twiddle.net>
Date: Fri, 8 Dec 2017 07:12:23 -0800
MIME-Version: 1.0
In-Reply-To: <be257229-3723-7144-fffb-2206cab23e79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 08/10] s390x/tcg: implement
 extract-CPU-time facility
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

On 12/08/2017 07:02 AM, David Hildenbrand wrote:
> +/* Store CPU Timer (also used for EXTRACT CPU TIME) */
> +uint64_t HELPER(stpt)(CPUS390XState *env)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    /*
> +     * Fake a descending CPU timer. We could get negative values here,
> +     * but we don't care as it is up to the OS when to process that
> +     * interrupt and reset to > 0.
> +     */
> +    return UINT64_MAX - (uint64_t)cpu_get_host_ticks();
> +#else
> +    return time2tod(env->cputm - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +#endif
> +}
> +
> 

Looks good to me.


r~
