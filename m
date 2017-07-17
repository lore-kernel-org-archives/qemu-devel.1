Received: from eggs.gnu.org ([2001:4830:134:3::10]:39837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFil-0002Td-MK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFih-00078z-NA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:46:35 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFih-00078h-G5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:46:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id 19so634693qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:46:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-15-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <13b59565-d5a7-e252-5be0-4abdab7d6ad4@twiddle.net>
Date: Mon, 17 Jul 2017 13:46:25 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-15-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/45] tcg: define CF_PARALLEL and use
 it for TB hashing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> +/* mask cflags for hashing/comparison */
> +static inline uint32_t mask_cf(uint32_t cflags)
> +{
> +    uint32_t mask = 0;
> +
> +    mask |= CF_PARALLEL;
> +    return cflags & mask;
> +}

Surely we don't need a function for this, just a define near all the other CF_ 
definitions.

> +
> +/* current cflags, masked for hashing/comparison */
> +static inline uint32_t curr_cf_mask(void)
> +{
> +    uint32_t val = 0;
> +
> +    if (parallel_cpus) {
> +        val |= CF_PARALLEL;
> +    }
> +    return val;
> +}

Better as curr_cflags?  What's the "mask" part of this?

Also, let's write this more directly, e.g.

   return parallel_cpus ? CF_PARALLEL : 0;

until we have something more to put here.


r~
