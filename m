Received: from eggs.gnu.org ([209.51.188.92]:56408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6C-0007Np-2F
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y43-00073S-NR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y43-000735-G7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:26:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id u9so786546pfn.1
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:26:51 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-6-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a288f88-9706-7633-083a-cceedd1f47ad@linaro.org>
Date: Mon, 11 Mar 2019 20:26:47 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-6-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/11] target/hppa: remove PSW I/R/Q bit
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> HP ODE use rfi to set the Q bit, and i don't see anything in the
> documentation that this is forbidden. So remove it.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/op_helper.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
