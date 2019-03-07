Received: from eggs.gnu.org ([209.51.188.92]:59263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uk0-0002RD-Lv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1uju-0005c5-Aj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:15:24 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1uju-0005b5-0t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:15:18 -0500
Received: by mail-pf1-x431.google.com with SMTP id v21so11648987pfm.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:15:17 -0800 (PST)
References: <20190307121539.12842-1-david@redhat.com>
	<20190307121539.12842-28-david@redhat.com>
	<6caab30c-42bb-1eae-4f6b-577505764b8f@linaro.org>
	<6a7f0375-ad6b-7bdc-c1c2-0ba1588b0d7c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5edf564a-91c9-3dee-4870-c085836122e7@linaro.org>
Date: Thu, 7 Mar 2019 07:15:13 -0800
MIME-Version: 1.0
In-Reply-To: <6a7f0375-ad6b-7bdc-c1c2-0ba1588b0d7c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/32] s390x/tcg: Provide
 probe_write_access helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 3/7/19 6:34 AM, David Hildenbrand wrote:
> So it should be
> 
> 
> +void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
> +                        uintptr_t ra)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    if (!h2g_valid(addr) || !h2g_valid(addr + len - 1) ||
> +        page_check_range(addr, len, PAGE_WRITE) < 0) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
> +    }

Correct.  With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
