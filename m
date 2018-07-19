Received: from eggs.gnu.org ([2001:4830:134:3::10]:49517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgG16-0001DK-S4
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgG12-0005ja-8K
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:59:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgG12-0005ir-1i
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:59:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id v13-v6so4819548pgr.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 13:59:11 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-18-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72f0a549-f8b4-95a7-4195-93056f0d1064@linaro.org>
Date: Thu, 19 Jul 2018 13:59:07 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-18-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 17/40] target/mips: Implement emulation
 of nanoMIPS EXTW instruction
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
> From: James Hogan <james.hogan@mips.com>
> 
> Implement emulation of nanoMIPS EXTW instruction, which is similar to
> the MIPS r6 ALIGN instruction, except that it counts the other way and
> in bits instead of bytes. We therefore generalise gen_align() into
> gen_align_bits() (which counts in bits instead of bytes and optimises
> when bits = size of the word), and implement gen_align() and a new
> gen_ext() based on that. Since we need to know the word size to check
> for when the number of bits == the word size, the opc argument is
> replaced with a wordsz argument (either 32 or 64).
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 53 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
