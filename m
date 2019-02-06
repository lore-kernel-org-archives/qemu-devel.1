Received: from eggs.gnu.org ([209.51.188.92]:33854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grGVU-0004sQ-AK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grGNG-0007Pc-54
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:07:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grGNF-0007PD-UN
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 01:07:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id z18so5420519wrh.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 22:07:52 -0800 (PST)
References: <20190129191402.29539-1-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6b232ca-b4ab-5994-d753-0585ce79d866@linaro.org>
Date: Wed, 6 Feb 2019 06:07:47 +0000
MIME-Version: 1.0
In-Reply-To: <20190129191402.29539-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/hppa: fix PSW Q bit behaviour to
 match hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <rth@twiddle.net>

On 1/29/19 7:14 PM, Sven Schnelle wrote:
> PA-RISC specification says: "Setting the PSW Q-bit, PSW{28}, to 1
> with this instruction, if it was not already 1, is an undefined
> operation." However, at least HP-UX 10.20 sets the Q bit from 0 to 1
> with the SSM instruction. Tested this both on HP9000/712 and
> HP9000/785/C3750, both machines set the Q bit from 0 to 1 without
> exception. This makes HP-UX 10.20 progress a little bit further.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/op_helper.c | 5 -----
>  1 file changed, 5 deletions(-)

Queued, with much of this text copied into a comment in the code.


r~
