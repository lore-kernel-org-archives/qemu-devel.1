Received: from eggs.gnu.org ([209.51.188.92]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyItO-00027t-7J
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyItN-00053g-FU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:14:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyItN-000530-47
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:14:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id b65so1687829plb.6
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:14:09 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17cce95e-8e0d-5f49-920a-1e35c9ce8968@linaro.org>
Date: Mon, 25 Feb 2019 08:14:04 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 7/7] s390x/tcg: Implement LOAD COUNT TO
 BLOCK BOUNDARY
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

On 2/25/19 3:55 AM, David Hildenbrand wrote:
> +uint64_t HELPER(lcbb)(uint64_t addr, uint32_t m3)
> +{
> +    const uint32_t block_size = 1ul << (m3 + 6);
> +    const uint64_t rounded_addr = ROUND_UP(addr, block_size);
> +    uint32_t to_load = 16;
> +
> +    if (rounded_addr != addr) {
> +        to_load = MIN(rounded_addr - addr, to_load);
> +    }
> +    return to_load;
> +}

I don't understand all of this "blocksize" business, when they are all powers
of two, and the maximum value returned is 16.

As far as I can see, the result is obtained by -(addr | -16) regardless of the
value of m3.


r~
