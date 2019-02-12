Received: from eggs.gnu.org ([209.51.188.92]:37273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPiN-0004XL-2e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPiL-0003NV-Ko
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:40990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtPiK-0003JF-CQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:30:33 -0500
Received: by mail-pl1-x632.google.com with SMTP id k15so654649pls.8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:30:31 -0800 (PST)
References: <20190211181907.2219-2-svens@stackframe.org>
	<20190211181907.2219-6-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d469091-10b7-4922-da91-56208632c0b7@linaro.org>
Date: Mon, 11 Feb 2019 20:30:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190211181907.2219-6-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/hppa: fix dcor instruction
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

On 2/11/19 10:19 AM, Sven Schnelle wrote:
> It looks like the operands where exchanged. HP bootrom tests the
> following sequence:
> 
> 0x00000000f0004064:  ldil L%-66666800,r7
> 0x00000000f0004068:  addi 19f,r7,r7
> 0x00000000f000406c:  addi -1,r0,rp
> 0x00000000f0004070:  addi f,r0,r4
> 0x00000000f0004074:  addi 1,r4,r5
> 0x00000000f0004078:  dcor rp,r6
> 0x00000000f000407c:  cmpb,<>,n r6,r7,0xf000411
> 
> This returned 0x66666661 instead of the expected 0x9999999f in QEMU.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued.


r~
