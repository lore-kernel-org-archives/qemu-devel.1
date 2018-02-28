Received: from eggs.gnu.org ([2001:4830:134:3::10]:42542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er9Sb-0000bl-Er
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:40:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er9SW-0000uf-4q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:40:25 -0500
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:44035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er9SV-0000t7-Dp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:40:19 -0500
Received: by mail-pl0-x22b.google.com with SMTP id w21-v6so2319247plp.11
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:40:19 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-6-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99cb6bcc-55d2-f07f-fdf4-c55355d2c39f@linaro.org>
Date: Wed, 28 Feb 2018 13:40:15 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-6-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/16] translate-all: iterate over TBs in a
 page with PAGE_FOR_EACH_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/26/2018 09:39 PM, Emilio G. Cota wrote:
> +/* list iterators for lists of tagged pointers in TranslationBlock */
> +#define TB_FOR_EACH_TAGGED(head, tb, n, field)                  \
> +    for (n = (head) & 1,                                        \
> +             tb = (TranslationBlock *)((head) & ~1);            \
> +         tb;                                                    \
> +         tb = (TranslationBlock *)tb->field[n],                 \
> +             n = (uintptr_t)tb & 1,                             \
> +             tb = (TranslationBlock *)((uintptr_t)tb & ~1))
> +
> +#define PAGE_FOR_EACH_TB(pagedesc, tb, n)                       \
> +    TB_FOR_EACH_TAGGED((pagedesc)->first_tb, tb, n, page_next)
> +

I'm not sure I like the generalization of TB_FOR_EACH_TAGGED.  Do you use it
for anything besides PAGE_FOR_EACH_TB?

Weird indentation in the clauses.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
