Received: from eggs.gnu.org ([2001:4830:134:3::10]:39274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA8F-0000if-6L
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA81-0004iI-TQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:23:27 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:36620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erA81-0004gK-1k
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:23:13 -0500
Received: by mail-pl0-x230.google.com with SMTP id 61-v6so2399118plf.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:23:12 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-9-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9409454-7524-454b-c45e-4793a8db6b54@linaro.org>
Date: Wed, 28 Feb 2018 14:23:09 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/16] translate-all: work page-by-page in
 tb_invalidate_phys_range_1
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
> So that we pass a same-page range to tb_invalidate_phys_page_range,
> instead of always passing an end address that could be on a different
> page.
> 
> As discussed with Peter Maydell on the list [1], tb_invalidate_phys_page_range
> doesn't actually do much with 'end', which explains why we have never
> hit a bug despite going against what the comment on top of
> tb_invalidate_phys_page_range requires:
> 
>> * Invalidate all TBs which intersect with the target physical address range
>> * [start;end[. NOTE: start and end must refer to the *same* physical page.
> The appended honours the comment, which avoids confusion.
> 
> While at it, rework the loop into a for loop, which is less error prone
> (e.g. "continue" won't result in an infinite loop).
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg09165.html
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
