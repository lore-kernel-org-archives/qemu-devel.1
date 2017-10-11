Received: from eggs.gnu.org ([2001:4830:134:3::10]:45156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e26bl-0007gd-ID
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e26bd-0005Nb-Tp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:18:49 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e26bd-0005NQ-Md
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:18:45 -0400
Received: by mail-pf0-x230.google.com with SMTP id p87so359110pfj.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 19:18:45 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <520fa164-103e-c09d-67af-5d0e9d8ebb9b@linaro.org>
Date: Tue, 10 Oct 2017 19:18:42 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/9] target/arm: Pull Thumb insn word loads
 up to top level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:48 AM, Peter Maydell wrote:
> +    if ((insn >> 11) == 0x1e && (s->pc < s->next_page_start - 3)) {
> +        /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
> +         * is not on the next page; we merge this into a 32-bit
> +         * insn.
> +         */
> +        return false;
> +    }
> +    /* 0b1110_1xxx_xxxx_xxxx : BLX suffix (or UNDEF);
> +     * 0b1111_1xxx_xxxx_xxxx : BL suffix;
> +     * 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix on the end of a page
> +     *  -- handle as single 16 bit insn
> +     */

I really had to search to find docs for this.  I suspect it's quite clear in v5
manuals, but I didn't have one handy and arm.com seems to have dropped
everything before v6M.  However, I did see a footnote in v7M that explained.

But, everything appears to be in order.  It's a nice cleanup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
