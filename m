Received: from eggs.gnu.org ([2001:4830:134:3::10]:35247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHImE-0001LR-6d
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHImA-0006KT-1h
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:52:46 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHIm9-0006KC-RU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:52:41 -0400
Received: by mail-pg0-x242.google.com with SMTP id g20-v6so3092548pgv.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:52:41 -0700 (PDT)
References: <20180511071052.1443-1-ptesarik@suse.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22c3cda5-253b-0bd2-7c46-8f37a6cce748@linaro.org>
Date: Fri, 11 May 2018 17:52:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180511071052.1443-1-ptesarik@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] Fix conversion from uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Petr Tesarik <ptesarik@suse.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 05/11/2018 12:10 AM, Petr Tesarik wrote:
> The significand is passed to normalizeRoundAndPackFloat128() as high
> first, low second. The current code passes the integer first, so the
> result is incorrectly shifted left by 64 bits.
> 
> This bug affects the emulation of s390x instruction CXLGBR (convert
> from logical 64-bit binary-integer operand to extended BFP result).
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks.


r~
