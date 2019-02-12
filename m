Received: from eggs.gnu.org ([209.51.188.92]:49377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLbZ-0007sM-A3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLbY-0008Ur-A0
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:07:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLbY-0008Ti-1Y
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:07:16 -0500
Received: by mail-pg1-x543.google.com with SMTP id y1so321929pgk.11
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:07:15 -0800 (PST)
References: <20190211181907.2219-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <44edd17a-ced9-f52c-6963-879b2d1d037b@linaro.org>
Date: Mon, 11 Feb 2019 16:07:12 -0800
MIME-Version: 1.0
In-Reply-To: <20190211181907.2219-2-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/hppa: move GETPC to HELPER()
 functions
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
> When QEMU is compiled with -O0, these functions are inlined
> which will cause a wrong restart address generated for the TB.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/op_helper.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued, thanks.


r~
