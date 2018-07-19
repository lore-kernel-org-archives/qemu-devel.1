Received: from eggs.gnu.org ([2001:4830:134:3::10]:53070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgCFH-0004aa-M9
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgCFE-000492-JS
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:57:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgCFE-00048Z-93
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:57:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id p23-v6so4283815pgv.13
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:57:36 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-6-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <270ed7c2-9f82-d49d-a745-c43e003b3aa9@linaro.org>
Date: Thu, 19 Jul 2018 09:57:32 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-6-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/40] target/mips: Add nanoMIPS
 decoding and extraction utilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +static int decode_gpr_gpr3(int r)
> +{
> +    static const int map[] = { 16, 17, 18, 19, 4, 5, 6, 7 };
> +
> +    return map[r & 0x7];
> +}
> +
> +static int decode_gpr_gpr4(int r)
> +{
> +    static const int map[] = { 8, 9, 10, 11, 4, 5, 6, 7,
> +                            16, 17, 18, 19, 20, 21, 22, 23 };
> +
> +    return map[r & 0xf];
> +}
> +
> +/* Used for 16-bit store instructions.  */
> +static int decode_gpr_gpr4_zero(int r)

I think it's worth spending one line to document the pseudocode function from
which each of these come.  E.g.

/* Implement nanoMIPS pseudocode decode_gpr(encoded_gpr, 'gpr4.zero').  */

Which is certainly more accurate than the comment that is there currently.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
